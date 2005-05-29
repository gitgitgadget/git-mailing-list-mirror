From: Petr Baudis <pasky@ucw.cz>
Subject: Re: -p diff output and the 'Index:' line
Date: Sun, 29 May 2005 21:03:05 +0200
Message-ID: <20050529190305.GP1036@pasky.ji.cz>
References: <20050529071520.GC1036@pasky.ji.cz> <7vd5raqy28.fsf@assigned-by-dhcp.cox.net> <20050529120248.GD1036@pasky.ji.cz> <7vekbpq56r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 21:01:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcT1p-0004fj-SX
	for gcvg-git@gmane.org; Sun, 29 May 2005 21:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVE2TDO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 15:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVE2TDN
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 15:03:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43392 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261346AbVE2TDH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 15:03:07 -0400
Received: (qmail 16972 invoked by uid 2001); 29 May 2005 19:03:05 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vekbpq56r.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 29, 2005 at 08:04:44PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> You said you do not do "less", so the following may not apply to
> your usage, but I disagree your comment about "typing that /
> stuff seems insane".  Sean's workaround to use "less -p '^diff
> --git .*'" in a script, combined with typing 'n' in a "less"
> session to find the next such line, would make it very pleasant
> to use.

(As long as you don't want to search for something else. ;-)

But yes, I like the less -p hack.

> PB> OTOH I think I'll go for the diff output colorification (at
> PB> the Cogito level), so the separator indeed isn't strictly
> PB> necessary. I can live without it. :-)
> 
> When I want to make a customized diff output out of the "diff-*
> -p' command, I find it a lot easier to use the GIT_EXTERNAL_DIFF
> mechanism than parsing what comes out of "diff-* -p" and munging
> it.  I am not _telling_, _ordering_, nor even _asking_ you to
> use GIT_EXTERNAL_DIFF; just suggesting you to consider that as a
> way to possibly make your implementation easier.  I'd start from
> the supplied git-external-diff-script and go from there.

It's just something along the lines of "Me Og. Og sees /^+/. Og makes
the line green." written in gawk (actually I'm not sure if pure awk
wouldn't do, but I actually don't know the language), so I don't think
the external diff thing would've helped me with that in any way.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
