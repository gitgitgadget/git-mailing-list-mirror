From: Petr Baudis <pasky@ucw.cz>
Subject: Re: 'read-tree -m head' vs 'read-tree head'
Date: Tue, 3 May 2005 23:34:44 +0200
Message-ID: <20050503213444.GD15995@pasky.ji.cz>
References: <20050503124935.GT25004@cip.informatik.uni-erlangen.de> <7vbr7sw2aj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 23:28:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT4wM-0004Xn-Rd
	for gcvg-git@gmane.org; Tue, 03 May 2005 23:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVECVer (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 17:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVECVer
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 17:34:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4812 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261801AbVECVep (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 17:34:45 -0400
Received: (qmail 11637 invoked by uid 2001); 3 May 2005 21:34:44 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbr7sw2aj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 03, 2005 at 09:13:40PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> That said, I've been wondering if "git-read-tree -m <tree>"
> always does the same thing (but only making the operation
> afterwards faster) as "git-read-tree <tree>".  That is, if there
> is a valid use case where you would want to use it without "-m"
> because "-m" does something wrong.  If there is no such valid
> use case probably we should always do "-m" version if we are
> reading only one tree, practically deprecating "-m" flag to the
> same status as "-r" flag to git-diff-cache.
> 
> However, I have not had time to think things through and have
> not bugged Linus about it myself.

-m fails when your cache file is missing/corrupted. Not that it cannot
be fixed, just remember to fix it if you are going to do what you
described.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
