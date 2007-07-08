From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Sun, 8 Jul 2007 19:17:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707081911160.4248@racer.site>
References: <11839118073186-git-send-email-skimo@liacs.nl>
 <1183911808787-git-send-email-skimo@liacs.nl> <Pine.LNX.4.64.0707081729040.4248@racer.site>
 <20070708173027.GK1528MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jul 08 20:24:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7bR8-000760-Iu
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 20:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbXGHSYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 14:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753414AbXGHSYo
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 14:24:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:38354 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753098AbXGHSYn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 14:24:43 -0400
Received: (qmail invoked by alias); 08 Jul 2007 18:24:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 08 Jul 2007 20:24:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qld8CUQwqmbKf2Ng4tCGgLBwKdyj7Slzq4FfXce
	4PhklUpq49Y8Lh
X-X-Sender: gene099@racer.site
In-Reply-To: <20070708173027.GK1528MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51901>

Hi,

On Sun, 8 Jul 2007, Sven Verdoolaege wrote:

> On Sun, Jul 08, 2007 at 05:37:22PM +0100, Johannes Schindelin wrote:
> > That is to be expected.  After all, the first is a script.  However, I 
> > really have ask: how often per hour do you want to run that program?
> 
> I have a project that needs some cleaning-up and I'd like to do it 
> incrementally.  I think I'll have to run it about a dozen times.

A dozen times seems not that bad, especially since you can run both 
programs on a limited set of commits.  So the cost is not that big.

> > I am really unhappy that so much is talked about filtering out 
> > commits.  That is amost certainly not what you want in most cases.  
> > In particular, I suspect that most users would expect the _changes_ 
> > filtered out by such a command, which is just not true.
> 
> I don't care about that either.  I'm just mentioning it because it's 
> mentioned in the git-filter-branch documentation (which you added).

Which I copied.  And this is not the first, let alone the only example in 
filter-branch's documentation.

> > The second is to rewrite the commit messages so that the hashes are 
> > mapped, too.  But that should be relatively easy, too: you can provide 
> > a message filter, and you can use the provided "map" function.  If 
> > this seems to be what many people need, you can write a simple 
> > function and put it into filter-branch for common use.
> 
> It's not going to be me (as I sais, I don't like shell programming).

Yes, you made that clear.

However, this leaves things only in half-finished states.

- "git filter-branch" did not learn the useful features that you seem to 
  need, and

- your builtin is at most a start of a builtin replacement for 
  filter-branch, which changes the semantics, to be sure.

I have no doubts that it will stay that way for a while, since this 
builtin seems to be good enough for what you want it to do.

Ciao,
Dscho
