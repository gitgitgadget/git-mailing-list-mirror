From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 5/9] git p4 test: rename some "git-p4 command" strings
Date: Mon, 25 Jun 2012 21:18:21 -0400
Message-ID: <1340673505-10551-6-git-send-email-pw@padd.com>
References: <1340673505-10551-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 03:23:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjKVH-0004Kg-Dn
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 03:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757929Ab2FZBUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 21:20:10 -0400
Received: from honk.padd.com ([74.3.171.149]:45534 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757794Ab2FZBUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 21:20:09 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 82E122E87;
	Mon, 25 Jun 2012 18:20:08 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3EA1231383; Mon, 25 Jun 2012 21:20:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc2.72.gebb7ee5
In-Reply-To: <1340673505-10551-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200616>

Use the actual command name; git-p4 is gone.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9810-git-p4-rcs.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index c7313b0..d8bb3d0 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git-p4 rcs keywords'
+test_description='git p4 rcs keywords'
 
 . ./lib-git-p4.sh
 
@@ -147,7 +147,7 @@ test_expect_success 'scrub ko files differently' '
 	)
 '
 
-# hack; git-p4 submit should do it on its own
+# hack; git p4 submit should do it on its own
 test_expect_success 'cleanup after failure' '
 	(
 		cd "$cli" &&
@@ -193,7 +193,7 @@ test_expect_success 'do not scrub plain text' '
 	)
 '
 
-# hack; git-p4 submit should do it on its own
+# hack; git p4 submit should do it on its own
 test_expect_success 'cleanup after failure 2' '
 	(
 		cd "$cli" &&
-- 
1.7.11.rc2.72.gebb7ee5
