From: Junio C Hamano <junkio@cox.net>
Subject: [NOTE] minor breakages here and there in "next"
Date: Thu, 21 Sep 2006 13:00:39 -0700
Message-ID: <7vfyel7zx4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 21 22:02:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQUiy-0006cB-28
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 22:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWIUUAl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 16:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWIUUAk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 16:00:40 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:16373 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751500AbWIUUAk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 16:00:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060921200039.DSPU6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Sep 2006 16:00:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id R80f1V0041kojtg0000000
	Thu, 21 Sep 2006 16:00:39 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27502>

I am at day-job today but have noticed a couple more minor
breakages coming from the resolve_ref() clean-up done recently
in "next".  Nothing serious or major, but would be nice to fix.

 - git-show-branch does not use '*' for the column for the
   current branch anymore.

 - "git update-index -g" updates everything, not just things
   already different from HEAD.

The latter I think is probably read_ref() around l.446 in
builtin-update-index.c
