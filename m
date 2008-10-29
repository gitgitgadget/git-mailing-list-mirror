From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Tue, 28 Oct 2008 17:44:08 -0700
Message-ID: <1225241048-99267-1-git-send-email-dsymonds@gmail.com>
References: <20081029003931.GA7291@sigill.intra.peff.net>
Cc: David Symonds <dsymonds@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 29 01:46:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuzCi-000291-FM
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 01:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbYJ2ApT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 20:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbYJ2ApT
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 20:45:19 -0400
Received: from smtp-out.google.com ([216.239.33.17]:48766 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbYJ2ApT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 20:45:19 -0400
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com [172.24.198.69])
	by smtp-out.google.com with ESMTP id m9T0iIOG028279;
	Wed, 29 Oct 2008 00:44:20 GMT
Received: from localhost.localdomain (dhcp-172-19-79-244.mtv.corp.google.com [172.19.79.244])
	by wpaz5.hot.corp.google.com with ESMTP id m9T0i93s027403;
	Tue, 28 Oct 2008 17:44:09 -0700
X-Mailer: git-send-email 1.6.0
In-Reply-To: <20081029003931.GA7291@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99339>

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
index 0000000..66a5e33
--- /dev/null
+++ b/git-staged.sh
@@ -0,0 +1,2 @@
+#!/bin/sh
+exec git diff --cached "$@"
-- 
1.6.0
