From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] gitk: Mark some strings for translation
Date: Mon, 30 Mar 2009 21:17:25 +0200
Message-ID: <200903302117.25371.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Mon Mar 30 21:21:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoN2R-0001L8-0O
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 21:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759775AbZC3TSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 15:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759665AbZC3TSp
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 15:18:45 -0400
Received: from smtp.katamail.com ([62.149.157.154]:57873 "HELO smtp2.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1759760AbZC3TSo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 15:18:44 -0400
Received: (qmail 4830 invoked by uid 89); 30 Mar 2009 19:18:33 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host177-57-dynamic.104-80-r.retail.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.177)
  by smtp2-pc with SMTP; 30 Mar 2009 19:18:33 -0000
User-Agent: KMail/1.9.10
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115188>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 gitk |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 3835a51..8b61d0d 100755
--- a/gitk
+++ b/gitk
@@ -521,7 +521,7 @@ proc updatecommits {} {
     incr viewactive($view)
     set viewcomplete($view) 0
     reset_pending_select {}
-    nowbusy $view "Reading"
+    nowbusy $view [mc "Reading"]
     if {$showneartags} {
 	getallcommits
     }
@@ -3766,7 +3766,7 @@ proc editview {} {
     set newviewopts($curview,perm) $viewperm($curview)
     set newviewopts($curview,cmd)  $viewargscmd($curview)
     decode_view_opts $curview $viewargs($curview)
-    vieweditor $top $curview "Gitk: edit view $viewname($curview)"
+    vieweditor $top $curview "[mc "Gitk: edit view"] $viewname($curview)"
 }
 
 proc vieweditor {top n title} {
@@ -10227,7 +10227,7 @@ proc doprefs {} {
 proc choose_extdiff {} {
     global extdifftool
 
-    set prog [tk_getOpenFile -title "External diff tool" -multiple false]
+    set prog [tk_getOpenFile -title [mc "External diff tool"] -multiple false]
     if {$prog ne {}} {
 	set extdifftool $prog
     }
-- 
1.6.2.22.gc2ac
