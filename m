From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments on recursive merge..
Date: Tue, 08 Nov 2005 16:59:41 -0800
Message-ID: <7vlkzyd4aq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<20051107225807.GA10937@c165.ib.student.liu.se>
	<7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
	<Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051108210211.GA23265@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
	<20051108223609.GA4805@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
	<20051109003236.GA30496@pasky.or.cz>
	<Pine.LNX.4.64.0511081646160.3247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 02:00:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZeJe-0001ca-VK
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 01:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbVKIA7o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 19:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbVKIA7n
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 19:59:43 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:48299 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030486AbVKIA7m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 19:59:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109005920.UNHL1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Nov 2005 19:59:20 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511081646160.3247@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 8 Nov 2005 16:51:11 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11375>

Linus Torvalds <torvalds@osdl.org> writes:

> Junio? You even wrote the comment about the case in git-merge-base, I'm 
> wondering whether it's a bug that we use the fast-and-cheap algorithm in 
> git-show-branch..

I did show-branch soon after we worked on those pathlogical
merge-base fix, so I would be a bit surprised if I did it
without using all the knowledge from that exercise, but I do not
remember offhand.  The core logic should be simple
generalization of two-head merge-base to N heads.
