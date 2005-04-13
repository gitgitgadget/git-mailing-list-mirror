From: Petr Baudis <pasky@ucw.cz>
Subject: Re: teach ls-tree how to handle names with embedded LF
Date: Thu, 14 Apr 2005 01:50:18 +0200
Message-ID: <20050413235018.GQ25711@pasky.ji.cz>
References: <7vd5sytf94.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 01:50:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLrc4-0001FK-Sb
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 01:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVDMXvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 19:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVDMXvM
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 19:51:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:30905 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261236AbVDMXuT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 19:50:19 -0400
Received: (qmail 29890 invoked by uid 2001); 13 Apr 2005 23:50:18 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5sytf94.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 14, 2005 at 01:43:03AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> GIT dircache can represent filenames with embedded newline.
> Give ls-tree an option to terminate its output with '\0', so that
> its output can be further processed with tools like "sort -z"
> (and custom perl/python scripts).

Actually, what about just making it consistent with diff-tree and making
it always terminate the records with '\0'?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
