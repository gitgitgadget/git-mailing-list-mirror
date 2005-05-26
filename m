From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git-update-cache: allow dot-files
Date: Thu, 26 May 2005 10:37:45 +0200
Message-ID: <20050526083745.GD22262@pasky.ji.cz>
References: <7vhdgstb7x.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505241723060.2307@ppc970.osdl.org> <7v8y24taai.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505241748520.2307@ppc970.osdl.org> <7v3bscrtwx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 10:37:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbDqc-00040O-6r
	for gcvg-git@gmane.org; Thu, 26 May 2005 10:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVEZIhy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 04:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVEZIhy
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 04:37:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35501 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261278AbVEZIhq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2005 04:37:46 -0400
Received: (qmail 29679 invoked by uid 2001); 26 May 2005 08:37:45 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bscrtwx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, May 25, 2005 at 03:11:42AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
> 
> LT> Heh. There's a difference between being anal, and allowing people to shoot 
> LT> themselves in the foot.
> 
> How about we do something like this:
> 
>  (1) we keep hardcoded .git refusing as you did;
>  (2) we forbid GIT_DIR to be set to anything other than what
>      ends with "/.git", unless it is literally ".git";

That doesn't make any sense. When I'm working on kernel.org, why
would you prohibit me to set GIT_DIR to /pub/scm/cogito/cogito.git ?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
