Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA78C20282
	for <e@80x24.org>; Tue, 20 Jun 2017 12:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbdFTMcl (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 08:32:41 -0400
Received: from gtlbmlpps0101.mail.arvato-systems.de ([84.17.190.201]:39399
        "EHLO gtlbmlpps0101.mail.arvato-systems.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751106AbdFTMck (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Jun 2017 08:32:40 -0400
Received: from pps.filterd (gtlbmlpps0101.mail.arvato-systems.de [127.0.0.1])
        by gtlbmlpps0101.mail.arvato-systems.de (8.16.0.20/8.16.0.20) with SMTP id v5KCUmN0011598;
        Tue, 20 Jun 2017 14:32:37 +0200
Received: from gtlbmlxct0004.bagmail.net ([145.228.229.249])
        by gtlbmlpps0101.mail.arvato-systems.de with ESMTP id 2b4v4rp68k-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 20 Jun 2017 14:32:37 +0200
Received: from GTLBML3EX0003.bagmail.net (145.228.190.203) by
 GTLBMLXCT0004.bagmail.net (145.228.229.249) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 20 Jun 2017 14:32:36 +0200
Received: from GTLBML3EX0005.bagmail.net (145.228.190.205) by
 GTLBML3EX0003.bagmail.net (145.228.190.203) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Tue, 20 Jun 2017 14:32:36 +0200
Received: from GTLBML3EX0005.bagmail.net ([fe80::9c:dbb6:e2ae:baae]) by
 GTLBML3EX0005.bagmail.net ([fe80::9c:dbb6:e2ae:baae%22]) with mapi id
 15.00.1263.000; Tue, 20 Jun 2017 14:32:36 +0200
From:   <paul.mattke@s4m.com>
To:     <larsxschneider@gmail.com>
CC:     <git@vger.kernel.org>
Subject: AW: Transform log message during migration svn -> git (using git-svn)
Thread-Topic: Transform log message during migration svn -> git (using
 git-svn)
Thread-Index: AdLpl0Xlhavyu/yyR3WJmtAnNLgYzQAAAyQAAAppLvA=
Date:   Tue, 20 Jun 2017 12:32:35 +0000
Message-ID: <90ee80a910884e1e98fa8a5001ae850c@GTLBML3EX0005.bagmail.net>
References: <8ce2bf074fcf4d6181a29eb3e7fff132@GTLBML3EX0005.bagmail.net>
 <EAA4B747-FA00-4A3B-88CD-AF8EBE1F8586@gmail.com>
In-Reply-To: <EAA4B747-FA00-4A3B-88CD-AF8EBE1F8586@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.14.6.79]
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
        micalg=SHA1; boundary="----=_NextPart_000_008B_01D2E9D2.0E84E4C0"
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-11.0.0.4283-8.100.1062-23144.001
X-TM-AS-Result: No--23.432600-8.000000-31
X-TM-AS-MatchedID: 150657-705584-700752-703747-711953-707078-702271-704049-7
        07451-702037-106470-705450-106580-700071-700276-708196-852748-863737-705386
        -853550-703523-850298-701305-700476-139010-700412-700075-709584-704980-7076
        63-707163-701594-702931-702267-703712-705461-139630-707911-105700-708339-70
        2376-700756-863828-136070-702020-705178-188199-148035-148051-20043-23116-42
        002-42003-52000
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-06-20_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

------=_NextPart_000_008B_01D2E9D2.0E84E4C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Well this is a possibility, of course. Our problem is that our SVN
repository contains about 220.000 revisions currently. As a colleague of
mine said that the command you suggest might take about 4 seconds per
revision, it would take about 10 days to do this for our whole =
repository.
So of course it could save a lot of time generally if such operation =
could
be done immediately during git-svn.

Paul Mattke
Software Developer
-------------------------------------------------
Arvato Systems S4M GmbH
Am Coloneum 3
50829 K=F6ln
=A0
Phone: +49 221 28555-443
Fax: +49 221 28555-210
E-Mail:=A0paul.mattke@s4m.com
www.s4m.arvato-systems.com


-----Urspr=FCngliche Nachricht-----
Von: Lars Schneider [mailto:larsxschneider@gmail.com]=20
Gesendet: Dienstag, 20. Juni 2017 11:32
An: Mattke, Paul, NMM-BPDD <paul.mattke@s4m.com>
Cc: git@vger.kernel.org
Betreff: Re: Transform log message during migration svn -> git (using
git-svn)


> On 20 Jun 2017, at 09:32, paul.mattke@s4m.com wrote:
>=20
> Hi there,
>=20
> this is actually not really a bug report, but much more a feature=20
> request (if I did not oversee an already existing feature like this):
>=20
> We want to migrate our SVN repository to GIT and will be using git-svn =

> for that of course. Currently in SVN, all our commit log messages=20
> start either
> with:
>=20
> 123456 (a number, representing the Bug Id in our old legacy bug=20
> tracker)
>=20
> or
>=20
> T123456 (a number, but prefixed with T, referring a TFS item in this=20
> case)
>=20
> During conversion to GIT, we want to replace the T in such log=20
> messages with a #, so commits, referring a TFS item will start with
#123456 in the future.
> We don=92t care about log messages which do not start with a T, only =
the=20
> TXXXXXX messages need to be transformed here.
>=20
> I guess an operation like this is currently not possible with git-svn, =

> isn=92t it? So it would be nice, if a feature could be implemented =
that=20
> gives the user the possibility to specify some kind of script file for =

> example, which transforms the log message in any way we want it.

You can migrate your repo from SVN to Git as is. Afterwards you can fix =
up
the commit messages with the following command:

git filter-branch -f --msg-filter 'perl -lape "s/^T(\d+)/#\$1/"'

(this might take a while on a large repo)

- Lars

------=_NextPart_000_008B_01D2E9D2.0E84E4C0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIISCzCCBccw
ggOvoAMCAQICECzGe5Jp6H93DXHA5J/yLj4wDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNVBAYTAkdC
MRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoT
EUNPTU9ETyBDQSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRpb24gQXV0
aG9yaXR5MB4XDTE1MDYxNTAwMDAwMFoXDTIwMDYxNDIzNTk1OVowUzELMAkGA1UEBhMCREUxDzAN
BgNVBAcTBkJlcmxpbjEVMBMGA1UEChMMRC1UcnVzdCBHbWJIMRwwGgYDVQQDExNELVRSVVNUIENB
IDItMSAyMDE1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAm9zSLAsNb8I8XMlPG+gQ
Y+uGVarqHArHK+vukmi7F9xz2jhTyfWO/Enp7jl/gEiyVGvBM17rOlWyLoW/mMJ9sO4jln9kz62q
4A4YTr6GIuTq9IhGlbO0CRtdcNCx5RrbP8TyfEi5M3mEoKCadZsfmv+7zQgKkgTeZ+kGmS7DC4X9
PbrXZFdTDInxEL+QsXgr6aqItPU3uBRIg89VVRDi689ZbWS3LAVw8ZRZinjSfbpN4JXqytza/Z7o
qhzwGJe9D51oAi2S2NefX1l6WarA16GiJqVZkR8BPRK85BIOiQCRKa3ZN/fzGH6vgFH8geypIbgG
wmhd+sfy2aZhmC1EjwIDAQABo4IBYjCCAV4wHwYDVR0jBBgwFoAUu69+Aj36pvE8hI6t7jiY7Nky
MtQwHQYDVR0OBBYEFKA9keAI/iLPXo/onfTWFn9fjYMwMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMB
Af8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDAYBgNVHSAEETAPMA0G
CysGAQQBpTQCgUgCMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NP
TU9ET1JTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHEGCCsGAQUFBwEBBGUwYzA7BggrBgEF
BQcwAoYvaHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQWRkVHJ1c3RDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwFAAOCAgEAFy+B
GxmzV89Cz6H7yAwwbcDv2pQCpDJabAT/flx3ec1AwcHdBe6EhFDfjB5XDrdBdL4MNDtY9z8gZWbp
dYJ4MYIUTql+U57TbZvuMwsrbpm4zdZWDt1w6balw/EnXf2mkNG9uUo49l4iUja2SfQ1ObSXK79v
a/pKvZxXbA+2U8muKFa4TmIxuy/0txLkQH6HJ7/RQNsUpR4gAS/NWuYx3yyJ32/JT6keSGItQ3xL
W49lFamsNZqd+bJovVMk2WWBSpH9TlVxAlcVhOx8oXhCI2KT4nWAFKZDXhfcS0f7VdF3OqIcfphC
foCWgejgnUsGCM+pTcbR9eggRlf0mMQOVm7Sz15SH3q9H8yv/L4+/Hy9w3WwAIERPcPSNf3le+6Y
SRcI3is51Okgk8PuBYTmQf9EceBL9ixSqlQCtUaMc/A8cZaKG6HmuotzeXNaUnJVYb9DtmRqWdd8
DcSk+ez7gujJf4wgfCCKusbccFHmMNZ6FiVO8hrYaTmu69kYF/ubDDkgDAE6LmFVBBT6BCzokTMX
P5ebWKLCSzZxU/8wjrU5dFkOua2QR3FXpzBF4tX0r3cPGecsZgkbJ0T5Sr0r5dz8Eq6xLLPAATK9
+CI0eVpypM6TstskvLnlhOiEidygPiTK85z9VEbc7VNNxWb6SgyYdynPB8cbIcaCLZmWP4wwggXY
MIIDwKADAgECAhBMqvnK22Nv4B/3TthbA4adMA0GCSqGSIb3DQEBDAUAMIGFMQswCQYDVQQGEwJH
QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQK
ExFDT01PRE8gQ0EgTGltaXRlZDErMCkGA1UEAxMiQ09NT0RPIFJTQSBDZXJ0aWZpY2F0aW9uIEF1
dGhvcml0eTAeFw0xMDAxMTkwMDAwMDBaFw0zODAxMTgyMzU5NTlaMIGFMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFD
T01PRE8gQ0EgTGltaXRlZDErMCkGA1UEAxMiQ09NT0RPIFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhv
cml0eTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAJHoVJLSClaxrA0k3cXPRGd0mSs3
o30jcABxvFPfxPoqEo9LfxBWvZ9wcrdhf8lLDxenPeOwBGHu/xGXx/SGPgr6Plz5k+Y0etkUa+ec
s4Wggnp2r3GQ1+z9DfqcbPrfsIL0FH75vsSmL09/mX+1/GdDcr0MANaJ62ss0+2PmBwUq37l4278
2KjkkiTaQ2tiuFX96sG8bLaL8w6NmuSbbGmZ+HhIMEXVreENPEVg/DKWUSe8Z8PKLrZr6kbHxyCg
sR9l3kgIuqROqfKDRjeE6+jMgUhDZ05yKptcvUwbKIpcInu0q5jZ7uBRg8MJRk5tPpn6lRfafDNX
QTyNUe0LtlyvLGMa31fIP7zpXcSbr0WZ4qNaJLS6qVY9z2+q/0lYvvCo//S4rek3+7q49As6+ehD
Qh6J2ITLE/HZu+GJYLiMKFasFB2cCudx688O3T2plqFIvTz3r7UNIkzAEYHsVjv206LiW7eyBCJS
lYCTaeiOTGXxkQMtcHQC6otnFSlpUgK7199QalVGv6CjKGF/cNDDoqosIapHziicBkV2v4IYJ7TV
rrTLUOZr9EyGcTDppt8WhuDY/0Dd+9BCiH+jMzouXB5BEYFjzhhxayvspoq3MVw6akfgw3lZ1iAa
r/JqmKpyvFdK0kuduxD8sExB5e0dPV4onZzMv7NR2qdH5YRTAgMBAAGjQjBAMB0GA1UdDgQWBBS7
r34CPfqm8TyEjq3uOJjs2TIy1DAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zANBgkq
hkiG9w0BAQwFAAOCAgEACvHVRoS3rlG7bLJNQRQAk0ycy+XAVM+gJY4C+f2wog31IJg8Ey2sVqKw
1n4Rkukuup4umnKxvRlEbGE1opq0FhJpWozh1z6kGugvA/SuYR0QGyqki3rF/gWm4cDWyP6ero8r
uj2Z+NhzCVhGbqac9Ncn05XaN4NyHNNz4KJHmQM4XdVJeQApHMfsmyAcByRpV3iyOfw6hKC1nHyN
vy6TYie3OdoXGK69PAlo/4SbPNXWCwPjV54U99HrT8i9hyO3tklDeYVcuuuSC6HG6GioTBaxGpkK
6FMskruhCRh1DGWoe8sjtxrCKIXDG//QK2LvpHsJkZhnjBQBzWgGamMhdQOAiIpugcaF8qmkLef0
pSQQR4PKzfSNeVixBpvnGirZnQHXlH3tA0rK8NvoqQE+9VaZyR6OST275Qm54E9Jkj0WgkDMzFnG
5jrtEi5pPGyVsf2qHXt/hr4eDjJG+/sTj3V/TItLRmP+ADRAcMHDuaHdpnDiBLNBvOmAkepknHrh
IgOpnG5vDmVPbIeHXvNuoPl1pZtA6FOyJ51KucB3IY3/h/LevIzvF9+3SQvR8m4wCxoOTnbtEfz1
6Vayfb/HbQqTjKXQwLYdvjpOlKLXbmwLwop8+iDzxOTlzQ2oy5GSsXyF7LUUaWYOgufNzsgtplF/
IcE1U4UGSl2frbsbX3QwggZgMIIFSKADAgECAhBm6LUUf1gSGUkA0JxAp0LYMA0GCSqGSIb3DQEB
CwUAMFMxCzAJBgNVBAYTAkRFMQ8wDQYDVQQHEwZCZXJsaW4xFTATBgNVBAoTDEQtVHJ1c3QgR21i
SDEcMBoGA1UEAxMTRC1UUlVTVCBDQSAyLTEgMjAxNTAeFw0xNzAyMjQwNzAzMjBaFw0xODAyMjcw
NzAzMjBaMIGuMQswCQYDVQQGEwJERTEgMB4GA1UEChMXYXJ2YXRvIFN5c3RlbXMgUzRNIEdtYkgx
FDASBgNVBAMTC1BhdWwgTWF0dGtlMRUwEwYDVQQFEwxDU00wMDUyMDM5NzYxDjAMBgNVBAcMBUvD
tmxuMSIwIAYJKoZIhvcNAQkBFhNwYXVsLm1hdHRrZUBzNG0uY29tMRwwGgYDVQQIExNOb3Jkcmhl
aW4tV2VzdGZhbGVuMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAj5OR48ElM5i2S8hu
pVEg3WaoaXMu/ft72S9iT/JUyXmoBPju1OVEFOVObZjNTOf9m5sq/ObT2t6YfKuFwaojsKF2tHvW
Ao4ggqP+OeGf7ArlD2o3ufaMqq5RpeII5cNIsXPsmhgn6D1xGynQBfSjor/hGsmck7doWCmst39L
oCT5LB3Zd4hMKlQJB7h8m0yV2kr8/tJijHvzyo5GcWkp2OSBnOGRbabETk5QThOIQKLILXYmJC2b
TGPqMUs7cwGCIgf+evuSjIutkZOXEpHWsixYnqFDAkCD9eawQ6HpmqsDOyuyF6b3DA4RIGchweA3
HzEGu6Fd5rapNDpzW+0htQIDAQABo4IC0jCCAs4wNAYDVR0lBC0wKwYIKwYBBQUHAwIGCCsGAQUF
BwMEBggrBgEFBQcDBwYLKwYBBAGCNwMKAwwwHwYDVR0jBBgwFoAUoD2R4Aj+Is9ej+id9NYWf1+N
gzAwgf4GCCsGAQUFBwEBBIHxMIHuMDcGCCsGAQUFBzABhitodHRwOi8vZC10cnVzdC1jYS0yLTEt
MjAxNS5vY3NwLmQtdHJ1c3QubmV0MEIGCCsGAQUFBzAChjZodHRwOi8vd3d3LmQtdHJ1c3QubmV0
L2NnaS1iaW4vRC1UUlVTVF9DQV8yLTFfMjAxNS5jcnQwbwYIKwYBBQUHMAKGY2xkYXA6Ly9kaXJl
Y3RvcnkuZC10cnVzdC5uZXQvQ049RC1UUlVTVCUyMENBJTIwMi0xJTIwMjAxNSxPPUQtVHJ1c3Ql
MjBHbWJILEM9REU/Y0FDZXJ0aWZpY2F0ZT9iYXNlPzBvBgNVHSAEaDBmMFoGCysGAQQBpTQCgUgC
MEswSQYIKwYBBQUHAgEWPWh0dHA6Ly93d3cuZC10cnVzdC5uZXQvaW50ZXJuZXQvZmlsZXMvRC1U
UlVTVF9DU01fUEtJX0NQUy5wZGYwCAYGBACPegEDMIGzBgNVHR8EgaswgagwgaWggaKggZ+GaWxk
YXA6Ly9kaXJlY3RvcnkuZC10cnVzdC5uZXQvQ049RC1UUlVTVCUyMENBJTIwMi0xJTIwMjAxNSxP
PUQtVHJ1c3QlMjBHbWJILEM9REU/Y2VydGlmaWNhdGVyZXZvY2F0aW9ubGlzdIYyaHR0cDovL2Ny
bC5kLXRydXN0Lm5ldC9jcmwvZC10cnVzdF9jYV8yLTFfMjAxNS5jcmwwHQYDVR0OBBYEFKyJLyJT
q2d/XbskL4xQHPwzAPvOMA4GA1UdDwEB/wQEAwIEsDAeBgNVHREEFzAVgRNwYXVsLm1hdHRrZUBz
NG0uY29tMA0GCSqGSIb3DQEBCwUAA4IBAQBWpoFfuJL4XBeGGMXTalwm/pZcsZ8cxbkmj2Up/R12
iimMCuGgKDolvf9pNljj+OZLSn89QQY6qoOcKIfGvY4TSUgEDOR5jf3wUGXK/shMemSCoBxTG22W
JZMN4fnuE96jyHufqu4uoyFyw6EDmDt3gY6EGUtBhPhIB4yBQqAzE92VhS1NZZvrRuPSO9SrfYE0
2T6oIjeLj4aN2OTHdFUJ2hw5bhWB2I9kmN21rpwFyi7atYsbRA7VtGEn46L0xYbatfaP5qep6Ghq
R5ehjae/WGHCAXZS5QiB1KZRnw3vqUY3Y2HPArHXLGN3SV7/qtF9zewgTsjA5LsjhxA4gSskMYID
dzCCA3MCAQEwZzBTMQswCQYDVQQGEwJERTEPMA0GA1UEBxMGQmVybGluMRUwEwYDVQQKEwxELVRy
dXN0IEdtYkgxHDAaBgNVBAMTE0QtVFJVU1QgQ0EgMi0xIDIwMTUCEGbotRR/WBIZSQDQnECnQtgw
CQYFKw4DAhoFAKCCAeUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MTcwNjIwMTIzMjM0WjAjBgkqhkiG9w0BCQQxFgQUsqD0CxqVs/ox4Fk39MmB0DgiHNUwdgYJKwYB
BAGCNxAEMWkwZzBTMQswCQYDVQQGEwJERTEPMA0GA1UEBxMGQmVybGluMRUwEwYDVQQKEwxELVRy
dXN0IEdtYkgxHDAaBgNVBAMTE0QtVFJVU1QgQ0EgMi0xIDIwMTUCEGbotRR/WBIZSQDQnECnQtgw
eAYLKoZIhvcNAQkQAgsxaaBnMFMxCzAJBgNVBAYTAkRFMQ8wDQYDVQQHEwZCZXJsaW4xFTATBgNV
BAoTDEQtVHJ1c3QgR21iSDEcMBoGA1UEAxMTRC1UUlVTVCBDQSAyLTEgMjAxNQIQZui1FH9YEhlJ
ANCcQKdC2DCBkwYJKoZIhvcNAQkPMYGFMIGCMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYI
KoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUr
DgMCGjALBglghkgBZQMEAgMwCwYJYIZIAWUDBAICMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQAq3OnLPClGjrxg59YeeDqdQPnQnn2b+/DCS8WWIWDRy0KczImzPoZG8Nlt1IT+/pWgzFqA
Sk/458aYc30Yq+P7a98RHeYzGPtUaUVcJJXp/yRSlHx+Gps2GqN7egqmiwHjOORn8LCPs7SBh3iQ
Ooly9SCQJaqwWXgr+7xB6uaHYpVdHl1K/VaLD86fPmnGY2eR+lkqn67AYpSIr83DbP91U8LYnS+j
PF9WqXHvEaA6o55otvrcQ+fq/zwtw12p24oUDHTu43G/3+GDQ+xtp2IiCJvb1PQkyOe/81HNDItd
E1G8YnvYOP/e9gShoAA3KX56zwgm3uhYGvYvL4MszjumAAAAAAAA

------=_NextPart_000_008B_01D2E9D2.0E84E4C0--
