From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Change "added.moved or removed" to "added, moved or removed" in
Date: Fri,  6 Jul 2007 18:23:54 -0700
Message-ID: <118377143481-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 07 03:24:17 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6z1y-000486-0x
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 03:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbXGGBX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 21:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbXGGBX7
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 21:23:59 -0400
Received: from neon.ftbfs.org ([83.168.236.214]:59357 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbXGGBX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 21:23:58 -0400
Received: from pool-71-104-149-201.lsanca.dsl-w.verizon.net ([71.104.149.201] helo=asturias.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1I6zAW-0007A2-Ec; Fri, 06 Jul 2007 18:33:05 -0700
Received: from kraai by asturias.ftbfs.org with local (Exim 4.67)
	(envelope-from <kraai@ftbfs.org>)
	id 1I6z1e-0001ye-Ru; Fri, 06 Jul 2007 18:23:54 -0700
X-Mailer: git-send-email 1.5.2.3
X-Spam-Score: -3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51796>

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 Documentation/core-intro.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/core-intro.txt b/Documentation/core-intro.txt
index eea44d9..f3cc223 100644
--- a/Documentation/core-intro.txt
+++ b/Documentation/core-intro.txt
@@ -528,7 +528,7 @@ paths that have been trivially merged.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Sadly, many merges aren't trivial. If there are files that have
-been added.moved or removed, or if both branches have modified the
+been added, moved or removed, or if both branches have modified the
 same file, you will be left with an index tree that contains "merge
 entries" in it. Such an index tree can 'NOT' be written out to a tree
 object, and you will have to resolve any such merge clashes using
-- 
1.5.2.3
