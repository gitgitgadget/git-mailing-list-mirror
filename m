From: Max Kirillov <max@max630.net>
Subject: [PATCH] gitk: fix mistype
Date: Sat, 18 Jan 2014 14:58:51 +0200
Message-ID: <20140118125541.GA6869@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Jan 18 13:59:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4VUd-0003Ew-33
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 13:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbaARM7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 07:59:14 -0500
Received: from p3plsmtpa09-06.prod.phx3.secureserver.net ([173.201.193.235]:51514
	"EHLO p3plsmtpa09-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752032AbaARM7N (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 07:59:13 -0500
Received: from wheezy.local ([89.27.29.195])
	by p3plsmtpa09-06.prod.phx3.secureserver.net with 
	id FQz51n00l4CavkR01QzBbq; Sat, 18 Jan 2014 05:59:13 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240647>

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk-git/gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index b217dbc..30a3b20 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7958,7 +7958,7 @@ proc blobdiffmaybeseehere {ateof} {
     if {$diffseehere >= 0} {
 	mark_ctext_line [lindex [split $diffseehere .] 0]
     }
-    maybe_scroll_ctext ateof
+    maybe_scroll_ctext $ateof
 }
 
 proc getblobdiffline {bdf ids} {
-- 
1.8.5.2.421.g4cdf8d0
