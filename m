From: Junio C Hamano <junkio@cox.net>
Subject: [RFH] Solaris cloning woes...
Date: Tue, 04 Apr 2006 01:47:52 -0700
Message-ID: <7vu099916v.fsf@assigned-by-dhcp.cox.net>
References: <7vy7yol0nk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Tue Apr 04 10:48:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQhCj-0005Na-P7
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 10:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWDDIrz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 04:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWDDIry
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 04:47:54 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:46513 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932397AbWDDIry (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 04:47:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060404084753.TLMS3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Apr 2006 04:47:53 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18378>

The sigaction() patch cooked by Linus and Jason are in "next",
to fix pack-objects breakage started between 1.2.2 and 1.2.3.

Once this is confirmed to fix the problem on Solaris boxes, I'd
like to include and do an 1.2.5, just in case OpenSolaris folks
would want to play with it, and also put them in the "master"
branch.

I have an access to a not-so-well-maintained Solaris box at
work, and built the relevant parts with somewhat stripped down
configuration to run the test.  The "master" version without the
sigaction() patches exhibits the symptom Oejet and I observed
the other night, and "next" seems to fix it.  I am reasonably
happy.
