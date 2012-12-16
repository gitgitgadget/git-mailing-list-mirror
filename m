From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v6 3/7] tests: paint skipped tests in bold blue
Date: Sun, 16 Dec 2012 18:28:11 +0000
Message-ID: <1355682495-22382-4-git-send-email-git@adamspiers.org>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 19:39:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkJ7i-0007bF-AJ
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 19:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab2LPSjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 13:39:06 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:41202 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab2LPSi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 13:38:57 -0500
Received: from localhost (4.8.9.4.4.5.7.d.4.0.6.a.a.2.0.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:b02a:a604:d754:4984])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 2F6F42E663
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 18:28:19 +0000 (GMT)
X-Mailer: git-send-email 1.7.12.1.396.g53b3ea9
In-Reply-To: <1355682495-22382-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211597>

Skipped tests indicate incomplete test coverage.  Whilst this is not a
test failure or other error, it's still not a complete success.

Other testsuite related software like automake, autotest and prove
seem to use blue for skipped tests, so let's follow suit.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 710f051..220b172 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -212,7 +212,7 @@ then
 		error)
 			tput bold; tput setaf 1;; # bold red
 		skip)
-			tput bold; tput setaf 2;; # bold green
+			tput bold; tput setaf 4;; # bold blue
 		warn)
 			tput bold; tput setaf 3;; # bold brown/yellow
 		pass)
-- 
1.7.12.1.396.g53b3ea9
