From: Junio C Hamano <junkio@cox.net>
Subject: Re: A note on merging conflicts..
Date: Sat, 01 Jul 2006 11:37:45 -0700
Message-ID: <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
	<7vy7vedntn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
	<20060701150926.GA25800@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jul 01 20:38:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwkLy-0002Hk-SD
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 20:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWGAShr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 14:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWGAShr
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 14:37:47 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:40163 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751202AbWGAShr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 14:37:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060701183746.WRQG19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 1 Jul 2006 14:37:46 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20060701150926.GA25800@lsrfire.ath.cx> (Rene Scharfe's message
	of "Sat, 1 Jul 2006 17:09:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23056>

I suspect this has the same problem I pointed out to Kristian's 
attempt to make git-branch a built-in.

    Subject: Re: [PATCH] Implement git-branch and git-merge-base as built-ins.
    Date: Thu, 08 Jun 2006 11:53:48 -0700
    Message-ID: <7vverbsclf.fsf@assigned-by-dhcp.cox.net>

Namely, merge-base code is not set up to be called more than
once without cleaning things up.
