From: Petr Baudis <pasky@ucw.cz>
Subject: Re: import mbox?
Date: Thu, 28 Apr 2005 01:14:12 +0200
Message-ID: <20050427231412.GL22956@pasky.ji.cz>
References: <42701B79.8080106@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 01:09:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQveI-00013D-Eb
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 01:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVD0XOQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 19:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVD0XOQ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 19:14:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55468 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262088AbVD0XOO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 19:14:14 -0400
Received: (qmail 14725 invoked by uid 2001); 27 Apr 2005 23:14:12 -0000
To: Jeff Garzik <jgarzik@pobox.com>
Content-Disposition: inline
In-Reply-To: <42701B79.8080106@pobox.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 28, 2005 at 01:08:41AM CEST, I got a letter
where Jeff Garzik <jgarzik@pobox.com> told me that...
> Sorry for the FAQ, but I didn't see this in any of the scripts in the 
> 'git' archives, nor in the README.
> 
> What script should kernel developers use, to import an mbox full of patches?

There is git-tools. One of the many ways how to get it is

	$ cg-clone rsync://rsync.kernel.org/pub/linux/kernel/people/torvalds/git-tools.git

Note that AFAIK it does not set $AUTHOR_DATE properly; patches were
posted to this mailing list to fix this.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
