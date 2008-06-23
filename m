From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] t9301-fast-export.sh: Remove debug line
Date: Mon, 23 Jun 2008 18:19:23 +0200
Message-ID: <200806231819.24040.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 18:16:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAohp-00080W-Ia
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 18:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756500AbYFWQO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 12:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755891AbYFWQO0
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 12:14:26 -0400
Received: from smtp.katamail.com ([62.149.157.154]:41260 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1755225AbYFWQO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 12:14:26 -0400
Received: (qmail 24602 invoked by uid 89); 23 Jun 2008 16:14:18 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host45-56-dynamic.104-80-r.retail.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.45)
  by smtp2-pc with SMTP; 23 Jun 2008 16:14:17 -0000
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85880>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 t/t9301-fast-export.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 60b5ee3..f1bc5ce 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -83,7 +83,6 @@ test_expect_success 'import/export-marks' '
 	git checkout -b marks master &&
 	git fast-export --export-marks=tmp-marks HEAD &&
 	test -s tmp-marks &&
-	cp tmp-marks ~ &&
 	test $(wc -l < tmp-marks) -eq 3 &&
 	test $(
 		git fast-export --import-marks=tmp-marks\
-- 
1.5.6
