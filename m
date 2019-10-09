Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325AF1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 13:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbfJINgi (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 09:36:38 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38125 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbfJINgi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 09:36:38 -0400
Received: by mail-wm1-f50.google.com with SMTP id 3so2655008wmi.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 06:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mat.ucm.es; s=google;
        h=from:to:cc:subject:references:reply-to:date:message-id:user-agent
         :mime-version;
        bh=pgeJcDizcEaZyzs5yZdrLLxM/dfjZJ9VJ6Noo4zRe5o=;
        b=imbGn4eLw4QU5+8sUW6xibA4e8zcgDsiFjMcgIYjxNHdM33OljV4N9Of4VyI8SRAMR
         jV8Lw6Y8TtugplgOX0leiycmA82WBBIC8/QsBwrijVAVsJ30X3pf/XCyj7PSYnGlNleS
         NMcjegBdpq5kNqTt8uQvlPXyYh0U4Lx2WVP78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:reply-to:date
         :message-id:user-agent:mime-version;
        bh=pgeJcDizcEaZyzs5yZdrLLxM/dfjZJ9VJ6Noo4zRe5o=;
        b=leYgAkkOzKEBkG30q1NZofHSAJPWW+BhAB90AkmxiFdiR+JxPzHHmIkevcJ4QpVBkW
         M5PogmUMj8oNJm2vkdX8LCVZf3fab/V0VOmFFBNUT8Cq32AQCB0F+A2vYKohs+90/o4i
         yqtMf0REQN8OWCSpyYcT7FHTSqu6+UVWWbYUVs3y3/jP+Q6epksMrCCcQatFpOqlxN/N
         5mRgcW53R0w7ubc0HaS4mi0VHKjtn/LOBK5tyYXXP2elrpUkYxoVfVB5kS2Q6WffAzFM
         GUGt9AwjloYn1UY3pQDbFBmq0VwyAmIFFwo4Oul2cJXV3j0Y0XAGFcTeh56uQoyZmVqb
         NBvQ==
X-Gm-Message-State: APjAAAXd9Z2uZO/M9uB8r2qH8FBENSM9dRaK8CPa4guOjEW6xTXFE/ki
        /YOyTRqickj/cQSu1DMe6KoRbQ==
X-Google-Smtp-Source: APXvYqzb9HjuaFCMlt8ePKFC4XDwTpjYZIJpdZXDefPmPjNXeACjvKv4DrnaN2tCATNgseOXXxUKlg==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr2534303wmj.110.1570628194168;
        Wed, 09 Oct 2019 06:36:34 -0700 (PDT)
Received: from Utnapischtim (bzq-79-181-2-175.red.bezeqint.net. [79.181.2.175])
        by smtp.gmail.com with ESMTPSA id e17sm1583576wma.15.2019.10.09.06.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 06:36:32 -0700 (PDT)
X-Mailer: emacs 27.0.50 (via feedmail 11-beta-1 I)
From:   Uwe Brauer <oub@mat.ucm.es>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Uwe Brauer <oub@mat.ucm.es>, git <git@vger.kernel.org>
Subject: Re: I just pulled, and git log --graph does not show all
References: <87sgomyows.fsf@mat.ucm.es> <20191008230130.GE29845@szeder.dev>
        <871rvmsaxn.fsf@mat.ucm.es> <20191009132345.GH29845@szeder.dev>
Reply-To: Uwe Brauer <oub@mat.ucm.es>
X-Hashcash: 1:20:191009:szeder.dev@gmail.com::/kbKLFsDXlQt36WQ:000000000000000000000000000000000000000001SQb
X-Hashcash: 1:20:191009:oub@mat.ucm.es::dVXvKa7xpMvsiZXm:0002Wl+
X-Hashcash: 1:20:191009:git@vger.kernel.org::vCov1ERCPvG2en8e:00000000000000000000000000000000000000000057aS
Date:   Wed, 09 Oct 2019 16:36:26 +0300
Message-ID: <87ftk2oxb9.fsf@mat.ucm.es>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=sha256; protocol="application/pkcs7-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>>> "SG" =3D=3D SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

   > On Wed, Oct 09, 2019 at 09:13:56AM +0300, Uwe Brauer wrote:
   >> Could you please try out=20
   >> git clone https://git.code.sf.net/p/matlab-emacs/src matlab-emacs-hg

   > This repository contains two branches: 'master' and 'strings'.  From
   > these two 'master' is the default branch, so that is that 'git clone'
   > will check out for you; note the '*' in front of 'master':

Ok hg does the same, so I see the difference is in the git log --graph
command.


   >   $ git branch --all
   >   * master
   >     remotes/origin/HEAD -> origin/master
   >     remotes/origin/master
   >     remotes/origin/strings

   >> Then you will see
   >>=20
   >> That=20
   >> git log --graph
   >> and
   >>=20
   >> git log --graph --all
   >>=20
   >> Are giving two different results and I don't understand why the branch
   >> is not shown when using=20
   >>=20
   >> git log --graph

   > Without any ref parameter 'git log' shows the history starting at the
   > currently checked out commit (in this respect it behaves the same way
   > as 'hg log'), so it only shows the history of 'master'.  'git log
   > --all' means "show the history of all refs in the repository", so it
   > shows the history of the remote branch 'strings' as well.

This is the difference, hg log -G always show all the commit starting
with tip (basically the same as HEAD), the behavior you described would
be=20

  hg log -G --follow

   > As far as I can tell all Git commands above behave as they should.

   >> Funny thing is when I use the hg-git plugin and run=20
   >>=20
   >> hg clone https://git.code.sf.net/p/matlab-emacs/src matlab-emacs-hg
   >>=20
   >> I see this branch, converted to a hg bookmark.

   > For some reason after cloning that repository with Mercurial and its
   > hg-git plugin it checks out the 'strings' branch:

   >   $ hg bookmarks=20
   >      master                    170:6c03da83e522
   >    * strings                   195:b2396f3ceca3

   > Consequently, when you run 'hg log' without a branch/bookmark/whatever
   > parameter it shows the history of the 'strings' branch.

   > I'm not sure what to think about 'hg clone' checking out a branch
   > other than the default branch.  In Git this would definitely be a bug.
   > In Mercurial, I don't know; given my limited experience I don't want
   > to outright call it a bug.  I think it would be worth reporting it to
   > the 'hg-git' project.

No I think the point is not the checkout the point is the  hg log -G
command.

I am now not so sure that really the strings branch/bookmark was checked
out I rather think not.

   > Anyway, in your first email you asked how you can merge that branch
   > into 'master'.  The command 'git merge origin/strings' will "merge" it
   > without actually creating a merge commit, because 'strings' builds
   > entirely on top of 'master'; this is what Git calls a "fast-forward
   > merge".  If you do want a merge commit, then run 'git merge --no-ff
   > origin/strings'.


As this is what I was looking for. I actually don't like fast forward,
so I would use the --no-ff option.

That was very helpful, thanks

Uwe=20

--=-=-=
Content-Type: application/pkcs7-signature; name=smime.p7s
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=smime.p7s

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
EwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAL6znlesKHZ1QBbHOAOY08YYdiFQ8yV5C0y1oNF9Olg+nKcxLqf2
NHbZhGra0D00SOTq9bus3/mxgUsg/Wh/eXQ0pnp8tZ8XZWAnlyKMpjL+qUByRjXCA6RQyDMqVaVU
kbIr5SU0RDX/kSsKwer3H1pT/HUrBN0X8sKtPTdGX8XAWt/VdMLBrZBlgvnkCos+KQWWCo63OTTq
Rvaq8aWccm+KOMjTcE6s2mj6RkalweyDI7X+7U5lNo6jzC8RTXtVV4/Vwdax720YpMPJQaDaElmO
upyTf1Qib+cpukNJnQmwygjD8m046DQkLnpXNCAGjuJy1F5NATksUsbfJAr7FLUCAwEAAaOCATww
ggE4MB8GA1UdIwQYMBaAFLuvfgI9+qbxPISOre44mOzZMjLUMB0GA1UdDgQWBBSCr2yM+MX+lmF8
6B89K3FIXsSLwDAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADARBgNVHSAECjAI
MAYGBFUdIAAwTAYDVR0fBEUwQzBBoD+gPYY7aHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RP
UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwcQYIKwYBBQUHAQEEZTBjMDsGCCsGAQUFBzAC
hi9odHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FBZGRUcnVzdENBLmNydDAkBggrBgEF
BQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQB4XLKBKDRP
PO5fVs6fl1bsj6JrF/bz9kkIBtTYLzXN30D+03Hj6OxCDBEaIeNmsBhrJmuubvyE7HtoSmR809Ag
cYboW+rcTNZ/8u/Hv+GTrNI/AhqX2/kiQNxmgUPt/eJPs92Qclj0HnVyy9TnSvGkSDU7I5Px+TbO
+88G4zipA2psZaWeEykgzClZlPz1FjTCkk77ZXp5cQYYexE6zeeN4/0OqqoAloFrjAF4o50YJafX
8mnahjp3I2Y2mkjhk0xQfhNqbzlLWPoT3m7j7U26u7zg6swjOq8hITYc3/np5tM5aVyu6t99p17b
TbY7+1RTWBviN9YJzK8HxzObXYWBf/L+VGOYNsQDTxAk0Hbvb1j6KjUhg7fO294F29QIhhmiNOr8
4JHoy+fNLpfvYc/Q9EtFOI5ISYgOxLk3nD/whbUe9rmEQXLp8MB933Ij474gwwCPUpwv9mj2PMnX
oc7mbrS22XUSeTwxCTP9bcmUdp4jmIoWfhQm7X9w/Zgddg+JZ/YnIHOwsGsaTUgj7fIvxqith7Do
JC91WJ8Lce3CVJqb1XWeKIJ84F7YLXZN0oa7TktYgDdmQVxYkZo1c5noaDKH9Oq9cbm/vOYRUM1c
Wcef20Wkyk5S/GFyyPJwG0fR1nRas3DqAf4cXxMiEKcff7PNa4M3RGTqH0pWR8p6EjCCBScwggQP
oAMCAQICECLAY/HTlgg2ZPbDon99FPswDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNVBAYTAkdCMRsw
GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNP
TU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlv
biBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE5MDEwNjAwMDAwMFoXDTIwMDEwNjIzNTk1OVowHzEd
MBsGCSqGSIb3DQEJARYOb3ViQG1hdC51Y20uZXMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQDAJBqZzDcWLNdUqJsWmomjQHH1BbPl6gKkKT+uLY5hIKZ1+K5kFXrEs0lk+myiS9/wR5Gu
bpwKnr6xNcvtO0XP0dHMLLbu/1sTNg0t1/HOGJSgwUvZUHvUcUVhs/NACD69rh3V5F1w9oIAnXZj
g526lvwWeBv8G6RGBM4+AVFXxaLdNO7G6V8GX9E8goBKGMKIDBAK6f31D1YbPRCEF3voj2UtpVjy
PQXfQhHMZngUjyKChB7vWnHuRF+BIaxd0kWJ3qCPrOHNLHaEjr7bnjp9oZrS4DnnwbNifJBcdZjn
ZYxEDBIoeols9qg4pjT2HsdEi3H6Y/CBKzB1yiMmHBZ1AgMBAAGjggHkMIIB4DAfBgNVHSMEGDAW
gBSCr2yM+MX+lmF86B89K3FIXsSLwDAdBgNVHQ4EFgQUXbdUbNg/WjkhObIK9sKXkRnE4QswDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYIKwYBBQUHAwQGCysGAQQBsjEB
AwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEBATArMCkGCCsG
AQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklo
dHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNl
Y3VyZUVtYWlsQ0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQu
Y29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxD
QS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAZBgNVHREEEjAQgQ5v
dWJAbWF0LnVjbS5lczANBgkqhkiG9w0BAQsFAAOCAQEAtVRJu+IU+1WkBfCbsxbMisE9J3ObD7sN
OCv7cHOT6oJ9xL7ff8qP3+Lu3fkRCPiB7/LuzPT7xyFso0LjJ84mycemvehuOTpwLX5wt2D+mVuw
D/0wUHxpkKLLKIkTuBd4QNXU22UUn9iC4aqB3jgYPppfTKnam66X6PB7pL/7iycuOY06ymZeFGYL
o8CKlrAWvOsik7RfFfamTv1bdNOHuJG0IiH0iDd3GJUxG4N/C3arjWxBcJIwEeKcRA16maLqFt+y
9XyKpccfADI1WACfqn31+r2BvE2thbDDfUiGXVmzVsvPyQZup8uvjBscl6/yRu8bPKH508mPCLU3
+jOlazGCAm4wggJqAgEBMIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5j
aGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsG
A1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBD
QQIQIsBj8dOWCDZk9sOif30U+zANBglghkgBZQMEAgEFAKCBkzAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xOTEwMDkxMzM2MjZaMCgGCSqGSIb3DQEJDzEbMBkwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMC8GCSqGSIb3DQEJBDEiBCBI1W2gdFzoRrKdgVIRSqm+rokR
ebKNABannHXxdAkdMzANBgkqhkiG9w0BAQEFAASCAQA1fWLNZjTgx7BSCgIoiZh3i4bzuvkE8EPh
2TfpZTe24TYEb7pQ89BU8yUdrYuwU8uaPQv+IzoN6uveiUUhvBvXcFzJy9L3Gh38XSjdwH2D9LhB
hH8cbA6UOTq2/NqkRfNTMRXvNbkB/gSJYPMR6nBi0PXRG958FMpMV2u/vPXbSODrw9A98UqyR0jO
a4VTwpPvTFssGuj/dgGAuzncHJvN6CCstukg4y2HTDaAWK59qKwKEEep00UIwspExHDXuiBarDS7
Iawl/Q1HPGA0D0PYXlbSbeOehAQoIsY28jYEkuv1jAp+dF2M6b7kubfJIzSRQl08yvJ9BubzFVJh
Y/deAAAAAAAA
--=-=-=--
