From: Petr Baudis <pasky@suse.cz>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Fri, 29 Jul 2005 14:28:44 +0200
Message-ID: <20050729122844.GA21909@pasky.ji.cz>
References: <20050728183904.GA24948@pasky.ji.cz> <7v4qaeqrh3.fsf@assigned-by-dhcp.cox.net> <20050729070628.GA24895@pasky.ji.cz> <7vmzo6jbme.fsf@assigned-by-dhcp.cox.net> <20050729081051.GH24895@pasky.ji.cz> <7vek9igfgw.fsf@assigned-by-dhcp.cox.net> <20050729094046.GO24895@pasky.ji.cz> <Pine.LNX.4.58.0507291254100.5849@wgmdd8.biozentrum.uni-wuerzburg.de> <20050729111304.GS24895@pasky.ji.cz> <Pine.LNX.4.58.0507291424070.6247@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 14:29:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyTzX-0002dr-AP
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 14:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVG2M3F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 08:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVG2M3F
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 08:29:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33295 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262585AbVG2M2q (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 08:28:46 -0400
Received: (qmail 23031 invoked by uid 2001); 29 Jul 2005 12:28:44 -0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507291424070.6247@wgmdd8.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 29, 2005 at 02:26:51PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> told me that...
> Hi,
> 
> On Fri, 29 Jul 2005, Petr Baudis wrote:
> 
> > Dear diary, on Fri, Jul 29, 2005 at 12:57:50PM CEST, I got a letter
> > where Johannes Schindelin <Johannes.Schindelin@gmx.de> told me that...
> >
> > > 	git-switch-tree remotehead
> > > 	git-merge master
> > > 	git-push remoteside remotehead
> > >
> > > which would have the further advantage of documenting what you really did
> > > in the history.
> >
> > How would that document anything normal push wouldn't?
> 
> git-merge?

You have to git-merge anyway if remote head is not your ancestor yet,
otherwise the push cannot proceed.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
