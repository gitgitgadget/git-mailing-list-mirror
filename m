From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 3/8] Test diff --dirstat functionality
Date: Thu, 19 Feb 2009 12:13:37 +0100
Message-ID: <dffae171f72e565d4202e3d4bc0dad05bba8570d.1235041345.git.trast@student.ethz.ch>
References: <cover.1235041345.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 12:16:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La6sw-0000Pm-1r
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 12:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbZBSLOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 06:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752990AbZBSLOB
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 06:14:01 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16533 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635AbZBSLN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 06:13:59 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:53 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:52 +0100
X-Mailer: git-send-email 1.6.2.rc1.266.gce6c4
In-Reply-To: <cover.1235041345.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 19 Feb 2009 11:13:52.0571 (UTC) FILETIME=[2595B8B0:01C99283]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110674>

This is only a very rudimentary test, but it was untested before.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Same as v1.

 t/t4013-diff-various.sh                       |    1 +
 t/t4013/diff.diff_--dirstat_master~1_master~2 |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)
 create mode 100644 t/t4013/diff.diff_--dirstat_master~1_master~2

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 9c70902..0289336 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -268,6 +268,7 @@ diff --no-index --name-status dir2 dir
 diff --no-index --name-status -- dir2 dir
 diff --no-index dir dir3
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
1.6.2.rc1.266.gce6c4
