From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [NON-TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 15:22:02 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806241516440.19665@iabervon.org>
References: <alpine.DEB.1.00.0806241515460.9925@racer> <20080624163810.GA4654@sigill.intra.peff.net> <alpine.DEB.1.00.0806241750030.9925@racer> <alpine.DEB.1.00.0806241808400.9925@racer> <20080624174157.GB9500@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 24 21:23:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBE6Y-0007j7-R6
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbYFXTWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752761AbYFXTWG
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:22:06 -0400
Received: from iabervon.org ([66.92.72.58]:35469 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975AbYFXTWF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:22:05 -0400
Received: (qmail 5358 invoked by uid 1000); 24 Jun 2008 19:22:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Jun 2008 19:22:02 -0000
In-Reply-To: <20080624174157.GB9500@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86117>

On Tue, 24 Jun 2008, Jeff King wrote:

> On Tue, Jun 24, 2008 at 06:09:28PM +0100, Johannes Schindelin wrote:
> 
> > 	And this is my first attempt at a proper patch for it.
> > 
> > 	Now with documentation, and hopefully all places where the
> > 	user is being told about a "bad" commit.
> 
> This looks reasonably sane to me. The only thing I can think of that
> we're missing is that "git bisect visualize" will still show the refs as
> "bisect/bad" and "bisect/good".
> 
> To fix that, you'd have to ask people to start the bisect by saying "I
> am bisecting to find a fix, not a breakage." And then you could change
> the refnames and all of the messages as appropriate.

That would also be a good way of taking care of the problem where someone 
gets distracted while running a slow test, forgets what they're looking 
for, and marks the result as "bad" instead of "unfixed".

	-Daniel
*This .sig left intentionally blank*
