From: Junio C Hamano <junkio@cox.net>
Subject: Re: Recent unresolved issues
Date: Sun, 16 Apr 2006 01:14:17 -0700
Message-ID: <7vlku6c4yu.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604141637230.3701@g5.osdl.org>
	<7vlku7n05x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604141748070.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604141751270.3701@g5.osdl.org>
	<7vu08vjra5.fsf@assigned-by-dhcp.cox.net>
	<7vk69ri5cp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604150958140.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604151016220.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 10:14:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FV2Ot-0001Co-8m
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 10:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWDPIOU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 04:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWDPIOT
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 04:14:19 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:8151 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751314AbWDPIOT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Apr 2006 04:14:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060416081418.GZTE7053.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 16 Apr 2006 04:14:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604151016220.3701@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 15 Apr 2006 10:17:05 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18775>

Linus Torvalds <torvalds@osdl.org> writes:

> Btw, I can certainly understand if you don't want to do this before 1.3.x. 
> Since there's no actual user-visible advantage to it, it's probably worth 
> dropping for now.

Well, I bit the bullet, fixed-up the remaining issues I found in
rev-list in your grand unified version, reverted the revert, and
ported the changes for log/whatchanged/show.

For now this lives in the "next" branch and _will_ not graduate
before 1.3.0, of course.
