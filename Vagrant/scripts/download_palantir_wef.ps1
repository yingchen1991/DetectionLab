# Purpose: Downloads and unzips a copy of the Palantir WEF Github Repo. This includes WEF subscriptions and custom WEF channels.

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Downloading and unzipping the Palantir Windows Event Forwarding Repo from Github..."

$wefRepoPath = 'C:\Users\vagrant\AppData\Local\Temp\wef-Master.zip'
# netsh winhttp import proxy source=ie
# netsh winhttp set proxy "http://10.0.2.2:10809"
[System.Net.WebRequest]::DefaultWebProxy = New-Object System.Net.WebProxy("http://10.0.2.2:10809")
# $ProxyAddress = [System.Net.WebProxy]::GetDefaultProxy().Address
# Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) GetDefaultProxy: $ProxyAddress"
# [system.net.webrequest]::defaultwebproxy = New-Object system.net.webproxy($ProxyAddress)
If (-not (Test-Path $wefRepoPath))
{
    # GitHub requires TLS 1.2 as of 2/1/2018
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    # Disabling the progress bar speeds up IWR https://github.com/PowerShell/PowerShell/issues/2138
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri "https://github.com/palantir/windows-event-forwarding/archive/master.zip" -OutFile $wefRepoPath
    Expand-Archive -path "$wefRepoPath" -destinationpath 'c:\Users\vagrant\AppData\Local\Temp' -Force
}
else
{
    Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) $wefRepoPath already exists. Moving On."
}
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Palantir WEF download complete!"
