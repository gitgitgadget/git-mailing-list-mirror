From: Junio C Hamano <junkio@cox.net>
Subject: Various fixes and cleanups.
Date: Fri, 22 Jul 2005 19:08:07 -0700
Message-ID: <7vek9q8ebc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 04:08:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw9RB-0008AB-VT
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 04:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVGWCIK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 22:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVGWCIK
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 22:08:10 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:51651 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262274AbVGWCIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 22:08:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723020805.GIHJ550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 22:08:05 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'll be sending these next:

  [PATCH] Help scripts that use git-rev-parse to grok args with SP/TAB/LF
  [PATCH] git-branch: avoid getting confused by empty or nonexisting branches.
  [PATCH] Audit rev-parse users.
  [PATCH] Install tools with "make install-tools".
  [PATCH] Test framework: prettyprint the failed command.
  [PATCH] git-clone-script: store where we cloned from in .git/branches/origin

They are various minor fixes and clean-ups.
