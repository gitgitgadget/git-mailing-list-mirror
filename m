From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Does anyone have any benchmarks against CVS?
Date: Mon, 11 Jun 2007 10:47:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706111042110.4059@racer.site>
References: <20070611090451.26209.qmail@science.horizon.com>
 <86odjmg7ty.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 11:51:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxgY8-0002bj-33
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 11:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422AbXFKJuu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 05:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756542AbXFKJuu
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 05:50:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:59810 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756422AbXFKJut (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 05:50:49 -0400
Received: (qmail invoked by alias); 11 Jun 2007 09:50:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 11 Jun 2007 11:50:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+QiFxLgpyQPGWWC3+0BFqhVGrSHN6YKuOJFH6xcC
	YsKxeR9qGkJw9V
X-X-Sender: gene099@racer.site
In-Reply-To: <86odjmg7ty.fsf@lola.quinscape.zz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49839>

Hi,

On Mon, 11 Jun 2007, David Kastrup wrote:

> linux@horizon.com writes:
> 
> > It seems to be common knowledge that git is a heck of a lot faster than
> > CVS at most operations, but I'd like to do a little evangelizing and
> > I can't seem to find a benchmark to support that claim.
> >
> > Am I just blind?
> >
> > I could find a code base and measure myself, but perhaps someone who's
> > been hacking on CVS converters already has a reasonable code base
> > in both forms that could be used for testing?
> 
> CVS and git do completely different things (which is one of the main
> points of git).  git tends to do its own things pretty fast, CVS tends
> to its things more leasurely and with higher network impact.
> Benchmarking is not really useful since both systems do different
> things.

I disagree. For quite some time (pre 2005), I used CVS to track some 
directories, where the "server" was a directory on the same machine.

This is exactly the same workflow as I do now with Git. So I will try to 
come up with a sensible test this afternoon (If I can get at a copy 
of QEmu's cvsroot, I'll try that) where I compare CVS and Git, both of 
which have the repository already set up.

Okay, it is not completely fair, since Git _will_ blow CVS away, but 
linux-at-horizon asked for it.

Sidenote: It was always a hassle to set up the initial version with CVS. 
Funnily enough, the "CVS done right" SCM has the _same_ issue.

I even presented Git to an svn user last week (not his fault, really, he 
was more than willing to try Git), and he was surprised that you could 
_continue_ working in the _same_ working directory as before, after 
git-init...

Ciao,
Dscho
