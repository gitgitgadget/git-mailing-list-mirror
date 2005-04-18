From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re-done kernel archive - real one?
Date: Tue, 19 Apr 2005 01:09:42 +0200
Message-ID: <20050418230941.GN5554@pasky.ji.cz>
References: <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org> <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org> <20050418102332.A21081@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504180802060.7211@ppc970.osdl.org> <20050418225356.B16789@flint.arm.linux.org.uk> <20050418224852.GM5554@pasky.ji.cz> <20050418235951.D16789@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 01:06:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNfJT-00059M-85
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 01:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVDRXJ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 19:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVDRXJ4
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 19:09:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48304 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261169AbVDRXJy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 19:09:54 -0400
Received: (qmail 18723 invoked by uid 2001); 18 Apr 2005 23:09:42 -0000
To: Russell King <rmk@arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050418235951.D16789@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 12:59:52AM CEST, I got a letter
where Russell King <rmk@arm.linux.org.uk> told me that...
> In the case I highlighted, we don't want to end up having to require
> user intervention.  This is a common case here, and was one which was
> entirely scripted with BK.

Well, you can script that

	cd ,,merge && echo 'Merge with Linus' | git ci && cd ..

too. ;-)

But it seems like a good idea to just proceed with commit in case of no
conflicts (and possibly have a switch which will tell git merge to just
merge, not commit).

> Essentially, with BK, at 7am localtime each morning, I'd:
> 
> - update my baseline linux 2.6 tree
> - for each working tree which may be pulled from
>   - if the baseline is a superset
>     - update working tree from baseline
> 
> The net result is that my workflow consisted entirely of:
> 
> 1. commit whatever into working tree
> 2. test
> 3. send linus a pull request
> 4. repeat next day
> 
> The tree resynchronisation happened completely and entirely in the
> background with no user intervention required at all.

And in the case of conflicts...?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
