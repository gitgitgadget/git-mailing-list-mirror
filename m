From: Petr Baudis <pasky@ucw.cz>
Subject: Re: -p diff output and the 'Index:' line
Date: Mon, 30 May 2005 10:30:52 +0200
Message-ID: <20050530083052.GC1036@pasky.ji.cz>
References: <20050529071520.GC1036@pasky.ji.cz> <7vd5raqy28.fsf@assigned-by-dhcp.cox.net> <20050529120248.GD1036@pasky.ji.cz> <7vekbpq56r.fsf@assigned-by-dhcp.cox.net> <20050529190305.GP1036@pasky.ji.cz> <7v7jhh6ty5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 10:29:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcfdP-0001YT-IB
	for gcvg-git@gmane.org; Mon, 30 May 2005 10:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVE3Ia7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 04:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVE3Ia7
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 04:30:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16780 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261389AbVE3Iay (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 04:30:54 -0400
Received: (qmail 18475 invoked by uid 2001); 30 May 2005 08:30:52 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7jhh6ty5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 30, 2005 at 09:42:26AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> PB> It's just something along the lines of "Me Og. Og sees /^+/. Og makes
> PB> the line green." written in gawk (actually I'm not sure if pure awk
> PB> wouldn't do, but I actually don't know the language), so I don't think
> PB> the external diff thing would've helped me with that in any way.
> 
> Ah, I see.  I thought you were talking about the Index: and
> separator lines.  Colorizing diff/patch part, you need to parse
> the diff output with sed/awk/perl and annotate it anyway, and it
> does not matter if you annotate within GIT_EXTERNAL_DIFF or
> outside.  I agree with you that using GIT_EXTERNAL_DIFF
> mechanism would not help you here.

Well, I want to finally converge with the diff format to what git uses.
So I'm just colorizing the /^diff --git/ line with a unusually bright
color, which will hopefully make up for the Index: and separator lines.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
