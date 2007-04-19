From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Cogito is for sale
Date: Thu, 19 Apr 2007 13:23:51 -0700
Message-ID: <7vzm545d0o.fsf@assigned-by-dhcp.cox.net>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	<20070417104520.GB4946@moonlight.home>
	<8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
	<200704171818.28256.andyparkins@gmail.com>
	<20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl>
	<Pine.LNX.4.64.0704181130150.12094@racer.site>
	<alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
	<20070419124648.GL4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Apr 19 22:24:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HedAe-0000yt-Il
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 22:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767016AbXDSUXy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 16:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767024AbXDSUXy
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 16:23:54 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:50701 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767016AbXDSUXw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 16:23:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070419202352.LFUM1226.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Apr 2007 16:23:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id p8Pr1W00F1kojtg0000000; Thu, 19 Apr 2007 16:23:52 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45041>

Petr Baudis <pasky@suse.cz> writes:

> I agree that by now, the situation is too confusing and while I'm not
> happy with everything in Git, I believe that by now the best way is to
> just fix Git. Therefore, I'm announcing that I don't plan to add any (at
> least any significant) new features to Cogito. Sorry to all the Cogito
> users, it is a hard decision for me, but by now I believe that it is
> much more effective to just focus on Git.

I applaud this; I know this must have been a hard decision for
you to make.

> About git homepage:
>
> The very least I wanted to do at any rate with git.or.cz ASAP is to
> switch the crash courses to git-oriented ones too. I think git more or
> less got to a reasonable point when this is a sane idea.

I would agree, at this point.

When git.or.cz started offering those introductory pages, the
Porcelain-ish scripts (that is correct, "scripts", as there were
no "built-in" -- even "git diff" unified driver was a shell
script to driver diff-index, diff-files and diff-tree) shipped
with the core git was infinitely less pleasant to normal people,
especially the ones who have not seen the early days of git core
which shipped with almost none.  When you and I talked about
what text to put on git.or.cz, it was an obvious and easy thing
to agree on that newbie documentation should be based on Cogito,
and you did all the work to put the site together.

    I am saying this now for new people on the list, as I heard
    an incorrect "theory" that you have been advertising Cogito
    on git.or.cz site against the community's best interest,
    even when nobody seems to talk about it these days on the
    list anymore.

Since the early days of my involvement in git project, I said my
goal was to keep the plumbing stable, enhance the plumbing in
such a way that any and all Porcelains can do what they want
without resorting to Porcelain-specific hacks, so that the
resulting repositories can interoperate no matter what Porcelain
was used on top of the plumbing.  I worded that goal as "make
the choice of Porcelains irrelevant".  While that ideal still
stands, we ended up having rich enough Porcelain in the core
distribution.  To some people, this might look as if we are
making alternative Porcelains irrelevant instead, but that is
not the case.  Many features and workflows that are now
supported by the core Porcelain were first invented outside
(e.g. "automated tag following while fetching" came from
Cogito), and the core Porcelain does not ship with special
purpose features and expect alternative/augmentative Porcelains
to fill the niche (an existing example is that people who want
patch management use StGIT or guilt).  I am reasonably sure that
there still are features and workflows that Cogito supports
better, and given time and motivated users and contributors,
hopefully they will be ported to the core Porcelain.

I would thank you for your effort to ease adoption of git family
of tools to new people with Cogito; I would ask the list to do
the same.

And I look forward to see your continued involvement to make git
better.
