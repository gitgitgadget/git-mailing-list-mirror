From: Xavier Maillard <zedek@gnu.org>
Subject: [PATCH 4/7] Fixed dosctrings (typos) and preferably load cl before vc
Date: Sat, 03 Mar 2007 11:19:30 +0100
Message-ID: <15295.1172917170@localhost>
Cc: julliard@winehq.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 11:22:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNRNm-0004oC-E7
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 11:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbXCCKWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 05:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbXCCKWW
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 05:22:22 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:47740 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbXCCKWV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 05:22:21 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id BA5B57D0A;
	Sat,  3 Mar 2007 11:22:20 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l23AJU8p015296;
	Sat, 3 Mar 2007 11:19:30 +0100
X-Mailer: MH-E 8.0.3; nmh 1.2; GNU Emacs 23.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41282>



Signed-off-by: Xavier Maillard <zedek@gnu.org>
---
 contrib/emacs/vc-git.el |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index 4cab845..748cb60 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -32,8 +32,8 @@
 ;;  - more customisable variables
 
 (eval-when-compile 
-  (require 'cl)
-  (require 'vc))
+  (require 'vc)
+  (require 'cl))
 
 ;; Add it automatically
 (add-to-list 'vc-handled-backends 'GIT)
@@ -49,14 +49,14 @@
   :group 'vc-git)
 
 (defcustom vc-git-author-name nil
-"*Author name to use in git. If nil, we check for environment variables
-GIT_AUTHOR_NAME or `user_full_name'."
+"*Author name to use in git. If nil, we check for environment variable
+GIT_AUTHOR_NAME or `user-full-name'."
   :type '(choice string (const nil))
   :group 'vc-git)
 
 (defcustom vc-git-author-email nil
-"*Author email to use in git. If nil, we check for environment variables
-GIT_AUTHOR_ADDRESS and if still nil, `user_mail_address'."
+"*Author email to use in git. If nil, we check for environment variable
+GIT_AUTHOR_ADDRESS and if still nil, `user-mail-address'."
   :type '(choice string (const nil))
   :group 'vc-git)
 
-- 
1.5.0
