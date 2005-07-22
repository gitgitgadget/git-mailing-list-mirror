From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 0/2] apply.c: a fix and an enhancement
Date: Sat, 23 Jul 2005 01:59:44 +0200
Message-ID: <20050722235944.GS11916@pasky.ji.cz>
References: <7vzmsewzik.fsf@assigned-by-dhcp.cox.net> <20050722181800.GU20369@mythryan2.michonline.com> <7vsly6vd2b.fsf@assigned-by-dhcp.cox.net> <42E1571B.8070108@gmail.com> <Pine.LNX.4.58.0507221340450.6074@g5.osdl.org> <7vhdempmgg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507221447420.6074@g5.osdl.org> <20050722233344.GP11916@pasky.ji.cz> <Pine.LNX.4.58.0507221640050.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 01:59:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw7Qk-00069p-UV
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 01:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVGVX7p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 19:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVGVX7p
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 19:59:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33034 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262243AbVGVX7o (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 19:59:44 -0400
Received: (qmail 25839 invoked by uid 2001); 22 Jul 2005 23:59:44 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507221640050.6074@g5.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jul 23, 2005 at 01:50:09AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Sat, 23 Jul 2005, Petr Baudis wrote:
> > 
> > Yes, but this stuff is not for personal preferences. It is for
> > project-wide preferences and policies, which can be still normally
> > overridden or altered locally in each repository.
> 
> What you are describing is a nightmare.
> 
> Let's assume that a user alters the settings locally.
> 
> EVERY SINGLE TIME he does a "cg-commit", those local alterations would get 
> committed, since that config file is part of the same project, and cogito 
> by default commits all changes.

No, no, no. A user does not alter the settings locally in .gitinfo/ -
.gitinfo/ is for per-_project_ stuff, not per-user. If user wants an
override, he does it per-repository in his .git/conf directory, which is
not version-tracked (actually, core GIT does not even let me to).

> That's just insane. It means that in practive it's simply not reasonable 
> to have your own local copies of that file. So what would you do? You'd 
> add more and more hacks to cover this up, and have a "commit-ignore" file 
> that ignores the .gitinfo files etc etc. UGLY. All because of a design 
> mistake.

Actually, commit-ignore might be useful in other cases, e.g. when
someone (me, a thousand times in the past) needs to keep temporary hacks
in the Makefile so that he can actually build the thing on his weird
system etc. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
