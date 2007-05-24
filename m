From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 14:13:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705241412230.4648@racer.site>
References: <11799589913153-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0705240039370.4113@racer.site> <20070524072404.GF942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241033570.4648@racer.site> <20070524123841.GO4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: skimo@liacs.nl, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 24 15:13:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrD8Y-0003Ul-M3
	for gcvg-git@gmane.org; Thu, 24 May 2007 15:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756718AbXEXNNm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 09:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755721AbXEXNNm
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 09:13:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:44116 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755994AbXEXNNm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 09:13:42 -0400
Received: (qmail invoked by alias); 24 May 2007 13:13:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 24 May 2007 15:13:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bRgsEM5BbSjK7iIY0qxPj5eXs6Nzs7bZT2qZMrj
	hy1dywG0tkqdH6
X-X-Sender: gene099@racer.site
In-Reply-To: <20070524123841.GO4489@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48256>

Hi,

On Thu, 24 May 2007, Petr Baudis wrote:

> On Thu, May 24, 2007 at 11:35:33AM CEST, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Thu, 24 May 2007, Sven Verdoolaege wrote:
> > 
> > > On Thu, May 24, 2007 at 12:40:20AM +0100, Johannes Schindelin wrote:
> > > > On Thu, 24 May 2007, skimo@liacs.nl wrote:
> > > > > This patch series implements a mechanism for cloning submodules.
> > > > > Each submodule is specified by a 'submodule.<submodule>.url'
> > > > > configuration option, e.g.,
> > > > > 
> > > > > bash-3.00$ ./git-config --remote=http://www.liacs.nl/~sverdool/isa.git --get-regexp 'submodule\..*\.url' 
> > > > > submodule.cloog.url /home/sverdool/public_html/cloog.git
> > > > > submodule.cloog.url http://www.liacs.nl/~sverdool/cloog.git
> > > > 
> > > > I am sorry to complain so late in the game, but I am not really interested 
> > > > in submodules. However, what you say here is not a task for git-config 
> > > > IMHO, but rather for git-remote.
> > > 
> > > Hmmm... git-remote does only local configuration and never gets
> > > any information from the other side.
> > > What would be the interface and how would you get the information?
> > 
> > I was complaining that git-config, which is purely a local beast, gets 
> > infected with even more obscure stuff. Junio mentions regularly that he 
> > does not trust git-config that much, and given the number of fixes we 
> > still get, I have to agree. So let's not put any more stuff into that 
> > kitchen sink, especially if it has nothing to do with the configuration of 
> > your repo.
> 
> Then again, git-remote is purely a local beast too, isn't it?

No. Think "update" and "prune". Both access the remote site.

> We could use git-remote-config for accessing remote configuration (if 
> it's a good idea at all, which I'm not totally convinced about)... (And 
> hope people don't confuse it with stuff related to git-remote too much.)

As Junio _already_ said, people have no business looking in other people's 
configuration.

If you have something to publish, do so. But don't make the tool publish 
_everything_ by default.

Ciao,
Dscho
