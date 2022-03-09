Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D834EC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 23:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiCIXDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 18:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCIXDO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 18:03:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D0E1066F6
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 15:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646866931;
        bh=QLLBAFvq5XkUMmnL95imUchYSK1qkRhg161BASBo8NU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Suze1PpqyhW8xY226F9gEUEoRUJ2ASupB65KzDVDkyxtzcuzYbi3xjAGe/EjmQA9g
         iojIG2gUMbTLcP8Xupkl8HF3hGxNRuv6xIlLcUm7OEZ0xRS+PBsvKDxe+Oc14He3sU
         muB7sqXb+HeNPzUYmq6vkwp8JXvWTAJztAt4nVnY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lc9-1nSMQy1owt-000wOn; Thu, 10
 Mar 2022 00:02:11 +0100
Date:   Thu, 10 Mar 2022 00:02:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Adam Kapos <adam@yousician.com>
cc:     git@vger.kernel.org
Subject: Re: Leading slash exclusion does not with git clean on Windows
In-Reply-To: <CAMwvdPQLMK2-CPyLqSKBWZjEi+6o2iaj_=C2VnJA=sV5GUV47Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203092358510.357@tvgsbejvaqbjf.bet>
References: <CAMwvdPQLMK2-CPyLqSKBWZjEi+6o2iaj_=C2VnJA=sV5GUV47Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8z9u8Vzhcdjo55UFSPSUuqa5JOEu0wHKY6Yp9XyfpPovYtu3fkO
 qR0sInk1IuGtrLSs5NCGaz7Jhh04xeyhd2Dj++l+qvNAJlg1XSf7igAX5Yoox7muNZc2Bmt
 rkIrIKbEDLoBq0nP44ogp4XyUgJLqUyGYQnaaOaT6J7d+GcRCALUAAb+rUkvYz/bf4P66v7
 XDBLLTYi+rmm9RzZ1Nrqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z2JvgL7uw70=:pKw/tWfnDX/EcmuoYa8khS
 YfQ3RN5nSCTpqQhgEvQ5jCCmpFZk3WUmbsNjzCuGpuRmz05F7ZVJu53GUhpp1Ei0OScvflbB1
 Jluk+njDlMcQecz5Sp76VwfnZvIMVdHu6YucDwMwhzvkKX8ClvM+QrYK4vh8i+WxGQXOJbIcS
 sLBnx/AV8xmgyUmh37mR1WNyQf614RG1J5ZgqGvNmQekyTu6+CZ6OizN8t9nsct6L1WvujYZZ
 a55ne90tB0y6QcubFywAmr85aQsbiB4y6q5fQNOpV/W3Z2xTOtjf4gtVx7jWJwl01jJ9qsPMz
 znqoRifQz60RyL4UaFS/D1HElJpnnnGNjAsUEfhamsp1xBSnWpt12zJemElbJ+5hoFXr3RkQZ
 Mn70APN9mnc7PY6aMSDwCt+6WZima+ezWd13pMC7XrRAu0fD3c4NeIbUWjEMf/R291ThJEDeE
 T4/xRvIZs4rvFdFLsjYBPGRZz5u1ulixkAKfDaf14GICAGzHipjxZjUMCyQcCdJmBHOBFmaMz
 3lJsj3C3vWaLtGVl0Rmi4DwDvl2knpKs0m8ibxgnmsJs6/bOEvSNIUsDRmI1RHBGcQXIgAWys
 ZvqXWtM8r6KWmmj1WawWCAyWdf6EzYn9CHl+ragPOWm+eiHC5B00iKUkOaAjaMb0hdzrE/PNo
 ZLi5Vv/+Xk8Ik551NDqaSsDrdWWzDfxDkj4AX5mepOwPzbBt3HVy6mTQsQuoltQRU4aX6y3NH
 SvERSfU3nhXdx5MnyunD85Wg2LoJ6PnuWyqwJ3lh+9MRmUQadTMf4Ij/6Rr0mMlx+pzA16H6s
 zLZjatfEyz+X9qrqkMTo3n8Y4NOP1ud4muvsHywtA9Co/goU/uUWDH5uwZ57AdBUdQDqcfmcL
 xdAcrSKqtGrgslf7gxVDUyUt5jP1qTUxaSrE5c+jBhgfYBc5vOOW7RUlKRXiiA5bhK6XgElGT
 pRFQKGpCxFTXUX8YtEmwM06Ug8ukESulqxEvlrM+CEcHtaqOkKgMlw4YcXEHhw1kYDpRu1f/K
 AQZWyVRpKq1PY76XosR8bX45dxsn1l5sGJSRW6DQlEfZH1vO/LuRFkIDfFzBosQBCCaUjv0js
 vnN2L1/c7eA6qI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam,


On Wed, 16 Feb 2022, Adam Kapos wrote:

> I came across an issue where the leading slash exclusion pattern does
> not work with git clean on Windows.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> Run the following commands:
> 1. mkdir foo
> 2. mkdir -p bar/foo
> 3. git clean -fdx --exclude /foo
>
> What did you expect to happen? (Expected behavior)
> The root-level directory is not removed because it's excluded
>
> Removing bar/
>
> What happened instead? (Actual behavior)
> The root level directory is removed:
>
> Removing bar/
> Removing foo/
>
>
> What's different between what you expected and what actually happened?
> The root-level exclusion doesn't work

As mentioned in the Known Issues section of Git for Windows' Release Notes
(https://github.com/git-for-windows/build-extra/blob/master/ReleaseNotes.m=
d#known-issues,
also available via Start Menu>Git>Git Release Notes):

	* If you specify command-line options starting with a slash,
	  POSIX-to-Windows path conversion will kick in converting e.g.
	  "`/usr/bin/bash.exe`" to "`C:\Program
	  Files\Git\usr\bin\bash.exe`". When that is not desired -- e.g.
	  "`--upload-pack=3D/opt/git/bin/git-upload-pack`" or "`-L/regex/`"
	  -- you need to set the environment variable `MSYS_NO_PATHCONV`
	  temporarily, like so:

	  > `MSYS_NO_PATHCONV=3D1 git blame -L/pathconv/ msys2_path_conv.cc`

	  Alternatively, you can double the first slash to avoid
	  POSIX-to-Windows path conversion, e.g. "`//usr/bin/bash.exe`".

Ciao,
Johannes

> Anything else you want to add:
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.35.1.windows.2, 2.31.1.windows.1
> cpu: x86_64
> built from commit: c5f0be26a7e3846e3b6268d1c6c4800d838c6bbb
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 22000
> compiler info: gnuc: 10.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash=
.exe
>
>
> [Enabled Hooks]
> post-commit
> post-checkout
> post-merge
> pre-push
>
> --
>
>
>
>
> **Confidentiality**
> The
>  information contained in this e-mail is
> confidential, may be privileged
>  and is intended solely for the use of the
> named addressee. Access to
> this e-mail by any other person is not
> authorised. If you are not the
> intended recipient, you should not
> disclose, copy, distribute, take any
> action or rely on it and you should
> please notify the sender by reply.
> Any opinions expressed are not
> necessarily those of the company.
>
> We
>  may monitor all incoming and
> outgoing emails in line with current
> legislation. We have taken steps to
> ensure that this email and
> attachments are free from any virus, but it
> remains your responsibility
> to ensure that viruses do not adversely affect
> you.
>
>
>
