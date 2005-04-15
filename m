From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: write-tree is pasky-0.4
Date: Fri, 15 Apr 2005 23:22:55 +0200
Message-ID: <20050415212255.GJ7417@pasky.ji.cz>
References: <20050414233159.GX22699@pasky.ji.cz> <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net> <20050414223039.GB28082@64m.dyndns.org> <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net> <20050415062807.GA29841@64m.dyndns.org> <7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net> <7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org> <7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.61.0504151617170.27637@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 23:19:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMYDv-0000yB-8m
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 23:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVDOVXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 17:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVDOVXF
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 17:23:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55009 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261974AbVDOVXA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 17:23:00 -0400
Received: (qmail 27307 invoked by uid 2001); 15 Apr 2005 21:22:55 -0000
To: "C. Scott Ananian" <cscott@cscott.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504151617170.27637@cag.csail.mit.edu>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 15, 2005 at 10:58:10PM CEST, I got a letter
where "C. Scott Ananian" <cscott@cscott.net> told me that...
> On Fri, 15 Apr 2005, Junio C Hamano wrote:
> 
> >to yours is no problem for me.  Currently I see your HEAD is at
> >461aef08823a18a6c69d472499ef5257f8c7f6c8, so I will generate a
> >set of patches against it.
> 
> Have you considered using an s/key-like system to make these hashes more 
> human-readable?  Using the S/Key translation (11-bit chunks map to a 1-4 
> letter word), Linus' HEAD is at:
>   WOW-SCAN-NAVE-AUK-JILL-BASH-HI-LACE-LID-RIDE-RUSE-LINE-GLEE-WICK-A
> ...which is a little longer, but speaking of branch "wow-scan" (which 
> gives 22 bits of disambiguation) is probably less error-prone than 
> discussing branch '461...' (only 12 bits).
> 
> You could supercharge this algorithm by using (say) 
> /usr/dict/american-english-large (>2^17 words; 160 bits of hash = 10 
> dictionary words), or mixing upper and lower case (likely to reduce the 15 
> word s/key phrase to ~11 words) to give something like
>    RiDe-Rift-rIMe-rOSy-ScaR-sCat-ShiN-sIde-Sine-seeK-TIEd-TINT
> My personal feeling is that case is likely to be dropped in casual 
> conversation, so speaking of branch 'wow', 'wow-scan', or 'wow-scan-nave' 
> is likely to be significantly more useful than trying to pronounce 
> mixed-cased versions of these.
> 
> This is obviously a cogito issue, rather than a git-fs thing.

I kind of like it, the only thing I fear is possible conflict with
branch names; it is not very likely though, I think. I believe (at
least) the first three words should be used if possible.

I'm not sure in what cases do you think we should use those "verbal"
names, though. Of course we should accept them as IDs, but I don't think
we should ever show them automatically. Probably provide a trivial to
use tool to convert to them, and parameters for *-id tools to show them.

I assume we would have a custom tool for the translation?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
