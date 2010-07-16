From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 5/5] Documentation/reset: move "undo permanently" example behind "make topic"
Date: Fri, 16 Jul 2010 11:44:42 +0200
Message-ID: <acd131cb3c2f6f7d4aca2c53738fb458380bb8c9.1279273256.git.trast@student.ethz.ch>
References: <cover.1279273256.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 16 11:45:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZhU7-0000Rd-BN
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 11:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871Ab0GPJpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 05:45:22 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:43493 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964864Ab0GPJpI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 05:45:08 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 16 Jul
 2010 11:45:03 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 16 Jul
 2010 11:44:43 +0200
X-Mailer: git-send-email 1.7.2.rc3.259.g43154
In-Reply-To: <cover.1279273256.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151143>

I consider the latter usage more important.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-reset.txt |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index ce08581..34da771 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -127,19 +127,6 @@ edit the message further, you can give -C option instead.
 +
 See also the --amend option to linkgit:git-commit[1].
 
-Undo commits permanently::
-+
-------------
-$ git commit ...
-$ git reset --hard HEAD~3   <1>
-------------
-+
-<1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad
-and you do not want to ever see them again.  Do *not* do this if
-you have already given these commits to somebody else.  (See the
-"RECOVERING FROM UPSTREAM REBASE" section in linkgit:git-rebase[1] for
-the implications of doing so.)
-
 Undo a commit, making it a topic branch::
 +
 ------------
@@ -155,6 +142,19 @@ current HEAD.
 <2> Rewind the master branch to get rid of those three commits.
 <3> Switch to "topic/wip" branch and keep working.
 
+Undo commits permanently::
++
+------------
+$ git commit ...
+$ git reset --hard HEAD~3   <1>
+------------
++
+<1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad
+and you do not want to ever see them again.  Do *not* do this if
+you have already given these commits to somebody else.  (See the
+"RECOVERING FROM UPSTREAM REBASE" section in linkgit:git-rebase[1] for
+the implications of doing so.)
+
 Undo a merge or pull::
 +
 ------------
-- 
1.7.2.rc3.259.g43154
