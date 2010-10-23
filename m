From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Fix an inconsistency in gitdiffcore long options markup.
Date: Sat, 23 Oct 2010 16:31:22 +0200
Message-ID: <1287844282-11477-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 23 16:31:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9f8B-0006AX-Ez
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 16:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164Ab0JWObb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 10:31:31 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:48777 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757041Ab0JWOba (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 10:31:30 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 440A0D48096;
	Sat, 23 Oct 2010 16:31:25 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P9f80-0002zd-3O; Sat, 23 Oct 2010 16:31:24 +0200
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159787>

---
 Documentation/gitdiffcore.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 6af29a4..702ab5a 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -141,7 +141,7 @@ merges these filepairs and creates:
 
 When the "-C" option is used, the original contents of modified files,
 and deleted files (and also unmodified files, if the
-"\--find-copies-harder" option is used) are considered as candidates
+`\--find-copies-harder` option is used) are considered as candidates
 of the source files in rename/copy operation.  If the input were like
 these filepairs, that talk about a modified file fileY and a newly
 created file file0:
-- 
1.7.2.3
