From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/3] Better document the original repository layout.
Date: Fri,  4 Dec 2009 15:36:28 +0100
Message-ID: <91462ec5e4409e558ec5158b7dea33ebf0081d3e.1259934977.git.mhagger@alum.mit.edu>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 15:37:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGZHI-0005g2-79
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 15:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbZLDOgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 09:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbZLDOgu
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 09:36:50 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:45770 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbZLDOgu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 09:36:50 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (ssh.berlin.jpk.com [212.222.128.135])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id nB4EafCe020736;
	Fri, 4 Dec 2009 15:36:53 +0100
X-Mailer: git-send-email 1.6.5.4
In-Reply-To: <cover.1259934977.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1259934977.git.mhagger@alum.mit.edu>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134511>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t3404-rebase-interactive.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3a37793..073674f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -16,13 +16,14 @@ set_fake_editor
 
 # set up two branches like this:
 #
-# A - B - C - D - E
+# A - B - C - D - E     (master)
 #   \
-#     F - G - H
+#     F - G - H         (branch1)
 #       \
-#         I
+#         I             (branch2)
 #
-# where B, D and G touch the same file.
+# where B, D and G touch the same file.  In addition, set tags at
+# points A, F, and I.
 
 test_expect_success 'setup' '
 	: > file1 &&
-- 
1.6.5.4
