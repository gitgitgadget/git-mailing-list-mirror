From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 1/5] README: use markdown syntax
Date: Thu, 25 Feb 2016 09:37:26 +0100
Message-ID: <1456389450-27118-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
 <1456389450-27118-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 09:38:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYrQu-0002n3-CD
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 09:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760119AbcBYIhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 03:37:54 -0500
Received: from mx2.imag.fr ([129.88.30.17]:35279 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759493AbcBYIhx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 03:37:53 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8bc3O012975
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 25 Feb 2016 09:37:38 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8bdLL010488;
	Thu, 25 Feb 2016 09:37:39 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456389450-27118-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 25 Feb 2016 09:37:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1P8bc3O012975
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456994260.27835@nfDK/dvGpsXCtrUnbXtJUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287341>

This allows repository browsers like GitHub to display the content of
the file nicely formatted.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 README => README.md | 7 ++-----
 t/t7001-mv.sh       | 2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)
 rename README => README.md (93%)

diff --git a/README b/README.md
similarity index 93%
rename from README
rename to README.md
index 1083735..600779c 100644
--- a/README
+++ b/README.md
@@ -1,8 +1,5 @@
-////////////////////////////////////////////////////////////////
-
-	Git - the stupid content tracker
-
-////////////////////////////////////////////////////////////////
+Git - the stupid content tracker
+================================
 
 "git" can mean anything, depending on your mood.
 
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 51dd2b4..4008fae 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -102,7 +102,7 @@ test_expect_success \
 
 test_expect_success \
     'adding another file' \
-    'cp "$TEST_DIRECTORY"/../README path0/README &&
+    'cp "$TEST_DIRECTORY"/../README.md path0/README &&
      git add path0/README &&
      git commit -m add2 -a'
 
-- 
2.7.2.334.g35ed2ae.dirty
