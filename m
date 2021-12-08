Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F02C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 12:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhLHMqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:46:32 -0500
Received: from mout.gmx.net ([212.227.15.18]:49563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229496AbhLHMqa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 07:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638967371;
        bh=OEbXAjIFgXK6jKgXra0iLGdz9eAwjrfDVjTLJ5WEcB8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ewscDP3zt3yL8m71r/dRiiZoUARnlTFpTeU1lAt9QBDvI0U0nhd7XL4OuXIO93lOg
         D4I9T9UKRQUmWjeKZl95uUMiebS2fPLqyPwkZpGzk8saBQ1Sj4wfZ7+UubD9xm4yKs
         TqFKGwxjYr1P5pOJGF1NZiZFZNIesoLW7vndPtRI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([89.1.212.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Il-1mY0ec1RMr-013LC3; Wed, 08
 Dec 2021 13:42:51 +0100
Date:   Wed, 8 Dec 2021 13:42:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2021, #01; Fri, 3)
In-Reply-To: <e1aadd47-533c-fd8b-4fae-f64a53c81ec9@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112081340420.90@tvgsbejvaqbjf.bet>
References: <xmqqh7bpqhf0.fsf@gitster.g> <e1aadd47-533c-fd8b-4fae-f64a53c81ec9@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/AFnDBNYPBFHb2CQQLKNfh0GpXkQvQzAB5QoHb/W1UQCouR4j6O
 5G10uz2F2s/D6wOdi8bMlR4y3YCKIbgXkbWVhPU0CtkZGXT2niaVXuFPs1IRhvdiWXsL3Mx
 KZocz1sw+Ia0IlCTVKA332fg7LsjudMLIL28McHSb2M83i6zPaE3vslVr2Yv7o246qzK7h5
 WjA33ydvvF5QA1iN3kEIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hMaXn4dootE=:lrFhQIXlTHSbQGKsM0RgVj
 mR+WR+I+HGxx4I2IaIti9fY2Y+foFtDtIp1/AenExcudNBbE6xEK4a8B7//q7ZrVW6BX+T5dE
 +SlR4l8Lyd/swOohtHOjA033kRv4giQW+/j3LKGsWqsVCUko+b0KYIoWi7Fnkdk8H916umpGo
 5U269h5brhiGPkUUMGk6+501fxlV/wH4jGMrebpeDU2Vjvv5RQN5ha3WkkjeZYLBxMguCLInS
 LsKM5YLpudqm5wpbHvBb40qh8P0FTUlCbLbwdl4wuKKG8dZcWdPNbiX0g007eeQrQUWW98/2y
 HfWdKgfBtoWe26Z4ncwajmEhMOdWiupybj8aWOPF5w6ZLAkr3bcurtvRWUPc4OQm4y7cUS4l0
 dU/7OQmAsa06GpquG9nXby7aNKQuivT3eZCFpMe7jB2xc9ByYOubiG6ec3HJQ4fmRzozvQ4Xs
 rGw2A0huMaV8wq/l007fle0kNxqg7fgBim9cpxo4pekuEl/pJ5ibkX+gIzNhi4Brm5vtDzHb4
 fQzqIdap9mxlZv8Qkyaf1SrkWthZ/W4IzcVFNa0sO1Vz5ViScXd9QryDpWFfm73XVwWJeuU6+
 Q19Y4BxOFxLlqCwGtwMhwzh4YoUPH8C2FPNvNHsjGS3Htn4ZDytzpPAxA2PHP12F6FRwiN6Gg
 pdnFmwPcpNnVfxoBjAtiWtiFXkk3pip9MxTkHFslTDl/fl9RTn0kQjJEPkvyJoGJH0wT9HI2h
 ompYTvzzWNEE291+oT7ZPJG4XlvnmQjeuIfCnApAucRIKfhbHlAwuPWpjVsFron5eoI7H0CMw
 bNVsz9NeKQn4vJ1dQF40UeRaDMAILX9UWdKjj846+ANcc5I5MKeixFbL8ohamChRey71Bj5Rg
 Um/nN8OPWBXxva4iDa86B4x53TUskjUVMZmb6J1PAl5XCONw5Td7CK8mPYJHVKjC3wP8LVWcd
 Tz9rda9UL08Gk00/75459Lrs3loQod/1WeEwoUFTo+B+8gcI+Or2vlbj6MmduYNeN6ZyOugPL
 a9/1IIgywOFQ0zuMVeVBSCoEXtb3RTOYXoY0ipKIaWakiZ5Y93OmG2QjHDyNstVkjPc6ngqKl
 ctUgD7pBC7EnLo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 6 Dec 2021, Phillip Wood wrote:

> On 04/12/2021 01:37, Junio C Hamano wrote:
>
> > * pw/diff-color-moved-fix (2021-10-27) 15 commits
> >   - diff --color-moved: intern strings
> >   - diff: use designated initializers for emitted_diff_symbol
> >   - diff --color-moved-ws=3Dallow-indentation-change: improve hash loo=
kups
> >   - diff --color-moved: stop clearing potential moved blocks
> >   - diff --color-moved: shrink potential moved blocks as we go
> >   - diff --color-moved: unify moved block growth functions
> >   - diff --color-moved: call comparison function directly
> >   - diff --color-moved-ws=3Dallow-indentation-change: simplify and opt=
imize
> >   - diff: simplify allow-indentation-change delta calculation
> >   - diff --color-moved: avoid false short line matches and bad zerba
> >   coloring
> >   - diff --color-moved=3Dzebra: fix alternate coloring
> >   - diff --color-moved: rewind when discarding pmb
> >   - diff --color-moved: factor out function
> >   - diff --color-moved: clear all flags on blocks that are too short
> >   - diff --color-moved: add perf tests
> >
> >   Long-overdue correctness and performance update to "diff
> >   --color-moved" feature.
> >
> >   Need to pick up the reroll before merging to 'next'.
> >   cf. <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
>
> Dscho spotted a typo which I was going to correct with a re-roll but I'v=
e been
> holding off in case he has time to read the rest of the series.

I would have loved to give this a much more in-depth review, but the days
have become short on the North hemisphere, haven't they.

In any case, the patch series looks good to me (personally, I do not care
so much about typos as long as they aren't indicator of sloppiness, which
in this case they aren't, I find your patches really well done).

Thanks,
Dscho
