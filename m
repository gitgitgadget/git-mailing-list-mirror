From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Documentation/technical/api-diff.txt: correct name of diff_unmerge()
Date: Thu, 26 May 2011 13:46:56 -0700
Message-ID: <1OYUkoTZ9lnzCtR8b7JelpPejr-QfrYvT8fEnZLPLk-TdnsgvRcAtTw7sncEtReLmIdxE8dB2ikYxpOO4ViEhQ@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 26 22:56:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPhbj-0005bd-3W
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 22:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758540Ab1EZU41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 16:56:27 -0400
Received: from mail2.nrlssc.navy.mil ([128.160.25.4]:48670 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758389Ab1EZU40 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 16:56:26 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 May 2011 16:56:26 EDT
Received: by mail.nrlssc.navy.mil id p4QKo2W2028043; Thu, 26 May 2011 15:50:06 -0500
X-OriginalArrivalTime: 26 May 2011 20:47:21.0404 (UTC) FILETIME=[1C0E77C0:01CC1BE6]
X-Virus-Scanned: clamav-milter 0.95.3 at mail2
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174566>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Documentation/technical/api-diff.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-diff.txt b/Documentation/technical/api-diff.txt
index 20b0241..2d2ebc0 100644
--- a/Documentation/technical/api-diff.txt
+++ b/Documentation/technical/api-diff.txt
@@ -32,7 +32,7 @@ Calling sequence
 
 * As you find different pairs of files, call `diff_change()` to feed
   modified files, `diff_addremove()` to feed created or deleted files,
-  or `diff_unmerged()` to feed a file whose state is 'unmerged' to the
+  or `diff_unmerge()` to feed a file whose state is 'unmerged' to the
   API.  These are thin wrappers to a lower-level `diff_queue()` function
   that is flexible enough to record any of these kinds of changes.
 
@@ -50,7 +50,7 @@ Data structures
 This is the internal representation for a single file (blob).  It
 records the blob object name (if known -- for a work tree file it
 typically is a NUL SHA-1), filemode and pathname.  This is what the
-`diff_addremove()`, `diff_change()` and `diff_unmerged()` synthesize and
+`diff_addremove()`, `diff_change()` and `diff_unmerge()` synthesize and
 feed `diff_queue()` function with.
 
 * `struct diff_filepair`
-- 
1.7.4.4
