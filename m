From: esr@thyrsus.com (Eric S. Raymond)
Subject: Re: CVS -> SVN -> Git
Date: Sat, 14 Jul 2007 21:39:49 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20070715013949.GA20850@thyrsus.com>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk> <469804B4.1040509@alum.mit.edu> <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com> <4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com> <46994BDF.6050803@alum.mit.edu>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, dev <dev@cvs2svn.tigris.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 15 03:40:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9t5o-0001LO-FY
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 03:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757797AbXGOBkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 21:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760534AbXGOBkI
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 21:40:08 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:59317
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757797AbXGOBkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 21:40:06 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id F32A03C0663; Sat, 14 Jul 2007 21:39:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46994BDF.6050803@alum.mit.edu>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52520>

Michael Haggerty <mhagger@alum.mit.edu>:
> Could you give a quick summary of the relevant differences between CVS
> and RCS files in this context?  Then I'd be happy to try to figure out
> how bad the situation still is today, and whether it can be easily improved.

I found my copy of the bug report, and I misremembered the problem
slightly.  It turns out to be even more relevant to this 
discussion than I thought.

Thread begins with <20040810031409.GA25564@thyrsus.com> on
9 Aug 2004.  The thread title was "RFC -- enhancing cvs2svn to have a
notion of spans of mergeable commits".  Your mailing-list archive
search can't seem to find it, unfortunately.  I'll repost the query
iseparately

> Other people have complained about having to convert from SVN to
> distributed SCMs, because the SVN model doesn't map so easily to their
> favorite.

OK.  But I think that if SVN -> X is hard, CVS -> X is going to be harder.

> You are basically suggesting that an SVN repository is the best lingua
> franca of the SCM world, which I don't believe.

Not quite.  I'm suggesting it's an appropriate lingua franca for centralized
VCSes with branching, e.g. everything pre-Arch.

>                                               The CVS history *does*
> have to be deformed a bit to fit into SVN, and an svn2xxx converter
> would have to undo the deformation.

Then perhaps the right thing to think about is this: how exactly does
CVS history need to be deformed, and is there some way to express the
lost information as conventional properties or tags?

> My idea is not to built (for example) cvs2git; rather, I'd like cvs2svn
> to be split conceptually into two tools:

Well, that makes more sense.  But how would whatever the first half outputs
be different from an svn dump file? 
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
