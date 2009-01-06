From: jidanni@jidanni.org
Subject: [PATCH] Documentation/merge-strategies.txt, diff-options: grammar
Date: Tue,  6 Jan 2009 11:52:36 +0800
Message-ID: <1231213956-14929-1-git-send-email-jidanni@jidanni.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 04:54:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK311-0008C1-Du
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 04:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbZAFDwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 22:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbZAFDwk
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 22:52:40 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:57521 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751286AbZAFDwj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2009 22:52:39 -0500
Received: from jidanni.org (122-127-36-59.dynamic.hinet.net [122.127.36.59])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id 05F48C5983;
	Mon,  5 Jan 2009 19:52:39 -0800 (PST)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104632>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/diff-options.txt     |    4 ++--
 Documentation/merge-strategies.txt |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index b432d25..9cd162f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -143,11 +143,11 @@ endif::git-format-patch[]
 	that matches other criteria, nothing is selected.
 
 --find-copies-harder::
-	For performance reasons, by default, `-C` option finds copies only
+	For performance reasons, by default, the `-C` option finds copies only
 	if the original file of the copy was modified in the same
 	changeset.  This flag makes the command
 	inspect unmodified files as candidates for the source of
-	copy.  This is a very expensive operation for large
+	the copy.  This is a very expensive operation for large
 	projects, so use it with caution.  Giving more than one
 	`-C` option has the same effect.
 
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 1276f85..3cef90a 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -11,7 +11,7 @@ resolve::
 recursive::
 	This can only resolve two heads using 3-way merge
 	algorithm.  When there are more than one common
-	ancestors that can be used for 3-way merge, it creates a
+	ancestor that can be used for 3-way merge, it creates a
 	merged tree of the common ancestors and uses that as
 	the reference tree for the 3-way merge.  This has been
 	reported to result in fewer merge conflicts without
-- 
1.6.0.6
