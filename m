Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B45C21F600
	for <e@80x24.org>; Sun, 23 Jul 2017 22:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751490AbdGWW0Q (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 18:26:16 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33779 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbdGWW0P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 18:26:15 -0400
Received: by mail-lf0-f43.google.com with SMTP id p2so22472932lfg.0
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps;
        h=from:mime-version:subject:in-reply-to:date:cc:message-id:references
         :to;
        bh=uXYZcH2Rik13qRonQ76OQBQudAlzbNql17JBqVQhLoc=;
        b=bV4GQbAIpgQjBmyQKtgE44UKRgzPyQSBnL4eCv3C4fyTjiKhLD1pa1BIGFJ5QtYFxe
         3EbwnY8aP7MvOFvMKQhNsifuodI5t8YcoXMay8z5qDu+nE60K6ytBJQA88ON3AXii0im
         l9WiLnbnWXfIo/oLGiR1O9qAZAekY/b4sLdsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:in-reply-to:date:cc
         :message-id:references:to;
        bh=uXYZcH2Rik13qRonQ76OQBQudAlzbNql17JBqVQhLoc=;
        b=UrIT3jk3hCsXfMy0xnK5pI6JYmZEeMR9k1klXePgh0T3w+EG5HW/D4HekjjnLnpVnb
         d6nTdw9g7qm7zki8d2vc7TOW2FPLbEk0FsrZfSo0qJs+48Ef0tcy23kxRx/R94z7e4zU
         uiunhFqJ4rSXfWTM3Fqdg0fEsHvlvcjnO3QTgRRx3WRouUPUDFeTrxG6+Nl/qFi7/22C
         +0fo8PthIdPt0oTro6xgr/KPcmhEsPiWwR4kNHRMVORI1NYbHmbQVWP5SNjNHZ91+71o
         Rcf/3XimMgJVsHAZWhXFnCcCQy5U4MF67YgCADwQrU75D971C+zc/tfTfj87CejuY7N7
         9wlA==
X-Gm-Message-State: AIVw1133XrnbpnB/2DfU4IlpEUKBcxg2XUpLm37dWSdl07Xi3wTvpEDI
        7VsnVnI/E83fnJSV
X-Received: by 10.46.69.6 with SMTP id s6mr3298280lja.40.1500848773842;
        Sun, 23 Jul 2017 15:26:13 -0700 (PDT)
Received: from [192.168.1.50] ([188.170.80.48])
        by smtp.gmail.com with ESMTPSA id t24sm2080322ljd.1.2017.07.23.15.26.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Jul 2017 15:26:13 -0700 (PDT)
From:   Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-Google-Original-From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Content-Type: multipart/signed; boundary="Apple-Mail=_6378C7A6-3FB1-4BF4-99B6-AFF8447114FD"; protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Remove help advice text from git editors for interactive rebase and reword
In-Reply-To: <xmqqshhmerf1.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 24 Jul 2017 01:26:09 +0300
Cc:     git <git@vger.kernel.org>
Message-Id: <CEDBC0C9-03F7-4536-809C-9ADB8901B722@jetbrains.com>
References: <241D60E0-1687-4DD8-A18C-CF7310DBFAEB@jetbrains.com> <xmqqshhmerf1.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_6378C7A6-3FB1-4BF4-99B6-AFF8447114FD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On 24 Jul 2017, at 01:09 , Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Who is running "git commit --amend" and "git rebase -i" in the
> workflow of a user of your tool?  Is it the end user who types these
> commands to the shell command prompt, or does your tool formulate
> the command line and does an equivalent of system(3) to run it?
>=20
> I am assuming that the answer is the latter in my response.

Yes, it is the latter case: the tool formulates the command line and =
forks a process.

> Not at all interested, as that would mean your tool will tell its
> users to set such a configuration variable and their interactive use
> of Git outside your tool will behave differently from other people
> who use vanilla Git, and they will complain to us.

That's not true, since the tool can (and would) use the `git -c =
config.var=3Dvalue rebase -i` syntax to set the configuration variable =
just for this particular command, without affecting the environment.

Btw, if my proposal is so uninteresting, why the existing advice.* =
variables were previously introduced? I don't know the motivation, but =
assume that it was about making Git less wordy for experienced users. So =
I don't see any difference here.

> But stepping back a bit, as you said in the parentheses, your tool
> would need to grab these "hints" from Git, instead of having a
> separate hardcoded hints that will go stale while the underlying Git
> command improves, to be able to show them "separately". =20

There is no need to call Git to get these "hints". They are quite =
obvious, well-known and can be hardcoded. However, I don't plan to use =
these hints anyway, since they are a bit foreign to the GUI of the tool =
I develop. For instance, for reword I'd like to show an editor =
containing just the plain commit message that the user is about to =
change.=20

--Apple-Mail=_6378C7A6-3FB1-4BF4-99B6-AFF8447114FD
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIH3jCCB9ow
ggXCoAMCAQICCkvfNsYAAAAAGkYwDQYJKoZIhvcNAQELBQAwZzETMBEGCgmSJomT8ixkARkWA05l
dDEYMBYGCgmSJomT8ixkARkWCEludGVsbGlKMRQwEgYKCZImiZPyLGQBGRYETGFiczEgMB4GA1UE
AxMXSmV0QnJhaW5zIEVudGVycHJpc2UgQ0EwHhcNMTcwMTEzMTI0MTIwWhcNMTgwMTEzMTI0MTIw
WjCBnzETMBEGCgmSJomT8ixkARkWA05ldDEYMBYGCgmSJomT8ixkARkWCEludGVsbGlKMRQwEgYK
CZImiZPyLGQBGRYETGFiczEMMAoGA1UECxMDU1BCMRowGAYDVQQDExFLaXJpbGwgTGlraG9kZWRv
djEuMCwGCSqGSIb3DQEJARYfS2lyaWxsLkxpa2hvZGVkb3ZAamV0YnJhaW5zLmNvbTCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAMecZGRE7qNBRi7tiOPM/A7RKF2PphOIZMQp0fOB9sVQ
g3Vd2Iog7FGbNbvrNC1n2UgxZQSjldjqzZAY1PEbU7KWyDXIbDfTgqLYViSRGGcc1AkhOp8uOPf9
GMjYMbhKQSECvnEREZ6IBm6DXaLLuYJbugH0MOvPgmwzsjxIOFovex7opPh2RIVSliuUGB6JhJar
cuYmfNGtE8gy2rKFSukqTPUZHYyaqH0rEsRbvZlvIH4ATo0zz8M8kHcoHTbM8jSOBW+pitUGFNHA
jm7zng+CL2/Z3gawF5prV8vBS+ZEtQLo6pFxRkAQ/sGJ5CuTuaWNrEmUCDOiEkpLn+4kzBUCAwEA
AaOCA00wggNJMB0GA1UdDgQWBBSLZs17EFhrIzzHew9l/oro79GeBjAfBgNVHSMEGDAWgBQfxyv8
mKFlvb69lwMoXDJld4EnxjCCATQGA1UdHwSCASswggEnMIIBI6CCAR+gggEbhoHLbGRhcDovLy9D
Tj1KZXRCcmFpbnMlMjBFbnRlcnByaXNlJTIwQ0EsQ049Q2VydHNydixDTj1DRFAsQ049UHVibGlj
JTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1MYWJzLERD
PUludGVsbGlKLERDPU5ldD9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xh
c3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGS2h0dHA6Ly9jZXJ0c3J2LmxhYnMuaW50ZWxsaWoubmV0
L0NlcnRFbnJvbGwvSmV0QnJhaW5zJTIwRW50ZXJwcmlzZSUyMENBLmNybDCB1gYIKwYBBQUHAQEE
gckwgcYwgcMGCCsGAQUFBzAChoG2bGRhcDovLy9DTj1KZXRCcmFpbnMlMjBFbnRlcnByaXNlJTIw
Q0EsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZp
Z3VyYXRpb24sREM9TGFicyxEQz1JbnRlbGxpSixEQz1OZXQ/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29i
amVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwFwYJKwYBBAGCNxQCBAoeCABVAHMAZQBy
MAsGA1UdDwQEAwIFoDApBgNVHSUEIjAgBgorBgEEAYI3CgMEBggrBgEFBQcDBAYIKwYBBQUHAwIw
XwYDVR0RBFgwVqAzBgorBgEEAYI3FAIDoCUMI0tpcmlsbC5MaWtob2RlZG92QExhYnMuSW50ZWxs
aUouTmV0gR9LaXJpbGwuTGlraG9kZWRvdkBqZXRicmFpbnMuY29tMEQGCSqGSIb3DQEJDwQ3MDUw
DgYIKoZIhvcNAwICAgCAMA4GCCqGSIb3DQMEAgIAgDAHBgUrDgMCBzAKBggqhkiG9w0DBzANBgkq
hkiG9w0BAQsFAAOCAgEAnRmAHx7gxio3dgYGWuMb3z4gt9P9YcVzoaBbbHps2iwhtMKEZ5+AO2MX
ByLFTUzoMk/3cz5H0SADYvd6zqwQrJ6uam1e+OqDtqt7Psj8aUmVzIqN+YI7xWvga4ctYrUGJ1+p
JeR68zk1tmIPyESeIT3Iyjey134FKFqVeEr3WUibJwNLHPRc0MXIMpOwKyUOcbtyKVvBtJQm3ePm
G8cc6gaQsZrVTBo1uVDna6mpPOjs5VbAgZ2ruVDHicw3SxZQlBDzTb0FF0B5nD46kcsCzxz4BK10
Rf8TZzZpd0uBby1qwsMH91jnRUFuTFcNdsq9G+luSSc13oVkLNtwj4SjLHXrayrPDSMMUj70Tlga
lZWg+pS2Va/0SCDq9dfvC8DXydjBs97NG5fQxmqyNE9ZgVqTgOkcWGUleqlL8ADElzh967bHkP6Y
lqTfYxhwoykneV6eW2DlfS4S+zURxsvKt0qqgB+NRvIb+UKfzhPUp7IQSwHgFjYG8lPJEAmCWsug
/kfwoDZR4rL5fKTfSojXcfm3SlJGgb1EpLH7zZgC1hOyuSl/DJ618k+Xyo8mhe7qe49LvjWq/7fS
0uir7P9XgJbf0xPw0eFsOzgEgXCxsoknNQTV2HlCELX9oYmwkLdcZzPMpfsE04HEfPf+53h+wQhW
5AI/gUTzsIoZ7l+F7xcxggMNMIIDCQIBATB1MGcxEzARBgoJkiaJk/IsZAEZFgNOZXQxGDAWBgoJ
kiaJk/IsZAEZFghJbnRlbGxpSjEUMBIGCgmSJomT8ixkARkWBExhYnMxIDAeBgNVBAMTF0pldEJy
YWlucyBFbnRlcnByaXNlIENBAgpL3zbGAAAAABpGMAkGBSsOAwIaBQCgggFtMBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3MDcyMzIyMjYxM1owIwYJKoZIhvcNAQkE
MRYEFJ6dShN/PxK/8mXEZHlf05yE/2kXMIGEBgkrBgEEAYI3EAQxdzB1MGcxEzARBgoJkiaJk/Is
ZAEZFgNOZXQxGDAWBgoJkiaJk/IsZAEZFghJbnRlbGxpSjEUMBIGCgmSJomT8ixkARkWBExhYnMx
IDAeBgNVBAMTF0pldEJyYWlucyBFbnRlcnByaXNlIENBAgpL3zbGAAAAABpGMIGGBgsqhkiG9w0B
CRACCzF3oHUwZzETMBEGCgmSJomT8ixkARkWA05ldDEYMBYGCgmSJomT8ixkARkWCEludGVsbGlK
MRQwEgYKCZImiZPyLGQBGRYETGFiczEgMB4GA1UEAxMXSmV0QnJhaW5zIEVudGVycHJpc2UgQ0EC
CkvfNsYAAAAAGkYwDQYJKoZIhvcNAQEBBQAEggEAtEzcTKpaXXCp7mIKxWUi41RePafLC990vlWy
VLpHdUPDJiVypHd1fJZeonwcYUkoxjROYzaip10Uaj+B37J78MWxJiJIi2R4Qn6BDIHHWc6uM2yM
aHDZwz/rcFHS10K1kOWSxIy6VvNdAmOhgLmMsADnO2xXUXkqlK5hKE85GgzBnaFtb7enaNNjapP7
gx5la/9+waQOtSzAAyYDmjwXMne71AWS2Sl0ivs68A76q+/fZQWceWu8fwRNW06MLnDcosJIr3GJ
IoIpcgFr+TRowBcgaMV+ER1QyD2jzGj8teufAng/3imWW2WKVLNtW3LbfOmonbJJTBWu7za0NTNI
iwAAAAAAAA==
--Apple-Mail=_6378C7A6-3FB1-4BF4-99B6-AFF8447114FD--
