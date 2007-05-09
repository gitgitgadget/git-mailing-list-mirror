From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user
 manual
Date: Wed, 9 May 2007 11:27:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705091120560.4167@racer.site>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site>
 <20070509031803.GA27980@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junio@cox.net, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed May 09 11:27:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HliSB-0004de-Co
	for gcvg-git@gmane.org; Wed, 09 May 2007 11:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348AbXEIJ1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 05:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755370AbXEIJ1R
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 05:27:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:44359 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755123AbXEIJ1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 05:27:16 -0400
Received: (qmail invoked by alias); 09 May 2007 09:27:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 09 May 2007 11:27:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xlbtC+XkxuYa0j3pcRbbizL8SwuQroBK4WRPuGW
	k4MYQKB40yl5xq
X-X-Sender: gene099@racer.site
In-Reply-To: <20070509031803.GA27980@fieldses.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46689>

Hi,

On Tue, 8 May 2007, J. Bruce Fields wrote:

> On Tue, May 08, 2007 at 05:10:47PM +0200, Johannes Schindelin wrote:
> > 
> > +If you grasp the ideas in that initial commit (it is really small and you 
> > +can get into it really fast, and it will help you recognize things in the 
> > +much larger code base we have now), you should go on skimming `cache.h`, 
> > +`object.h` and `commit.h`.
> 
> Might want to add "in a recent commit"?--it's not clear that you've
> transitioned away from talking about the initial commit.

Yes, good idea.

> > +This is just to get you into the groove for the most libified part of Git:
> > +the revision walker.
> 
> Unless the reader has already been hanging out on the mailing list a 
> while, "most libified" may not mean much to them yet at this point.

How about a sentence way before that, when I talk about the initial 
commit, like this:

	In the early days, Git (in the tradition of UNIX) was a bunch of 
	programs which were extremely simple, and which you used in scripts, 
	piping the output of one into another. This turned out to be good 
	for initial development, since it was easier to test new things. 
	However, recently many of these parts have become builtins, and 
	some of the core has been "libified", i.e. put into libgit.a for 
	performance, portability reasons, and to avoid code duplication.

> The organization of the next bit is slightly confusing: we're set up to
> expect a longer lecture on the revision walker, but instead there's just
> the historical note on git-rev-list, a mention of 'revision.c',
> 'revision.h', and 'struct rev_info', and then it rapidly digresses into
> discussing builtins.
> 
> Which actually is fine, but just a few small markers of where we are in
> the discussion might be reassuring--a section header or two, maybe a
> little more emphasis on the pointers you're giving, like: "take a moment
> to go read revision.h and revision.c now, paying special attention to
> struct rev_info, which ....".

Okay. I hope I will be able to make these changes until tomorrow (I will 
be gone for a few days after that).

Ciao,
Dscho
