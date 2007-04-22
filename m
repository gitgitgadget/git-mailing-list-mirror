From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Sat, 21 Apr 2007 23:24:19 -0700
Message-ID: <7vejmdq63w.fsf@assigned-by-dhcp.cox.net>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
	<7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
	<7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 08:24:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfVUm-0004Gk-NQ
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 08:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbXDVGYV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 02:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbXDVGYV
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 02:24:21 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:49127 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964792AbXDVGYU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 02:24:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422062420.HYLX1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 02:24:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id q6QK1W00G1kojtg0000000; Sun, 22 Apr 2007 02:24:20 -0400
X-master-at: 42c4b58059fa9af65e90f2c418bb551e30d1d32f
X-next-at: 280f4b4203d05113c2d1f5bf214d7668af9330e3
In-Reply-To: <7v647tcjr6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 18 Apr 2007 17:04:13 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45221>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* jc/attr (Sat Apr 21 19:09:02 2007 -0700) 2 commits
 - Add 'ident' conversion.
 - Add 'filter' attribute and external filter driver definition.

This is the remaining "controversial" bits.

* lt/objalloc (Mon Apr 16 22:13:09 2007 -0700) 1 commit
 . Make the object lookup hash use a "object index" instead of a
   pointer
* jc/the-index (Sun Apr 1 23:26:07 2007 -0700) 2 commits
 - Make read-cache.c "the_index" free.
 - Move index-related variables into a structure.
* jc/blame (Tue Mar 27 01:58:01 2007 -0700) 4 commits
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up
 - blame -s: suppress author name and time.
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

The rest are stalled.
