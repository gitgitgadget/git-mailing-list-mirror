From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 1/5] Documentation/git-reset: reorder modes for soft-mixed-hard progression
Date: Sun, 18 Jul 2010 20:23:22 +0200
Message-ID: <e1b0c4024710394a5c9787c95f479a827ba18591.1279477130.git.trast@student.ethz.ch>
References: <cover.1279477130.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 18 20:24:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaYWy-0002SZ-Sq
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 20:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756941Ab0GRSXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 14:23:36 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:9242 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756927Ab0GRSXc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 14:23:32 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 18 Jul
 2010 20:23:31 +0200
Received: from localhost.localdomain (129.132.209.162) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 18 Jul
 2010 20:23:30 +0200
X-Mailer: git-send-email 1.7.2.rc3.317.gc287
In-Reply-To: <cover.1279477130.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151232>

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
1.7.2.rc3.317.gc287
