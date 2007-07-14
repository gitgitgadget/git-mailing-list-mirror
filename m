From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CVS -> SVN -> Git
Date: Sat, 14 Jul 2007 13:58:36 -0700
Message-ID: <7vzm1yg0sj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>
	<469804B4.1040509@alum.mit.edu>
	<46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>
	<4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, dev <dev@cvs2svn.tigris.org>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sat Jul 14 22:58:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9ohO-0007lU-MO
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 22:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763180AbXGNU6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 16:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762873AbXGNU6j
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 16:58:39 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:52138 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755997AbXGNU6i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 16:58:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070714205838.IJVU1393.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 14 Jul 2007 16:58:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PYyc1X00C1kojtg0000000; Sat, 14 Jul 2007 16:58:37 -0400
In-Reply-To: <20070714195252.GB11010@thyrsus.com> (Eric S. Raymond's message
	of "Sat, 14 Jul 2007 15:52:52 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52509>

esr@thyrsus.com (Eric S. Raymond) writes:

> So, I hear about plans to make cvs2svn generate something other than
> Subversion, and here's my instant reaction:
>
> 	    	       	   DON'T DO IT!
>
> This is not because I think Subversion is some kind of final answer to the
> VCS problem.  Fame from it -- I'm moving towards Mercurial.  No, the
> real reason I think this would be a waste of time is subtler than that.
>
> Subversion, by design, is very good at capturing the metadata from
> SCCS and RCS and the various CVS variants floating around.  In fact,
> lifting from those into Subversion is basically lossless - the real
> problems are that (a) as Michael notes, the data you're losslessly
> lifting is scratchy, and (b) as I've noted, you have to use heuristics
> to coalesce file histories into changesets and those don't always make
> the links they should.

Converting to Subversion might be lossless, but is it really the
most convenient intermediate format for other people to convert
further from?

Even after xxx2svn overcomes the problems (a) and (b) you noted
above, my impression has been that svn2yyy needs to work harder
than necessary to grok the branches/ and tags/ that artificially
are flattened, only because Subversion does not do branches nor
tags, but just represents them as copies.
