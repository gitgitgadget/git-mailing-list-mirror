From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Next problem: cg-commit
Date: Tue, 3 May 2005 00:30:31 +0200
Message-ID: <20050502223031.GG20818@pasky.ji.cz>
References: <20050429215118.D30010@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 00:29:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSjN3-0004nB-11
	for gcvg-git@gmane.org; Tue, 03 May 2005 00:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVEBWc0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 18:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVEBWas
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 18:30:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59315 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261188AbVEBWad (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 18:30:33 -0400
Received: (qmail 9025 invoked by uid 2001); 2 May 2005 22:30:31 -0000
To: Russell King <rmk@arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050429215118.D30010@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 29, 2005 at 10:51:18PM CEST, I got a letter
where Russell King <rmk@arm.linux.org.uk> told me that...
> Unfortunately, cg-commit seems to return wrong exit status, returning
> 1 on success.  Eg:
> 
> $ cg-commit
> arch/arm/mach-ixp2000/pci.c
> include/asm-arm/arch-ixp2000/platform.h
> Enter commit message, terminated by ctrl-D on a separate line:
> blah blah blah
> Committed as fafb525292acc9c0818b91b1d8e58cf770616542.
> $ echo $?
> 1
> 
> It appears that [ "$merging" ] towards the end of cg-commit is the
> cause of this odd behaviour.  Force zero exit status, since we
> successfully completed.

Nice find, thanks. I added it to few other files too.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
