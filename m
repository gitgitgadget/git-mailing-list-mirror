From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] git-submodule: re-enable 'status' as the default subcommand
Date: Sat,  4 Aug 2007 16:25:53 +0200
Message-ID: <11862375532593-git-send-email-hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 16:22:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHKWa-0001aH-Qc
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 16:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762463AbXHDOWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 10:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762182AbXHDOWW
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 10:22:22 -0400
Received: from mail49.e.nsc.no ([193.213.115.49]:48716 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759464AbXHDOWW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 10:22:22 -0400
Received: from localhost.localdomain (ti231210a341-3110.bb.online.no [85.166.56.40])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id l74EMKdg011977
	for <git@vger.kernel.org>; Sat, 4 Aug 2007 16:22:20 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.rc4-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54855>

This was broken as part of ecda072380.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2cfeadd..3320998 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -313,7 +313,7 @@ case "$add,$init,$update,$status,$cached" in
 ,,1,,)
 	modules_update "$@"
 	;;
-,,,1,*)
+,,,*,*)
 	modules_list "$@"
 	;;
 *)
-- 
1.5.3.rc4-dirty
