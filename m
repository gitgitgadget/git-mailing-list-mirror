From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCHv2 1/2] git-svn.txt: move option descriptions
Date: Tue, 26 Apr 2011 13:34:18 +0200
Message-ID: <1303817659-26541-2-git-send-email-valentin.haenel@gmx.de>
References: <20110425210623.GB13953@dcvr.yhbt.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Valentin Haenel <valentin.haenel@gmx.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 13:35:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEgYY-0004LU-CR
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 13:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab1DZLfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 07:35:46 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:55626 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349Ab1DZLfp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 07:35:45 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p3QBYbEo026626;
	Tue, 26 Apr 2011 13:34:37 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p3QBYbwG026625;
	Tue, 26 Apr 2011 13:34:37 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <20110425210623.GB13953@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172087>

The options '---use-log-author' and '--add-author-from' are applicable to other
subcommands except 'fetch' -- therefore move them from the 'fetch' section to
the more general 'options' section

Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
Acked-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index c07b2ad..ba8a95e 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -145,17 +145,6 @@ Skip "branches" and "tags" of first level directories;;
 ------------------------------------------------------------------------
 --
 
---use-log-author;;
-	When retrieving svn commits into git (as part of fetch, rebase, or
-	dcommit operations), look for the first From: or Signed-off-by: line
-	in the log message and use that as the author string.
---add-author-from;;
-	When committing to svn from git (as part of 'commit-diff', 'set-tree' or 'dcommit'
-	operations), if the existing log message doesn't already have a
-	From: or Signed-off-by: line, append a From: line based on the
-	git commit's author string.  If you use this, then --use-log-author
-	will retrieve a valid author string for all commits.
-
 'clone'::
 	Runs 'init' and 'fetch'.  It will automatically create a
 	directory based on the basename of the URL passed to it;
@@ -574,6 +563,17 @@ repository that will be fetched from.
 For 'branch' and 'tag', display the urls that will be used for copying when
 creating the branch or tag.
 
+--use-log-author::
+	When retrieving svn commits into git (as part of fetch, rebase, or
+	dcommit operations), look for the first From: or Signed-off-by: line
+	in the log message and use that as the author string.
+--add-author-from::
+	When committing to svn from git (as part of 'commit-diff', 'set-tree' or 'dcommit'
+	operations), if the existing log message doesn't already have a
+	From: or Signed-off-by: line, append a From: line based on the
+	git commit's author string.  If you use this, then --use-log-author
+	will retrieve a valid author string for all commits.
+
 
 ADVANCED OPTIONS
 ----------------
-- 
1.7.1
