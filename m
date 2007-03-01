From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 2/4] Documentation/git-quiltimport.txt: Fix labeled list formatting
Date: Thu,  1 Mar 2007 22:41:15 +0300
Message-ID: <11727780872894-git-send-email-vsu@altlinux.ru>
References: <1172778077659-git-send-email-vsu@altlinux.ru>
Cc: git@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 20:42:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMrAP-0004Qr-Sq
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 20:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965535AbXCATmO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 14:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965538AbXCATmN
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 14:42:13 -0500
Received: from master.altlinux.org ([62.118.250.235]:3607 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965535AbXCATmN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 14:42:13 -0500
Received: by master.altlinux.org (Postfix, from userid 584)
	id 856D9E3C46; Thu,  1 Mar 2007 22:42:11 +0300 (MSK)
X-Mailer: git-send-email 1.5.0.2.285.g5347
In-Reply-To: <1172778077659-git-send-email-vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41120>

Mark the continuation paragraph of a list entry as such to avoid
getting a literal paragraph instead.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 Documentation/git-quiltimport.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index 6e9a8c3..296937a 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -42,10 +42,10 @@ OPTIONS
 --patches <dir>::
 	The directory to find the quilt patches and the
 	quilt series file.
-
-        The default for the patch directory is patches
-	or the value of the $QUILT_PATCHES environment
-	variable.
++
+The default for the patch directory is patches
+or the value of the $QUILT_PATCHES environment
+variable.
 
 Author
 ------
-- 
1.5.0.2.285.g5347
