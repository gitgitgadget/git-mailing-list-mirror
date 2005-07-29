From: Petr Baudis <pasky@suse.cz>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Fri, 29 Jul 2005 13:13:04 +0200
Message-ID: <20050729111304.GS24895@pasky.ji.cz>
References: <20050728161815.GC17952@pasky.ji.cz> <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net> <20050728183904.GA24948@pasky.ji.cz> <7v4qaeqrh3.fsf@assigned-by-dhcp.cox.net> <20050729070628.GA24895@pasky.ji.cz> <7vmzo6jbme.fsf@assigned-by-dhcp.cox.net> <20050729081051.GH24895@pasky.ji.cz> <7vek9igfgw.fsf@assigned-by-dhcp.cox.net> <20050729094046.GO24895@pasky.ji.cz> <Pine.LNX.4.58.0507291254100.5849@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 13:14:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DySoi-0002e3-8y
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 13:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVG2LNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 07:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbVG2LNp
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 07:13:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36622 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262463AbVG2LNG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 07:13:06 -0400
Received: (qmail 18326 invoked by uid 2001); 29 Jul 2005 11:13:04 -0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507291254100.5849@wgmdd8.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 29, 2005 at 12:57:50PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> told me that...
> Hi,

Hello,

> On Fri, 29 Jul 2005, Petr Baudis wrote:
> 
> > You might get the push access rather lately in the process (this "lazy
> > development privileges granting" is one of the point of distributed
> > VCSes), at point where other people are used to pull from you and
> > renaming your branch locally might mean some trouble.
> 
> I still do not get it. What is so wrong with
> 
> 	git-switch-tree remotehead
> 	git-merge master
> 	git-push remoteside remotehead
> 
> which would have the further advantage of documenting what you really did
> in the history.

How would that document anything normal push wouldn't?

> And if you really want to be able to spread chaos in your own head, you
> can do something like
> 
> 	ln -s master .git/refs/heads/remotehead
> 	git-push remoteside remotehead

I'd argue that's much more messy and evil than pushing to heads with
different names. If you compare what you just proposed with pushing to
heads with different names, what's the advantage?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
