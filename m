From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] gitk: add a string to translation
Date: Sat, 23 May 2009 11:48:25 +0200
Message-ID: <200905231148.25678.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Sat May 23 11:49:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7nqp-0000Bq-Qy
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 11:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbZEWJtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 05:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbZEWJtA
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 05:49:00 -0400
Received: from smtp.katamail.com ([62.149.157.154]:39472 "HELO smtp1.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751509AbZEWJs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 05:48:59 -0400
Received: (qmail 6405 invoked by uid 89); 23 May 2009 09:48:45 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host80-57-dynamic.104-80-r.retail.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.80)
  by smtp1-pc with SMTP; 23 May 2009 09:48:45 -0000
User-Agent: KMail/1.9.10
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119772>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 1855390..c8af13e 100755
--- a/gitk
+++ b/gitk
@@ -3829,7 +3829,7 @@ proc vieweditor {top n title} {
     global known_view_options
 
     toplevel $top
-    wm title $top [concat $title "-- criteria for selecting revisions"]
+    wm title $top [concat $title [mc "-- criteria for selecting revisions"]]
     make_transient $top .
 
     # View name
-- 
1.6.3.1.17.g076c3
