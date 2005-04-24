From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Humble request of 'git' developers
Date: Sun, 24 Apr 2005 22:44:09 +0200
Message-ID: <20050424204408.GM1507@pasky.ji.cz>
References: <426AA8E2.60403@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 22:39:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPntH-00055D-Gu
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 22:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVDXUo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 16:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVDXUo0
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 16:44:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50635 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262409AbVDXUoO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 16:44:14 -0400
Received: (qmail 10810 invoked by uid 2001); 24 Apr 2005 20:44:09 -0000
To: Jeff Garzik <jgarzik@pobox.com>
Content-Disposition: inline
In-Reply-To: <426AA8E2.60403@pobox.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 23, 2005 at 09:58:26PM CEST, I got a letter
where Jeff Garzik <jgarzik@pobox.com> told me that...
> Please stop filling up my /usr/local/bin :)
> 
> Just have one 'git' script, which looks in /usr/local/libexec/git for 
> further scripts and backends programs like write-tree and diff-cache.

Ad core git, yes, one of the reasons why I decided for the Cogito rename
was to free the "git namesace" for the git programs. :-)

> Also, please don't assume that "." is in PATH.  I think there is at 
> least one invocation of commit-id with that assumption, in git-pasky-0.6.3.

Yes, sorry, fixed and pushed out.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
