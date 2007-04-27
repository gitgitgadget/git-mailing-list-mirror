From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Fri, 27 Apr 2007 01:24:24 -0700
Message-ID: <11776622643639-git-send-email-junkio@cox.net>
References: <11776622643106-git-send-email-junkio@cox.net>
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 10:24:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhLkn-0003A5-PN
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 10:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547AbXD0IY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 04:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755550AbXD0IY3
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 04:24:29 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:49094 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547AbXD0IYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 04:24:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427082424.LIZD1226.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Fri, 27 Apr 2007 04:24:24 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id s8QQ1W0031kojtg0000100; Fri, 27 Apr 2007 04:24:24 -0400
X-Mailer: git-send-email 1.5.2.rc0.758.g0818
In-Reply-To: <11776622643106-git-send-email-junkio@cox.net>
X-master-at: 4342572600f446b9f8db553df03d458229f944dd
X-next-at: 0818190177e8db9470b3d76953aad69ff29b7a70
References: <7v647ninbq.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45699>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* jc/attr (Sat Apr 21 03:14:13 2007 -0700) 2 commits
 + Add 'filter' attribute and external filter driver definition.
 + Add 'ident' conversion.

As two people on the list whose judgement on design issues I
trust both say "give them rope is Ok", perhaps I should push
this out to 'master' before v1.5.2-rc1.  I am still worried
about the rope being too long, though, and tried to describe the
intent and limitation in the documentation to prevent users from
hurting themselves, but I do not think the descriptions I have
are good enough yet.

* jc/blame (Fri Apr 27 00:42:15 2007 -0700) 7 commits
 - Apply mailmap in git-blame output.
 - Split out mailmap handling out of shortlog
 - blame: show log as it goes
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up
 - blame -s: suppress author name and time.

In addition to the update to use .mailmap, this has the "log"
output that uses the blame machinery Linus suggested.  I think I
know what more are needed to make it more pleasant to use, but
the necessary changes seem a bit too involved.  I might advance
the topic a bit more during the stabilization period for v1.5.2,
but I am planning to leave the actual merge until v1.5.3 cycle.

* lt/objalloc (Mon Apr 16 22:13:09 2007 -0700) 1 commit
 - Make the object lookup hash use a "object index" instead of a
   pointer
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

These are stalled.
