Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7D681F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 06:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfJIGOL (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 02:14:11 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:34453 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfJIGOK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 02:14:10 -0400
Received: by mail-wm1-f49.google.com with SMTP id y135so3956349wmc.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 23:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mat.ucm.es; s=google;
        h=from:to:cc:subject:references:reply-to:date:message-id:user-agent
         :mime-version;
        bh=apW/OXF8fRCA583j39KWyJwrhSKKZYQ6VLqnj7Uz50k=;
        b=HHy8lr/BWxIb2ClT1I1XspxkfnuvF+9SvoPckIxw5sP1BKm4tBjeJo0A2NX75bdXDx
         TH4muFwdqg9jdsp0o0pJNXOX0hGqJSN18uihVgyVN+22oDbyb86Se8hOItGjS3BddjwQ
         SSW0HTK9ZDXrHkGDEdiyH2XP9X7+6NujNZZfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:reply-to:date
         :message-id:user-agent:mime-version;
        bh=apW/OXF8fRCA583j39KWyJwrhSKKZYQ6VLqnj7Uz50k=;
        b=m3wtI/tDmrAETDSSzDJqO+LboVkTmhoG1qgw0Xg2Zc8NVGl+6UzEHOCy21MQyurOwY
         xI1DlfgkE8Y/lStCCyl1EMe3Bw0kkXUoEb8geqnvnJw7xG/U2W8ezjOgozuKDpEj2S21
         zYoHMaRzsatc4Wlee8xVXdkvuv+nsxnBsKmEOOLIpH0ATO2+IT4Fclt71yfDk6DNsqtC
         OImyoK17lAs0jppr+lSkL7dFq8bBsQ6IxpBn7+WdgoN4Ti0QUK82QTsTE1HhnVW2Snpx
         nF6joeQWGjelXTNlTRU+bgdCnOlCSGQUwcLW5zWR6gwIO+hFHsKT1Wt2Ct8CBv+LFxzp
         hs5A==
X-Gm-Message-State: APjAAAXa/RVizOTtVdXvk3y34QJDKLNAJCgxZcImyee6XIsHplT6Zgvg
        F+xHhIBoOGFrTEA1dYM31sCkaolk+BY=
X-Google-Smtp-Source: APXvYqyF5FuoLIR9FfAqK1ZECs2P8G2GV23dd+Zjzxerism1FcZ1P0rA+DhP6FNTRnKAQ6KumPN/sA==
X-Received: by 2002:a1c:f305:: with SMTP id q5mr1174504wmq.137.1570601645807;
        Tue, 08 Oct 2019 23:14:05 -0700 (PDT)
Received: from Utnapischtim ([62.0.197.205])
        by smtp.gmail.com with ESMTPSA id h17sm1419539wme.6.2019.10.08.23.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 23:14:03 -0700 (PDT)
X-Mailer: emacs 27.0.50 (via feedmail 11-beta-1 I)
From:   Uwe Brauer <oub@mat.ucm.es>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Uwe Brauer <oub@mat.ucm.es>, git <git@vger.kernel.org>
Subject: Re: I just pulled, and git log --graph does not show all
References: <87sgomyows.fsf@mat.ucm.es> <20191008230130.GE29845@szeder.dev>
Reply-To: Uwe Brauer <oub@mat.ucm.es>
X-Hashcash: 1:20:191009:oub@mat.ucm.es::Mu+3CzFOT8A1KSRN:0003C/7
X-Hashcash: 1:20:191009:git@vger.kernel.org::VbQH8oUifbEp1q6w:0000000000000000000000000000000000000000004sij
X-Hashcash: 1:20:191009:szeder.dev@gmail.com::XkAbQt8G/jJwVCbP:00000000000000000000000000000000000000000BJLx
Date:   Wed, 09 Oct 2019 09:13:56 +0300
Message-ID: <871rvmsaxn.fsf@mat.ucm.es>
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


   > On Tue, Sep 24, 2019 at 12:22:27PM +0200, Uwe Brauer wrote:

   > I hear you: I had a brief encounter with Mercurial not that long ago,=
=20
   > and there were several things that didn't work the way I expected (or=
=20
   > rather: the way I got used to with Git).  The subtle and sometimes
   > not-so-subtle differences between the concepts and philosophy of the
   > two systems might very well explain why Git didn't work the way you
   > expected.

   > However, it's impossible to give any explanation or advice without
   > knowing more about the situation, e.g. at least the exact commands
   > that you run and what they outputted, if you still have them or at
   > least if you can still reproduce the issue. (with potentially
   > sensitive URLs and/or branchnames redacted, if necessary).

Thanks for your answer.

Could you please try out=20
git clone https://git.code.sf.net/p/matlab-emacs/src matlab-emacs-hg

Then you will see

That=20
git log --graph
and

git log --graph --all

Are giving two different results and I don't understand why the branch
is not shown when using=20

git log --graph

Funny thing is when I use the hg-git plugin and run=20

hg clone https://git.code.sf.net/p/matlab-emacs/src matlab-emacs-hg

I see this branch, converted to a hg bookmark.


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
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xOTEwMDkwNjEzNTZaMCgGCSqGSIb3DQEJDzEbMBkwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMC8GCSqGSIb3DQEJBDEiBCCtfis08FqWDl1QOIW5nYjgCZQA
iF1ljUFidG4XGgY6iTANBgkqhkiG9w0BAQEFAASCAQBawkCTuZhFE1Dh56yu6W654xn9J4Cxf9bl
TiHMOSFzYxBxTNlCpVHfMP5Ocuf1h0RYN6zlKxpPtSSlpmjeKI2GpVSHnOKud8Jxp5P2QdomKfcH
MKVlaN6PRLlYgkF2UqIM0i3Sw8tSYldJKszPelys3ifjKCQiqlVXqwwy+bperIOkZ9SkItUXef5G
CuJGfw+KU34di6cGII7q7PcTysyc1hSRBGkgLAiliDzBTdPpQzJrC+3IOz13oEHkJHmN45ImqeEh
ZTrGgfSpQfdza4nHmVDUav9HwBfex8mpD094uX08f5wTrezfCfnPx3vMqavsHeUyDXeqFdwnEK10
erHwAAAAAAAA
--=-=-=--
