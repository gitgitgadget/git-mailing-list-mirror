From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/4] t5510: fix indent with spaces
Date: Thu, 1 Mar 2012 22:40:49 +0100
Message-ID: <72a62936d799cb72a39943a60a15541d7aa1db0f.1330637923.git.trast@student.ethz.ch>
References: <cover.1330637923.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:41:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3DkV-0007ba-1P
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 22:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133Ab2CAVlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 16:41:04 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:45305 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965106Ab2CAVk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 16:40:56 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 22:40:49 +0100
Received: from thomas.inf.ethz.ch (129.132.210.31) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 22:40:53 +0100
X-Mailer: git-send-email 1.7.9.2.467.g7fee4
In-Reply-To: <cover.1330637923.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.210.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191977>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t5510-fetch.sh |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 6df24b2..8827828 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -429,14 +429,14 @@ test_expect_success 'fetch --dry-run' '
 '
 
 test_expect_success "should be able to fetch with duplicate refspecs" '
-        mkdir dups &&
-        cd dups &&
-        git init &&
-        git config branch.master.remote three &&
-        git config remote.three.url ../three/.git &&
-        git config remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
-        git config --add remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
-        git fetch three
+	mkdir dups &&
+	cd dups &&
+	git init &&
+	git config branch.master.remote three &&
+	git config remote.three.url ../three/.git &&
+	git config remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
+	git config --add remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
+	git fetch three
 '
 
 test_done
-- 
1.7.9.2.467.g7fee4
