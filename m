From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: CVS -> SVN -> Git
Date: Sat, 14 Jul 2007 13:32:23 -0400
Message-ID: <20070714173223.GA25574@pe.Belkin>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk> <469804B4.1040509@alum.mit.edu> <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com> <4699034A.9090603@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, dev <dev@cvs2svn.tigris.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Jul 14 20:01:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9lvm-0008Uj-9i
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 20:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758430AbXGNSBI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 14:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757441AbXGNSBH
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 14:01:07 -0400
Received: from eastrmmtao102.cox.net ([68.230.240.8]:43883 "EHLO
	eastrmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757360AbXGNSBG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 14:01:06 -0400
X-Greylist: delayed 1720 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Jul 2007 14:01:06 EDT
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070714173224.FXMT2069.eastrmmtao102.cox.net@eastrmimpo02.cox.net>;
          Sat, 14 Jul 2007 13:32:24 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo02.cox.net with bizsmtp
	id PVYP1X0030epFYL0000000; Sat, 14 Jul 2007 13:32:23 -0400
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1I9lTj-0006ej-79; Sat, 14 Jul 2007 13:32:23 -0400
Content-Disposition: inline
In-Reply-To: <4699034A.9090603@alum.mit.edu>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52490>

On Sat, Jul 14, 2007 at 07:09:30PM +0200, Michael Haggerty wrote:
> Martin Langhoff wrote:
> > On 7/14/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> >> Incidentally, now that cvs2svn 2.0.0 is nearly out, I am thinking about
> >> what it would take to write some other back ends for cvs2svn--turning
> >> it, essentially, into cvs2xxx.  Most of the work that cvs2svn does is
> >> inferring the most plausible history of the repository from CVS's
> >> sketchy, incomplete, idiomatic, and often corrupt data.  This work
> >> should also be useful for a cvs2git or cvs2hg or cvs2baz or ...
> > 
> > Great to hear that. I'm game if we can do something in this direction
> > - surely we can make it talk to fastimport ;-)
> 
> We added some hooks to cvs2svn 2.0 to start working in this direction.
> But I don't really know what information is needed for a git import.
> One quick-and-dirty idea that I had was to have cvs2svn output
> information compatible with cvsps's output, as I believe that several
> tools rely on cvsps to do the dirty work and so could perhaps be
> persuaded to use cvs2svn out of the box.

Depending on how difficult that is, it might be very useful, even
if it's not the best way to interface with fast-import (which I
suspect it's not).  I, for one, would be interested to know how
cvs2svn's output compared to CVSps's, especially w.r.t. detecting each
branch's parent.

Perhaps one is always more correct than the other, but if not, I bet
that seeing the differences using the same format would help to
improve either one.

-chris
