From: Petr Baudis <pasky@ucw.cz>
Subject: Re: More problems...
Date: Fri, 29 Apr 2005 20:27:08 +0200
Message-ID: <20050429182708.GB14202@pasky.ji.cz>
References: <20050429170127.A30010@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 20:23:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRa7w-0000oB-7Z
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 20:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbVD2S1r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 14:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbVD2S1R
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 14:27:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3801 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262876AbVD2S1K (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 14:27:10 -0400
Received: (qmail 15137 invoked by uid 2001); 29 Apr 2005 18:27:09 -0000
To: Russell King <rmk@arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050429170127.A30010@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 29, 2005 at 06:01:27PM CEST, I got a letter
where Russell King <rmk@arm.linux.org.uk> told me that...
> rmk@dyn-67:[linux-2.6-rmk]:<1049> cg-update origin
> `../linux-2.6/.git/objects/00/78aeb85737197a84af1eeb0353dbef74427901' -> `.git/objects/00/78aeb85737197a84af1eeb0353dbef74427901'
> cp: cannot create link `.git/objects/00/78aeb85737197a84af1eeb0353dbef74427901': File exists
> 
> By that time, the object files in the reference tree appear to have
> a newer timestamp than the corresponding ones in my local tree, and
> cp -lua fails.

I'm now away ,unfortunately, and no immediate idea stems to my mind on
how to fix it. Ideas welcomed - I need to hardlink missing entries from
one tree to another; it would be enough to be able to just tell cp to
ignore already present files.

Could you please try to give cp the -f flag?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
