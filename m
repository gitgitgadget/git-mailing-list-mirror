From: Petr Baudis <pasky@suse.cz>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Fri, 29 Jul 2005 09:06:29 +0200
Message-ID: <20050729070628.GA24895@pasky.ji.cz>
References: <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <200507271458.43063.Josef.Weidendorfer@gmx.de> <20050728120806.GA2391@pasky.ji.cz> <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728153506.GL14229@pasky.ji.cz> <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728161815.GC17952@pasky.ji.cz> <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net> <20050728183904.GA24948@pasky.ji.cz> <7v4qaeqrh3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 09:07:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyOxi-00024d-NO
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 09:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVG2HGy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 03:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVG2HGy
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 03:06:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13579 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262469AbVG2HGl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 03:06:41 -0400
Received: (qmail 25834 invoked by uid 2001); 29 Jul 2005 07:06:30 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4qaeqrh3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 29, 2005 at 04:24:40AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > One of the Cogito design bits is that branch name is something local to
> > the repository. When you are adding a branch, the local name you assign
> > it is your private thing repository-wise, and doesn't have to have any
> > correlation to other repositories you might interact width.
> 
> I do not disagree with that.  I think branch name is mostly a
> local matter.  However, I happen to think that two repositories
> you use send-pack (not clone which uses completely different
> protocol) to sync one from the other are semantically equivalent
> ones, except that the destination may be a strict subset.  I
> think of it as "a copy I throw at a public place to show what I
> have in my private repository I work in", so,...

Aha, so it seems our problem is hopefully only in terminology, great.

So, what do you mean by "clone" here? And what command should I use for
pushing then?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
