Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF0561F461
	for <e@80x24.org>; Tue, 20 Aug 2019 19:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfHTTeg (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 15:34:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40418 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbfHTTef (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 15:34:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so3652486wmj.5
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 12:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mat.ucm.es; s=google;
        h=from:to:cc:subject:references:reply-to:date:message-id:user-agent
         :mime-version;
        bh=1mBK2tGjioY2jBg8tWJkpfJC2BPr+oqYk+8/YCj82bc=;
        b=HbCAiOfvVG09fJCQUQTnQti2DtJitbeMjpapcy8Mb0N6Y3m99kW/qbyviks+j9z6hp
         D6FAgmNkPvMHMn0m2E2w4FpP3sx3fyyFnapkMuZRqHpwxzZmEzJURQFiiETJ5VziF0y5
         PqrD8Cn3FNmT3vhbfytAsIotxMVPgz8qQmqwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:reply-to:date
         :message-id:user-agent:mime-version;
        bh=1mBK2tGjioY2jBg8tWJkpfJC2BPr+oqYk+8/YCj82bc=;
        b=iW+GKy97rGrJ5FXn50Cq5J+jhnCNMM8Sy4sjTsrjK3uRNNKJe6dyOjwVFPyK4bLyDY
         JO6kTIm6WA1U0tVNO9d6fOqgtGsP6vl88odhxo1h6cBFVUX7GVD6yagxW6+cSN0e+92a
         dDd2X/9F1+w3UJdWp2bENCVjlyiKBeyez46TYZ71lCaiSvFB67mgVBRHwkxjRaRYjshF
         lRaTbnpW9mgUL+CtAvLNj01chkciujDs7j55p7OokJup3u9x/XRFN/PrktEUEih45JsM
         ahnUy6H8tTliV+llgM+gOW7ycsJ5hRB4bGfK6O8I6L7tknvXiW9GOSh3SNaL63fcwocX
         rwcQ==
X-Gm-Message-State: APjAAAWwyoasPRA/Rn5eLXPImh6YrnrDPM0KvoS9ttfDTXi8ujGuXXKw
        bWoyUOBoT+abeDJFfuTDs1iicQ==
X-Google-Smtp-Source: APXvYqzKxhE5ABsGKx45dSwBgS6i8RY/jJi1CM3z7QqepZ1rhBivPKE6Rmx5xLI3KRUqMMLiYnEo7g==
X-Received: by 2002:a1c:5402:: with SMTP id i2mr1712542wmb.41.1566329671400;
        Tue, 20 Aug 2019 12:34:31 -0700 (PDT)
Received: from Utnapischtim (p2003000611CFBC14D5AD6B2F5C7C552A.dip0.t-ipconnect.de. [2003:6:11cf:bc14:d5ad:6b2f:5c7c:552a])
        by smtp.gmail.com with ESMTPSA id q124sm640471wma.33.2019.08.20.12.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 12:34:29 -0700 (PDT)
X-Mailer: emacs 27.0.50 (via feedmail 11-beta-1 I)
From:   Uwe Brauer <oub@mat.ucm.es>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Uwe Brauer <oub@mat.ucm.es>,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [problem with name-rev]
References: <87blwq7rn5.fsf@mat.ucm.es> <20190818190032.GA11185@rigel>
        <87pnkzkivn.fsf_-_@mat.ucm.es>
        <xmqqh86bvgsz.fsf@gitster-ct.c.googlers.com>
Reply-To: Uwe Brauer <oub@mat.ucm.es>
X-Hashcash: 1:20:190820:alban.gruin@gmail.com::ubJHLR8btYEbhTh3:00000000000000000000000000000000000000000jBA
X-Hashcash: 1:20:190820:oub@mat.ucm.es::lQaRSq7ENTGWA/+6:0000NAH
X-Hashcash: 1:20:190820:gitster@pobox.com::HuecfHVkH8sR9+Wd:000000000000000000000000000000000000000000004cA2
X-Hashcash: 1:20:190820:rafa.almas@gmail.com::w0ZnKqp9ThzR4sK7:0000000000000000000000000000000000000000094C0
X-Hashcash: 1:20:190820:git@vger.kernel.org::OBBFr+iNKDY7f7cW:0000000000000000000000000000000000000000007Xne
Date:   Tue, 20 Aug 2019 21:34:22 +0200
Message-ID: <87k1b7k4w1.fsf@mat.ucm.es>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=sha256; protocol="application/pkcs7-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

>>> "JCH" =3D=3D Junio C Hamano <gitster@pobox.com> writes:

   > Uwe Brauer <oub@mat.ucm.es> writes:
   >> Gives
   >> *   changeset: ae68dbe:master
   >> |\  user:      Uwe Brauer
   >> | | date:      Tue Aug 20 16:25:53 2019 +0200
   >> | | summary:   1.2.1/1.1
   >> | |
   >> | * changeset: c00bb5d:master^2
   >> | | user:      Uwe Brauer
   >> | | date:      Tue Aug 20 16:25:53 2019 +0200
   >> | | summary:   1.2.1
   >> | |
   >> | * changeset: 54c9230:master^2~1
   >> | | user:      Uwe Brauer
   >> | | date:      Tue Aug 20 16:25:53 2019 +0200
   >> | | summary:   1.2
   >> | |
   >> * | changeset: da0712f:master~1
   >> |/  user:      Uwe Brauer
   >> |   date:      Tue Aug 20 16:25:53 2019 +0200
   >> |   summary:   1.1
   >> |
   >> * changeset: 8eb999d:master~2
   >> user:      Uwe Brauer
   >> date:      Tue Aug 20 16:25:53 2019 +0200
   >> summary:   1
   >>=20
   >> That looks odd.
   >>=20
   >> Any comments?

   > When you make a merge like the ae68dbe, merging a topic with two
   > commits 54c9230 and c00bb5d into the then-current tip of the master
   > branch da0712f, _all_ direct parents are recorded in the resulting
   > merge commit, so the first parent of it is denoted as ae68dbe~1
   > (which is da0712f) and the second parent of it ae68dbe^2 (which is
   > c00bb5d).




   > There is no linear ordering between these two commits, so c00bb5d
   > will *never* be named as master~<some-number>.  As a commit on a
   > side branch, its description from the tip of 'master' will always
   > involve some ^2 (the second parent of some merge commit) somewhere
   > in its name-rev result.

Hm I realize that I understand git much less than I thought (I thought
it is like mercurial, where git branches are mercurial bookmarks more or
less). It turns out that this is not the case.

Take the following part of what I did

git init=20
echo 1 > 1
git add 1
git commit -m 1
echo 1.1 > 1
git add .
git commit -m 1.1
git checkout -b foo master~1
echo 1.2 > 1
git add .
git commit -m 1.2
echo 1.2.1 > 1
git add .
git commit -m 1.2.1
git checkout master

There are 4  commits.

But=20

Git --log --graph --decorate=20

Returns
* commit 98922f82932cd1bef58bebf0229367922bca45fc (HEAD -> master)
| Author: Uwe Brauer <oub@mat.ucm.es>
| Date:   Tue Aug 20 21:19:59 2019 +0200
|
|     1.1
|
* commit 8f565d59c356a6038e3d8a7f5dcd2e4a39ae1bb4
  Author: Uwe Brauer <oub@mat.ucm.es>
  Date:   Tue Aug 20 21:19:59 2019 +0200


If I would do the same with mercurial (either with bookmarks or with
named branches) I receive=20

hg init=20
echo 1 > 1
hg add 1
hg commit -m 1
hg branch foo
echo 1.1 > 1
hg add .
hg commit -m 1.1
hg branch master=20
echo 1.2 > 1
hg add .
hg commit -m 1.2
echo 1.2.1 > 1
hg add .
hg commit -m 1.2.1
hg checkout master




@  changeset:   3:9ebcc17a6389
|  branch:      master
|  tag:         tip
|  user:        Uwe Brauer <oub@mat.ucm.es>
|  date:        Tue Aug 20 21:27:05 2019 +0200
|  summary:     1.2.1
|
o  changeset:   2:e02d297e2f75
|  branch:      master
|  user:        Uwe Brauer <oub@mat.ucm.es>
|  date:        Tue Aug 20 21:27:04 2019 +0200
|  summary:     1.2
|
o  changeset:   1:7ddaef206d57
|  branch:      foo
|  user:        Uwe Brauer <oub@mat.ucm.es>
|  date:        Tue Aug 20 21:27:04 2019 +0200
|  summary:     1.1
|
o  changeset:   0:dbf3c9975cf3
   user:        Uwe Brauer <oub@mat.ucm.es>
   date:        Tue Aug 20 21:27:03 2019 +0200
   summary:     1



Funny enough if I convert the git repo, to a hg repo either with hg
convert or with hg clone (and the hg-git plugin)

I receive a different graph

o  changeset:   3:e7b2696c94fb
|  bookmark:    master
|  tag:         tip
|  parent:      0:5dfd9027787a
|  user:        Uwe Brauer <oub@mat.ucm.es>
|  date:        Tue Aug 20 21:19:59 2019 +0200
|  summary:     1.1
|
| o  changeset:   2:277f6423b9c8
| |  bookmark:    foo
| |  user:        Uwe Brauer <oub@mat.ucm.es>
| |  date:        Tue Aug 20 21:19:59 2019 +0200
| |  summary:     1.2.1
| |
| o  changeset:   1:3529c82f37ae
|/   user:        Uwe Brauer <oub@mat.ucm.es>
|    date:        Tue Aug 20 21:19:59 2019 +0200
|    summary:     1.2
|
o  changeset:   0:5dfd9027787a
   user:        Uwe Brauer <oub@mat.ucm.es>
   date:        Tue Aug 20 21:19:59 2019 +0200
   summary:     1


Anyhow, I don't want this message to be interpreted as a flamewar of
sorts.

I don't really know how the import functions work, but I see that git
and mercurial treat commits which look simple to me very differently.=20

Uwe Brauer=20

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
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xOTA4MjAxOTM0MjJaMCgGCSqGSIb3DQEJDzEbMBkwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMC8GCSqGSIb3DQEJBDEiBCA5pX4AtDR3Imxos1Z1KGM5dRAp
wQfGnGBW3Sa3zC0ZIjANBgkqhkiG9w0BAQEFAASCAQB/rExzCcPjh1fHucVqFzBxoSE7qEIGTNWG
AN0C2vyOSTg9C4++TfJkCLywc2L9lIiLM3QNlDQB+3iueOs80hcsktz4HpiFqaVbosbmFlW5El4x
pdRo+4uHP8ur1mnPEcoAUQ5j9t0ISAbXgCWVuVWBO0KWW9+/N8b1wzgteD67lD4IrUlA96OsszyW
aHHx/Dxho6nV5+YIoMZe4LwrqS0Ys9hIzg5ywNbkrsIzIH0PssxMZkCdFGlvUHkCBFAzTHHClQ0T
tsiJjg26yEFNxZX7X3VIF275K5tWlgpffKyqRI+ftVxc8RfK5xKHMLv05EgTydg1/VE814qd/MGF
buXtAAAAAAAA
--=-=-=--
