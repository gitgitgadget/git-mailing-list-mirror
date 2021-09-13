Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C62FC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79063610A2
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbhIMLoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 07:44:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:44405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239770AbhIMLoT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 07:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631533380;
        bh=HUJLV088OYjPTTp4X7hZnXsWeUXMhF23cxO1eFDUXu8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DSblBgA3O0eiJ8utVJSVCwruL+1j+06GuB88xyrIC91h/IpFvzEiQKSm6acKlPV4Y
         vFecw3NgntoeYoLhmtQFAqCul0Lq19oaJOuio4j6BYLqyxvwc5KQQL9W2LZRpuuo1t
         eOrz5Y8WiffpCBRKSQGSR4ZihZgAjFGpRaTI3Jqs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.116.95] ([89.1.214.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp5a-1mQrM006Ye-00YD9Q; Mon, 13
 Sep 2021 13:43:00 +0200
Date:   Mon, 13 Sep 2021 13:42:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, bagasdotme@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 0/3] windows: allow building without NO_UNIX_SOCKETS
In-Reply-To: <20210913085600.35506-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109131339540.55@tvgsbejvaqbjf.bet>
References: <20210912202830.25720-1-carenas@gmail.com> <20210913085600.35506-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-495828304-1631533379=:55"
X-Provags-ID: V03:K1:f62w/SmERXvCwrS/mZ7raVCYbO4RxLcyeXGTRjD6XEvctgk8kJT
 V2fZOBXr057iozejoMdxeQWagrXvyJk77GRg2x+b+a/gSPIlD6HuUZG54fNdxcbzmjXm9hf
 0FYM/8s7i/qGCOvXZps4XO7kpMxinmwKDR5IxFrj3SBq73MgR/GoDLlkGhV0Wd0zR5sYIT7
 NCi9JEhVjX3JWArl4RXoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F6Rvp/pg6VA=:xQ+7DjsJ2MT4ul8lQT2bd6
 0E6GceDhdOHjxgqVKKh2jzDjZiHdoH2TkMZSuUKc/qoXMxQU4+4iou1ydKvDrAv1aNiJ5HLLg
 e9AUBmckbAZ055pcV6yxleAe9xJeqGiPA3ivlvtDIvzKQjrbK2K3aiO6FNjmEaqyfYzzAeOe0
 asmDj3Mo8pfx/MBdkX8yDfIp1IXupvkTKM6+1eokdFvjtV/kWieUHIcNWE3CGUaQJbcNsDaM2
 4zbmOowMkaCf6Esp0EbjhBgztKy8kZuGz7yTW6CbAPgIjgXw2YZ2Cjk4kN68alJGAPNxiQ5hD
 fLLZsDmZljYK1f9q0D8M3s7gb3AVAsZAqzsh6HuoJcllKldpQJ1KXWrrk92cATz3RwU1qZ4si
 YrTiiMOitx7rZkQGeRoMRebR8GA+v0HpsySu9ixS94VhUcQ7qWiO/jK3kmJw3SdCYMjiewiou
 gi7ZFi1SzU/TXuBnBCmK2VnPoIbWpN2qPeACh3yECX5aXYJgWvdzcEIk7djly3KF68zI79pYh
 RqHXc3Rh+jHfVexjeS0L7w3buYUUB1tpY8hAQZqS3y1bhfYZ99fJNij9z19n4gEkOY8hLY/6m
 elJuH0akOfy6NppVPiu8uI9qLgdvhb/OFxuvO4XjywGldlQf+qiGYFhx4m5kmC7S4142HzCyV
 YYoPVgerm8n/qjQ/wmXQdy3nAJfOoDxxyjHCNCUBUJJmURx1UZrin2LIJMR95015OGLEATyNt
 WskW93wfhXiRj5fiQ/hB1Yl86B8vCvHywHr/NRuA3EHLGyh5pu9ODWLB5FI0naHab/B2D3U8p
 dndn09lSOu0a557yV7H12hP1JTnNSGfLBAAZHXX35d2on9KYeTNvCozy68SiNfFl8W5MRd+h4
 W9kEqCCrlXa07Oy1fO+OGQk+v2iFpjvVelzNcYXLGXjIG6aN0LBCDipmCeaKJsAC+YvmxhcxG
 B8A7PwEIKhD/U6joPYKoH0oyiMV1lhuK2qUTS2rciXecIWxYcLEnqJX+OwEVqEAlxbUc+RLbY
 xBs5nMAvfW/FIatTMrliD0QqMmjfAppsNyfJgnpwXlp7SbDJ1uY3QELV+1UVy3ZzszoJ9sxXQ
 mgavlS7kmtLO70=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-495828304-1631533379=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Mon, 13 Sep 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> Eventhough NO_UNIX_SOCKETS was specifically added to support Windows,
> it might not be necessary in the future, because Windows added support
> for Unix Sockets in late 2017.

The fact that some recent Windows 10 versions support Unix sockets is
nice, no doubt. As far as Git for Windows is concerned (which does not
recompile itself during an installation based on the Windows version it
found), we cannot use it, of course. At least not until all of the
previous Windows versions are _long_ out of service. For example, we still
support Windows 7 even if it reached it's "End-Of-Life".

Having said that: thank you for working on this. For users who build their
Git themselves (which is definitely something Git for Windows makes
easy), the option to use Unix sockets is really nice.

Ciao,
Dscho

> The implementation of Unix Sockets, uses an internal NTFS mechanism
> and is therefore not visible at the filesystem layer, like it is in
> UNIX, but seems to be good enough to allow to build and run the
> `git credential-cache` and its daemon; additional testing to confirm
> trace2 (builds and doesn't fail any tests) is functional will be
> needed.
>
> V2 reuses the same third patch from V1, and applies all suggested
> feedback on patches 1 and 2 and should apply cleanly as a reroll of
> cb/unix-sockets-with-windows.
>
> Carlo Marcelo Arenas Bel=C3=B3n (3):
>   t0301: fixes for windows compatibility
>   credential-cache: check for windows specific errors
>   git-compat-util: include declaration for unix sockets
>
>  builtin/credential-cache.c  | 30 ++++++++++++++++++++++++++++--
>  git-compat-util.h           |  3 +++
>  t/t0301-credential-cache.sh | 32 ++++++++++++++++++++++++--------
>  3 files changed, 55 insertions(+), 10 deletions(-)
>
> --
> 2.33.0.481.g26d3bed244
>
>

--8323328-495828304-1631533379=:55--
