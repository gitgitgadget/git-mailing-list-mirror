From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 3/6] user-manual: fix inconsistent use of pull and merge
Date: Sat, 10 Mar 2007 23:35:28 -0500
Message-ID: <11735877331883-git-send-email-bfields@citi.umich.edu>
References: <7vr6s42xgm.fsf@assigned-by-dhcp.cox.net> <11735877311383-git-send-email-bfields@citi.umich.edu> <11735877321525-git-send-email-bfields@citi.umich.edu> <11735877332438-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 05:36:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQFms-0000sT-Tp
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 05:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933100AbXCKEfq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 23:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933120AbXCKEfq
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 23:35:46 -0500
Received: from pool-138-88-140-139.esr.east.verizon.net ([138.88.140.139]:50437
	"EHLO pad.fieldses.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933100AbXCKEfm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 23:35:42 -0500
Received: from pad.fieldses.org (pad.fieldses.org [127.0.0.1])
	by pad.fieldses.org (8.13.8/8.13.8) with ESMTP id l2B4ZX9Q022229;
	Sat, 10 Mar 2007 23:35:34 -0500
Received: (from bfields@localhost)
	by pad.fieldses.org (8.13.8/8.13.8/Submit) id l2B4ZXub022228;
	Sat, 10 Mar 2007 23:35:33 -0500
X-Mailer: git-send-email 1.5.0.gb75812-dirty
In-Reply-To: <11735877332438-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41906>

From: J. Bruce Fields <bfields@citi.umich.edu>

I used "git pull ." instead of "git merge" here without any explanation.
Stick instead to "git merge" for now (the equivalent pull syntax is
still covered in a later chapter).

Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 8b5709b..f4ea967 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1133,17 +1133,9 @@ modified in two different ways in the remote branch and the local
 branch--then you are warned; the output may look something like this:
 
 -------------------------------------------------
-$ git pull . next
-Trying really trivial in-index merge...
-fatal: Merge requires file-level merging
-Nope.
-Merging HEAD with 77976da35a11db4580b80ae27e8d65caf5208086
-Merging:
-15e2162 world
-77976da goodbye
-found 1 common ancestor(s):
-d122ed4 initial
-Auto-merging file.txt
+$ git merge next
+ 100% (4/4) done
+Auto-merged file.txt
 CONFLICT (content): Merge conflict in file.txt
 Automatic merge failed; fix conflicts and then commit the result.
 -------------------------------------------------
-- 
1.5.0.gb75812-dirty
