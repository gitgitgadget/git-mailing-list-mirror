From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Thu, 28 Jul 2005 21:47:49 +0200
Message-ID: <20050728194748.GD24948@pasky.ji.cz>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca> <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com> <20050722192424.GB8556@mars.ravnborg.org> <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net> <1122068634.7042.35.camel@localhost.localdomain> <7vu0imh23q.fsf@assigned-by-dhcp.cox.net> <1122108098.6863.38.camel@localhost.localdomain> <20050723093035.GB11814@pasky.ji.cz> <1122114452.6863.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Bryan larsen <bryanlarsen@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Thu Jul 28 21:49:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyENC-0006x7-RS
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 21:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVG1TsT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 15:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVG1TsP
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 15:48:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1043 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261550AbVG1Tr6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 15:47:58 -0400
Received: (qmail 1485 invoked by uid 2001); 28 Jul 2005 19:47:49 -0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <1122114452.6863.72.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jul 23, 2005 at 12:27:31PM CEST, I got a letter
where Catalin Marinas <catalin.marinas@gmail.com> told me that...
> > Agreed. What Cogito uses:
> > 
> > 	.git/author	Default author information in format
> > 				Person Name <email@addy>
> 
> What about .git/committer? This is useful if I do a commit at work and I
> want the repository to have my gmail address.

The committer field generally identifies the committer "physically", and
isn't usually overriden. You'll find <xpasky@machine.sinus.cz> in my
committer field, e.g.

> > 	.git/branch-name
> > 			Symbolic name of the branch of this repository.
> 
> Isn't this the same as $(readlink .git/HEAD), with some trimming?

No, that is something totally separate from the usual concepts of
branches and repositories, designed to make it possible to distinguish
between repositories etc. from the outside of the system.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
