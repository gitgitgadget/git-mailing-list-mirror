From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 15:54:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705251553190.4648@racer.site>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site>
 <200705251559.53846.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0705251514220.4648@racer.site>
 <200705251651.35234.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Lars Hjemli <hjemli@gmail.com>, skimo@liacs.nl,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 16:55:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrbC6-00038h-PZ
	for gcvg-git@gmane.org; Fri, 25 May 2007 16:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759928AbXEYOzB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 10:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757718AbXEYOzB
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 10:55:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:48078 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752626AbXEYOzA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 10:55:00 -0400
Received: (qmail invoked by alias); 25 May 2007 14:54:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 25 May 2007 16:54:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/qw/ctCYHqtx2nbQz8GhSCyAPU7FRSxWxnKCnaWB
	Jh/B+FD/fXEtmO
X-X-Sender: gene099@racer.site
In-Reply-To: <200705251651.35234.Josef.Weidendorfer@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48388>

Hi,

On Fri, 25 May 2007, Josef Weidendorfer wrote:

> On Friday 25 May 2007, Johannes Schindelin wrote:
> > On Fri, 25 May 2007, Josef Weidendorfer wrote:
> >
> > > * Submodules can appear/disappear any time in the superproject. 
> > > Therefore, going back in time can make it necessary to have to clone 
> > > a submodule you did not have before.
> > >
> > > * Not every submodule is interesting for every developer; therefore, 
> > > an important design-decision for submodules is to allow at git-clone 
> > > time to not clone some submodules at all. However, you can change 
> > > your mind and want to follow a given submodule later.
> > 
> > Okay, so there are exceptions to the rule, just as everywhere.
> 
> The question here is in how many superprojects the exception will become 
> the rule, which would make manual overriding quite cumbersome.

I never disputed that manual overriding is cumbersome. However, I dispute 
that automatic overriding is _possible_.

> I agree with Junio that a simply, basic and robust submodule 
> implementation currently is important as first goal.

Good. Me, too.

Ciao,
Dscho
