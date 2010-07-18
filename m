From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 5/5] Documentation/reset: move "undo permanently" example behind "make topic"
Date: Sun, 18 Jul 2010 20:23:26 +0200
Message-ID: <81de753d1130b2e29151d67494926656af3e0cee.1279477130.git.trast@student.ethz.ch>
References: <cover.1279477130.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 18 20:24:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaYX1-0002SZ-1B
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 20:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756963Ab0GRSXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 14:23:45 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:9248 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756945Ab0GRSXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 14:23:42 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 18 Jul
 2010 20:23:41 +0200
Received: from localhost.localdomain (129.132.209.162) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 18 Jul
 2010 20:23:40 +0200
X-Mailer: git-send-email 1.7.2.rc3.317.gc287
In-Reply-To: <cover.1279477130.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151235>

I consider the latter usage more important.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-reset.txt |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 1550ba2..b04d129 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -128,19 +128,6 @@ edit the message further, you can give -C option instead.
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
@@ -156,6 +143,19 @@ current HEAD.
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
1.7.2.rc3.317.gc287
