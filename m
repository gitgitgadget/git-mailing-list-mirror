From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] whatchanged: customize diff-tree output
Date: Thu, 22 Dec 2005 20:19:39 -0800
Message-ID: <7vvexgfns4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512212336230.18908@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvexhr6rc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512212245440.4827@g5.osdl.org>
	<Pine.LNX.4.63.0512221200190.7112@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051222210620.GA4679@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 23 05:20:16 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpePc-0006tJ-Js
	for gcvg-git@gmane.org; Fri, 23 Dec 2005 05:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbVLWETm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 23:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbVLWETm
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 23:19:42 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:21169 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030406AbVLWETl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 23:19:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051223041845.VWVB6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Dec 2005 23:18:45 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13984>

Alex Riesen <raa.lkml@gmail.com> writes:

> That's the point, isn't it? A script from ~user1/bin, which calls
> git-whatchanged suddenly stops working in ~user2/repo.

For scripted use you can give command line arguments yourself to
whatchanged and you can bypass the repoconfig.  I do not think
whatchanged is meant for scripted use, though --- it is such a
simple script, and if you want to build on it to do something
more elaborate, I think you would be better off writing those
rev-list and diff-tree in your script.
