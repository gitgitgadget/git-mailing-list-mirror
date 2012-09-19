From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH] Improve legibility of test_expect_code output
Date: Wed, 19 Sep 2012 23:38:30 +0100
Message-ID: <1348094310-11214-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 00:40:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TESw1-0005J1-7n
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 00:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab2ISWjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 18:39:12 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:45247 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab2ISWic (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 18:38:32 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 462D32E39E
	for <git@vger.kernel.org>; Wed, 19 Sep 2012 23:38:31 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206006>

---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 t/test-lib-functions.sh

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
old mode 100644
new mode 100755
index 8889ba5..e022e73
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -562,7 +562,7 @@ test_expect_code () {
 		return 0
 	fi
 
-	echo >&2 "test_expect_code: command exited with $exit_code, we wanted $want_code $*"
+	echo >&2 "test_expect_code: command exited with $exit_code, we wanted $want_code from: $*"
 	return 1
 }
 
-- 
1.7.12.147.g6d168f4
