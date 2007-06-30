From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Correct the name of NO_R_TO_GCC_LINKER in the comment describing it.
Date: Sat, 30 Jun 2007 10:05:03 -0700
Message-ID: <11832231032116-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 30 19:53:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4h8J-0002Sj-14
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 19:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbXF3RxR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 13:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbXF3RxR
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 13:53:17 -0400
Received: from neon.ftbfs.org ([83.168.236.214]:52268 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297AbXF3RxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 13:53:16 -0400
X-Greylist: delayed 2884 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Jun 2007 13:53:16 EDT
Received: from pool-71-104-149-201.lsanca.dsl-w.verizon.net ([71.104.149.201] helo=asturias.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1I4gVq-0003M5-0I; Sat, 30 Jun 2007 10:13:39 -0700
Received: from kraai by asturias.ftbfs.org with local (Exim 4.67)
	(envelope-from <kraai@ftbfs.org>)
	id 1I4gNb-0002S7-In; Sat, 30 Jun 2007 10:05:03 -0700
X-Mailer: git-send-email 1.5.2.2
X-Spam-Score: -3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51234>

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index a98e27a..5d60dc8 100644
--- a/Makefile
+++ b/Makefile
@@ -94,9 +94,9 @@ all::
 # Define OLD_ICONV if your library has an old iconv(), where the second
 # (input buffer pointer) parameter is declared with type (const char **).
 #
-# Define NO_R_TO_GCC if your gcc does not like "-R/path/lib" that
-# tells runtime paths to dynamic libraries; "-Wl,-rpath=/path/lib"
-# is used instead.
+# Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
+# that tells runtime paths to dynamic libraries;
+# "-Wl,-rpath=/path/lib" is used instead.
 #
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
-- 
1.5.2.2
