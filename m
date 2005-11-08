From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-pull.sh's bad mode
Date: Tue, 8 Nov 2005 17:35:46 +0100
Message-ID: <20051108163546.GC1431@pasky.or.cz>
References: <E1EZUK2-0005EG-56@jdl.com> <7v4q6njecr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 17:46:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZWRy-0002Od-Ib
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 17:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVKHQfu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 11:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVKHQfu
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 11:35:50 -0500
Received: from w241.dkm.cz ([62.24.88.241]:3794 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932465AbVKHQfu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 11:35:50 -0500
Received: (qmail 14007 invoked by uid 2001); 8 Nov 2005 17:35:46 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4q6njecr.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11336>

Dear diary, on Tue, Nov 08, 2005 at 05:25:56PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Jon Loeliger <jdl@freescale.com> writes:
> 
> > Public apology and brown paper bag.  My patch
> > accidentally twiddled the mode on git-pull.sh:
> >
> >      mode change 100755 => 100644 git-pull.sh
> 
> No need for worrying things like this.  Mistakes and accidents
> happen.
> 
> Makefile installs git-pull with executable bit set anyway, so it
> really does not matter.

But it should definitely be fixed. E.g. I actually personally use (for
Cogito development) git-core which I never make install (I have
system-wide git-core installation which is just whatever is the latest
version Gentoo ships, and I use that for non-Cogito development).
It would be painful if this mode of usage wouldn't be supported.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
