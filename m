From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] git-status-script was missed during the conversion from N -> A
Date: Wed, 27 Jul 2005 04:36:08 -0400
Message-ID: <20050727083608.GF19290@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 27 10:36:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxhOr-0000Al-3i
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 10:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVG0IgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 04:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVG0IgK
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 04:36:10 -0400
Received: from mail.autoweb.net ([198.172.237.26]:61123 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262071AbVG0IgJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2005 04:36:09 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DxhOa-0006wy-TA
	for git@vger.kernel.org; Wed, 27 Jul 2005 04:36:08 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DxhXZ-0007Yx-00
	for <git@vger.kernel.org>; Wed, 27 Jul 2005 04:45:25 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DxhOa-0007ac-7V
	for git@vger.kernel.org; Wed, 27 Jul 2005 04:36:08 -0400
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-status-script was missed during the conversion from "N" to "A" as
the new-file marker flag.

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 git-status-script |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

10d81954c415dc46287f9d135e2b94302d4d7e84
diff --git a/git-status-script b/git-status-script
--- a/git-status-script
+++ b/git-status-script
@@ -18,7 +18,7 @@ report () {
     T ) echo "#	typechange: $name";;
     C*) echo "#	copied: $name -> $newname";;
     R*) echo "#	renamed: $name -> $newname";;
-    N*) echo "#	new file: $name";;
+    A*) echo "#	new file: $name";;
     U ) echo "#	unmerged: $name";;
     esac
   done

-- 

Ryan Anderson
  sometimes Pug Majere
