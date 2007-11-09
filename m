From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] git-push: add documentation for the newly add --mirror mode
Date: Fri, 9 Nov 2007 15:01:07 -0000
Message-ID: <1194620467.0@pinky>
References: <1194619555.0@pinky>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 16:01:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqVMB-0003oy-E3
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 16:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758969AbXKIPA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 10:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754431AbXKIPA7
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 10:00:59 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:1104 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754123AbXKIPA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 10:00:58 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1IqVLs-0001Th-7t
	for git@vger.kernel.org; Fri, 09 Nov 2007 15:00:56 +0000
InReply-To: <1194619555.0@pinky>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64195>


Add some basic documentation on the --mirror mode for git-push.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 Documentation/git-push.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index e5dd4c1..2403621 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -62,6 +62,14 @@ the remote repository.
 \--all::
 	Instead of naming each ref to push, specifies that all
 	refs under `$GIT_DIR/refs/heads/` be pushed.
+	
+\--mirror::
+	Instead of naming each ref to push, specifies that all
+	refs under `$GIT_DIR/refs/heads/` and `$GIT_DIR/refs/tags/`
+	be mirrored to the remote repository.  Newly created local
+	refs will be pushed to the remote end, locally updated refs
+	will be force updated on the remote end, and deleted refs
+	will be removed from the remote end.
 
 \--dry-run::
 	Do everything except actually send the updates.
