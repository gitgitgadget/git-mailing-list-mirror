From: Petr Baudis <pasky@suse.cz>
Subject: Re: Status of git.git repository
Date: Fri, 5 Aug 2005 00:26:11 +0200
Message-ID: <20050804222611.GE24479@pasky.ji.cz>
References: <7vhded6o0r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 00:32:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0oFS-0006eP-SU
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 00:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbVHDW2e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 18:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVHDW0T
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 18:26:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4621 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262745AbVHDW0N (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 18:26:13 -0400
Received: (qmail 29778 invoked by uid 2001); 4 Aug 2005 22:26:11 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhded6o0r.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jul 30, 2005 at 04:11:48AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> By the way, do people mind my posting my own patches to the
> list?  I keep the same in the "pu" (proposed updates) branch, so
> if the list readers think I am just adding noise to the list
> traffic, I would stop doing so, and instead just invite
> interested people to browse the "pu" branch.

Browsing the "pu" branch may be bothersome and you won't ensure that the
related discussion stays in a single thread, and posting the patches
here makes them generally more visible, so I think it's a good idea to
keep doing so.

Cogito (and Git itself as well, I guess) does not handle those
"volatile" branches well at all - following them is difficult since
Cogito will think that you did some local commits and want to do a tree
merge. Would anyone consider doing

	if ref(updatebranch) == ref(master) then
		merge: always_fastforward
	else
		merge: perhaps_treemerge

a Bad Thing (tm)? It seems to me that it should do the right thing and
never get it wrong.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
