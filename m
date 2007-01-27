From: Bill Lear <rael@zopyra.com>
Subject: [PATCH] Document --check option to git diff.
Date: Sat, 27 Jan 2007 07:21:53 -0600
Message-ID: <11699041133940-git-send-email-rael@zopyra.com>
Cc: Bill Lear <rael@zopyra.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 27 14:21:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAnVH-0005Y2-DV
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 14:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbXA0NVz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 08:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbXA0NVz
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 08:21:55 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60175 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246AbXA0NVy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 08:21:54 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0RDLs632503;
	Sat, 27 Jan 2007 07:21:54 -0600
X-Mailer: git-send-email 1.4.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37953>


Signed-off-by: Bill Lear <rael@zopyra.com>
---
 Documentation/SubmittingPatches |    3 ++-
 Documentation/diff-options.txt  |    4 ++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 41b76d8..ce85d06 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -23,7 +23,8 @@ probably need to split up your commit to
 
 Oh, another thing.  I am picky about whitespaces.  Make sure your
 changes do not trigger errors with the sample pre-commit hook shipped
-in templates/hooks--pre-commit.
+in templates/hooks--pre-commit.  To help ensure this does not happen,
+run git diff --check on your changes before you commit.
 
 
 (2) Generate your patch using git tools out of your commits.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index da1cc60..019a39f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -58,6 +58,10 @@
 	Turn off rename detection, even when the configuration
 	file gives the default to do so.
 
+--check::
+	Warn if changes introduce trailing whitespace
+	or an indent that uses a space before a tab.
+
 --full-index::
 	Instead of the first handful characters, show full
 	object name of pre- and post-image blob on the "index"
-- 
1.4.4.1
