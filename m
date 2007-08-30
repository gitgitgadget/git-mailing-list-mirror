From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] git-filter-branch: more detailed USAGE
Date: Thu, 30 Aug 2007 19:10:41 +0200
Message-ID: <1188493842963-git-send-email-giuseppe.bilotta@gmail.com>
References: <11884893671845-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 19:12:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQnZD-0000EQ-3j
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 19:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757539AbXH3RMX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 13:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbXH3RMX
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 13:12:23 -0400
Received: from averell.tiscali.it ([213.205.33.55]:32932 "EHLO
	averell.tiscali.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757460AbXH3RMW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 13:12:22 -0400
Received: from localhost.localdomain (84.221.55.162) by averell.tiscali.it (7.3.122)
        id 468D1A8000670722; Thu, 30 Aug 2007 19:12:20 +0200
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <11884893671845-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57055>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-filter-branch.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 0190060..ec2f75d 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -8,7 +8,13 @@
 # a new branch. You can specify a number of filters to modify the commits,
 # files and trees.
 
-USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] [REV-RANGE]"
+USAGE="[--env-filter <command>] [--tree-filter <command>] \
+[--index-filter <command>] [--parent-filter <command>] \
+[--msg-filter <command>] [--commit-filter <command>] \
+[--tag-name-filter <command>] [--subdirectory-filter <directory>] \
+[--original <namespace>] [-d <directory>] [-f | --force] \
+[<rev-list options>...]"
+
 . git-sh-setup
 
 warn () {
-- 
1.5.2.5
