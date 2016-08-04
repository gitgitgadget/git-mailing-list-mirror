Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EBAE20193
	for <e@80x24.org>; Thu,  4 Aug 2016 15:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758768AbcHDPaU (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 11:30:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:49784 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757009AbcHDPaR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 11:30:17 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MDFB2-1bUEed1WFY-00GXia; Thu, 04 Aug 2016 17:29:55
 +0200
Date:	Thu, 4 Aug 2016 17:29:52 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive:
 abort properly upon errors
In-Reply-To: <20160803165652.zek5df7tv5reg6w4@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1608041706040.5786@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <20160803163449.iwjv4youmsf6okme@sigill.intra.peff.net>
 <xmqqbn19aj5t.fsf@gitster.mtv.corp.google.com> <20160803165652.zek5df7tv5reg6w4@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ilHzB4KFzPZhLhCUqRggZSMmFIB2MToAfb734Pc5GyBVIfIlj7u
 N9ayWNWzCp8wtWB9FgoMsW9Y5liqbjMWkX4/pqyjfM3Q/2u1zRRRdYyeiRYg6M8ifqST9NU
 BVZSeguwU2m50CJS5U7INKy4xq34Yi7u7agNymTWO313YRWV8WxS5n5OMZ9Gsb5Nt2YY9m+
 G0c7VLOeQKjSTL2vyJauA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:TAXlOM1mpGg=:VSwq0fK3f+jtaQgvIPUbZN
 gq88KZGfCFMLmMGgDMY9MDjdru1KsVEqgM5OtO9L8UZQa/0nFw0wwPYUfUvUzaVIc1muWXNGy
 qKzHQCObPQT6vacPTcDKQLOVQQ4s+CV/0WEkEvxl6BXlvffDqRBhyRYHr3yR/X8WWo4WzKvND
 Sw1sMKN+2SR/WU2AblaV8iv7SQGEvy/r+hLVY24dIgEZzdM3TxPmM7O1ntEXKKWSlv3wgvNs3
 Tq9P7tRbuz2WqX82LVhNEruHePwIEWOHodJjsxMFpqPzAwYMcQneYKa59oz0lj4Dc27M7cIdj
 BP7JPYWbOq9AxOcYw7jD4f7Btb+Yd1zCTKckkP3TVd77KOYVXlplW678BAk4ss4vd/Qv85tOe
 xz7bZWgQ0LS8wj2PJNmEG3D3pHNRo0fsCaJwQkhpz0q4USA+BmhQHuH4D4pHWTdztaPADirur
 FLXIQ2FwmZ+iScox+9GgN+aQHK7nwqepoj199f8xNiXiRWu3bDd8/DIEWcw1XjiJcF3uTBSDo
 scVZXl9cNl4UR98VsJtxX1UeaNZ5IkkuwlGWrjvskL5FiFRu0EY5j7AAgk4IK56OKAh8457bm
 5/XzS5OAGBSfRYxiGu1ZKCvrWrOv7UTA8YHCG44E8kpcts5whqdL+SPJQO97eguDvDB21XjVW
 9kF2JwoBrgasOJ3Nx107WT5gmos1ERbi6aqD0xSzEGGrwXgcz9h/zOUkWjz/icCqImlk0hV5m
 QWTS/IEf6bVBeTbhVxITa8xO6kTyz95FHghVqdqMKHEhKt+YHEDbAHVXwnCP0asPeve9VQgbQ
 lEqQIsi
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Wed, 3 Aug 2016, Jeff King wrote:

> On Wed, Aug 03, 2016 at 09:53:18AM -0700, Junio C Hamano wrote:
> 
> > > Leaving aside Dscho's questions of whether pulling patches from email is
> > > convenient for most submitters (it certainly is for me, but I recognize
> > > that it is not for many), I would much rather see incremental fixup
> > > patches from you than whole "here's what I queued" responses.
> > 
> > Ah, yes, I misspoke.  It should be either an incremental diff or
> > in-line comment to spell out what got changed as a response to the
> > patch.
> > 
> > I find myself fixing the title the most often, which is part of the
> > "log message" you pointed out that would not convey well with the
> > "incremental diff" approach.
> 
> I mentioned a micro-format elsewhere in my message. And it certainly is
> nice to have something that can be applied in an automatic way.

Indeed. This is what I meant by my (succinct to the point of being
intelligible, admittedly) reword! suggestion.

Let's clarify this idea.

I find myself using fixup! and squash! commits a lot. Actually, let me
pull out the Linux key for that. I use those commits A LOT.

I know, I opposed the introduction of this feature initially (and I think
that my concerns were nicely addressed by Junio's suggestion to guard this
feature behind the --autosquash option). Guess what: I was wrong.

And I am really missing the same functionality for the commit message
munging. These days, I find myself using `git commit --allow-empty
--squash=$COMMIT -c $COMMIT` very often, duplicating the first line,
adding an empty line between them, deleting the "squash! " prefix from the
now-third line, and then editing the commit message as I want to. When it
comes to cleaning up the branch via rebase -ki, I simply jump to the empty
line after the squash! line and delete everything before it.

This is as repetitive, tedious and un-fun to me as having to transmogrify
patches from the nice and cozy Git universe into the not-at-all compatible
universe of mails (I congratulate you personally, Peff, for finding a mail
client that works for you. I am still looking for one that does not suck,
Alpine being the least sucky I settled for).

So my idea was to introduce a new --reword=<commit> option to `git commit`
that would commit an empty patch and let the user edit the commit message,
later replacing the original one with the new one. This is not *quite* as
nice as I want it, because it makes the changes unobvious. On the other
hand, I would not find a series of sed commands more obvious, in
particular because that limits you in the ways of sed. And, you know,
regexp. I like them, but I know many people cannot really work with them.

> But in practice, most review comments, for the commit message _or_ the
> text, are given in human-readable terms. And as a human, I read and
> apply them in sequence.

So true. I do the very same.

> That pushes work onto the submitter, but saves work from the reviewers,
> who can quickly say "something like this..." without having to worry
> about making a full change, formatting it as a diff, etc.
> 
> I do think that's the right time-tradeoff to be making, as we have more
> submitters than reviewers.

I agree that it is the right trade-off. TBH I was shocked when I learned
how much effort Junio puts into applying my patches. I do not want that. I
want my branch to reflect pretty precisely (modulo sign-off, of course)
what is going to be integrated into Git's source code.

I'd much prefer to resubmit a cleaned-up version, even if it was just the
commit subjects, and be certain that `pu` and my branch are on the same
page.

Instead, Junio puts in a tremendous amount of work, and it does not help
anybody, because the local branches *still* do not have his fixups, and as
a consequence subsequent iterations of the patch series will have to be
fixed up *again*.

Just compare https://github.com/git/git/compare/1fd7e78...6999bc7 to
https://github.com/dscho/git/compare/f8f7adc...3b4494c (the onelines are
enough to show you just how different things are).

I'd much prefer the contributor (me, in this case) to put in a little more
work, and have things consistent. And avoid unnecessary work on both
sides.

Ciao,
Dscho
