Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB41C33CB2
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 09:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBAA20705
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 09:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="be6R9rOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgAaJc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:32:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:34745 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbgAaJc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 04:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580463139;
        bh=nqYNiqjPdvf2DPGmIMnV4XpUZPXgoqjXMHaLCf8aU2E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=be6R9rOyDCpuJ1ZI37fi7xV7n7A6u8ttR4+pQfMsSCMapWqF8yarmVX/4ZuxZNxYe
         fNCGu78APzWbhlfq/MkN8kqHXsW4D4tzrZyew7kD9aMmGARFWElMCe+WpGTprVKiKR
         gC2e4DHQOS7RgMPuoxGsXv4/buskM09EZw8jGatM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYc0-1jQRcD2cbm-00lzuK; Fri, 31
 Jan 2020 10:32:19 +0100
Date:   Fri, 31 Jan 2020 10:32:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Jakub Narebski <jnareb@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        christian.couder@gmail.com, t.gummerer@gmail.com,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: Converting scripted commands to built-ins, was Re: [GSoC]
 Exploring Previous year Projects
In-Reply-To: <39a8c249-f0bc-fb0f-2ed5-5ecceb6d4789@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001311007590.46@tvgsbejvaqbjf.bet>
References: <20200129171248.6217-1-shouryashukla.oo@gmail.com> <86k15ars55.fsf@gmail.com> <nycvar.QRO.7.76.6.2001301154170.46@tvgsbejvaqbjf.bet> <39a8c249-f0bc-fb0f-2ed5-5ecceb6d4789@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EtgJCHnXk27IE+4CXe+7p4uW6ynX2YHKTpC1XKQZ9dRQR8YxQD+
 kDcoUnDWeyBXWELVdFkXJIAgc7nJlxhI4vUlsk2MCrNU3EAMp4Mc6a/Y+cvD4656cDyBTZA
 7nRPU0EFE114yAOvlUiiNPmgKnDGSxjKYR0ogtK1dJ1QX1tY12LIVryP7D1beiYHdv3w8XD
 Dn519OjW46khocUsPHksQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xXuEtTx8G4Q=:oa8okPkfRDQEVsQZENuaPc
 1k7t16++GNTRkNZ0+y+6Hyj7Yivr1MmxliQ42AeENDxjteBKVqLSIzPt2Nl63hWbgrt1qTBju
 Huv/v/+TkF9pNlMneVcqFTnWOQAIL+6VQ/reHOp/x771JJhZXrPxnIipU8N2DOlfI9TKRnAL8
 hGjEimjZDVi6vvWIL3GOxFys/ekFGkSFTqvgvN4c0Yh0f3bxIliLe3l3XiIDCtGj0st1p17F9
 noCH07WS0uDeN+qvSx4hfLmdD7N8kTJb1Zl4E+DBwn0CSL/vvpTr/I3+QrBIlFiG860kRc6vB
 sT4QlzQtrKVoru6vSmOOlX5yuLVhC2urFNtGPGo+CBaHotFo0ZC5LHwpvxXYXAz9E2bbc89BH
 4BtIg3VPLy8Ip0Zk6U9aHjnQMcHlgXd+S0tiIJtLmuG3EKgS/p8cBT2v1dwwfAo1UhYirGMty
 kQrl4xEXNKYgOv31aKOAOW5tdbYhg0DXoELXKz2wFYhKfqIa7Q4Ux16UaJCDEyc4LJujVA2VW
 zLzNJ3gGjS4dmZ0DznvcDMdXF2F42Q1sDTrSo9z8aBsj6UtEDpqOgsyz0S4hR8JIKL9mB6TCB
 wjWrILHfRh3hjCIE1S3HTNb0XwLlnU98/oBSkKGXSYHxGMslJ8kLOgqWXs3HjZUN8luMI1olu
 +3SBazcOf1BSTQawnwRr0H40UN3z3h26jsHo3FBaMI434hescZzrSVqwnDP9zIJGb2gy4QFl7
 kdWKnPmIoRvBP/uqZCOP0u58tfqBCgknRPv94ot24OvawaMfT5mPB7RKWkdsw+wL15W0zvS6F
 yORZjjdeXMFWu9XgOt5QAtu8GB2/7XamTAsIDS9oA6rUMw8DHxFvHFMO6Y2gIQl3t60B74twm
 fhF6buSmVl9l79DqLd98mAy7ifWBo9u6h/KUNTJnD2teamkofPUKiPF9LgDMaWqZtVAne9fzP
 aqjbhVWKVnN+LHd06FFI5GxvwpttxlbScHQ6Kxi7I8LIXy1OJJuQIVIjOOxBxmhaQobxuUDd0
 K/okGDjrnSHmWIe8mQ6WNnHKnjIWgJKJhiUKXQAQjsxViK0pOcxwI547ToYa0lf5UmTzSYWe2
 MM37okWkfPgZVlHZ+zTPqacoYP0//hHO3NmkW9b3QXF/MP2h5NiTRpZxU6q2tWKldETV71l0c
 0DBaE5vIEPJ0K1JtoK8E6+pzD/csharJjA8zKvjRGt1b6uuY3lTBlkAgRTtR1IvKnK7yCHqti
 3RQ0508tQUCknuUtO
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Thu, 30 Jan 2020, Derrick Stolee wrote:

> On 1/30/2020 6:10 AM, Johannes Schindelin wrote:
> > Large parts of `git submodule` are already implemented in `git
> > submodule--helper`, so that's a head start (thanks Stephan Beller!).
>
> As I recall, a bit part of what prevented more going into submodule--hel=
per
> was isolating the_repository and allowing multiple repositories in-memor=
y
> at once. That effort has stalled since Stephan has moved to other things=
.
> (I will also admit that perhaps I am wrong: is it complete, rather than
> stalled?)

There was definitely a push toward using `the_repository` in more places,
essentially making the entire code base a bit more object-oriented. My
impression is that this effort has largely stalled since Stephan and Duy
moved to other things.

However, this push is not exactly necessary to make `git submodule` a
built-in, much like `git push` can be a built-in even if it has to work on
two different repositories when run locally: it simply spawns a `git
receive-pack` in the repository to push to, rather than handling two
repositories in the same memory space.

The same is true for `git submodule`, of course: it can very easily spawn
processes for all the submodules. And that's what the `submodule--helper`
already does ;-)

> I would be happy to see more progress in this area, and it could be a
> good way to get familiar with the codebase and submitting patches.

I am of two minds here. On the one hand, I am eager to get rid of issues
such as https://github.com/git-for-windows/git/issues/1661, i.e. issues
that are solely due to Git requiring a Unix shell interpreter to run some
subcommands.

On the other hand... it is well known, I believe, what I think of
the design of Git's submodules feature. Putting an effort into making them
easier to use will not change this design.

In my mind, it would make more sense to focus on making partial clone and
sparse checkout a thing, and then combine it with a built-in version of
`git subtree` to include dependencies' commit history. Yes, I do suspect
that git-subtrac is going the wrong direction from git-subtree.

> > Realistically, I think that it would be possible for a GSoC student
> > who is already very familiar with the code base and with submodules to
> > finish the conversion of `git submodule` in one season.
>
> Even assuming the most generous definition of "very familiar" I'm not su=
re
> this is the case. But I also don't meet the bar of "very familiar" when =
it
> comes to the submodule code.

Hmm. I guess you're right, and it actually matches my earlier assessment:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.1904031957480.41@tvgsbejvaqb=
jf.bet/

While it would be more satisfying for a prolific student to "complete" the
conversion in 3 months, it does not _have_ to be rushed that way. There
are tons of things to learn along the way, which is also part of GSoC's
mission.

The good news is that it is not an all-or-nothing project. Just like the
conversion of `git rebase` to C, which took several years, and the effort
of several contributors (implementing merge-recursive in C, then the
sequencer, then letting most of `rebase -i` be performed by the sequencer,
then the built-in `git am`, then the two GSoC projects to convert `git
rebase` and `git rebase -i`, extracting and deprecating `rebase -p` and of
course implementing the replacement for it: `rebase -r`), `git submodule`
_can_ and should be converted incrementally.

> So, I'm sending this message just to say "DRAGONS BE HERE" and recommend
> taking on a smaller project.

I can get behind that pretty good advice ;-)

Thanks for weighing in,
Dscho
