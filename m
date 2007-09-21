From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git as a filesystem
Date: Sat, 22 Sep 2007 00:42:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709220040450.28395@racer.site>
References: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com>
 <Pine.LNX.4.64.0709211208440.28395@racer.site>
 <fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com>
 <alpine.LFD.0.9999.0709210912120.32185@xanadu.home> <20070921233343.GA8327@muzzle>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Peter Stahlir <peter.stahlir@googlemail.com>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Sep 22 01:43:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYs9S-0006ef-8D
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 01:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755792AbXIUXnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 19:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753957AbXIUXnH
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 19:43:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:38819 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755792AbXIUXnG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 19:43:06 -0400
Received: (qmail invoked by alias); 21 Sep 2007 23:43:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 22 Sep 2007 01:43:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+X+NULh5CXwF8MmwtupnrmR3RrlKkTV5gt/bn6jx
	ZBh2vIgCmLKH1u
X-X-Sender: gene099@racer.site
In-Reply-To: <20070921233343.GA8327@muzzle>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58893>

Hi,

On Fri, 21 Sep 2007, Eric Wong wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > On Fri, 21 Sep 2007, Peter Stahlir wrote:
> > 
> > > This is was I was looking for. My motivation is whether it is possible
> > > to run a system, for example Debian on a computer on top of gitfs,
> > > and then have a huge mirror on it, for example a complete 252GB
> > > Debian mirror as space efficient as possible.
> > > 
> > > I wonder how big a deltified Debian mirror in one pack file would be. :)
> > 
> > It would be just as big as the non gitified storage on disk.
> > 
> > The space saving with git comes from efficient delta storage of 
> > _versioned_ files, i.e. multiple nearly identical versions of the same 
> > file where the stored delta is only the small difference between the 
> > first full version and subsequent versions.  Unless you plan on storing 
> > many different Debian versions together, you won't benefit from any 
> > delta at all. And since Debian packages are already compressed, git 
> > won't be able to compress them further.
> > 
> > So don't waste your time.
> 
> On a similar note, has anybody experimented with using git to
> store maildirs or news spools?  I'd imagine the quoted portions of
> most message threads could be delta-compressed quite efficiently.

I store all my mail in a git repository.  Works beautifully.  Except that 
the buffers on my laptop are constantly full :-(  So a simple commit takes 
some waiting.

Should be no issue on normal (desktop) machines.

Ciao,
Dscho
