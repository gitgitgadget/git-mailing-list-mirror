From: Junio C Hamano <junkio@cox.net>
Subject: Re: Users of git-check-files?
Date: Wed, 03 Aug 2005 09:36:59 -0700
Message-ID: <7vk6j3f044.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0508021942500.3341@g5.osdl.org>
	<7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508030808530.3341@g5.osdl.org>
	<7vr7dbhvci.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508030913060.3341@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 18:39:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0MF1-0000KU-0o
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 18:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVHCQhD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 12:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVHCQhD
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 12:37:03 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:6048 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262324AbVHCQhB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 12:37:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050803163700.NCRI3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 Aug 2005 12:37:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508030913060.3341@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 3 Aug 2005 09:17:22 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> I've lost that state. Can you explain a bit mroe..

Sorry, you have not lost anything.  It is my bad that this is
the first time I brought it up.  I've been seeing that from time
to time when I push to either my "send to master" repository
from my working repository, or from the "send to master"
repository to master.kernel.org, but I haven't figured it out if
there is any pattern.  It's one of those "I'll try to take a
snapshot so I can have a reproduction recipe to figure it out
next time it happens" things.  Unfortunately, when it happens
against master.kernel.org, I have more urgent task of making
sure that the public repository is not in any way corrupted, and
after fixing that (it typically takes removing the
git.git/refs/{master,pu} and repushing, which recovers fine), I
do not have much to start trying to reproduce it anymore X-<.
