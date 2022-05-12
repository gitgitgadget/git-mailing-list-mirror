Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81CDC433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 15:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355705AbiELPfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 11:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355687AbiELPff (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 11:35:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671222415C7
        for <git@vger.kernel.org>; Thu, 12 May 2022 08:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652369718;
        bh=5SYN28hYjrFEKj53Wttn+Jo2X8nsq8AD5wgp0PFxZ2E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eg1CnuBNMlRgk1xBm30OffJNTfbvgC9y8c4Ry8EEzn8PvwhoYo18EhJbq1MP0Ur60
         i0DrXMXNtE3Nx+H9qrJHZhKH/88Xb2fjUuuQNTcG4C9Afm4wuZcs+b62xg3RYU8Bk1
         LekUfHzRQqFtRfj+c+ZLWzNTSBHcIzL6F/1c9Z/U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([213.196.213.50]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9T7-1ng41f0RRh-0099Ks; Thu, 12
 May 2022 17:35:18 +0200
Date:   Thu, 12 May 2022 17:35:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Torsten B??gershausen <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 00/28] Builtin FSMonitor Part 3
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205121726260.352@tvgsbejvaqbjf.bet>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com> <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-841657370-1652369718=:352"
X-Provags-ID: V03:K1:tFoMnu71ZykLeIH0i5syLVt5uNlAEuH38hZOB+ewwSRUbLbj3dp
 Ck4z3jTxzN1qnPhefRe9k6sbucUo/3Ssvej9dG6o5ygKUxz1HADPGDTpo065wCsDKxTbY1z
 TJVzx53iEGicxQ466nFGkYBUJ5wvS4r1vnVo6jOT9cHkAMFyEXbc+d+xK8VkkDOOn0wKC+H
 k8as1pbA7un0SFt8Korig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PBJGUhDzm60=:GG/psbFJQWeRiB6v44rFtO
 HYcYrMfwXeM8174o/wI09Ysz+Rydxq3bmNydhlJTzQvDNlSJb+kBB8JRiOzIvoS8ZSOhLuphZ
 6lNdS85KrGmSrFDS/8k1Dip3wfP1XtHu70lCJClpo9YMs44pzSfb1TAFIXAtppZou5Kq93I+i
 OjILU0JSFD+8m4DjIapsfBaw9p40Yzd6R3JyOK1Hwm/5VaIpiUcRnVZ+O5chIop4gLumJtt5b
 2lVp4N+j/Ten2qkqX75MQdsTxh58IMUKga1nJhWLJmL0UAQtEJmQxx4+47TjFWy4L2O7Gooxt
 na72yuonJL6/iKRZcZWLMQbNDIKrlZ29rZuSsZRqF7As4F9V8cLeZgjg/M/Uc4nPeITKLR39X
 3qDV1leGxRV2Bcemkpy39DDIGYJTv4lomCJEWgsgSujJxJft5oLBkZlBIBZTtCTb+c8+g8coE
 rNiX42/ifL7KmNm8rTGxtqtld9jZQPeZnh3ezfpK/E+uHfKMhPDrTRdhNkqUM1qgGkKqwSbSY
 HC+GKVW4jWjMwPfzvyu2E/BPguWHjJXYOCmTPrsY/XzSxR9GscZeG/uI/Yfy3Z8kFal/BrL0z
 bm8V3r8JGqxhr4spI3ESZG/OKwqFwzaBjFtFVKmmHXDeo6NU7XTovkC4OwbGM1SJZTPHZU5ys
 ndlX0aynjoWl1o9kWvOtcIXNtbwmsFbbMExG2PbXcfAl7sP+HufBgIKlKL9007FbHoX+kJCUD
 BGnA/TFRpez5UU4uG574/L1xJmThE0cDVUZIYSzd0jyCCn7nIpSlnTbsX84t9FZ/I36Dhesoh
 JUGINaqVPZpZnzPbflXAk/Qk3wL7h36CIz7FW+5U8mhi1A2UxskppXSckPjKanKcMx8519IBq
 2hxjo46TxfKQEMdWCcaGj6rBJR2qrlK+cuVvZldrF3IOvvZVUlchoLErVkqilZE5rQ76sBMlL
 jk2q7GaDnfr6shX+UwcVDigmf21QQLH1OtKkCjYMN5Sl7vfByngNLRGB1cT/sAYWP5/O4M9FN
 8aRNPhCfpA5Rq/MIljC/ZZNacmluXETu8XhdJBpl6nWdSKrhKNAym9/WiesuUXEtsGtl86H5D
 u31m2pNWz1Yh/I=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-841657370-1652369718=:352
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Fri, 22 Apr 2022, Jeff Hostetler via GitGitGadget wrote:

> Here is version 6 of part 3 of FSMonitor.
>
> This version addresses:
>
>  1. Junio's comments on V5 23/28 WRT shell variable references and quoti=
ng
>     pathnames in the create_super and create_sub helper functions.
>
>  2. =C3=86var's comments on V4 4/27 (sorry I didn't see them until after=
 I sent
>     V5) WRT somewhat blurry logic around the fsmonitor-settings and
>     detecting incompatible worktrees. I simplified things, but not to th=
e
>     level that =C3=86var was suggesting. For example, in builtin/update-=
index.c
>     the suggestion was to detect incompatible FS before taking the lock =
on
>     the index, but the lock is taken before the CL args are parsed (beca=
use
>     update-index uses a custom version of parse_options_start()), so we
>     don't know yet whether the user passed --fsmonitor until much later =
and
>     that is what triggers the error/warning. I did replace the return 1 =
with
>     a die() so hopefully, we'll release the lock on the index like all o=
f
>     the other errors in that function. I did try to better document the =
code
>     in update-index.c and in builtin/fsmonitor--daemon.c to explain how
>     things are supposed to work. So hopefully it'll be easier to review.
>
>  3. Also, in update-index and fsmonitor--daemon, I redid how the error
>     messages are printed, so that I could use die() in the cmd_*() funct=
ions
>     rather than having calls to error() hidden inside fsmonitor-settings=
.c.
>     I think that helped with the above cleanup.

Thank you _so_ much for keeping on the ball. I do see how much effort you
had to put into FSMonitor, what with three large patch series, plenty of
reviews that necessitated plenty of iterations, but I heard from a couple
of sides now just how important this feature is for users who work with
large repositories.

Your work truly has a great impact on Git users!

I offered a couple of suggestions in my replies to individual patches,
nothing majorly critical (except maybe the `wcscpy()`/`wcsncpy()` calls
that _might_ overrun their buffer in cornercases).

Hopefully you find the suggestions useful rather than annoying at this
late stage (you're already at iteration 6 of the third large patch series,
after all). I just didn't want us to run into any big surprises like when
the second FSMonitor patch series was integrated into `next` (finally!!!),
only to be dropped and needing to be replaced by yet another iteration
(not so yay :-( ).

After studying your patches for a few hours and then writing up my review
(only being interrupted _once_ today, briefly, yay!), I am fairly happy
even with the current shape of the series, and if you want to address my
suggestions and send out a seventh iteration of the patch series, I am
certain that it is ready for `next`.

Again, thank you _so much_ for keeping up the good work,
Dscho

--8323328-841657370-1652369718=:352--
