From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [cogito] paged output for cg-diff
Date: Sun, 29 May 2005 16:01:27 +0200
Message-ID: <20050529140127.GI1036@pasky.ji.cz>
References: <200505201517.05995.michal@rokos.info> <7vu0kyuhtq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Rokos <michal@rokos.info>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 16:00:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcOJz-0007N3-A4
	for gcvg-git@gmane.org; Sun, 29 May 2005 15:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVE2OBi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 10:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVE2OBf
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 10:01:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55530 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261309AbVE2OB3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 10:01:29 -0400
Received: (qmail 27785 invoked by uid 2001); 29 May 2005 14:01:27 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0kyuhtq.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, May 20, 2005 at 03:50:57PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> On the other hand, if your user is a "less" user, and if the
> user wants it to honor ANSI "color" escape sequences, it would
> be more helpful to the user if you educate/encourage the user to
> have "LESS=R" in the environment and make that in effect
> everywhere less is used not just in Cogito.  Giving that support
> silently just in Cogito at the first thought may seem to be more
> helpful but in reality it is not.
> 
> So I would suggest to use the above form without defining your
> own PAGER shell function, and add a tip for "less" users to have
> "LESS=R" in their environment somewhere in the documentation.

Using the $LESS variable didn't occur to me and I like the idea. :-)
I think the most reasonable thing for Cogito will be to set LESS=R$LESS
if the user passed -c to the given command.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
