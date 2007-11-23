From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] Mention that git-rm can be an appropriate resolution as well as git-add.
Date: Sat, 24 Nov 2007 00:38:50 +1100
Message-ID: <11958251302874-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org, David Symonds <dsymonds@gmail.com>
To: Junio Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 14:39:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvYkX-00057v-TX
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 14:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827AbXKWNi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 08:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755624AbXKWNi7
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 08:38:59 -0500
Received: from ipmail05.adl2.internode.on.net ([203.16.214.145]:22462 "EHLO
	ipmail05.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753252AbXKWNi6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Nov 2007 08:38:58 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAI1mRkd5LDXQ/2dsb2JhbACBWw
X-IronPort-AV: E=Sophos;i="4.21,456,1188743400"; 
   d="scan'208";a="528407"
Received: from ppp121-44-53-208.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.53.208])
  by ipmail05.adl2.internode.on.net with ESMTP; 24 Nov 2007 00:08:56 +1030
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65899>

Especially when using git-cherry-pick, removing files that are unmerged can be
a logical action. This patch merely changes the informative text to be less
confusing.

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 builtin-revert.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 365b330..d9ed40d 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -366,7 +366,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			die ("Error wrapping up %s", defmsg);
 		fprintf(stderr, "Automatic %s failed.  "
 			"After resolving the conflicts,\n"
-			"mark the corrected paths with 'git add <paths>' "
+			"mark the corrected paths with 'git add <paths>' or 'git rm <paths>' "
 			"and commit the result.\n", me);
 		if (action == CHERRY_PICK) {
 			fprintf(stderr, "When commiting, use the option "
-- 
1.5.3.1
