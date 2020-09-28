Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC1EC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 20:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B05CE2072E
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 20:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WU495cwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgI1UDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 16:03:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:47263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgI1UDU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 16:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601323395;
        bh=xhkD40ON3zJYBy/KSdtZK72e90SALFm5PAJ8b8+/GQU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WU495cwKykUlG5wFoSK/x9ZR++nkfuZ84Jl4Ibx3xp+hLQo/mTj2JhhG9CqQQ5Uil
         d0SEv3y9fvPSWIbHkVZFpHdgIoQnIhsIT3Vug40nPLdyVb5kduKt45pzaVXi3RuwH6
         TbrPRceyirElHLt61oGZ9OOsmsNQOefA3lelIj7w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([89.1.212.27]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N79u8-1kUozX2tLQ-017ZGj; Mon, 28
 Sep 2020 22:03:15 +0200
Date:   Mon, 28 Sep 2020 22:03:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Francis ANDRE <francis.andre.kampbell@orange.fr>
cc:     git@vger.kernel.org
Subject: Re: git-filter-repo on Windows
In-Reply-To: <8345312a-40aa-b582-50d7-714b8f518ecc@orange.fr>
Message-ID: <nycvar.QRO.7.76.6.2009282201380.50@tvgsbejvaqbjf.bet>
References: <8345312a-40aa-b582-50d7-714b8f518ecc@orange.fr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wDzrbwu0/zhI/OF1oKB1bq3UNGG/EgiTfD/bYmjlI/8qmUnAXpT
 +AxvceQbCnynXOKryRXu0QnbK4KzrVvNMy13A51g0RTwseznsVSSpiX1STwz6Uts/nL2sIx
 bw7Ic6Tq01ctZh5+G+D23XHr4wsCNAHcs/DRDaBaZL7ybTEGocQdPAzmivsdEQ6MIHAHI2Z
 QoWl7J9/lCKETnNfvgsqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hDAT7DPe0m0=:ZUmyHL25xL13qZoNuE0cXx
 jQiS37uap6YJdATHMzQ2wyTBb8+oDh2Loa6+1xGTrKLuVcel116EWrAnmm6SM2VHU1Xkd5ah9
 v6Q+s+ychlLbeTlYHTfoaykCSi6xJwWhMewI1Rkk+VZo32hEGf6I5ElyddgfLgM3/YZohUisk
 Yrv1mXWexBI6ir96rxYYTE+EJqKFunHpJDKhOItCZ9ibajvf7RQWw/Z4zwMFkieK6b2SX/Sn1
 87n8aZh4WEZc/SkRaVCKMPe7C2cPUeUsQ5AEFB4IJAhMwjpNdsGUcwQ4/9kjlLU1QKDRlVuov
 TePkLZZJ1ru3SAhXgWz0efabNPI+rzUWFJW7IcCiwim71MFFdV3IJBrLugzW/dHHHRIF7Dwar
 tGcvyffWCUjkqdjloQnFIteT9RfbuWdoolGrjmtXwhdgQyuWeyWZFHLHij4609AI5hHQx8d55
 GHxEyfL2U+aM5a6ZEbHAzkPFGIPy6bfNmxUQjHef7HQy6KzNzGhfruLH8KuN27AR9AV7Toq4p
 cr21dN/ihdRGNr9jFrD9hvRxEGno9pQ8uo8Brao5aihgUwZx3dA9WDp24LoaR4bDb6iXhSZLI
 pUWfkz73jf3KfpII3Q8fWegdMnVc1+s4tnkurxvkHB4n/fuU8x5PHfgqJreqa+x5nH723OZW/
 BecINHxTsaMcg+BIptaWJ1AS1gYogdM9VtNRM1i0P1d/NuTrKCPtBRioCovhOSs0kc2PEaYN5
 mKWiESXWP2BwPhu7xkXyVt8kmMZiED4alcH9xOBkgF01d4T6qRCfkbmz6uVTS+kjBNlRVSYI0
 Ld16gOPER46xPtWng8jHeWuo82NUUQhlPIXZZJVtZ1n1tbTJ401PufeyPNqHC1qd6MOucbX5i
 WyLnTYjQdhSaNsa0A3ew9GXL45z885E6Cc2p9GtT+liRjs1TEvVpC0VNbB+gWIweBKpalOliE
 Eh+wij4yahDTQQnOOqhESIwWEvWhe9W2q2GEwMsoNBIUUvfDTo6JeUdz/DDmC6XOTGY3Dl20a
 +HYYVN7djlCM6PVK1sIsWTfAFMdE/38TJ2055gaLALhtkEav+BD/1BDFcjklakFiaRCqA31jc
 vnmzjnXj00hA73yFiFOjsKudPIMgYi/ekpcTShAiMmSO/Mau0nGoFynmZlrl/g+xIPuhPayFL
 wblf4du3Fo2ppy5dqNb688uMqhYoEJyHFXb3LSG3C6gqz+ZAsY/yN52tWqSf2a5KW61CwLlQS
 ajGVfomal+4k6UooVHelmjyb+FIy1BYmvM27YCw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 22 Sep 2020, Francis ANDRE wrote:

> Hello Git people
>
> Since I understood that the git-filter-repo is now recommanded by Git to
> replace git-filter-branch, I am trying to use it on Windows 10 under a D=
OS
> window. The installation and use of this git-filter-repo is really a nig=
thmare
> on DOS Win10. As there is a git-for-windows specific installation, could=
 you
> make also an installation a little bit more Window oriented?

I assume you opened https://github.com/git-for-windows/git/issues/2833
describing this issue?

For lurkers, I found that editing `git-filter-repo` to run `/usr/bin/env
python` instead of `/usr/bin/env python3` works for me. Details here:
https://github.com/git-for-windows/git/issues/2833#issuecomment-699916239

Ciao,
Johannes

>
>
> C:\Users\fandre\Documents\MXW\MI\release>git filter-repo --analyse
> /usr/bin/env: 'python3': Permission denied
>
> C:\Users\fandre\Documents\MXW\MI\release>git filter-repo --analyse
> /usr/bin/env: 'python': Permission denied
>
> C:\Users\fandre\Documents\MXW\MI\release>where python3
> C:\Users\fandre\AppData\Local\Microsoft\WindowsApps\python3.exe
>
>
> Same with a git-bash window:
>
> FAE@FANDRE-LAPTOP MINGW64 ~/Documents/MXW/MI/release (release)
> $ git filter-repo --analyse
> /usr/bin/env: 'python': Permission denied
>
> FAE@FANDRE-LAPTOP MINGW64 ~/Documents/MXW/MI/release (release)
> $ ls -l /c/Users/fandre/AppData/Local/Microsoft/WindowsApps/python
> -rwxr-xr-x 1 FAE 1049089 0 Sep 22 10:59
> /c/Users/fandre/AppData/Local/Microsoft/WindowsApps/python*
>
> $ env | grep USER
> USERDOMAIN=3DMETRIXWARE
> USERNAME=3DFAE
> USERPROFILE=3DC:\Users\fandre
> USERDOMAIN_ROAMINGPROFILE=3DMETRIXWARE
> FPS_BROWSER_USER_PROFILE_STRING=3DDefault
> USERDNSDOMAIN=3DMETRIXWARE.LOCAL
> ALLUSERSPROFILE=3DC:\ProgramData
> UIPATH_USER_SERVICE_PATH=3DC:\Users\fandre\AppData\Local\UiPath\app-20.4=
.3\UiPath.Service.UserHost.exe
>
> Regards
>
>
