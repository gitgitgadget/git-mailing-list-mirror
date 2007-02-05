From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Use light orange for remote branches
Date: Sun, 04 Feb 2007 22:14:48 -0500
Message-ID: <20070205031448.4013.34275.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 05 04:14:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDuJg-000791-5z
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 04:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbXBEDOv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 22:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbXBEDOu
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 22:14:50 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:35575 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbXBEDOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 22:14:50 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HDuIZ-0005iY-2i
	for git@vger.kernel.org; Sun, 04 Feb 2007 22:13:43 -0500
Received: from localhost ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HDuJc-00013B-MH; Sun, 04 Feb 2007 22:14:48 -0500
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 src/common.h          |    1 +
 src/listview.cpp      |    2 +-
 src/namespace_def.cpp |    1 +
 3 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/common.h b/src/common.h
index 500545f..6799fe6 100644
--- a/src/common.h
+++ b/src/common.h
@@ -161,6 +161,7 @@ namespace QGit {
 	extern const QColor BROWN;
 	extern const QColor ORANGE;
 	extern const QColor DARK_ORANGE;
+	extern const QColor LIGHT_ORANGE;
 	extern const QColor LIGHT_BLUE;
 	extern const QColor PURPLE;
 	extern const QColor DARK_GREEN;
diff --git a/src/listview.cpp b/src/listview.cpp
index 80043e9..ef0bfe4 100644
--- a/src/listview.cpp
+++ b/src/listview.cpp
@@ -636,7 +636,7 @@ void ListViewItem::paintTagMarks(int col) {
 		addBranchPixmap(&newPm);
 
 	if (rt & Git::RMT_BRANCH)
-		addRefPixmap(&newPm, git->getRefName(_sha, Git::RMT_BRANCH), ORANGE);
+		addRefPixmap(&newPm, git->getRefName(_sha, Git::RMT_BRANCH), LIGHT_ORANGE);
 
 	if (rt & Git::TAG)
 		addRefPixmap(&newPm, git->getRefName(_sha, Git::TAG), Qt::yellow);
diff --git a/src/namespace_def.cpp b/src/namespace_def.cpp
index ffc6b32..a5049ba 100644
--- a/src/namespace_def.cpp
+++ b/src/namespace_def.cpp
@@ -22,6 +22,7 @@ const QString QGit::GIT_VERSION = "1.4.4";
 const QColor QGit::BROWN       = QColor(150, 75, 0);
 const QColor QGit::ORANGE      = QColor(255, 160, 50);
 const QColor QGit::DARK_ORANGE = QColor(216, 144, 0);
+const QColor QGit::LIGHT_ORANGE = QColor(255, 221, 170);
 const QColor QGit::LIGHT_BLUE  = QColor(85, 255, 255);
 const QColor QGit::PURPLE      = QColor(221, 221, 255);
 const QColor QGit::DARK_GREEN  = QColor(0, 205, 0);
