From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCH 2/2] git-svn.txt: small typeface improvements
Date: Fri, 22 Apr 2011 19:03:39 +0200
Message-ID: <1303491819-9850-3-git-send-email-valentin.haenel@gmx.de>
References: <1303491819-9850-1-git-send-email-valentin.haenel@gmx.de>
Cc: Eric Wong <normalperson@yhbt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Valentin Haenel <valentin.haenel@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 19:17:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDJyj-0004bT-R4
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 19:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292Ab1DVRRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2011 13:17:08 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:58826 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756208Ab1DVRRG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2011 13:17:06 -0400
X-Greylist: delayed 746 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Apr 2011 13:17:04 EDT
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p3MH4WhB009929;
	Fri, 22 Apr 2011 19:04:32 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p3MH4WaD009928;
	Fri, 22 Apr 2011 19:04:32 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1303491819-9850-1-git-send-email-valentin.haenel@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171939>

Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
---
 Documentation/git-svn.txt |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index e12f9f8..5c75d71 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -562,14 +562,15 @@ For 'branch' and 'tag', display the urls that will be used for copying when
 creating the branch or tag.
 
 --use-log-author::
-	When retrieving svn commits into git (as part of fetch, rebase, or
-	dcommit operations), look for the first From: or Signed-off-by: line
+	When retrieving svn commits into git (as part of 'fetch', 'rebase', or
+	'dcommit' operations), look for the first `From:` or `Signed-off-by:` line
 	in the log message and use that as the author string.
---add-author-from::
 	When committing to svn from git (as part of commit or dcommit
+--add-author-from::
+	When committing to svn from git (as part of 'commit' or 'dcommit'
 	operations), if the existing log message doesn't already have a
-	From: or Signed-off-by: line, append a From: line based on the
-	git commit's author string.  If you use this, then --use-log-author
+	`From:` or `Signed-off-by:` line, append a `From:` line based on the
+	git commit's author string.  If you use this, then `--use-log-author`
 	will retrieve a valid author string for all commits.
 
 
-- 
1.7.1
