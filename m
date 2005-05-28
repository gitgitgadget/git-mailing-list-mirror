From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Add -O<orderfile> option to diff-* brothers.
Date: Sat, 28 May 2005 13:12:38 +0200
Message-ID: <20050528111238.GA1036@pasky.ji.cz>
References: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 13:11:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbzD3-00079s-Oe
	for gcvg-git@gmane.org; Sat, 28 May 2005 13:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVE1LMn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 07:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVE1LMm
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 07:12:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3286 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262698AbVE1LMl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 May 2005 07:12:41 -0400
Received: (qmail 6301 invoked by uid 2001); 28 May 2005 11:12:38 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 28, 2005 at 11:54:39AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> A new diffcore filter diffcore-order is introduced.  This takes
> a text file each of whose line is a shell glob pattern.  Patches
> matching the glob pattern on an earlier line in the file are
> output before patches matching the glob pattern on a later line,
> and patches not matching any glob pattern is output last.
> 
> A typical orderfile for git project would probably look like
> this:
> 
>     README
>     Documentation
>     Makefile
>     *.h
>     *.c
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Hmm, is this really useful in practice? diff itself doesn't appear to
have it either, and I haven't seen something like this before. So is it
worth the code?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
