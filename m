From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Support projects including other projects
Date: Thu, 12 May 2005 11:47:50 -0700
Message-ID: <7vll6kgu21.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505121218280.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 20:41:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWIbX-0005Ci-T8
	for gcvg-git@gmane.org; Thu, 12 May 2005 20:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVELSry (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 14:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVELSrx
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 14:47:53 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:7337 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261246AbVELSrw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 14:47:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512184750.HLLC8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 14:47:50 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505121218280.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Thu, 12 May 2005 12:51:29 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> Do you have some solution to the problem of having the
DB> porcelain layer (or the end user) find the version of git
DB> that a version of cogito needs, in some way such that if I'm
DB> working on the project and make a change to cogito and a
DB> matching change to git, Petr can get them.

I have to think about this a bit but let me understand the
problem first.  Let's say it is a couple of weeks ago when there
were not cg-status.  You write cg-status, by adding -t flag to
ls-files.c  You commit the addition of -t flag to git-pb
repository and note the commit id.  You then commit addition of
cg-status to cogito repository and when you do so you want the
party that pulls the latter commit to know it needs the former
commit in the git-pb tree.  Is it what you are solving here?


