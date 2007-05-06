From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Sun, 06 May 2007 01:53:24 -0700
Message-ID: <7vd51ecozf.fsf@assigned-by-dhcp.cox.net>
References: <11776622643106-git-send-email-junkio@cox.net>
	<11776622643639-git-send-email-junkio@cox.net>
	<7v3b2jdo9h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 10:53:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkcV2-0001sg-68
	for gcvg-git@gmane.org; Sun, 06 May 2007 10:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932953AbXEFIx1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 04:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933368AbXEFIx1
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 04:53:27 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:52732 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932953AbXEFIxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 04:53:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506085324.PQEK13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 6 May 2007 04:53:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vktQ1W0051kojtg0000000; Sun, 06 May 2007 04:53:24 -0400
X-master-at: 9159afbfce955db86373dab95b5f8e31fb763dae
X-next-at: 5f84e769dce7bb881df1f7df082eecfb9b2e47b9
In-Reply-To: <7v3b2jdo9h.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 29 Apr 2007 11:33:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46321>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

As I have been sick and am mostly concentrating on fixes on
'master' anyway, there aren't much to see here.  Indeed,
'master' and 'next' still have identical trees.

* fl/cvsserver (Wed May 2 02:45:22 2007 +0200) 1 commit
 - cvsserver: Add test cases for git-cvsserver

I need to ask k.org people to install sqlite and
libdvd-sqlite-perl before I can advance this to 'next'.

* jc/blame (Fri Apr 20 16:25:50 2007 -0700) 4 commits
 - blame: show log as it goes
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up
