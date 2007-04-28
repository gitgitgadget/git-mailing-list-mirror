From: Bart Trojanowski <bart@jukie.net>
Subject: [PATCH] make j/k move down/up in gitk (like vi)
Date: Fri, 27 Apr 2007 23:02:15 -0400
Message-ID: <20070428030215.GZ26786@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 28 05:29:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhdcU-0005g0-1v
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 05:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030965AbXD1D3G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 23:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030967AbXD1D3G
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 23:29:06 -0400
Received: from bart.ott.istop.com ([66.11.172.99]:44812 "EHLO jukie.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030965AbXD1D3F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 23:29:05 -0400
X-Greylist: delayed 1601 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Apr 2007 23:29:05 EDT
Received: from tau.jukie.net ([10.10.10.211]:55787)
	by jukie.net with esmtp (Exim 4.50)
	id 1HhdCR-00037Y-Qq; Fri, 27 Apr 2007 23:02:15 -0400
Received: by tau.jukie.net (Postfix, from userid 1000)
	id 9A44EA75B49; Fri, 27 Apr 2007 23:02:15 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45768>

Currently gitk has i/k bound to move up and down in the commit list.  I
would like to make that more consistent with vi's j/k.

If this is not acceptable, I will investigate a git-config option for vi
compatibility mode.

---
 gitk |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index b1c65d7..0ce4a12 100755
--- a/gitk
+++ b/gitk
@@ -711,10 +711,8 @@ proc makewindow {} {
     bindkey n "selnextline 1"
     bindkey z "goback"
     bindkey x "goforw"
-    bindkey i "selnextline -1"
-    bindkey k "selnextline 1"
-    bindkey j "goback"
-    bindkey l "goforw"
+    bindkey k "selnextline -1"
+    bindkey j "selnextline 1"
     bindkey b "$ctext yview scroll -1 pages"
     bindkey d "$ctext yview scroll 18 units"
     bindkey u "$ctext yview scroll -18 units"
-- 
1.5.2.rc0.56.g6169a
