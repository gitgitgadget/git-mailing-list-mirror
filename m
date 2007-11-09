From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 4/4] git-push: add documentation for the newly added --mirror mode
Date: Fri, 9 Nov 2007 23:32:57 -0000
Message-ID: <1194651177.0@pinky>
References: <20071109233041.GC301@shadowen.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 00:33:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqdLt-0003WR-OA
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 00:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758493AbXKIXcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 18:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758234AbXKIXcr
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 18:32:47 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:3512 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757933AbXKIXcq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 18:32:46 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1IqdLB-0006d4-8r
	for git@vger.kernel.org; Fri, 09 Nov 2007 23:32:45 +0000
InReply-To: <20071109233041.GC301@shadowen.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64281>


Add some basic documentation on the --mirror mode for git-push.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 Documentation/git-push.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index e5dd4c1..3fa5992 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -63,6 +63,14 @@ the remote repository.
 	Instead of naming each ref to push, specifies that all
 	refs under `$GIT_DIR/refs/heads/` be pushed.
 
+\--mirror::
+	Instead of naming each ref to push, specifies that all
+	refs under `$GIT_DIR/refs/heads/` and `$GIT_DIR/refs/tags/`
+	be mirrored to the remote repository.  Newly created local
+	refs will be pushed to the remote end, locally updated refs
+	will be force updated on the remote end, and deleted refs
+	will be removed from the remote end.
+
 \--dry-run::
 	Do everything except actually send the updates.
 
