Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1B74203F3
	for <e@80x24.org>; Sun, 23 Jul 2017 10:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbdGWKD6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 06:03:58 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35227 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbdGWKD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 06:03:57 -0400
Received: by mail-lf0-f54.google.com with SMTP id t128so5272141lff.2
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 03:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps;
        h=from:subject:message-id:date:to:mime-version;
        bh=CeHrnoCXwxDGjGJLw3Q1ZOG9o0ljauK75iMBij+oxXA=;
        b=S4kgFq4UpjJgVXCHGkpb03BOmPABmgdRi6tn5+eEJLsYCKkVRE8LFw7KFlffPpedNI
         Zc5reUPp0TcxFHOMEJanzHh0AAyQuY3KD+W3HhkWmdAxpe9KWTKxiilBLIn+8AgekouH
         LLN8BVK3p72PBBzUx/H1iuhen2ixs5cEzZ2co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:message-id:date:to:mime-version;
        bh=CeHrnoCXwxDGjGJLw3Q1ZOG9o0ljauK75iMBij+oxXA=;
        b=GfePObi/tE2wsmkkcjDVKdo1xGbnsr3koMLKRIuJ63asNIElx94R4dCem6KWRgn18E
         yM+dRtu5JZPbZ3Nv/R3oee8PmB2+iCHb+UgK0PptUU98vATGxu3NJyjV1vImE9C3hqCx
         NNNt/KhUJtO0UHGBBVLyhpeiIWiIXS4CMDjjGxvIBMr6PVGXSks/VTyNn3SHjnNrS9xD
         JuIVRdFP7whQgCd1+twEcs5+6wQOosd+ovRv1mZyyLPLKnqz5kGO9yDvvXCHtP7kRtPk
         qu5bE4LDwCj4d+MC0J7YvFXfB33DAc4puL82yLIvdhIZgvkP3MjvKAgfiM4u5yjzigN2
         WL8A==
X-Gm-Message-State: AIVw110OFGGHraPCAYitl1EHloTiXgZP4n6I273il0vsUlPmWOnezZiB
        aODWhbl9UaQfWm1IP0wkkw==
X-Received: by 10.46.77.74 with SMTP id a71mr4263802ljb.34.1500804235009;
        Sun, 23 Jul 2017 03:03:55 -0700 (PDT)
Received: from [172.20.4.188] (gw.intellij.net. [81.3.129.2])
        by smtp.gmail.com with ESMTPSA id x62sm1777768lfa.13.2017.07.23.03.03.53
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Jul 2017 03:03:54 -0700 (PDT)
From:   Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-Google-Original-From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Content-Type: multipart/signed; boundary="Apple-Mail=_89AFF922-A92A-4FE8-9D93-7C42FE2AFA66"; protocol="application/pkcs7-signature"; micalg=sha1
Subject: Remove help advice text from git editors for interactive rebase and reword
Message-Id: <241D60E0-1687-4DD8-A18C-CF7310DBFAEB@jetbrains.com>
Date:   Sun, 23 Jul 2017 13:03:49 +0300
To:     git <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_89AFF922-A92A-4FE8-9D93-7C42FE2AFA66
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello,

is it possible to remove the helping text which appears at the bottom of =
the Git interactive rebase editor (the one with the list of =
instructions), and the one which appears at the bottom of the commit =
editor (which appears on rewording a commit or squashing commits)?=20

The texts I'm talking about are:

# Rebase e025896..efc3d17 onto e025896=C2=AC
#=C2=AC
# Commands:=C2=AC
#  p, pick =3D use commit=C2=AC
...

and

# Please enter the commit message for your changes. Lines starting=C2=AC
# with '#' will be ignored, and an empty message aborts the commit.
# Not currently on any branch.=C2=AC
...


If there is no way to do it now, do you think it makes sense to provide =
a configuration variable for this, e.g. to introduce more advice.* =
config variables in addition to existing ones?

My motivation is the following: I'm improving the Git client inside of =
IntelliJ IDEA IDE and I would like to provide only the plain commit =
message text to the user (any hints can be shown separately, not inside =
the editor).

I know I can load the original commit message myself (but I prefer not =
to make extra calls when possible); and I can parse and strip out the =
help pages (but it is not very reliable since the text may change in =
future), so I'd appreciate any other solution to my problem, as well.

However I suppose that experienced command line users could also benefit =
from such configuration, since this helping text is intended only for =
newbies and is more like a noise for advanced users.=

--Apple-Mail=_89AFF922-A92A-4FE8-9D93-7C42FE2AFA66
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
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3MDcyMzEwMDM1MFowIwYJKoZIhvcNAQkE
MRYEFPxXTHHcvMQUr97237J1lfvbHgu+MIGEBgkrBgEEAYI3EAQxdzB1MGcxEzARBgoJkiaJk/Is
ZAEZFgNOZXQxGDAWBgoJkiaJk/IsZAEZFghJbnRlbGxpSjEUMBIGCgmSJomT8ixkARkWBExhYnMx
IDAeBgNVBAMTF0pldEJyYWlucyBFbnRlcnByaXNlIENBAgpL3zbGAAAAABpGMIGGBgsqhkiG9w0B
CRACCzF3oHUwZzETMBEGCgmSJomT8ixkARkWA05ldDEYMBYGCgmSJomT8ixkARkWCEludGVsbGlK
MRQwEgYKCZImiZPyLGQBGRYETGFiczEgMB4GA1UEAxMXSmV0QnJhaW5zIEVudGVycHJpc2UgQ0EC
CkvfNsYAAAAAGkYwDQYJKoZIhvcNAQEBBQAEggEAWU/HyEhtK66ym0QYWTU3AxtqTTZJRlyQwHjM
cRZlewFQa2Yj1K3JOKvkoSY7/DEELKvdoYEQWzLv5X+4iqaW6G6NQvpQmS1qN+eI7VIDVuLlz/EX
lEYD8njZHdSgHs/MX498N7gRIIzrm8bZG9F1oY5nQp0IhrMAikO8Qf/20pwg9o7ht+O3+W/aOXmn
2uO7AmgE57DRYXf2TNP5IXL4fhVXqtBtALCfOTjsmrafZm4KSu+L/Ghfdcspu5RsUGbS28sRUd2w
2JnGWDAPHm2QzPBcRSfaQ2HwPP2X1Qhkv6ky60lnSVfGtV5uHDMk3lbdLeXfcUFTmn6ConO4Hnh0
BAAAAAAAAA==
--Apple-Mail=_89AFF922-A92A-4FE8-9D93-7C42FE2AFA66--
