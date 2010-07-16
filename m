From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 1/5] Documentation/git-reset: reorder modes for soft-mixed-hard progression
Date: Fri, 16 Jul 2010 11:44:38 +0200
Message-ID: <53e88b5a527fc4fc97750bbfbd74077ef699351a.1279273256.git.trast@student.ethz.ch>
References: <cover.1279273256.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 16 11:45:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZhTk-0000Fo-Sv
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 11:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857Ab0GPJpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 05:45:05 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:43493 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964795Ab0GPJpE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 05:45:04 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 16 Jul
 2010 11:45:03 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 16 Jul
 2010 11:44:42 +0200
X-Mailer: git-send-email 1.7.2.rc3.259.g43154
In-Reply-To: <cover.1279273256.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151139>

Reorder the documetation so that the soft/mixed/hard modes are in this
order.  This way they form a natural progression towards changing more
of the state.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-reset.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 645f0c1..dbb810d 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -8,7 +8,7 @@ git-reset - Reset current HEAD to the specified state
 SYNOPSIS
 --------
 [verse]
-'git reset' [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]
+'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]
 'git reset' [-q] [<commit>] [--] <paths>...
 'git reset' --patch [<commit>] [--] [<paths>...]
 
@@ -31,17 +31,17 @@ HEAD.
 
 OPTIONS
 -------
---mixed::
-	Resets the index but not the working tree (i.e., the changed files
-	are preserved but not marked for commit) and reports what has not
-	been updated. This is the default action.
-
 --soft::
 	Does not touch the index file nor the working tree at all, but
 	requires them to be in a good order. This leaves all your changed
 	files "Changes to be committed", as 'git status' would
 	put it.
 
+--mixed::
+	Resets the index but not the working tree (i.e., the changed files
+	are preserved but not marked for commit) and reports what has not
+	been updated. This is the default action.
+
 --hard::
 	Matches the working tree and index to that of the tree being
 	switched to. Any changes to tracked files in the working tree
-- 
1.7.2.rc3.259.g43154
