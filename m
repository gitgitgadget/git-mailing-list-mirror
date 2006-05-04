From: Petr Baudis <pasky@suse.cz>
Subject: Re: Unresolved issues #2
Date: Thu, 4 May 2006 11:58:27 +0200
Message-ID: <20060504095827.GW27689@pasky.or.cz>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mj@ucw.cz
X-From: git-owner@vger.kernel.org Thu May 04 11:57:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbaaN-0008FU-My
	for gcvg-git@gmane.org; Thu, 04 May 2006 11:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWEDJ5X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 05:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWEDJ5X
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 05:57:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1999 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751475AbWEDJ5X (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 May 2006 05:57:23 -0400
Received: (qmail 19620 invoked by uid 2001); 4 May 2006 11:58:27 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19562>

Dear diary, on Thu, May 04, 2006 at 10:15:03AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> * Message-ID: <1143856098.3555.48.camel@dv>
>   Per branch property, esp. where to merge from (Pavel Roskin)
> 
>   This involves user-level "world model" design, which is more
>   Porcelainish than Plumbing, and as people know I do not do
>   Porcelain well; interested parties need to come up with what
>   they want and how they want to use it.

Oh, my holey memory. In Cogito, I have just implemented a solution
suggested by Martin Mares, which is pretty simple, non-obtrusive
and will work equally fine with remotes as well as remote branches:

	if [ $branch != master ] && [ -s .git/branches/$branch-origin ]
		origin=.git/branches/$branch-origin
	else
		origin=.git/branches/origin
	fi

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
