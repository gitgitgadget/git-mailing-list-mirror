From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Support for pre-1.5 git in stgit tests.
Date: Mon, 19 Feb 2007 23:22:54 +0100
Message-ID: <20070219222221.23578.86170.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJIdc-0000iW-AB
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965621AbXBTAMd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965613AbXBTAL5
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:11:57 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:53480 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965611AbXBTALN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:11:13 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 9C9C54B1F9;
	Mon, 19 Feb 2007 23:24:06 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id EB34F1F084;
	Mon, 19 Feb 2007 23:22:54 +0100 (CET)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40169>


Support for older Git versions was broken in
5cd9e87faa0a116ce2b378be6a5c89d5f20629f1 (post 0.12).

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 t/t1900-mail.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1900-mail.sh b/t/t1900-mail.sh
index 4be7270..3eed7f8 100755
--- a/t/t1900-mail.sh
+++ b/t/t1900-mail.sh
@@ -6,7 +6,7 @@ test_description='Test the mail command'
 test_expect_success \
     'Initialize the StGIT repository' \
     '
-    git config stgit.sender "A U Thor <author@example.com>" &&
+    git repo-config stgit.sender "A U Thor <author@example.com>" &&
     for i in 1 2 3 4 5; do
       touch foo.txt &&
       echo "line $i" >> foo.txt &&
