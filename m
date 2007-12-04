From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make Git accept absolute path names for files within
 the work tree
Date: Tue, 4 Dec 2007 11:50:57 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712041149440.27959@racer.site>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com>
 <20071204014326.GA21358@coredump.intra.peff.net> <Pine.LNX.4.64.0712040216220.27959@racer.site>
 <200712040742.24728.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 12:51:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzWJc-0007W7-0T
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 12:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbXLDLvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 06:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbXLDLvc
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 06:51:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:54223 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752313AbXLDLvb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 06:51:31 -0500
Received: (qmail invoked by alias); 04 Dec 2007 11:51:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 04 Dec 2007 12:51:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+D3eFrAKqDEStRW3K498Ur03gycIuzqpKZg8eCZq
	68GLMdC5Oma2gX
X-X-Sender: gene099@racer.site
In-Reply-To: <200712040742.24728.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67038>

Hi,

On Tue, 4 Dec 2007, Robin Rosenberg wrote:

> tisdag 04 december 2007 skrev Johannes Schindelin:
> 
> > On Mon, 3 Dec 2007, Jeff King wrote:
> > 
> > > On Mon, Dec 03, 2007 at 09:53:30PM +0100, Robin Rosenberg wrote:
> > > 
> > > > code did not pass). Like Linus, this code does not resolve 
> > > > symlinks, but I forgot to state that it is by design. It solves my 
> > > > problem and
> > > 
> > > By design meaning "I didn't feel like implemening it because I do 
> > > not personally care" or "I have some reason not to resolve 
> > > symlinks"?
> > 
> > IMHO those symlinks would be a nice thing in some corner cases, but 
> > penalise the common case.  So I tend to believe the latter.  (See also 
> > Linus' message why he talks about his preference for the die() code 
> > path.)
> 
> Actually the forme.... I don't mind it being fixed if it doesn't cost 
> too much.

I do remember the hassles I went through with get_relative_cwd() until I 
broke down and used chdir() two times (ugly).  So the latter reason is 
good enough that you do not even have to admit to the former reason ;-)

Ciao,
Dscho
