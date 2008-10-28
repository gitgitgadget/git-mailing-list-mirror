From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Tue, 28 Oct 2008 16:59:28 -0700
Message-ID: <1225238368-98594-1-git-send-email-dsymonds@gmail.com>
References: <1225237145-95435-1-git-send-email-dsymonds@gmail.com>
Cc: David Symonds <dsymonds@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 29 01:01:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuyUj-0007DP-0M
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 01:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbYJ1X7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 19:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbYJ1X7w
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 19:59:52 -0400
Received: from smtp-out.google.com ([216.239.33.17]:46170 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbYJ1X7v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 19:59:51 -0400
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com [172.24.198.77])
	by smtp-out.google.com with ESMTP id m9SNxXp8026705;
	Tue, 28 Oct 2008 23:59:36 GMT
Received: from localhost.localdomain (dhcp-172-19-79-244.mtv.corp.google.com [172.19.79.244])
	by wpaz13.hot.corp.google.com with ESMTP id m9SNxSor028976;
	Tue, 28 Oct 2008 16:59:28 -0700
X-Mailer: git-send-email 1.6.0
In-Reply-To: <1225237145-95435-1-git-send-email-dsymonds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99335>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 .gitignore    |    1 +
 Makefile      |    1 +
 git-staged.sh |    2 ++
 3 files changed, 4 insertions(+), 0 deletions(-)
 create mode 100755 git-staged.sh

diff --git a/.gitignore b/.gitignore
index bbaf9de..9353d19 100644
--- a/.gitignore
+++ b/.gitignore
@@ -118,6 +118,7 @@ git-show
 git-show-branch
 git-show-index
 git-show-ref
+git-staged
 git-stash
 git-status
 git-stripspace
diff --git a/Makefile b/Makefile
index d6f3695..1b23e53 100644
--- a/Makefile
+++ b/Makefile
@@ -262,6 +262,7 @@ SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-sh-setup.sh
+SCRIPT_SH += git-staged.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
diff --git a/git-staged.sh b/git-staged.sh
new file mode 100755
index 0000000..85582ec
--- /dev/null
+++ b/git-staged.sh
@@ -0,0 +1,2 @@
+#!/bin/sh
+exec git diff --cached $*
-- 
1.6.0
