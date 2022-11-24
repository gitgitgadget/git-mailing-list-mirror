Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D96C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 09:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiKXJlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 04:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKXJlR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 04:41:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0F7122954
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 01:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669282862; bh=6R6pI/L2rUymo+gWKR/pii7bfhwq+i1euBJHpEnda6c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cjPBtj7GIU4kzp2XPDdhbSsypvSCpfLoZlCI87Ebr2LbvpCu6cOHgEa+S0reIRknb
         4mtbegEpgamWbAFkNyionfQEFnf9rec0dlO7T1vGIM6mkVL1rhToIzZb2l2nnA0D/b
         ++guO2eUaehmhzmzHYoLvWN1+g7U7yLZLgwWr29KeyjKLWw5cn197AUr/8SeOMxasq
         7mwTQ1a3yHPJ2w56gZ6V/dL3WqmheVH/ifAt1b/o4sqRbrWQvPx08If6NGKU+03na7
         tmqJiZXt4iyy+cA/wE7/AqQIUqguroflwNO3x5ZmLQlUXeL7GgYB+RhsT0U8hWsixo
         NCgu/g1cVHhGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.58.20] ([89.1.212.70]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDbx-1pCMK32yKL-00ucwj; Thu, 24
 Nov 2022 10:41:02 +0100
Date:   Thu, 24 Nov 2022 10:41:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/2] ci: upgrade version of p4
In-Reply-To: <CANYiYbERKwmRj2DU=d4GCPO-jy+g8pMPBgD+vtzwB2iXRH44Ew@mail.gmail.com>
Message-ID: <7rq4snrp-r2po-qoro-s756-rporso2o44p0@tzk.qr>
References: <20221123150233.13039-1-worldhello.net@gmail.com> <20221123150233.13039-3-worldhello.net@gmail.com> <n79194n5-8q94-29n4-s447-64r0p2po4r76@tzk.qr> <9q4525s6-qrq8-1841-n257-711328352n85@tzk.qr> <5p3n90pq-4ro8-0278-3q8s-r2p568q3o26r@tzk.qr>
 <CANYiYbERKwmRj2DU=d4GCPO-jy+g8pMPBgD+vtzwB2iXRH44Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Hsl1xQ2L+JF4UIqJ9DGeVr8GBay9dOed67d1i/lCxbSPTVMXeUN
 +4YwMbjKhJall5go7s/WYtu1nw7EoGp1QcXVLFs2xuEWY6D0DPE0x54j6ViQAjKzJKwel9X
 z7cIuk0W7NIpfdgGBXLRanrCaWDfsh5cwbW48LDSh4x1FuHYAqtxthwQ+CCQ64uXG7DZzxG
 FTE8dyWrqzo0w0PhLQI7Q==
UI-OutboundReport: notjunk:1;M01:P0:eBAQRguBWFY=;T1rVQOr/8Hopz86qv1xD2hHnJ3m
 K0jeTpA7IlXqtbz7/KA7Hq6WoAmvzcYwuvme9ZEpATlEpmZPkqFwihhqYUcGVnCQkg5FQbZdG
 zSV6fKjKA8fLTkantkE7mML1e+qucZsTv0Q/WYqJntrvuyeJmtCB9qhINmRiAiW3FslIKBUag
 5GTEFHQgChSQH2+Yxr15nd1jgISK3zazGv4BS9XpJvGfnVkv+m/LcV/L7jIWn8JSFUXDpEM2t
 HioVpxgbt80fWhf5z7upqUnKdINHPuhm6KujTfYxm26zx5eTwvpKDxLk8YOInstIoYJgS/ABv
 MPhu14IhOOHb5NpvJhExxKyzhGZwqnkUGJh+TNdp0hxcw2bltlk08+b+edZUKN2+5/RjAqAaI
 h/oNBVQKxDzmH6cGscx/W3gnJdcUzdhpN0boaawQQDliAMCeFKMIggjxpAWatQmNEBUIzWk/K
 AknUhXntg5Url5C+Wz9TNd2J3fJ2o1b7yluYcQGOXV+RclTfU9UAcdQm9+L2tKnyg5AhViatw
 MR2w9Ge+7UL5x4+6OptpCmNSi8KrwaX1YuUO97H5fq2+g6fPOsBWVx1HG+z/uxpO0UhOQvslB
 BgT3biQOEhvOAErgG+WgXeJiAuxZfaL7aDqODXnPA67vZvvLHqZAyKXn88wargo634vjDEZZA
 PAtSr6NXOEGl6GroKL45YDmHtd6+CQYcfme5kk0dG27v9GUDK5Ino9OBDKJpm3K+0TwiXO1G0
 lnSSd4LNnGXmtRnHOKio/mrNhiDqKCBhnmo16tJ7nR9clnr7LQCA4hRjboUBsHj+2aoSBRHj6
 s/U3BqJUBoLNoWNV/Gfylwf/pEfIQ03Wtsbx8DkJtAnQ3GrefTEqmicH0gQcpA/75Md2/x69T
 iUINFlPCrF5CbJYCRDqZ3HZkb+waYOO1GZqJ3FsCuF0WDWLNCsRay7+XXkSR9q4/TzA1dYLm7
 aG9AIBlSoinCvg1Fwz4WeBOdd+I=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 24 Nov 2022, Jiang Xin wrote:

> On Thu, Nov 24, 2022 at 4:54 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Me again,
> > Hmm. Hold on. While `p4d` now no longer segfaults, it looks as if `git=
 p4`
> > is completely broken (see
> > https://github.com/dscho/git/actions/runs/3538941550/jobs/5940295721#s=
tep:4:2005):
> >
> >   failure: t9800.3 basic git p4 clone
> >         git p4 clone --dest=3D"$git" //depot &&
> >         test_when_finished cleanup_git &&
> >         (
> >                 cd "$git" &&
> >                 git log --oneline >lines &&
> >                 test_line_count =3D 1 lines
> >         )
> >
> >   + git p4 clone --dest=3D/home/runner/work/git/git/t/trash directory.=
t9800-git-p4-basic/git //depot
> >   Perforce db files in '.' will be created if missing...
> >   fatal: 'p4' appears to be a git command, but we were not
> >   able to execute it. Maybe git-p4 is broken?
> >   error: last command exited with $?=3D128
> >   not ok 3 - basic git p4 clone
> >   #
> >   #             git p4 clone --dest=3D"$git" //depot &&
> >   #             test_when_finished cleanup_git &&
> >   #             (
> >   #                     cd "$git" &&
> >   #                     git log --oneline >lines &&
> >   #                     test_line_count =3D 1 lines
> >   #             )
> >   #
> >
> > I guess I will keep digging,
> > Dscho
>
> I found this is because python is not installed by default on
> ubuntu-22.04. This issue is fix in patch 3/3 of reroll v2.

Excellent find!

I was pulling out my hair because I could not reproduce the issue, but
then I did not override `PYTHON_PATH` in my build and therefore the
already-installed python3 was used.

FWIW I confirm that this fixes the build. I restricted the build to the
necessary minimum (and threw in an `action-tmate` step for more efficient
debugging) and it passed the p4 tests:
https://github.com/dscho/git/actions/runs/3539338333/jobs/5941122554

Thank you so much!
Dscho
