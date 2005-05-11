From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Stop git-rev-list at sha1 match
Date: Thu, 12 May 2005 01:44:55 +0200
Message-ID: <20050511234455.GL22686@pasky.ji.cz>
References: <1115839456.22180.79.camel@tglx> <7vy8alr0mz.fsf@assigned-by-dhcp.cox.net> <1115843429.22180.90.camel@tglx> <7vis1pqvi4.fsf@assigned-by-dhcp.cox.net> <20050511221719.GH22686@pasky.ji.cz> <1115851742.22180.154.camel@tglx> <20050511225058.GK22686@pasky.ji.cz> <1115852914.22180.170.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 01:37:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW0ln-0002J1-CJ
	for gcvg-git@gmane.org; Thu, 12 May 2005 01:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVEKXpK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 19:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVEKXpK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 19:45:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35012 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261328AbVEKXo6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2005 19:44:58 -0400
Received: (qmail 15629 invoked by uid 2001); 11 May 2005 23:44:55 -0000
To: Thomas Gleixner <tglx@linutronix.de>
Content-Disposition: inline
In-Reply-To: <1115852914.22180.170.camel@tglx>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 12, 2005 at 01:08:34AM CEST, I got a letter
where Thomas Gleixner <tglx@linutronix.de> told me that...
> On Thu, 2005-05-12 at 00:50 +0200, Petr Baudis wrote:
> > > Rn
> > > ---- Stop = Rn-1
> > > Rn-1
> > > ---- Stop = Rn-2
> > 
> > Mn
> > Mn-1
> > 
> > > Rn-2
> > > ---- Stop = Rn-3
> > > 
> > > The diff between Rn and Rn-1 contains always the changes merged from M
> > 
> > Yes, but you get the merge commits again since rev-list follows all the
> > parents.
> 
> That's plain wrong. The Mn(1) change hit repository r between revision
> Rn and Rn-1 and nowhere else. 
> 
> Date is irrelevant. The only relevant thing is the parent child(s)
> relationship.

What I described is just how rev-list works (now), nothing more. This is
what you get when you use rev-list.

Please see the thread of

5730     Apr 27 H. Peter Anvin  ( 0.2K) kernel.org now has gitweb installed

for extensive discussion on how (it is impossible or very hard) to do
better.

So how would you order the list of commits?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
