From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] gitk: mark a string for translation
Date: Mon, 3 Mar 2008 21:12:47 +0100
Message-ID: <200803032112.47375.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 21:11:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWH0A-0002CI-HI
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 21:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997AbYCCUKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 15:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754853AbYCCUKK
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 15:10:10 -0500
Received: from smtp.katamail.com ([62.149.157.154]:51478 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753819AbYCCUKI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 15:10:08 -0500
Received: (qmail 21377 invoked by uid 89); 3 Mar 2008 20:09:48 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host122-56-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.122)
  by smtp2-pc with SMTP; 3 Mar 2008 20:09:47 -0000
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75981>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index f1f21e9..e82f744 100755
--- a/gitk
+++ b/gitk
@@ -1858,7 +1858,7 @@ proc newview {ishighlight} {
 	raise $top
 	return
     }
-    set newviewname($nextviewnum) "View $nextviewnum"
+    set newviewname($nextviewnum) "[mc "View"] $nextviewnum"
     set newviewperm($nextviewnum) 0
     set newviewargs($nextviewnum) [shellarglist $revtreeargs]
     vieweditor $top $nextviewnum [mc "Gitk view definition"]
-- 
1.5.4.3

