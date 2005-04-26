From: Bram Cohen <bram@bitconjurer.org>
Subject: Re: Merge with git-pasky II.
Date: Tue, 26 Apr 2005 14:28:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0504261400570.4678-100000@wax.eds.org>
References: <Pine.LNX.4.58.0504261347520.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 23:24:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQXWe-0002ta-0E
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 23:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVDZV2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 17:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVDZV2j
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 17:28:39 -0400
Received: from wax.eds.org ([64.147.163.246]:52153 "EHLO wax.eds.org")
	by vger.kernel.org with ESMTP id S261798AbVDZV2e (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 17:28:34 -0400
Received: by wax.eds.org (Postfix, from userid 1044)
	id 510763240C1; Tue, 26 Apr 2005 14:28:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by wax.eds.org (Postfix) with ESMTP
	id 4E802B401A; Tue, 26 Apr 2005 14:28:34 -0700 (PDT)
X-X-Sender: bram@wax.eds.org
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504261347520.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:

> On Tue, 26 Apr 2005, Bram Cohen wrote:
> >
> > Now that you're done being dismissive, could you either (a) rebut my quite
> > detailed explanation of exactly why that functionality is both a dubious
> > idea and difficult to implement, or (b) admit that you have no plans
> > whatsoever for supporting any of this stuff? You can't have it both ways.
>
> I'm absolutely not going to do it myself, you're right about that.

Now you're just being an ass. I stated, flatly, that what you're proposing
to have done (by you or whoever, for feasibility it doesn't matter which)
is not going to happen due to just plain difficulty. You obviously
disagree with me, but rather than coming out and saying so you're
pretending I didn't make that statement.

> > What I'd really like to hear is some explanation of why git is
> > reimplementing all of this stuff from scratch.
>
> Git does in ~5000 lines and two weeks of work what _I_ think is the right
> thing to do.

So you think that a system which supports snapshots and history but has no
merging functionality whatsoever is the right thing? I'm asking this
seriously. You have a magic --make-somebody-else-do-merge command, but for
everybody else the current state of things is workable as a stopgap
measure (the original plan) but very painful for anything more.

Codeville is comparable in terms of number of lines of code to Git, by the
way.

> You're welcome to disagree, but the fact is, people have whined and
> moaned about my use of BK FOR THREE YEARS without showing me any better
> alternatives.

You were happy with BitKeeper, so why should we? Monotone and Codeville
are only just about now really mature, and you aren't exactly known as a
model customer.

> So why are you complaining now, when I implement my own version in two
> weeks?

I'm trying to tell you that the amount of time between now and when a
system as nice as BitKeeper is in use by the kernel can be dramatically
reduced by either using an existing system verbatim or basing new efforts
on one.

If you think that git as it exists right now is at all comparable to
Monotone or Codeville you're completely delusional.

> > In case these concepts got conflated, I'd like to point out that Codeville
> > merge both supports renames *and* does better than three-way merge can do
> > at merging a single, non-renamed file.
>
> And I'd like to point out (again) that git doesn't actually care what
> merge strategy the user uses.
>
> Me _personally_, I want to have something that is very repeatable and
> non-clever. Something I understand _or_ tells me that it can't do it. And
> quite frankly, merging single-file history _without_ taking all the other
> files' history into account makes me go "ugh".

Now you've just gone off the deep end. This is an apples-to-apples
comparison. Please accept one of thee following two statements:

(a) Git doesn't do merging, and none of the related new tools around it do
merging.

(b) Codeville merge (sans rename functionality) would be superior for the
merging which will be done.

-Bram

