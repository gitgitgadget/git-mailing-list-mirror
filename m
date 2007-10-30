From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Bisect: add "skip" to the short usage string.
Date: Tue, 30 Oct 2007 05:40:58 +0100
Message-ID: <20071030054058.ecf79b4f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 05:35:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImipT-0000nA-K4
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 05:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbXJ3EeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 00:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbXJ3EeI
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 00:34:08 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:41218 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbXJ3EeH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 00:34:07 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 09D0C1AB2B5;
	Tue, 30 Oct 2007 05:34:04 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id C82E41AB2B8;
	Tue, 30 Oct 2007 05:34:03 +0100 (CET)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62659>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

	This is an alternative patch to the previous one
	with the same name.

	Here I put "skip" just after "bad" and "good" as
	suggested by David Symonds, both in the short and
	long usage string.

diff --git a/git-bisect.sh b/git-bisect.sh
index 180c6c2..b74f44d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,12 +1,14 @@
 #!/bin/sh
 
-USAGE='[start|bad|good|next|reset|visualize|replay|log|run]'
+USAGE='[start|bad|good|skip|next|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
         reset bisect state and start bisection.
 git bisect bad [<rev>]
         mark <rev> a known-bad revision.
 git bisect good [<rev>...]
         mark <rev>... known-good revisions.
+git bisect skip [<rev>...]
+        mark <rev>... untestable revisions.
 git bisect next
         find next bisection to test and check it out.
 git bisect reset [<branch>]
@@ -17,8 +19,6 @@ git bisect replay <logfile>
         replay bisection log.
 git bisect log
         show bisect log.
-git bisect skip [<rev>...]
-        mark <rev>... untestable revisions.
 git bisect run <cmd>...
         use <cmd>... to automatically bisect.'
 
-- 
1.5.3.4.1405.g6c7bae
