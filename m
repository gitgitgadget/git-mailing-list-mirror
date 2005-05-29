From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Add -B flag to diff-* brothers.
Date: Sun, 29 May 2005 23:56:17 +0200
Message-ID: <20050529215617.GT1036@pasky.ji.cz>
References: <7vbr6vrvqf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 23:56:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcVjW-0001H5-4s
	for gcvg-git@gmane.org; Sun, 29 May 2005 23:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVE2V41 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 17:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVE2V41
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 17:56:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1412 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261457AbVE2V4T (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 17:56:19 -0400
Received: (qmail 32107 invoked by uid 2001); 29 May 2005 21:56:17 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbr6vrvqf.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 28, 2005 at 09:33:44PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> This introduces diffcore-break.c, a new diffcore
> transformation.
> 
> When the -B flag is given, a patch that represents a complete
> rewrite is broken into a deletion followed by a creation.  This
> makes it easier to review such a complete rewrite patch.
> 
> The -B flag takes the same syntax as the -M and -C flags to
> specify the maximum amount of source material the resulting file
> can still have to be considered a complete rewrite, and defaults
> to 15% if not specified.  For example, this detects the complete
> rewrite of ls-tree.c I sent earlier.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Actually, I like this one - contrary to -O I can see how this could be
quite useful - I have wished for this many times when people would send
me some "complete rewrite" patches which I actually wanted to review.

Please don't give up on it. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
