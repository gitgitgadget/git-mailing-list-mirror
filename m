From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Catching up: git-pasky-0.6.2 broken?
Date: Sat, 23 Apr 2005 23:25:05 +0200
Message-ID: <20050423212505.GB13222@pasky.ji.cz>
References: <20050423124758.B32116@flint.arm.linux.org.uk> <20050423151238.C32116@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 23:21:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPS4M-0002Hh-5p
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 23:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVDWVZ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 17:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVDWVZ1
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 17:25:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20662 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261880AbVDWVZL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 17:25:11 -0400
Received: (qmail 18953 invoked by uid 2001); 23 Apr 2005 21:25:05 -0000
To: Russell King <rmk@arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050423151238.C32116@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 23, 2005 at 04:12:39PM CEST, I got a letter
where Russell King <rmk@arm.linux.org.uk> told me that...
> Could the problem be related to some random garbage left in .git/add-queue
> and .git/rm-queue?

Quite likely.

> If so, how did these files get generated in the first place, and why
> weren't they removed when they were finished with?

That was a bug in git apply, fixed for quite some time already.

> IMHO updating a repository from an external source should _NOT_ be
> affected by the presence (or absense) of these two files, which
> contain only _local_ state information.

Note that the latest git-pasky (post-0.6.3) is already completely
queues-free.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
