From: Chris Hiestand <chiestand@salk.edu>
Subject: Re: [PATCH] Add Auto-Submitted header to post-receive-email
Date: Fri, 21 Sep 2012 02:04:58 -0700
Message-ID: <67C048AA-0DA7-4397-A257-E0BE66089A5D@salk.edu>
References: <E4715C92-2BE5-484E-A55B-273CAB5EB6B4@salk.edu>
Mime-Version: 1.0 (Mac OS X Mail 6.1 \(1498\))
Content-Type: multipart/signed; boundary="Apple-Mail=_435CF883-D89C-44CB-86D3-D60A9AD8E5F0"; protocol="application/pkcs7-signature"; micalg=sha1
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 21 11:12:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEzHF-0005op-9e
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 11:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325Ab2IUJLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 05:11:53 -0400
Received: from riis.snl.salk.edu ([198.202.70.55]:45018 "EHLO
	riis.snl.salk.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129Ab2IUJLw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 05:11:52 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Sep 2012 05:11:52 EDT
Received: from [172.18.0.7] (wsip-68-15-20-133.sd.sd.cox.net [68.15.20.133])
	(Authenticated sender: chiestand)
	by riis.snl.salk.edu (Postfix) with ESMTPSA id E6F5CEE067;
	Fri, 21 Sep 2012 02:05:00 -0700 (PDT)
X-Mailer: Apple Mail (2.1498)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206117>


--Apple-Mail=_435CF883-D89C-44CB-86D3-D60A9AD8E5F0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

My email in April went unanswered so I'm resending it. An Auto-Submitted =
header
would be an improvement to the standard [git] post receive email.

Thanks,
Chris


Begin forwarded message:

> From: Chris Hiestand <chiestand@salk.edu>
> Subject: [PATCH] Add Auto-Submitted header to post-receive-email
> Date: April 14, 2012 6:15:10 PM PDT
> To: git@vger.kernel.org, gitster@pobox.com
>=20
> Hi,
>=20
> I think the Auto-Submitted header is a useful hook mail header to =
include by default.
>=20
> This conforms to RFC3834 and is useful in preventing e.g. vacation =
auto-responders
> from replying by default.
>=20
> Perhaps you have already considered this and decided not to include =
it, but I found
> no record of such a conversation on this list.
>=20
> Thanks,
> Chris Hiestand
>=20
>=20
> =46rom 358fc3ae1ebfd7723d54e4033d3e9a9a0322c873 Mon Sep 17 00:00:00 =
2001
> From: Chris Hiestand <chiestand@salk.edu>
> Date: Sat, 14 Apr 2012 17:58:39 -0700
> Subject: [PATCH] Add Auto-Submitted header to post-receive-email
>=20
> Adds Auto-Submitted: auto-generated to post-receive-email header
> This conforms to RFC3834 and is useful in preventing eg
> vacation auto-responders from replying by default
> ---
> contrib/hooks/post-receive-email |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/contrib/hooks/post-receive-email =
b/contrib/hooks/post-receive-email
> index 01af9df..282507c 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -237,6 +237,7 @@ generate_email_header()
> 	X-Git-Reftype: $refname_type
> 	X-Git-Oldrev: $oldrev
> 	X-Git-Newrev: $newrev
> +	Auto-Submitted: auto-generated
>=20
> 	This is an automated email from the git hooks/post-receive =
script. It was
> 	generated because a ref change was pushed to the repository =
containing
> --=20
> 1.7.9
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--Apple-Mail=_435CF883-D89C-44CB-86D3-D60A9AD8E5F0
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIO1TCCBIow
ggNyoAMCAQICECf06hH0eobEbp27bqkXBwcwDQYJKoZIhvcNAQEFBQAwbzELMAkGA1UEBhMCU0Ux
FDASBgNVBAoTC0FkZFRydXN0IEFCMSYwJAYDVQQLEx1BZGRUcnVzdCBFeHRlcm5hbCBUVFAgTmV0
d29yazEiMCAGA1UEAxMZQWRkVHJ1c3QgRXh0ZXJuYWwgQ0EgUm9vdDAeFw0wNTA2MDcwODA5MTBa
Fw0yMDA1MzAxMDQ4MzhaMIGuMQswCQYDVQQGEwJVUzELMAkGA1UECBMCVVQxFzAVBgNVBAcTDlNh
bHQgTGFrZSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxITAfBgNVBAsTGGh0
dHA6Ly93d3cudXNlcnRydXN0LmNvbTE2MDQGA1UEAxMtVVROLVVTRVJGaXJzdC1DbGllbnQgQXV0
aGVudGljYXRpb24gYW5kIEVtYWlsMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsjmF
pPJ9q0E7YkY3rs3BYHW8OWX5ShpHornMSMxqmNVNNRm5pELlzkniii8efNIxB8dOtINknS4p1aJk
xIW9hVE1eaROaJB7HHqkkqgX8pgV8pPMyaQylbsMTzC9mKALi+VuG6JG+ni8om+rWV6lL8/K2m2q
L+usobNqqrcuZzWLeeEeaYji5kbNoKXqvgvOdjp6Dpvq/NonWz1zHyLmSGHGTPNpsaguG7bUMSAs
vIKKjqQOpdeJQ/wWWq8dcdcRWdq6hw2v+vPhwvCkxWeM1tZUOt4KpLoDd7NlyP0e03RiqhjKaJMe
oYV+9Udly/hNVyh00jT/MLbu9mIwFIws6wIDAQABo4HhMIHeMB8GA1UdIwQYMBaAFK29mHo0tCb3
+sQmVO8DveAky1QaMB0GA1UdDgQWBBSJgmd9xJ0mcABLtFBIfN49rgRufTAOBgNVHQ8BAf8EBAMC
AQYwDwYDVR0TAQH/BAUwAwEB/zB7BgNVHR8EdDByMDigNqA0hjJodHRwOi8vY3JsLmNvbW9kb2Nh
LmNvbS9BZGRUcnVzdEV4dGVybmFsQ0FSb290LmNybDA2oDSgMoYwaHR0cDovL2NybC5jb21vZG8u
bmV0L0FkZFRydXN0RXh0ZXJuYWxDQVJvb3QuY3JsMA0GCSqGSIb3DQEBBQUAA4IBAQAZ2IkRbyis
pgCi54fBm5AD236hEv0e8+LwAamUVEJrmgnEoG3XkJIEA2Z5Q3H8+G+v23ZF4jcaPd3kWQR4rBz0
g0bzes9bhHIt5UbBuhgRKfPLSXmHPLptBZ2kbWhPrXIUNqi5sf2/z3/wpGqUNVCPz4FtVbHdWTBK
322gnGQfSXzvNrv042n0+DmPWq1LhTq3Du3Tzw1EovsEv+QvcI4l+1pUBrPQxLxtjftzMizpm4Qk
LdZ/kXpoAlAfDj9N6cz1u2fo3BwuO/xOzf4CjuOoEwqlJkRl6RDyTVKnrtw+ymsyXEFs/vVdoOr/
0fqbhlhtPZZH5f4ulQTCAMyOofK7MIIFGjCCBAKgAwIBAgIQbRnqpxlPajMi5iIyeqpx3jANBgkq
hkiG9w0BAQUFADCBrjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVUMRcwFQYDVQQHEw5TYWx0IExh
a2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMSEwHwYDVQQLExhodHRwOi8v
d3d3LnVzZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVUTi1VU0VSRmlyc3QtQ2xpZW50IEF1dGhlbnRp
Y2F0aW9uIGFuZCBFbWFpbDAeFw0xMTA0MjgwMDAwMDBaFw0yMDA1MzAxMDQ4MzhaMIGTMQswCQYD
VQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRow
GAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE5MDcGA1UEAxMwQ09NT0RPIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAkoSEW0tXmNReL4uk4UDIo1NYX2Zl8TJO958yfVXQeExVt0KU4PkncQfFxmmkuTLE8UAakMwn
VmJ/F7Vxaa7lIBvky2NeYMqiQfZq4aP/uN8fSG1lQ4wqLitjOHffsReswtqCAtbUMmrUZ28gE49c
NfrlVICv2HEKHTcKAlBTbJUdqRAUtJmVWRIx/wmi0kzcUtve4kABW0ho3cVKtODtJB86r3FfB+Os
vxQ7sCVxaD30D9YXWEYVgTxoi4uDD216IVfmNLDbMn7jSuGlUnJkJpFOpZIP/+CxYP0ab2hRmWON
GoulzEKbm30iY9OpoPzOnpDfRBn0XFs1uhbzp5v/wQIDAQABo4IBSzCCAUcwHwYDVR0jBBgwFoAU
iYJnfcSdJnAAS7RQSHzePa4Ebn0wHQYDVR0OBBYEFHoTTgB0W8Z4Y2QnwS/ioFu8ecV7MA4GA1Ud
DwEB/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBYBgNVHR8E
UTBPME2gS6BJhkdodHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVROLVVTRVJGaXJzdC1DbGllbnRB
dXRoZW50aWNhdGlvbmFuZEVtYWlsLmNybDB0BggrBgEFBQcBAQRoMGYwPQYIKwYBBQUHMAKGMWh0
dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VVE5BZGRUcnVzdENsaWVudF9DQS5jcnQwJQYIKwYBBQUH
MAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEFBQADggEBAIXWvnhXVW0z
f0RS/kLVBqgBA4CK+w2y/Uq/9q9BSfUbWsXSrRtzbj7pJnzmTJjBMCjfy/tCPKElPgp11tA9OYZm
0aGbtU2bb68obB2v5ep0WqjascDxdXovnrqTecr+4pEeVnSy+I3T4ENyG+2P/WA5IEf7i686ZUg8
mD2lJb+972DgSeUWyOs/Q4Pw4O4NwdPNM1+b0L1garM7/vrUyTo8H+2b/5tJM75CKTmD7jNpLoKd
RU2oadqAGx490hpdfEeZpZsIbRKZhtZdVwcbpzC+S0lEuJB+ytF5OOu0M/qgOl0mWJ5hVRi0IdWZ
1eBDQEIwvuql55TSsP7zdfl/bucwggUlMIIEDaADAgECAhAJi8lShk8jTNMgVo7nXaDGMA0GCSqG
SIb3DQEBBQUAMIGTMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAw
DgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE5MDcGA1UEAxMwQ09N
T0RPIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTEyMDgxNDAw
MDAwMFoXDTEzMDgxNDIzNTk1OVowIzEhMB8GCSqGSIb3DQEJARYSY2hpZXN0YW5kQHNhbGsuZWR1
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtqz/Yy0csi37dTvyoNn8MNtPRvG2D7E3
pwSsuXFnBML17AZU1wpAKsQpggGoznvsFQvvOzJyWRBWKdF0deds1xpFGhe7+/GzMhnQKwFDeVZs
9hTXKWEERVVaBmyIbj0BP3D5VrUo/7eaybMALnxEjrteg9jyuFTSrGDc8qJ+c1Ps5vlH0v+Fvp4V
HoI8bW/+auu4mNT1E0nzpm3eWCsF1Rif2FVDetoDaArW1uTJh+g6oV3d1eJeGiqRnc+k7Q+ShfHj
wehOQT7dvYRE1CqArv69m2BBue+gHXQXWFgfaHx7/9mJapJG/ALpmqaHU8x9bMaBcZcIQHqEQV9E
3yOWpQIDAQABo4IB4jCCAd4wHwYDVR0jBBgwFoAUehNOAHRbxnhjZCfBL+KgW7x5xXswHQYDVR0O
BBYEFGOY5NfMgoO8duC6gWVGeskIkDbrMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAG
A1UdJQQZMBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0g
BD8wPTA7BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2Rv
Lm5ldC9DUFMwVwYDVR0fBFAwTjBMoEqgSIZGaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RP
Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBiAYIKwYBBQUHAQEEfDB6
MFIGCCsGAQUFBzAChkZodHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9DT01PRE9DbGllbnRBdXRoZW50
aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21v
ZG9jYS5jb20wHQYDVR0RBBYwFIESY2hpZXN0YW5kQHNhbGsuZWR1MA0GCSqGSIb3DQEBBQUAA4IB
AQCHpk5ZpwS5faNtGTJxlHTy9hQm4NwJZhatrTz7xq23Q93RjLxwVn9tFG/YuPB1iN1aEA1DZWwP
Xi5OMbYxEb4Icw7/QGbJGwdHn6IDkU6IR2UOx5RzQJ84Fl6jUKCvlnJ3/UbZuzYG3fCyqi5GhUk1
PN4l/qwbxmsZKLwZep45lrbmea5XmqIO5NB4F02NLFYZWmEByKEi92aHLfgsvULq1CfNJMKIIYD2
/AW96vDQmk/liJHld+gkQQkIlTTzZmOYbHKtkeN8B8kFkB5OmdUZJvWoDMDMLLHhPkfRBBYuS7WO
jQY521z50tPATaS3yDZUYlcFyXjns8Wew/gv/XT5MYIDqzCCA6cCAQEwgagwgZMxCzAJBgNVBAYT
AkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNV
BAoTEUNPTU9ETyBDQSBMaW1pdGVkMTkwNwYDVQQDEzBDT01PRE8gQ2xpZW50IEF1dGhlbnRpY2F0
aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEAmLyVKGTyNM0yBWjuddoMYwCQYFKw4DAhoFAKCCAdcw
GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTIwOTIxMDkwNDU5WjAj
BgkqhkiG9w0BCQQxFgQU/lG8l7MQEbrX9B31oB+2dnXBSlUwgbkGCSsGAQQBgjcQBDGBqzCBqDCB
kzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxOTA3BgNVBAMTMENPTU9ETyBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQCYvJUoZPI0zTIFaO512gxjCBuwYL
KoZIhvcNAQkQAgsxgauggagwgZMxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNo
ZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMTkwNwYD
VQQDEzBDT01PRE8gQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEAmL
yVKGTyNM0yBWjuddoMYwDQYJKoZIhvcNAQEBBQAEggEAX02kijCEsr6f1qNgyJ7E9xPYIGFBKqsr
3FjaWTieBeH7iAVM7Fbm744M4EWburG/61X3pWKhaaN500WN5hXVVs9rRKjA2s0KkIHldd5XSkST
5MhHu6j17rYMxc71Y+9pmwvGY3bSxKDfrtJsWxAR+84sVH+HurH1cc7ffiU0onBIOjnv1L9Fd6Fu
AcGKh5MoYf3MTsFfsdFNEvkq9DXH5mG1e7++JysJZmPMNi8zvPu6lQbniaHG86N0rVumAl8lo77U
gpiFgyFBt4/Jq3s+6R+8J4TwoP96jR+oOOisDehF4aMjHPD2MSN/S5X02NhmTF9Jo4kCeTFB3BEi
FyrsEQAAAAAAAA==

--Apple-Mail=_435CF883-D89C-44CB-86D3-D60A9AD8E5F0--
