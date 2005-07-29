From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Fri, 29 Jul 2005 13:10:56 +0200
Message-ID: <20050729111056.GR24895@pasky.ji.cz>
References: <tnx1x5ryvn2.fsf@arm.com> <20050722192424.GB8556@mars.ravnborg.org> <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net> <1122068634.7042.35.camel@localhost.localdomain> <7vu0imh23q.fsf@assigned-by-dhcp.cox.net> <1122108098.6863.38.camel@localhost.localdomain> <20050723093035.GB11814@pasky.ji.cz> <1122114452.6863.72.camel@localhost.localdomain> <20050728194748.GD24948@pasky.ji.cz> <tnxfytyey1j.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Bryan larsen <bryanlarsen@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Fri Jul 29 13:12:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DySmU-0002P9-6m
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 13:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbVG2LLV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 07:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVG2LLQ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 07:11:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33806 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262453AbVG2LLI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 07:11:08 -0400
Received: (qmail 18007 invoked by uid 2001); 29 Jul 2005 11:10:56 -0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <tnxfytyey1j.fsf@arm.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 29, 2005 at 11:55:52AM CEST, I got a letter
where Catalin Marinas <catalin.marinas@gmail.com> told me that...
> Petr Baudis <pasky@suse.cz> wrote:
> > The committer field generally identifies the committer "physically", and
> > isn't usually overriden. You'll find <xpasky@machine.sinus.cz> in my
> > committer field, e.g.
> 
> I thought GIT_COMMITTER_{NAME,EMAIL} were added to be able to override
> the defaults like username@localmachine.

Yes, but IIRC only for rather special cases like recommitting older
commits, importing from other VCSes, etc.

> The latest StGIT snapshot uses, by default, the committer's details
> for the From: line when sending patches by e-mail, assuming that this
> is a valid e-mail address. One can define his own e-mail template and
> use a different From: line but I thought it would be simpler to
> provide some defaults based on this.

Why don't you rather use the GIT_AUTHOR_* variables?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
