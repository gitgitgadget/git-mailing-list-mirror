From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 0/2] apply.c: a fix and an enhancement
Date: Sat, 23 Jul 2005 01:39:03 +0200
Message-ID: <20050722233903.GQ11916@pasky.ji.cz>
References: <7vzmsewzik.fsf@assigned-by-dhcp.cox.net> <20050722181800.GU20369@mythryan2.michonline.com> <7vsly6vd2b.fsf@assigned-by-dhcp.cox.net> <42E1571B.8070108@gmail.com> <Pine.LNX.4.58.0507221340450.6074@g5.osdl.org> <7vhdempmgg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507221447420.6074@g5.osdl.org> <7vfyu6jvrm.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507221619450.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 01:39:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw76p-0004Rb-7Z
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 01:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVGVXjI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 19:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVGVXjI
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 19:39:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12042 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261445AbVGVXjG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 19:39:06 -0400
Received: (qmail 23074 invoked by uid 2001); 22 Jul 2005 23:39:03 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507221619450.6074@g5.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jul 23, 2005 at 01:26:07AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Fri, 22 Jul 2005, Junio C Hamano wrote:
> > Linus Torvalds <torvalds@osdl.org> writes:
> > 
> > > I'd _really_ prefer to not have any preferences or other metadata files
> > > under version control within that same project.
> > 
> > Don't you think that would be a per-project decision?  Is it
> > acceptable if I make sure that .gitinfo/* is _optional_ and
> > things do not break for projects that do not use it?
> 
> It can't be a per-project decision, since the preferences are 
> per-developer.
> 
> In other words, if it's per-project, then that implies that every single 
> developer has to agree on the same thing. Which just not possible - it 
> makes no sense.

Some example of possible per-project settings:

	pre-commit hook killing trailing whitespaces
	global per-project ignore file (*.ko or something)
	common base commit template
		(standardized form developer fills in when committing,
		 some remindments in the comment section, ...)

Obviously, you still ought to have a way to locally override any of
those per-repository in your .git/conf/.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
