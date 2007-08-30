From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] git-filter-branch: more detailed USAGE
Date: Thu, 30 Aug 2007 17:56:07 +0200
Message-ID: <11884893671845-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 18:06:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQmUl-0005Km-BG
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 18:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757877AbXH3QDn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 12:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757842AbXH3QDn
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 12:03:43 -0400
Received: from joe.tiscali.it ([213.205.33.54]:38058 "EHLO joe.tiscali.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756959AbXH3QDn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 12:03:43 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Aug 2007 12:03:42 EDT
Received: from localhost.localdomain (84.221.55.162) by joe.tiscali.it (7.3.122)
        id 46A8A46B00370FFB; Thu, 30 Aug 2007 17:57:45 +0200
X-Mailer: git-send-email 1.5.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57049>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-filter-branch.sh |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 0190060..9fcab56 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -8,7 +8,16 @@
 # a new branch. You can specify a number of filters to modify the commits,
 # files and trees.
 
-USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] [REV-RANGE]"
+USAGE="[-d <tempdir>] \
+[--env-filter <command>] \
+[--tree-filter <command>] \
+[--index-filter <command>] \
+[--parent-filter <command>] \
+[--msg-filter <command>] \
+[--commit-filter <command>] \
+[--tag-name-filter <command>] \
+[--subdirectory-filter <command>] \
+[--original <namespace>] [rev-range]"
 . git-sh-setup
 
 warn () {
-- 
1.5.2.5
