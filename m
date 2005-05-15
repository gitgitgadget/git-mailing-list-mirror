From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Sun, 15 May 2005 11:30:40 +0200
Message-ID: <20050515093040.GC13024@pasky.ji.cz>
References: <Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org> <20050513224529.GF32232@pasky.ji.cz> <7vhdh691gs.fsf@assigned-by-dhcp.cox.net> <20050513233354.GK32232@pasky.ji.cz> <7vmzqy7k47.fsf@assigned-by-dhcp.cox.net> <7voebe63zs.fsf@assigned-by-dhcp.cox.net> <20050514150356.GK3905@pasky.ji.cz> <7vu0l5zsb4.fsf@assigned-by-dhcp.cox.net> <20050514233538.GY3905@pasky.ji.cz> <7vr7g9uhsl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 11:30:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXFSb-0005Fp-8K
	for gcvg-git@gmane.org; Sun, 15 May 2005 11:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVEOJar (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 05:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVEOJar
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 05:30:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26541 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261573AbVEOJal (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 05:30:41 -0400
Received: (qmail 26288 invoked by uid 2001); 15 May 2005 09:30:40 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr7g9uhsl.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 15, 2005 at 08:25:46AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> >> Wait a minute.  Aren't we scanning starting from the first
> >> '---\n'?  Why does what's in commit message matter?
> 
> PB> Ok, that changes the whole situation. I'll take your patches as they are
> PB> now in that case. :-)
> 
> Shooooooooot.  Seriously.
> 
> I already am beginning to like "\n@. " very much; it is much
> less distracting then the "# mode: " thing, especially with the
> help from additional newline.

I'd argue that it is too little distracting this way. But what I dislike
more is that the diff output is now visually inconsistent - some diffs
are separated by a newline and some aren't.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
