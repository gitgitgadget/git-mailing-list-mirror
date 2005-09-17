From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git and cogito uses different exclude files
Date: Sat, 17 Sep 2005 07:50:09 +0200
Message-ID: <20050917055009.GB31324@pasky.or.cz>
References: <432A7902.20603@drzeus.cx> <tnxbr2t9zsk.fsf@arm.com> <20050916104430.GA25169@pasky.or.cz> <7vfys5ote8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Pierre Ossman <drzeus-list@drzeus.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 07:50:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGVah-0000nC-2J
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 07:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVIQFuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 01:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbVIQFuP
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 01:50:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16357 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750942AbVIQFuN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Sep 2005 01:50:13 -0400
Received: (qmail 31768 invoked by uid 2001); 17 Sep 2005 07:50:09 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfys5ote8.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8755>

Dear diary, on Fri, Sep 16, 2005 at 06:43:27PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> >> The latest StGIT snapshot uses .git/info/exclude. Probably next week I
> >> will make a new StGIT release.
> >
> > So does Cogito now. ;-) It still looks at .git/exclude as well and gives
> > warning if it exists.
> 
> Late last night I could not find in the list archive the "list
> consensus" I used to justify what 'git-status' does in this log
> message:
> 
>     Message-ID: <7vfysw89do.fsf@assigned-by-dhcp.cox.net>
>     From: Junio C Hamano <junkio@cox.net>
>     Subject: [PATCH] Teach git-status-script about git-ls-files --others
>     Date: Fri, 26 Aug 2005 18:18:59 -0700
> 
>     When there is non-empty $GIT_DIR/info/exclude file, use it along
>     with .gitignore per-directory exclude pattern files (which was
>     a convention agreed on the list while ago and is compatible with
>     Cogito) to generate a list of ignored files as well.
> 
>     Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> I do remember checking Cogito and StGIT and making sure the use
> of .gitignore is consistent with you two, but I do not remember
> if we had consensus on info/exclude now.  It could be that I was
> just hallucinating back then and ended up forcing this change
> onto you and your users by mistake in this round.

I'm too tired to search now (just after a night bus trip from Denmark -
actually, one of the bus drivers looked exactly like Linus, perhaps his
twin works for a Czech bus company?), but I believe we actually did
agree on using .git/info/exclude instead of .git/exclude in some old
now-forgotten thread, or we are having the same hallucinations.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
