From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Make debian/rules executable, and correct the spelling of rsync in debian/control
Date: Tue, 19 Jul 2005 21:17:47 -0400
Message-ID: <20050720011747.GK20369@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 20 03:18:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dv3Do-000729-BI
	for gcvg-git@gmane.org; Wed, 20 Jul 2005 03:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVGTBRt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jul 2005 21:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVGTBRt
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jul 2005 21:17:49 -0400
Received: from mail.autoweb.net ([198.172.237.26]:50820 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261726AbVGTBRt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2005 21:17:49 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1Dv3DY-0008Q5-LU; Tue, 19 Jul 2005 21:17:48 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Dv3LR-0000je-00; Tue, 19 Jul 2005 21:25:57 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1Dv3DY-0003JH-0R; Tue, 19 Jul 2005 21:17:48 -0400
To: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Make debian/rules executable, and correct the spelling of rsync in
debian/control

---

 debian/control |    2 +-
 debian/rules   |    0 
 2 files changed, 1 insertions(+), 1 deletions(-)
 mode change 100644 => 100755 debian/rules

d1acec0c9f2f1936528769c76089961cec4a096e
diff --git a/debian/control b/debian/control
--- a/debian/control
+++ b/debian/control
@@ -7,7 +7,7 @@ Standards-Version: 3.6.1
 
 Package: git-core
 Architecture: any
-Depends: ${shlibs:Depends}, shellutils, diff, rysnc, rcs
+Depends: ${shlibs:Depends}, shellutils, diff, rsync, rcs
 Description: The git content addressable filesystem
  GIT comes in two layers. The bottom layer is merely an extremely fast
  and flexible filesystem-based database designed to store directory trees
diff --git a/debian/rules b/debian/rules
old mode 100644
new mode 100755
-- 

Ryan Anderson
  sometimes Pug Majere
