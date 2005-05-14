From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 2/2] update cg-* to use cg-Xignore
Date: Sat, 14 May 2005 17:14:28 +0200
Message-ID: <20050514151428.GM3905@pasky.ji.cz>
References: <E1DWihi-0007DQ-SD@ash.dgreaves.com> <20050513225516.GG32232@pasky.ji.cz> <4285B5CA.8060106@dgreaves.com> <20050514121846.GE3905@pasky.ji.cz> <42860EB0.9000105@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 17:14:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWyLi-0003lo-Cp
	for gcvg-git@gmane.org; Sat, 14 May 2005 17:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbVENPOp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 11:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVENPOp
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 11:14:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17050 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262783AbVENPOa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 11:14:30 -0400
Received: (qmail 11624 invoked by uid 2001); 14 May 2005 15:14:28 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <42860EB0.9000105@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 04:44:00PM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> Petr Baudis wrote:
> 
> >Dear diary, on Sat, May 14, 2005 at 10:24:42AM CEST, I got a letter
> >where David Greaves <david@dgreaves.com> told me that...
> >  
> >
> >>Petr Baudis wrote:
> >>    
> >>
> >Makes sense, ok.
> >
> >What about cg-commit? You already even added it.
> >  
> >
> 
> I'd use the same argument - you want to commit files changed in a directory:
> find src | xargs cg-commit
> find Documentation | xargs cg-commit
> I agree it's less compelling.
> I admit I was primarily just making sure that all cg-* commands behaved
> the same way.

Thinking about it, I think we can actually live with it. I agree that
it's more consistent.

> I also don't have an ignore-override - do you think we need one?

I'd prefer CVS-like format. That is, lines starting with ! are
exceptions to previous ignore rules.

> >>No, cogito has an ignore.
> >>git has a less powerful exclude.
> >>cogito users won't need exclude but power-users aren't barred from it.
> >>    
> >>
> >
> >I think having two essentially redundant things is useless. But you'll
> >be able to use the --exclude powers now since you have to fall back to
> >good ol' globs.
> >  
> >
> unless...

See my other mail that I'd prefer globs as the main ignoring mechanism
anyway. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
