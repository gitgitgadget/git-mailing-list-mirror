From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 2/4] Tweak diff output further to make it a bit less distracting.
Date: Tue, 17 May 2005 00:05:59 +0200
Message-ID: <20050516220559.GC8609@pasky.ji.cz>
References: <7vvf5kqj9l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue May 17 00:10:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXnll-0003wn-1z
	for gcvg-git@gmane.org; Tue, 17 May 2005 00:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVEPWHb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 18:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVEPWHb
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 18:07:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54223 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261947AbVEPWGB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2005 18:06:01 -0400
Received: (qmail 20108 invoked by uid 2001); 16 May 2005 22:05:59 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvf5kqj9l.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 15, 2005 at 11:19:50PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Adds an newline between each diff.  Also change "#mode : "
> string, which was misleading in that we are not showing just
> mode when we talk about a file changing into a symlink.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

So, I've been looking at the output, and I have to admit that I'm still
not too happy with it (I know I'm horrible). It turned out to be rather
confusing, since there are normally no blank lines in the middle of the
diffs, so it looked as the blank lines were actually part of the diffed
files.

What about just throwing away the newlines and just passing '@.'?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
