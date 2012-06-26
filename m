From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 4/9] git p4 test: never create default test repo
Date: Mon, 25 Jun 2012 21:18:20 -0400
Message-ID: <1340673505-10551-5-git-send-email-pw@padd.com>
References: <1340673505-10551-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 03:23:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjKVG-0004Kg-TW
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 03:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757903Ab2FZBTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 21:19:49 -0400
Received: from honk.padd.com ([74.3.171.149]:45532 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757788Ab2FZBTt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 21:19:49 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 9061C2E87;
	Mon, 25 Jun 2012 18:19:48 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 197BC31383; Mon, 25 Jun 2012 21:19:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc2.72.gebb7ee5
In-Reply-To: <1340673505-10551-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200610>


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 2693105..06d4d3a 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -2,6 +2,10 @@
 # Library code for git p4 tests
 #
 
+# p4 tests never use the top-level repo; always build/clone into
+# a subdirectory called "$git"
+TEST_NO_CREATE_REPO=NoThanks
+
 . ./test-lib.sh
 
 if ! test_have_prereq PYTHON; then
-- 
1.7.11.rc2.72.gebb7ee5
