From: Junio C Hamano <junkio@cox.net>
Subject: Re: Users of git-check-files?
Date: Wed, 03 Aug 2005 08:51:41 -0700
Message-ID: <7vr7dbhvci.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0508021942500.3341@g5.osdl.org>
	<7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508030808530.3341@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 17:54:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0LY0-0002Af-Il
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 17:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVHCPwV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 11:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbVHCPwE
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 11:52:04 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:6825 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262307AbVHCPvt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 11:51:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050803155142.DQLS1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 Aug 2005 11:51:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508030808530.3341@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 3 Aug 2005 08:09:32 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Yeah, probably not. git-rev-list does so much more than git-rev-tree ever 
> did.

Does rev-list do --edges ;-)?

BTW, I have two known bugs/problems that I haven't resolved,
which is bothering me quite a bit.  Yes, it is my fault (lack of
time and concentration).  One is the EINTR from the daemon.c,
and another is receive-pack failing with "unpack should have
generated but I cannot find it" when pushing.  The latter is
something "I am aware of, I know it needs to be diagnosed, but I
have not looked into yet".
