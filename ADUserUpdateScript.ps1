# Path to the CSV file
$csvPath = "path/to/csv.csv"

# Import the CSV file
$users = Import-Csv -Path $csvPath

foreach ($user in $users) {
    # Assuming the Identity in AD matches the formatted names in the CSV
    $identity = $user.name

    # Get the user in AD by their identity
    $adUser = Get-ADUser -Identity $identity

    # See docs for additonal update fields 
    # https://learn.microsoft.com/en-us/powershell/module/activedirectory/set-aduser?view=windowsserver2022-ps
    # Update the user

    if ($adUser) {
        Set-ADUser -Identity $adUser -Title $user.Title
        Write-Host "Updated job title for $($user.Name) to $($user.Title)"
    } else {
        Write-Host "User with identity $($user.Name) not found in AD"
    }
}