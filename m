From: Quinn Taylor <quinntaylor@mac.com>
Subject: Requesting `git stash --cached` or something similar
Date: Mon, 13 Apr 2015 14:24:04 -0700
Message-ID: <37E34942-ACEB-48BC-ABFF-C7248DA6607E@mac.com>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3020\))
Content-Type: multipart/signed;
 boundary="Apple-Mail=_66262E93-5C92-4E4C-BEA4-D2E1006EDCF0";
 protocol="application/pkcs7-signature"; micalg=sha1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 00:24:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhmm8-0007gJ-33
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 00:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbbDMWYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 18:24:11 -0400
Received: from mr11p24im-asmtp002.me.com ([17.110.78.42]:56871 "EHLO
	mr11p24im-asmtp002.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbbDMWYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 18:24:09 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2015 18:24:09 EDT
Received: from [17.153.38.189] (unknown [17.153.38.189])
 by mr11p24im-asmtp002.me.com
 (Oracle Communications Messaging Server 7.0.5.35.0 64bit (built Dec  4 2014))
 with ESMTPSA id <0NMR0018ZKS5L550@mr11p24im-asmtp002.me.com> for
 git@vger.kernel.org; Mon, 13 Apr 2015 21:24:08 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.13.68,1.0.33,0.0.0000
 definitions=2015-04-13_05:2015-04-10,2015-04-13,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=13 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1412110000 definitions=main-1504130184
X-Mailer: Apple Mail (2.3020)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267102>


--Apple-Mail=_66262E93-5C92-4E4C-BEA4-D2E1006EDCF0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I'm still fairly new to git (coming from svn) and have found `git stash` =
to be really useful for storing in-progress work to resume later, as one =
might otherwise do with diff/patch files. (With the git tools I use, I =
find `git stash pop` to be more convenient and reliable than creating =
and applying diffs, partially because the changes remained tied to my =
repository and easily accessible.)

Since `git stash` defaults to stashing ALL local modifications, I'd like =
to request there be an easy way to stash *only* the changes I've already =
staged in the index. (The reason I suggested --cached is due to the =
similarity with `git diff --cached`, but I don't doubt there would be a =
better name for this option.)

I tried staging everything *except* what I want to stash and using `git =
stash save --keep-index <message>`, but it isn't intended to support =
this case, and doesn't work when I have new untracked files. Instead, it =
stashes *all* local (tracked) changes =E2=80=94 both staged and unstaged =
=E2=80=94 but leaves the staged changes intact in the index.

I understand that git's branching model is powerful and flexible, and =
that an experienced git user would generally create a private branch and =
commit to that, then merge the changes to mainline sometime later. =
However, for those like me for whom having many branches is generally =
more confusing than helpful, it would be fantastic to have more =
flexibility with `git stash`.

Thanks in advance for considering my request.

Regards,
 - Quinn=

--Apple-Mail=_66262E93-5C92-4E4C-BEA4-D2E1006EDCF0
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIQmDCCBTIw
ggQaoAMCAQICEQC9Vw5DyGeYrAhEGIhud2GjMA0GCSqGSIb3DQEBCwUAMIGXMQswCQYDVQQGEwJH
QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQK
ExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGlj
YXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0xNDA5MjkwMDAwMDBaFw0xNTA5MjkyMzU5NTla
MCQxIjAgBgkqhkiG9w0BCQEWE3F1aW5udGF5bG9yQG1hYy5jb20wggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQC7zU7SckdlkfpJ2Qq71it9qwRyMOC6lPSoeqVSqsIs4xUOUgrO0FLdIigz
cg8qk8JUpWJx6Q+hctr2F3i0j7Vf27d0nZPKH8dZkc/pQJ94wsxugBo+dzHJ5HeLh9jAOX4PIVeF
jfrPSNbEjfxbaJO5+/HxWbA5mYPPlgFjlLNBF7pJlk8oEUUIyhJJ6fbaK0rPEjJzWRW3wLQUJ3/5
y//fpk+tvHnt3GVBTjkmwAyr3cImGE1ROt8FFViCDsHxV6AN2Fl/EjGonxQ0B5805Iltpi65Tt84
fQwecyWw4yZT9ixWuJnu76Eh3w5DiiVpvkcj1TDScpi7g5MZZrILKm0xAgMBAAGjggHpMIIB5TAf
BgNVHSMEGDAWgBSCr2yM+MX+lmF86B89K3FIXsSLwDAdBgNVHQ4EFgQUTJ5/kOGQSASTBGaV8EpR
voDMVn8wDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYIKwYBBQUHAwQG
CysGAQQBsjEBAwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEB
ATArMCkGCCsGAQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBR
ME+gTaBLhklodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNh
dGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0
dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2Vj
dXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAeBgNV
HREEFzAVgRNxdWlubnRheWxvckBtYWMuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQBRx+1JzylwkhJ6
5uKjK5d3dQJ8F27OD2ZC9erDgIiPsAR5PHXI6+R+pV23x7EIwbi1VBdPT2AQyHRmTE4Xuk58x3Rd
potwihQh/OXkkFi1KC8gtpGwyNrXuNh7Uk/uW420smAbERjRevPadUP2BhOUvgMYkZloDtaYiRCN
qqPKV5jv9YtrdGIo3dJnKOHBPC7CFqY1D94jlDEGJzq/3Q3O4p8t4Me9I5lcaQs1GHkp9jZ9rHYj
ePVx8d+TxPZq9Z+52661P3MqJJbcKYL2eiYU+OdgHzEsevkSExDW3UxtSIGR8EQbISda54qr1MI5
HLIRQjBuPdGMPkcp6XiVm2D2MIIFdDCCBFygAwIBAgIQJ2buVutJ846r13Ci/ITeIjANBgkqhkiG
9w0BAQwFADBvMQswCQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFk
ZFRydXN0IEV4dGVybmFsIFRUUCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBD
QSBSb290MB4XDTAwMDUzMDEwNDgzOFoXDTIwMDUzMDEwNDgzOFowgYUxCzAJBgNVBAYTAkdCMRsw
GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNP
TU9ETyBDQSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRpb24gQXV0aG9y
aXR5MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAkehUktIKVrGsDSTdxc9EZ3SZKzej
fSNwAHG8U9/E+ioSj0t/EFa9n3Byt2F/yUsPF6c947AEYe7/EZfH9IY+Cvo+XPmT5jR62RRr55yz
haCCenavcZDX7P0N+pxs+t+wgvQUfvm+xKYvT3+Zf7X8Z0NyvQwA1onrayzT7Y+YHBSrfuXjbvzY
qOSSJNpDa2K4Vf3qwbxstovzDo2a5JtsaZn4eEgwRdWt4Q08RWD8MpZRJ7xnw8outmvqRsfHIKCx
H2XeSAi6pE6p8oNGN4Tr6MyBSENnTnIqm1y9TBsoilwie7SrmNnu4FGDwwlGTm0+mfqVF9p8M1dB
PI1R7Qu2XK8sYxrfV8g/vOldxJuvRZnio1oktLqpVj3Pb6r/SVi+8Kj/9Lit6Tf7urj0Czr56ENC
HonYhMsT8dm74YlguIwoVqwUHZwK53Hrzw7dPamWoUi9PPevtQ0iTMARgexWO/bTouJbt7IEIlKV
gJNp6I5MZfGRAy1wdALqi2cVKWlSArvX31BqVUa/oKMoYX9w0MOiqiwhqkfOKJwGRXa/ghgntNWu
tMtQ5mv0TIZxMOmm3xaG4Nj/QN370EKIf6MzOi5cHkERgWPOGHFrK+ymircxXDpqR+DDeVnWIBqv
8mqYqnK8V0rSS527EPywTEHl7R09XiidnMy/s1Hap0flhFMCAwEAAaOB9DCB8TAfBgNVHSMEGDAW
gBStvZh6NLQm9/rEJlTvA73gJMtUGjAdBgNVHQ4EFgQUu69+Aj36pvE8hI6t7jiY7NkyMtQwDgYD
VR0PAQH/BAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAGBgRVHSAAMEQGA1UdHwQ9
MDswOaA3oDWGM2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9BZGRUcnVzdEV4dGVybmFsQ0FSb290
LmNybDA1BggrBgEFBQcBAQQpMCcwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5j
b20wDQYJKoZIhvcNAQEMBQADggEBAGS/g/FfmoXQzbihKVcN6Fr30ek+8nYEbvFScLsePP9NDXRq
zIGCJdPDoCpdTPW6i6FtxFQJdcfjJw5dhHk3QBN39bSsHNA7qxcS1u80GH4r6XnTq1dFDK8o+tDb
5VCViLvfhVdpfZLYUspzgb8c8+a4bmYRBbMelC1/kZWSWfFMzqORcUx8Rww7Cxn2obFshj5cqsQu
gsv5B5a6SE2Q8pTIqXOi6wZ7I53eovNNVZ96YUWYGGjHXkBrI/V5eu+MtWuLt29G9HvxPUsE2JOA
WVrgQSQdso8VYFhH2+9uRv0V9dlfmrPb2LjkQLPNlzmuhbsdjrzch5vRpu/xO28QOG8wggXmMIID
zqADAgECAhBqm+E4O/8ra58B1dm4p1JWMA0GCSqGSIb3DQEBDAUAMIGFMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFD
T01PRE8gQ0EgTGltaXRlZDErMCkGA1UEAxMiQ09NT0RPIFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhv
cml0eTAeFw0xMzAxMTAwMDAwMDBaFw0yODAxMDkyMzU5NTlaMIGXMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01P
RE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24g
YW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL6znles
KHZ1QBbHOAOY08YYdiFQ8yV5C0y1oNF9Olg+nKcxLqf2NHbZhGra0D00SOTq9bus3/mxgUsg/Wh/
eXQ0pnp8tZ8XZWAnlyKMpjL+qUByRjXCA6RQyDMqVaVUkbIr5SU0RDX/kSsKwer3H1pT/HUrBN0X
8sKtPTdGX8XAWt/VdMLBrZBlgvnkCos+KQWWCo63OTTqRvaq8aWccm+KOMjTcE6s2mj6RkalweyD
I7X+7U5lNo6jzC8RTXtVV4/Vwdax720YpMPJQaDaElmOupyTf1Qib+cpukNJnQmwygjD8m046DQk
LnpXNCAGjuJy1F5NATksUsbfJAr7FLUCAwEAAaOCATwwggE4MB8GA1UdIwQYMBaAFLuvfgI9+qbx
PISOre44mOzZMjLUMB0GA1UdDgQWBBSCr2yM+MX+lmF86B89K3FIXsSLwDAOBgNVHQ8BAf8EBAMC
AYYwEgYDVR0TAQH/BAgwBgEB/wIBADARBgNVHSAECjAIMAYGBFUdIAAwTAYDVR0fBEUwQzBBoD+g
PYY7aHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0
eS5jcmwwcQYIKwYBBQUHAQEEZTBjMDsGCCsGAQUFBzAChi9odHRwOi8vY3J0LmNvbW9kb2NhLmNv
bS9DT01PRE9SU0FBZGRUcnVzdENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2Rv
Y2EuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQB4XLKBKDRPPO5fVs6fl1bsj6JrF/bz9kkIBtTYLzXN
30D+03Hj6OxCDBEaIeNmsBhrJmuubvyE7HtoSmR809AgcYboW+rcTNZ/8u/Hv+GTrNI/AhqX2/ki
QNxmgUPt/eJPs92Qclj0HnVyy9TnSvGkSDU7I5Px+TbO+88G4zipA2psZaWeEykgzClZlPz1FjTC
kk77ZXp5cQYYexE6zeeN4/0OqqoAloFrjAF4o50YJafX8mnahjp3I2Y2mkjhk0xQfhNqbzlLWPoT
3m7j7U26u7zg6swjOq8hITYc3/np5tM5aVyu6t99p17bTbY7+1RTWBviN9YJzK8HxzObXYWBf/L+
VGOYNsQDTxAk0Hbvb1j6KjUhg7fO294F29QIhhmiNOr84JHoy+fNLpfvYc/Q9EtFOI5ISYgOxLk3
nD/whbUe9rmEQXLp8MB933Ij474gwwCPUpwv9mj2PMnXoc7mbrS22XUSeTwxCTP9bcmUdp4jmIoW
fhQm7X9w/Zgddg+JZ/YnIHOwsGsaTUgj7fIvxqith7DoJC91WJ8Lce3CVJqb1XWeKIJ84F7YLXZN
0oa7TktYgDdmQVxYkZo1c5noaDKH9Oq9cbm/vOYRUM1cWcef20Wkyk5S/GFyyPJwG0fR1nRas3Dq
Af4cXxMiEKcff7PNa4M3RGTqH0pWR8p6EjGCA7owggO2AgEBMIGtMIGXMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFD
T01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRp
b24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAL1XDkPIZ5isCEQYiG53YaMwCQYFKw4DAhoFAKCCAeEw
GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTUwNDEzMjEyNDA1WjAj
BgkqhkiG9w0BCQQxFgQU0vCOctPiqGyzB02o6+cJNzT8kiQwgb4GCSsGAQQBgjcQBDGBsDCBrTCB
lzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xp
ZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQC9Vw5DyGeYrAhEGIhud2Gj
MIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQC9Vw5DyGeYrAhEGIhud2GjMA0GCSqGSIb3DQEBAQUABIIBALcyG/NjfxVupCRX73Th
Ronrou1if7kRHG00i2Q1DR2aoxj7MesfneDILk7igvLpEx5Kin6s1QuJehyorgUGSvoXNsiBmx+8
SZMDPgdpHzCTAm/yS4Df/wnwg+Bc86l3YllHwBqXr8jXGttSCA7MiorEC4UstymohO+L1hpjYTH8
saYbFNntwnFt5ChO4zVrVDpxbs3zPkonOTq+d3MBixmDPK9/PF6L01Rd2JY3VGj8e9G4woePKLuj
3qdN+J+PNdWVWCujN13iddxCFfPNNm0q0dMu0fVMBeSTYJEa6Ep5Uk6bNOJoyrrQxNkdSfTUcEBJ
geL3C/+sWZSm4UKsn+kAAAAAAAA=
--Apple-Mail=_66262E93-5C92-4E4C-BEA4-D2E1006EDCF0--
