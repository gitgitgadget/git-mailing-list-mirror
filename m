From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Add exclude file support to cg-status
Date: Mon, 9 May 2005 01:42:27 +0200
Message-ID: <20050508234227.GQ9495@pasky.ji.cz>
References: <20050502171042.A24299@cox.net> <20050508015016.GL9495@pasky.ji.cz> <7vfywx2t77.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Porter <mporter@kernel.crashing.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 01:35:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUvJ1-0001pr-7c
	for gcvg-git@gmane.org; Mon, 09 May 2005 01:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbVEHXmf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 19:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbVEHXmc
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 19:42:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1249 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S263011AbVEHXm3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 19:42:29 -0400
Received: (qmail 14955 invoked by uid 2001); 8 May 2005 23:42:27 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfywx2t77.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 09, 2005 at 01:28:44AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> PB> ... since I *don't* think you want to share this. The very
> PB> fact it is in the .git/ directory implies here that these
> PB> are your local exclude patterns which are likely
> PB> temporary...
> 
> Is it really the case?  I recall that Linux kernel started
> shipping with the standard dontdiff file for everybody's use
> some time ago, after enough people wanted it included in the
> upstream release.  Maybe you would want to read from both?

Of course. You should combine them both, the .git/ one having the
ultimate precedence (if we support the CVS-like ! stuff too).

That is, in CVS the version-controlled files are per-directory, which
can be very nice too; things are getting harder now, though, since we
should have some per-project ignore file too.

> PB> The fact that we have no support for version-tracked exclude file can't
> PB> stop me! ;-)
> 
> What darcs folks do is that they have a per-tree configuration
> (kept in ./_darcs, which is similar to our ./.git) that says
> which file is the exclude list, and by setting configuration
> item to point at a file which _is_ version controlled they can
> share the exclude file.

That is certainly a good idea (at least for kernel, where you probably
just want to give it dontdiff), but we need a sensible default.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
