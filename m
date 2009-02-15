From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/8] Test diff --dirstat functionality
Date: Sun, 15 Feb 2009 23:25:40 +0100
Message-ID: <74dedc1dea8500339a1c7bdc27a85a720ef3a663.1234736374.git.trast@student.ethz.ch>
References: <cover.1234736374.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 23:28:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYpSu-0004VH-Du
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 23:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbZBOW0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 17:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753456AbZBOW0F
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 17:26:05 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:11608 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbZBOW0B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 17:26:01 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:25:55 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 15 Feb 2009 23:25:54 +0100
X-Mailer: git-send-email 1.6.2.rc0.335.g1a2b
In-Reply-To: <cover.1234736374.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 15 Feb 2009 22:25:54.0381 (UTC) FILETIME=[5D9AA7D0:01C98FBC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110073>

This is only a very rudimentary test, but it was untested before.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t4013-diff-various.sh                       |    1 +
 t/t4013/diff.diff_--dirstat_master~1_master~2 |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)
 create mode 100644 t/t4013/diff.diff_--dirstat_master~1_master~2

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index aba5320..f140b9c 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -263,6 +263,7 @@ diff --name-status dir2 dir
 diff --no-index --name-status dir2 dir
 diff --no-index --name-status -- dir2 dir
 diff master master^ side
+diff --dirstat master~1 master~2
 EOF
 
 test_done
diff --git a/t/t4013/diff.diff_--dirstat_master~1_master~2 b/t/t4013/diff.diff_--dirstat_master~1_master~2
new file mode 100644
index 0000000..b672e1c
--- /dev/null
+++ b/t/t4013/diff.diff_--dirstat_master~1_master~2
@@ -0,0 +1,3 @@
+$ git diff --dirstat master~1 master~2
+  40.0% dir/
+$
-- 
1.6.2.rc0.335.g1a2b
