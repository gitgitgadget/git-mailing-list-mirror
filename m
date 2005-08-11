From: Petr Baudis <pasky@suse.cz>
Subject: Re: Make git-rev-tree obsolete
Date: Fri, 12 Aug 2005 00:22:31 +0200
Message-ID: <20050811222231.GH25280@pasky.ji.cz>
References: <Pine.LNX.4.63.0508090222190.4076@wgmdd8.biozentrum.uni-wuerzburg.de> <7vhddzygcp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 00:22:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3LRa-0002GW-E0
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 00:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbVHKWWc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 18:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbVHKWWc
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 18:22:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:21770 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932499AbVHKWWb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 18:22:31 -0400
Received: (qmail 21416 invoked by uid 2001); 11 Aug 2005 22:22:31 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhddzygcp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Aug 09, 2005 at 04:49:26AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Junio remarked that Jeff's git-changes-script still uses git-rev-tree, and 
> > therefore it should not be removed. This patch changes git-changes-script 
> > over to git-rev-list:
> 
> Just to make things clear, "Junio remarked" that Cogito also
> seems to use it as well, so git-rev-tree is not going away.

Please note

41283a6ed1924c7b3963c5455ba39911f1069682
	cg-mkpatch: Ditch git-rev-tree in favour of git-rev-list
7136aa4337334a28e55c8853018423d4b780214c
	cg-commit: Use git-rev-list instead of git-rev-tree

from 2005-08-05, which should remove any traces of git-rev-tree usage
from Cogito. Unfortunately, I did that only after releasing Cogito-0.13,
so you would break that particular version (first to depend on git
externally) by removing git-rev-tree now. But I think it's safe to kill
after a while (and another Cogito release, which shouldn't be far away).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
