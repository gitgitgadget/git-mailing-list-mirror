From: sgm <sim0629@gmail.com>
Subject: [PATCH] Documentation: fix indentation in git-svn.txt
Date: Sun, 11 Aug 2013 00:16:31 +0900
Message-ID: <1376147791-13906-1-git-send-email-sim0629@gmail.com>
Cc: sgm <sim0629@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 10 17:17:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8Aug-0000ev-ML
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 17:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934387Ab3HJPQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 11:16:57 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:62672 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934153Ab3HJPQz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 11:16:55 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so5962630pab.11
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 08:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=IKz2CCoJ4b4pXq0VSCI2IJLpIZwp/mTdsBkcX2T7HhE=;
        b=UaMEmvEMxWt7PsV7B6r2C7jfyIjTp/FkFVZl7DTcuC6d2wXLviL0Y3hdxOPCFl1Z2q
         1DwciQ6VLpt0CqiEbR19C4rWzZJvwgkOGDfPeB9jl2rZfkXWCBnyhwqZmt5mZxfUmwCh
         WbrkbdTgQSKiL6sHv8CkaRGFC90y8ZbW7PYF40/Lvg9+24wVA0NJNgGsP3c/UHLmDGcK
         bSimp6Zpy1bY8/mzW96sIhwMKJFWKjFRalRkz85X2+W8m9bmY9DQVIS76M/ftulDAj7N
         Aeor1taqYxi+DjrEjElmQWhiIouNBgEsv8ncsCbD1V1yiBLNGJe5gDXwOd8IskD5+NMV
         gpaw==
X-Received: by 10.66.119.196 with SMTP id kw4mr16642144pab.164.1376147815447;
        Sat, 10 Aug 2013 08:16:55 -0700 (PDT)
Received: from neria.kr ([183.101.170.51])
        by mx.google.com with ESMTPSA id ot4sm28960310pac.17.2013.08.10.08.16.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 10 Aug 2013 08:16:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232100>

The indentation should be tab not spaces.

Signed-off-by: sgm <sim0629@gmail.com>
---
 Documentation/git-svn.txt | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 4dd3bcb..c13d0ed 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -159,11 +159,11 @@ Skip "branches" and "tags" of first level directories;;
 	precedence over '--include-paths'.
 
 --log-window-size=<n>;;
-    Fetch <n> log entries per request when scanning Subversion history.
-    The default is 100. For very large Subversion repositories, larger
-    values may be needed for 'clone'/'fetch' to complete in reasonable
-    time. But overly large values may lead to higher memory usage and
-    request timeouts.
+	Fetch <n> log entries per request when scanning Subversion history.
+	The default is 100. For very large Subversion repositories, larger
+	values may be needed for 'clone'/'fetch' to complete in reasonable
+	time. But overly large values may lead to higher memory usage and
+	request timeouts.
 
 'clone'::
 	Runs 'init' and 'fetch'.  It will automatically create a
@@ -256,7 +256,7 @@ first have already been pushed into SVN.
 	For each patch, one may answer "yes" (accept this patch), "no" (discard this
 	patch), "all" (accept all patches), or "quit".
 	+
-       'git svn dcommit' returns immediately if answer is "no" or "quit", without
+	'git svn dcommit' returns immediately if answer is "no" or "quit", without
 	committing anything to SVN.
 
 'branch'::
@@ -347,12 +347,12 @@ environment). This command has the same behaviour.
 Any other arguments are passed directly to 'git log'
 
 'blame'::
-       Show what revision and author last modified each line of a file. The
-       output of this mode is format-compatible with the output of
-       `svn blame' by default. Like the SVN blame command,
-       local uncommitted changes in the working tree are ignored;
-       the version of the file in the HEAD revision is annotated. Unknown
-       arguments are passed directly to 'git blame'.
+	Show what revision and author last modified each line of a file. The
+	output of this mode is format-compatible with the output of
+	`svn blame' by default. Like the SVN blame command,
+	local uncommitted changes in the working tree are ignored;
+	the version of the file in the HEAD revision is annotated. Unknown
+	arguments are passed directly to 'git blame'.
 +
 --git-format;;
 	Produce output in the same format as 'git blame', but with
@@ -506,7 +506,7 @@ OPTIONS
 
 -r <arg>::
 --revision <arg>::
-	   Used with the 'fetch' command.
+	Used with the 'fetch' command.
 +
 This allows revision ranges for partial/cauterized history
 to be supported.  $NUMBER, $NUMBER1:$NUMBER2 (numeric ranges),
@@ -810,7 +810,7 @@ Tracking and contributing to an entire Subversion-managed project
 # View all branches and tags you have cloned:
 	git branch -r
 # Create a new branch in SVN
-    git svn branch waldo
+	git svn branch waldo
 # Reset your master to trunk (or any other branch, replacing 'trunk'
 # with the appropriate name):
 	git reset --hard remotes/trunk
-- 
1.8.1.2
