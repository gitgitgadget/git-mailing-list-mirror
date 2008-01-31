From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] Fix typo in a comment in t/test-lib.sh
Date: Thu, 31 Jan 2008 22:59:11 +0100
Message-ID: <200801312259.11908.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 22:58:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKhQf-00064U-1W
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 22:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762375AbYAaV6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 16:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762053AbYAaV6I
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 16:58:08 -0500
Received: from [62.149.157.154] ([62.149.157.154]:52299 "HELO
	smtp1.pc.aruba.it" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1760826AbYAaV6G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 16:58:06 -0500
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Jan 2008 16:58:06 EST
Received: (qmail 25296 invoked by uid 89); 31 Jan 2008 21:51:05 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host84-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.84)
  by smtp2-pc with SMTP; 31 Jan 2008 21:51:01 -0000
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72139>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 90b6844..142540e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -257,7 +257,7 @@ test_expect_code () {
 	echo >&3 ""
 }
 
-# Most tests can use the created repository, but some amy need to create more.
+# Most tests can use the created repository, but some may need to create more.
 # Usage: test_create_repo <directory>
 test_create_repo () {
 	test "$#" = 1 ||
-- 
1.5.3.8
