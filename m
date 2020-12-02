Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB66C64E8A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 12:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DDCC2223F
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 12:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgLBMwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 07:52:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:42387 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbgLBMwB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 07:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606913429;
        bh=hbMzaA+pnYNECWnmWX/8vJl6CpZ+hJ8Y/WeqIag1B54=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AY6/5dYGY1P51QXKWGa2jEvmFA6x46uGaKckmYUaNZ43ZtC4wrXy8DDdzYpaWLMBi
         SsKmpQVCCG8BoXkCvoHnlnBGuShxFOQluIkbhB+uZJHlWysDAtv63itzV67JPeJBNm
         K6SuLALXc9vTnYbtThwB98K9HGqyBRz5dQygNb/s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([213.196.213.207]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfUo-1kvT9Z0ey0-00B3VW; Wed, 02
 Dec 2020 13:50:29 +0100
Date:   Wed, 2 Dec 2020 12:15:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Kerry, Richard" <richard.kerry@atos.net>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Can I Insert some Ancient History into a repo?
In-Reply-To: <AM0PR02MB40811C5C2E8B13B63D06E4B49CF30@AM0PR02MB4081.eurprd02.prod.outlook.com>
Message-ID: <nycvar.QRO.7.76.6.2012021210390.25979@tvgsbejvaqbjf.bet>
References: <AM0PR02MB40811C5C2E8B13B63D06E4B49CF30@AM0PR02MB4081.eurprd02.prod.outlook.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1652509332-1606907713=:25979"
X-Provags-ID: V03:K1:eI5RpZnBSEUdpO3zbwr8j46p1DpVAXRmUn72naFKgRiLvS6HqCR
 f99BXVX4JQvZcAEeQPlw1kruR9TNC8i+586ESLFb9GRCgK9j4R2pmOSu7S3CRa4bcgBp0bd
 JcnUuh5ZrPH5mgNRTXYlnHV9vloA49SVJQhcrTlGRidgAI7ijLnjxUpgcdZB6rS9VKrnawp
 VtuB/pQbNozD2viFlE6mQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jkpy4lFpt4s=:svyxV1w0ZvRGtZKQ1A9TpT
 xQEvY+WYiV6cwoPbDLROXs3NtntcejZ+7oZcx6HhQT2iqQBTBoEceUJ7I0x1ydFI/ThBbSF67
 hHk5qemDRU1AhQ/Mu7UA2q77t3JP/WcxoXR9OPp0YWTiAOF37WGCVb2NW/RyUx41MQvcItzJg
 tehXGyQhYvR+W1eD5ZNDtzXcwkK2LF3whlvuQNNINOnWeJtjg11PPf/p0D2xvgrMpiSqu6K2t
 cX1KftOq3t0M3F4oKkn35aDCFCtzFR/ZG7vncTkHJs7rvIZYvg4Uaw7lpfKl+jkuLSeWw5Mi3
 KUXYM335ubtVCjy+QfzR1ZZLC2R5SYiBe4kNj5z+mfCuC08E0iOVqekEdKfCaHFGunRdP4RI7
 DmHgen1LTpUpvlE2uEq94yR5MBl9+KdxA4szVpdPVsX3AoMPOrjFPqxIhqLXSRa6JXlkybMhm
 kmh4Q+XVPLQkL+/jKDhAI2BYob0MJG2QlZLd7qbZz7byVzfFKrSmRaMCjLvEc+7QUc3nBt9FU
 Qhrk3C8ONnxmUgZPxTuBbQpGx1dLiXrcDtuuECl5QIcB4EbEFER/Api124qoX0tFKK/S1hDQH
 LDzPePA/9IcSSb5CCWGL7VbAlisiRjVFdfJALAieYkJm6Abaho2GDnUT1sq8N3GKA59PUYfho
 MyI2Ne2ETs80bR3If23rC9WJ3a5h0Uw9ONeE6fOtwKZ21dH9BO7bhQ70+RsMdzJub1IMemjR7
 uOUNWjEH2HOn96Lv2WODavguyrXqqZH5GvvkFnmeTz1ulI7JmwpJCh9RRBHtx3IevrHyoTy8R
 qfJQqCAGtdysbqJx8FPQYjs8u8BcA86rwGEo3TJZRqGstAp5xfkBY/i4oCnueK4XPyOaA6ugH
 z6+xY/cmQNhPrdvDg+/RJln50kE0gMUCPp/uF4fvU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1652509332-1606907713=:25979
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Wed, 2 Dec 2020, Kerry, Richard wrote:

> The Story
> - - - - - - - -
> My project, "L", has two branches "L1" and "L2".=C2=A0 It was developed =
as L1
> for a long period, then a branch, L2, was made and further development
> done on that.=C2=A0 Since the branch there has been further development =
on
> L1.
> =C2=A0
> A-B-C-D-E-F-G-H
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
>               J-K-L-M
> =C2=A0
> (That's supposed to show J branching off D.=C2=A0 I'm writing this with
> proportional spacing so it may look different on receipt)
>
>
> The Reality
> - - - - - - - - -
> L was developed in CVS as its trunk.=C2=A0 That is what I am now referri=
ng to as L1.
> A-B-C-D-E-F-G-H
> =C2=A0
> At some point a snapshot was taken and put into Subversion.=C2=A0 That i=
s what I am now referring to as L2.
> It is either
> D-J-K-L-M
> Or, more likely, just
> J-K-L-M
> (If some work was done on the snapshot before it was used to start the
> new project in SVN, which I think it was)
> =C2=A0
> L2 has been converted to git using git's built-in Subversion handling.
> I have a backup of the CVS repository for L1 and I can easily convert it
> to git using cvs2git.
> =C2=A0
> What I would like to do is to merge these two branches into a single git
> repo.=C2=A0 Specifically, to insert L1 into the existing git repo which =
is
> currently only L2.
>
> (The subversion server no longer exists, and I don't have easy access to
> the repository backup, and there may have been work done since the
> import.=C2=A0=C2=A0I have a full backup of the CVS repository and I can =
easily
> convert it to git using cvs2git, with any extra parameters required.)
>
> I've read up on merging repositories and I can easily get L1 into the
> same repo as L2, as a separate line of development.=C2=A0 However, mergi=
ng it
> is not the right thing to do, as that leaves me with L1 and L2 having
> separate starting points, with a merge leading to there being only one
> head.=C2=A0 That's the opposite of what I want - I want to keep one star=
ting
> point (that of L1), and branch L2 off it (with L2 ending up as master).
>
> cvs2git works by generating fast-import scripts, so I can intercept the
> result of that and edit the import scripts if necessary.=C2=A0 I can eve=
n
> dump L2 and rebuild everything using fast-import if that's the best
> option.=C2=A0 Maybe L2 needs to be imported into L1 after generating a t=
ag in
> L1 to indicate where the branch happens?=C2=A0 That seems to be a more
> complex work-flow for this task - I would hope to be able to do minor
> manipulations of branches and only one fast-import (ie L1).
>
>
> So, I'm still looking to see if I can find any other way of wrangling
> branches to make this happen, but I'd appreciate anyone else's advice on
> how to achieve my merger.

If I were you, I would use `git replace` to pretend that the `D` in your
`L2` history has the `C` in your `L1` history as parent:

	git replace --graft <D-as-in-L2> <C>

Note that this is a local-only operation. Even if you push, the remote
repository won't know that you grafted L2 onto L1 in your local worktree.

Ciao,
Johannes

--8323328-1652509332-1606907713=:25979--
