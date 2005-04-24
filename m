From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Hash collision count
Date: Sun, 24 Apr 2005 02:40:39 +0200
Message-ID: <20050424004039.GU13222@pasky.ji.cz>
References: <426AAFC3.800@pobox.com> <1114297231.10264.12.camel@maze.mythral.org> <426AD835.5070404@pobox.com> <20050423234637.GS13222@pasky.ji.cz> <426AE9ED.4060005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ray Heasman <lists@mythral.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 02:36:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPV6P-0000RT-F2
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 02:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVDXAko (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 20:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVDXAko
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 20:40:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31161 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261201AbVDXAkl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 20:40:41 -0400
Received: (qmail 8805 invoked by uid 2001); 24 Apr 2005 00:40:39 -0000
To: Jeff Garzik <jgarzik@pobox.com>
Content-Disposition: inline
In-Reply-To: <426AE9ED.4060005@pobox.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 24, 2005 at 02:35:57AM CEST, I got a letter
where Jeff Garzik <jgarzik@pobox.com> told me that...
> Someone just told me that one implementation of the Venti archive 
> server[1] simply fails the write, if a data item exists with a duplicate 
> hash value.  As long as git fails or does something -predictable- in the 
> face of the hash collision, I'm satisfied.

-DCOLLISION_CHECK

See the top of Makefile.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
