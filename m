From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 0/2] apply.c: a fix and an enhancement
Date: Sat, 23 Jul 2005 01:33:44 +0200
Message-ID: <20050722233344.GP11916@pasky.ji.cz>
References: <7vzmsewzik.fsf@assigned-by-dhcp.cox.net> <20050722181800.GU20369@mythryan2.michonline.com> <7vsly6vd2b.fsf@assigned-by-dhcp.cox.net> <42E1571B.8070108@gmail.com> <Pine.LNX.4.58.0507221340450.6074@g5.osdl.org> <7vhdempmgg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507221447420.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 01:34:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw71v-0003zb-FO
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 01:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVGVXdt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 19:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVGVXdt
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 19:33:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:7690 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262219AbVGVXdp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 19:33:45 -0400
Received: (qmail 22641 invoked by uid 2001); 22 Jul 2005 23:33:44 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507221447420.6074@g5.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 22, 2005 at 11:53:41PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Fri, 22 Jul 2005, Junio C Hamano wrote:
> > 
> > And the file would obviously be per-project, so according to
> > Pasky's suggestion that would be ".gitinfo/fake_parents" ;-).
> 
> I'd _really_ prefer to not have any preferences or other metadata files
> under version control within that same project.
> 
> If you want to version control them, that's fine, but don't tie the
> versioning to the main project itself. You can have a _separate_ git
> index, and a separate branch for the preferences and other metadata (but
> you can, if you want to, obviously share the .git directory contents and
> mix up the objects).

I think that is a bad idea. Suddenly, you do not have the two things in
the same timeline, which may be quite confusing especially in case of
some hooks which depend on the contents of the tree of the project
itself, in case of commit templates and such.

> And personal preferences are just that - personal. I do _not_ want to have 
> the kernel project history have things like "editor preferences" etc in 
> the revision history - you might want to revision them, but that would be 
> totally independent of the history of the project itself.

Yes, but this stuff is not for personal preferences. It is for
project-wide preferences and policies, which can be still normally
overridden or altered locally in each repository.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
