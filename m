Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74434C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 13:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B3A613B1
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 13:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhHXNes (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 09:34:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:40969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234881AbhHXNeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 09:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629812035;
        bh=mDNkB99EE5DvIJsqkGKrZUPBt8UByik3HH9anys95/k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W6gFQrgJCg8t9ngzBPmKKiSLIPl03aPdwTW9Tr12zNDWUg761bhJpKJIKSa9mfaOc
         Se1BJq7OBUCEWMemPR7dXBLWWa48QoEZtG8ongCxk2rAyQ3Iio2PonV4/ImNBtjm6j
         fKOJcEp+I/z+1KklUG2IHuxj8nngursxeraWvgpk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([89.1.214.7]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyuc-1nCwfl1i4s-00x2QP; Tue, 24
 Aug 2021 15:33:55 +0200
Date:   Tue, 24 Aug 2021 15:33:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/4] rebase -r: some merge related fixes
In-Reply-To: <pull.1015.v2.git.1629474038.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108241533270.55@tvgsbejvaqbjf.bet>
References: <pull.1015.git.1628860053.gitgitgadget@gmail.com> <pull.1015.v2.git.1629474038.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-396644810-1629812035=:55"
X-Provags-ID: V03:K1:cP9NxP4mJ++QsuQBzx+W6cAQZvqrCfJJpaCt3UNvf/rYa83Wn6S
 u6vxsnjNTVsA42JrV3DZjCMZd4Zn2iYBAmRnACwcYZGTkiVvn9lbWqf/WZvDWQIyUtRfI67
 7w+RtWmfcBwmat+786R/jELuo0HaaeoQKEkzYj/QLneNqQ9u8kY3/FVnOFMpJQhoa1lO/df
 fw/xuubs7auTH7NYJ0iow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lrdfAxsmuQ0=:nMJaXqXgV+CjUy8Ja2tVw6
 VurSt9O0tIEfugWVPOktlZW8jR7qPUSsFMQanJtmgUe/oJZuBaLJBoAYmBaa2UtrDP2RWNLfj
 b0kTarwlN4bZRGar7YF01JEzskN6n/diV2ICWKjiSWPYmEnsJcpDHJHhZIE5HbkkmvPT61OyA
 G37dfay/ya7t3DFsRs78Y2MWvuni0V2gi3wzSsypuXbq7tR8/xKZhHVXj3GjOn0W7sR5Xg2pu
 oGNS6SzXGji8FGuAC6Ay7Gek5ejY8TZFkkx3pJyasyVYwxuuV/Zaq3WbTFdi07s4ZriMfx3T5
 +DXbfS7+NJLeGuhsP1kbW+djn5RBssv2ULzSB0rn2kbDxEILIu0hZSKB4tooGdcliFo4cTM1a
 dwLctFl+9CdZM1i39AiTHQWtcG2GAuX+M96fdrEZK5zNom4ampNXq6Ry3ezbFxH914x7SoSfb
 3eotBhn4iZv3s8kFedi4sVwJRPSrOZHbW4Ry4iCgEGY2XtYajnErdDfKavgQjHPCwP+z1LSh6
 7Snt/oVwBiBkh/H65FfbPqR4ifWwucNnIsfBn4g28Wykof+HA+LMFm8q3bI/PuZ8Hqp0J9lkr
 wZIpusuhUYXXYhGzy9IV5W3ii/O3g+dW//DScKZKGl+atdyEC0wr2X/T+BXRWajRfub7xE/yz
 U8MvNn5D9GXti4HF4AsVeuzYC2CYmM5UPxjraPxgAnL4Jmc7uA6LPDDJa9NZfgu2lV6sLz5L3
 jEIujFGI8dT93nu3G/IC4x+jUfybldH7vfO70acqld+4sWAQdN8nZTzrrtHgpwNo+eDryBtc+
 +ve/vv62JwbOVwUnb8xj6WPhhNPPuXoLx/lJ7KWuzgsx8ovztvvsRVRvwB0zk8aziCwEiwYaZ
 uUXb+1w3YdFV6TPu2IykWLfEjPFKWo/xu7gBKaH/7uX6ytYGAzvf5qUDE0qKx8O7l+v+053Pv
 lI2CR6hU11jhAFGWI7sfViikup8DEvcWc9VU4oT3D63vW7n+K+e9Z2hvbXZ7eDkv6tLg23nTP
 uTlxZYG8Ec5yCKw6ba3WcVkvd0qhd99ZJ7/edzfqeSf2GRuQ+jiz32xniW7QJd4vJzbuhS24f
 F81ogqLRyKPqH5rIfc4kuDdzus33SZgWU520gT99UrvcCA5qEt88xeNcg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-396644810-1629812035=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Fri, 20 Aug 2021, Phillip Wood via GitGitGadget wrote:

> Thanks for the feedback on V1. I have added a sentence to the commit mes=
sage
> of the third patch to make it clear that the fast-forward code is just
> moved, not changed
>
> Cover letter from V1: This is a collection of merge related fixes for re=
base
> -r
>
>  * Make merge -c behave like reword.
>  * When fast-forwarding a merge don't leave .git/MERGE_MSG around (repor=
ted
>    by G=C3=A1bor)
>  * Make merge -c work when with --strategy
>
> Phillip Wood (4):
>   rebase -r: make 'merge -c' behave like reword
>   rebase -i: Add another reword test
>   rebase -r: don't write .git/MERGE_MSG when fast-forwarding
>   rebase -r: fix merge -c with a merge strategy
>
>  sequencer.c                   | 106 ++++++++++++++++++----------------
>  t/lib-rebase.sh               |  56 ++++++++++++++++++
>  t/t3404-rebase-interactive.sh |  13 +++++
>  t/t3430-rebase-merges.sh      |  38 +++++++++---
>  4 files changed, 155 insertions(+), 58 deletions(-)
>
>
> base-commit: 66262451ec94d30ac4b80eb3123549cf7a788afd
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1015%2=
Fphillipwood%2Fwip%2Fsequencer-merge-c-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1015/phil=
lipwood/wip/sequencer-merge-c-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1015
>
> Range-diff vs v1:
>
>  1:  b514dbdf928 =3D 1:  b514dbdf928 rebase -r: make 'merge -c' behave l=
ike reword
>  2:  511cf9204ad =3D 2:  511cf9204ad rebase -i: Add another reword test
>  3:  01d5ed4cba0 ! 3:  080e580e11c rebase -r: don't write .git/MERGE_MSG=
 when fast-forwarding
>      @@ Commit message
>           is not removed and can end up seeding the message of a commit =
made
>           after the rebase has finished. Avoid writing .git/MERGE_MSG wh=
en we
>           are fast-forwarding by writing the file after the fast-forward
>      -    checks.
>      +    checks. Note that there are no changes to the fast-forward cod=
e, it is
>      +    simply moved.

The result still looks fine to me.

Thank you,
Dscho

>
>           Note that the way this change is implemented means we no longe=
r write
>           the author script when fast-forwarding either. I believe this =
is safe
>  4:  f2a2e3531a1 =3D 4:  b6981ea5439 rebase -r: fix merge -c with a merg=
e strategy
>
> --
> gitgitgadget
>

--8323328-396644810-1629812035=:55--
