From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can you do this with GIT?
Date: Fri, 27 Jul 2007 20:05:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707272002250.14781@racer.site>
References: <11834063.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: CPD <cdavidson@altsoftware.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 21:06:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEV8T-0001Wb-8L
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 21:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760956AbXG0TF6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 15:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757418AbXG0TF6
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 15:05:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:42673 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760088AbXG0TF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 15:05:57 -0400
Received: (qmail invoked by alias); 27 Jul 2007 19:05:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 27 Jul 2007 21:05:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18x2SVFTtMxadHWGTJRK4ORqvgWZi3kEDLqvksTDA
	X9Y0CxVXgnbChG
X-X-Sender: gene099@racer.site
In-Reply-To: <11834063.post@talk.nabble.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53948>

Hi,

On Fri, 27 Jul 2007, CPD wrote:

> I hope this is the right forum, it's all I could find. Sincere apologies 
> in advance if I in the wrong place.

You might be interested in http://git.or.cz: there is a lot of useful 
information to find; amongst others what is the right forum...

So yes, this is the right forum.

> I set up a source control system for the company around CVS, but GIT has
> some very attractive features and I'd like to migrate if it can do some
> other things that we need.
> 
> We produce variations based on a (mostly) common codebase. In CVS I set 
> up "environment" modules for each platform, then when you are working on 
> that platform, you simply check out the correct environment and build. 
> Only the needed code and tools are exposed in that environment (this is 
> important as clients must NOT see each other's code and most customers 
> have some customization). I do this by defining and renaming modules in 
> the CVSROOT modules file.

I would use branches for that.  A base branch with the common code, and 
the customisations in all the branches, which merge from the base branch.

If you have an interesting change in a custom branch, you can percolate 
that back into the base branch, by checking out that base branch and 
cherry-picking the commit you want to have.

Of course, you can automate this merging (or even rebasing, if you are 
interested in keeping your customisations nice and tidy) with a script.  
With a git alias even.

Hth,
Dscho
