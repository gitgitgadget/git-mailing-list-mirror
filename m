From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 14:38:41 +0200
Message-ID: <20070524123841.GO4489@pasky.or.cz>
References: <11799589913153-git-send-email-skimo@liacs.nl> <Pine.LNX.4.64.0705240039370.4113@racer.site> <20070524072404.GF942MdfPADPa@greensroom.kotnet.org> <Pine.LNX.4.64.0705241033570.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 24 14:38:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrCag-0003la-CV
	for gcvg-git@gmane.org; Thu, 24 May 2007 14:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbXEXMio (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 08:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754866AbXEXMio
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 08:38:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52244 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754084AbXEXMin (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 08:38:43 -0400
Received: (qmail 13571 invoked by uid 2001); 24 May 2007 14:38:41 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705241033570.4648@racer.site>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48251>

On Thu, May 24, 2007 at 11:35:33AM CEST, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 24 May 2007, Sven Verdoolaege wrote:
> 
> > On Thu, May 24, 2007 at 12:40:20AM +0100, Johannes Schindelin wrote:
> > > On Thu, 24 May 2007, skimo@liacs.nl wrote:
> > > > This patch series implements a mechanism for cloning submodules.
> > > > Each submodule is specified by a 'submodule.<submodule>.url'
> > > > configuration option, e.g.,
> > > > 
> > > > bash-3.00$ ./git-config --remote=http://www.liacs.nl/~sverdool/isa.git --get-regexp 'submodule\..*\.url' 
> > > > submodule.cloog.url /home/sverdool/public_html/cloog.git
> > > > submodule.cloog.url http://www.liacs.nl/~sverdool/cloog.git
> > > 
> > > I am sorry to complain so late in the game, but I am not really interested 
> > > in submodules. However, what you say here is not a task for git-config 
> > > IMHO, but rather for git-remote.
> > 
> > Hmmm... git-remote does only local configuration and never gets
> > any information from the other side.
> > What would be the interface and how would you get the information?
> 
> I was complaining that git-config, which is purely a local beast, gets 
> infected with even more obscure stuff. Junio mentions regularly that he 
> does not trust git-config that much, and given the number of fixes we 
> still get, I have to agree. So let's not put any more stuff into that 
> kitchen sink, especially if it has nothing to do with the configuration of 
> your repo.

Then again, git-remote is purely a local beast too, isn't it?

We could use git-remote-config for accessing remote configuration (if
it's a good idea at all, which I'm not totally convinced about)... (And
hope people don't confuse it with stuff related to git-remote too much.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
