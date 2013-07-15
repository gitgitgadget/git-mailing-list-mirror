From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v3 1/6] t4000-diff-format.sh: modernize style
Date: Mon, 15 Jul 2013 19:55:20 +0200
Message-ID: <1373910925-18422-2-git-send-email-Matthieu.Moy@imag.fr>
References: <20130715173536.GB14690@google.com>
 <1373910925-18422-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: jrnieder@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 15 19:56:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyn0S-0004VY-2G
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 19:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472Ab3GOR4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 13:56:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45482 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910Ab3GOR4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 13:56:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r6FHtrM8010113
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 19:55:53 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Uyn07-00043b-B7; Mon, 15 Jul 2013 19:55:55 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Uyn07-0004oB-11; Mon, 15 Jul 2013 19:55:55 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
In-Reply-To: <1373910925-18422-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Jul 2013 19:55:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6FHtrM8010113
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1374515756.25148@QkrX1Ju8UEdH57Q4S9pLjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230504>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t4000-diff-format.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index 6ddd469..2b5dffc 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -15,17 +15,17 @@ line 3'
 cat path0 >path1
 chmod +x path1
 
-test_expect_success \
-    'update-index --add two files with and without +x.' \
-    'git update-index --add path0 path1'
+test_expect_success 'update-index --add two files with and without +x.' '
+	git update-index --add path0 path1
+'
 
 mv path0 path0-
 sed -e 's/line/Line/' <path0- >path0
 chmod +x path0
 rm -f path1
-test_expect_success \
-    'git diff-files -p after editing work tree.' \
-    'git diff-files -p >current'
+test_expect_success 'git diff-files -p after editing work tree.' '
+	git diff-files -p >actual
+'
 
 # that's as far as it comes
 if [ "$(git config --get core.filemode)" = false ]
@@ -55,8 +55,8 @@ deleted file mode 100755
 -line 3
 EOF
 
-test_expect_success \
-    'validate git diff-files -p output.' \
-    'compare_diff_patch current expected'
+test_expect_success 'validate git diff-files -p output.' '
+	compare_diff_patch expected actual
+'
 
 test_done
-- 
1.8.3.1.495.g13f33cf.dirty
