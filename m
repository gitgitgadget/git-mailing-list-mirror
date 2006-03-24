From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 19:39:44 -0500
Message-ID: <20060324003944.GA28652@pe.Belkin>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org> <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org> <Pine.LNX.4.64.0603221717120.26286@g5.osdl.org> <20060323200306.GG31387@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 01:39:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMaLI-0006Cl-1w
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 01:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWCXAjq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 19:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWCXAjq
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 19:39:46 -0500
Received: from eastrmmtao03.cox.net ([68.230.240.36]:5563 "EHLO
	eastrmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751493AbWCXAjp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 19:39:45 -0500
Received: from localhost ([24.250.31.7]) by eastrmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060324003936.PWTJ29285.eastrmmtao03.cox.net@localhost>;
          Thu, 23 Mar 2006 19:39:36 -0500
Received: from chris by localhost with local (Exim 4.43)
	id 1FMaLA-0007SY-75; Thu, 23 Mar 2006 19:39:44 -0500
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Content-Disposition: inline
In-Reply-To: <20060323200306.GG31387@lug-owl.de>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17891>

On Thu, Mar 23, 2006 at 09:03:06PM +0100, Jan-Benedict Glaw wrote:
> On Wed, 2006-03-22 17:28:23 -0800, Linus Torvalds <torvalds@osdl.org> wrote:
> > On Wed, 22 Mar 2006, Linus Torvalds wrote:
> > > This one-liner to cvsps.c seems to make sure we have an ancestor branch 
> > > for that "gdb-4.18-branch" branch, at least according to the cvsps output. 
> > 
> > The "git cvsimport" is still running, but at least it seems to be happily 
> > running further past the point it broke earlier.
> 
> I've started it once again, too, with the one-liner added to Debian
> unstable's version of cvsps:
> 
> It seems there's a patch like
> http://www.gelato.unsw.edu.au/archives/git/0602/16278.html is missing?
> ...or we need a better cvsps.  Shall I add it and try again / try to
> continue, or give up on it for now?  Though it would be nice to have
> these two large and important source trees under GIT control :-)

You make want to try the cvsps patch I attached to the email here:

http://www.gelato.unsw.edu.au/archives/git/0511/11812.html

Good luck!

-chris
