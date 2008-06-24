From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [NON-TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 20:26:55 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806242026441.9925@racer>
References: <alpine.DEB.1.00.0806241515460.9925@racer> <20080624163810.GA4654@sigill.intra.peff.net> <alpine.DEB.1.00.0806241750030.9925@racer> <alpine.DEB.1.00.0806241808400.9925@racer> <20080624174157.GB9500@sigill.intra.peff.net>
 <alpine.LNX.1.00.0806241516440.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 21:29:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEDD-0001aE-7P
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227AbYFXT26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752934AbYFXT26
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:28:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:46009 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752779AbYFXT25 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:28:57 -0400
Received: (qmail invoked by alias); 24 Jun 2008 19:28:55 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp051) with SMTP; 24 Jun 2008 21:28:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192qeQEgox2YYDvWRK+/xXA/OszJPGlnkQCoqIOmL
	qJannYbHyN+zAv
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LNX.1.00.0806241516440.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86121>

Hi,

On Tue, 24 Jun 2008, Daniel Barkalow wrote:

> On Tue, 24 Jun 2008, Jeff King wrote:
> 
> > On Tue, Jun 24, 2008 at 06:09:28PM +0100, Johannes Schindelin wrote:
> > 
> > > 	And this is my first attempt at a proper patch for it.
> > > 
> > > 	Now with documentation, and hopefully all places where the
> > > 	user is being told about a "bad" commit.
> > 
> > This looks reasonably sane to me. The only thing I can think of that
> > we're missing is that "git bisect visualize" will still show the refs as
> > "bisect/bad" and "bisect/good".
> > 
> > To fix that, you'd have to ask people to start the bisect by saying "I
> > am bisecting to find a fix, not a breakage." And then you could change
> > the refnames and all of the messages as appropriate.
> 
> That would also be a good way of taking care of the problem where someone 
> gets distracted while running a slow test, forgets what they're looking 
> for, and marks the result as "bad" instead of "unfixed".

Feel free to rework my patch.

Ciao,
Dscho
