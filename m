From: Petr Baudis <pasky@ucw.cz>
Subject: Re: More git pull problems
Date: Tue, 19 Apr 2005 10:23:41 +0200
Message-ID: <20050419082341.GC2393@pasky.ji.cz>
References: <E1DNlmx-00029W-L2@flint.arm.linux.org.uk> <20050419080251.A11988@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 10:20:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNnxW-0007xn-F8
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 10:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVDSIXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 04:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVDSIXv
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 04:23:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52921 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261407AbVDSIXp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 04:23:45 -0400
Received: (qmail 4072 invoked by uid 2001); 19 Apr 2005 08:23:41 -0000
To: Russell King <rmk@arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050419080251.A11988@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 09:02:51AM CEST, I got a letter
where Russell King <rmk@arm.linux.org.uk> told me that...
> My automatic pull this morning produced the following messages, which
> seem to indicate that something's up with git pull now.
> 
> git-pasky-0.4 (7bef49b5d53218ed3fa8bac291b5515c6479810c)
> 
> > New branch: 945a2562ee9e632bc6b3399fd49e028c39d19023
> > Tracked branch, applying changes...
> > Fast-forwarding 945a2562ee9e632bc6b3399fd49e028c39d19023 -> 945a2562ee9e632bc6b3399fd49e028c39d19023
> > 	on top of 945a2562ee9e632bc6b3399fd49e028c39d19023...
> > gitdiff.sh: trying to diff 67607f05a66e36b2f038c77cfb61350d2110f7e8 against itself

This means nothing more than you pulled your tracked branch for the
first time, but before you already had the latest copy; this wouldn't
have happened with subsequent pulls, and it was fixed some time ago - it
would be really nice if you could try the new pull and merge.

It is harmless anyway. It got confused and tried to do "zero-length fast
forward", which git diff complained about, but it couldn't do any harm
(I hope).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
