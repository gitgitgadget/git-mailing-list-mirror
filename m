From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Sun, 29 Apr 2007 11:33:14 -0700
Message-ID: <7v3b2jdo9h.fsf@assigned-by-dhcp.cox.net>
References: <11776622643106-git-send-email-junkio@cox.net>
	<11776622643639-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 29 20:33:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiED1-0002Yn-Nx
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 20:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031010AbXD2SdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 14:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031071AbXD2SdQ
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 14:33:16 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:62014 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031010AbXD2SdP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 14:33:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070429183315.UDBB1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 29 Apr 2007 14:33:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id t6ZE1W00M1kojtg0000000; Sun, 29 Apr 2007 14:33:15 -0400
X-master-at: a07157ac624b2524a059a3414e99f6f44bebc1e7
X-next-at: 58684fff8eb18ff7b1036fcf3398fcf43d83040b
In-Reply-To: <11776622643639-git-send-email-junkio@cox.net> (Junio C. Hamano's
	message of "Fri, 27 Apr 2007 01:24:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45830>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

Well, everything meant for v1.5.2 is in 'master' now.  There is
nothing to see here.

* jc/blame (Fri Apr 20 16:25:50 2007 -0700) 4 commits
 - blame: show log as it goes
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up
* lt/objalloc (Mon Apr 16 22:13:09 2007 -0700) 1 commit
 - Make the object lookup hash use a "object index" instead of a
   pointer
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel
