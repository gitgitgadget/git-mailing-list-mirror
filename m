Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DC621F462
	for <e@80x24.org>; Thu,  6 Jun 2019 13:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfFFNJK (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 09:09:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:44695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfFFNJK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 09:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559826545;
        bh=ro3WxUliWX8MzLfbBrLn4aBa3VVJQ5QPc03N7zWmDdo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=O2xJJhRoGgKgXZ6WyEJehP5v1jXFk/MVOiejqozykkpaSwCHnqfXWwcstS9zsbhB+
         evqTtqAG0T1l7o0BFfMHrTvvzubx9YGTM1zo9/qKwCeJqrbvjjItSDpqKbtnke/h4M
         d24fZi1XMIIOdhnDbSCyzNKQZI/Nmv/+EIzXqb8c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McDl1-1hIixy26DP-00JbTt; Thu, 06
 Jun 2019 15:09:05 +0200
Date:   Thu, 6 Jun 2019 15:09:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Nickolai Belakovski <nbelakovski@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2019, #05; Thu, 30)
In-Reply-To: <CAC05385iALWsN_fRS-Mzt1Q-3kV+562KfkV+Gz_XtEw40_ddLQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906061508090.42@tvgsbejvaqbjf.bet>
References: <xmqqwoi7ws9z.fsf@gitster-ct.c.googlers.com> <CAC05385iALWsN_fRS-Mzt1Q-3kV+562KfkV+Gz_XtEw40_ddLQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rVDYJXuU7VxU/UxN66G8uU3gbiMOuyqprejUvpiXdaHVesZ+lkc
 WV8iBk37bd9XwDfu7L7FUthHIS+DYwvlXHGVyIJLI0995rMkS3x1bVo11u0sE3ftJWY23dz
 pdNZKEqwvGkGhwtFP1HgRSNEwyQnPBTGHIG4SiF6QN16kwk+XTMUMnBC5FieFGkyf8yFwbG
 CGrSB+1WPHp5BPP8QsQ4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XDR8z0l32YY=:JDWEJFZyxaYBa6xp1VBi8A
 0T6psp0UgDQ8zCDkVtiL6b4r50OeVgM20fA1mgfhMSYEj8h5j11aTVLeYWaFHl2+pbPZJBSTn
 GjrBhvgbWXrsKgVifGea5NXuJuLVGCltTAIcp30hdrGXPyGKekQ8tblQWhBfxmlLRlSuqgXRG
 O3ZA7w3JbcISCW2xEW9duuRprOvdnPJ9wGni9/dlnSfQLMPPNuCaCpDPv0deaHkEoYRowdlx5
 Fu+t1NHoBGoq4OR1zZu/mylxKPUYsu1cRUIYuaWenCEftLSi3AnPxs6+B7bxdS0iRz+jiKudc
 bLCH0rTa7H1QLFcA2QEcn/q7xbJJvkHo/ZRlCXFATYiDd9UvU7QMF3WQLTOultIN75vOwN1rf
 kBAjveL0eHZJ7NRIbVX675PkUCOW0HnidmoDO8zClA7+bsYeqv6z0pZVeYTV6F99dDZGvkkNm
 NdVGQhWcw6SrOSNyrEXnpXBDF4EWP0QQdaRxTNkMLMxDGs/HOH+sjD0omGEG6g5+jBPV5+r79
 lQQ6e7eS+rwGNMxunUQTKFwcvvbXIuqcsZusW+g16oBXyyVcDezktgBSrUUUv45uWni3KCb+d
 fV8bSOn7dOfLdQPWhAKLTa8oYEUQGu6+n4sg5TYgQlsrtI0Fdjt1kAPQKAsnke+/ertOlQw6R
 FcQ1yKYRqVU4AaWCxHqGlNykR8+pFHQUi1H6iM/fBs6ZXmtpowA+X0wy1/ThVA4Tu0yFst4Dd
 E7YTbMRhem3wGIJKSA2/fSOaTDB8PNVsdQihhVrrhJSrbXpNMhqVAkyHHYNL1DrkVntTbvriL
 UwfVseb8a55rbmJ3Kysti6C4gEResr6lyGTPOaq5vgQpQfdr+Zu14rnPV6qw9oQLxnrIsNFdx
 t88aMiFkeB0Q39SnCaHxMSoNUTgTCdQ8jaUu/unKEWLQfloWFwMqIl/+HHYAy83/ymcNOCdMI
 cu43GI+ZVR2d6ttjJWyZex879/dWKfOqspm+3k0CVE62eh/OZowEX
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 5 Jun 2019, Nickolai Belakovski wrote:

> On Thu, May 30, 2019 at 5:20 PM Junio C Hamano <gitster@pobox.com> wrote=
:
> >
> > * nb/branch-show-other-worktrees-head (2019-05-07) 3 commits
> >  - branch: add worktree info on verbose output
> >  - branch: update output to include worktree info
> >  - ref-filter: add worktreepath atom
> >
> >  "git branch --list" learned to show branches that are checked out
> >  in other worktrees connected to the same repository prefixed with
> >  '+', similar to the way the currently checked out branch is shown
> >  with '*' in front.
> >
>
> I see that this has been in 'pu' for some time now. Is there something
> holding it up from going into 'next'?

If all that is needed is a vote in favor of this feature: Here is my
"yay!". I am a heavy user of worktrees, and this strikes me as something I
want to see in the output of `git branch --list`.

Thanks,
Johannes
