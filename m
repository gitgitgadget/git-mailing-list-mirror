From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] git-submodule(1): update description and key names
Date: Fri,  6 Jul 2007 19:38:38 +0200
Message-ID: <1183743518430-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 19:39:51 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6rmY-0001XI-3B
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 19:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760067AbXGFRjr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 13:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760042AbXGFRjr
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 13:39:47 -0400
Received: from mail44.e.nsc.no ([193.213.115.44]:43767 "EHLO mail44.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756662AbXGFRjq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 13:39:46 -0400
Received: from localhost.localdomain (ti231210a341-3110.bb.online.no [85.166.56.40])
	by mail44.nsc.no (8.13.8/8.13.5) with ESMTP id l66Hcotp010547;
	Fri, 6 Jul 2007 19:38:51 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51776>

When git-submodule was updated to allow mapping between submodule name and
submodule path, the documentation was left untouched.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/git-submodule.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 7f0904e..e5a6c51 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -32,8 +32,8 @@ status::
 
 init::
 	Initialize the submodules, i.e. register in .git/config each submodule
-	path and url found in .gitmodules. The key used in git/config is
-	`submodule.$path.url`. This command does not alter existing information
+	name and url found in .gitmodules. The key used in .git/config is
+	`submodule.$name.url`. This command does not alter existing information
 	in .git/config.
 
 update::
@@ -64,7 +64,7 @@ FILES
 When initializing submodules, a .gitmodules file in the top-level directory
 of the containing repository is used to find the url of each submodule.
 This file should be formatted in the same way as $GIR_DIR/config. The key
-to each submodule url is "module.$path.url".
+to each submodule url is "submodule.$name.url".
 
 
 AUTHOR
-- 
1.5.2.2
