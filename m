From: Xavier Maillard <zedek@gnu.org>
Subject: [PATCH 1/7] .git directory should be ignored
Date: Sat, 03 Mar 2007 11:18:03 +0100
Message-ID: <15268.1172917083@localhost>
Cc: julliard@winehq.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 11:21:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNRMU-0004I1-Lz
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 11:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbXCCKUz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 05:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbXCCKUz
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 05:20:55 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:47212 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbXCCKUy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 05:20:54 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id BD1527210;
	Sat,  3 Mar 2007 11:20:53 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l23AI3mZ015269;
	Sat, 3 Mar 2007 11:18:03 +0100
X-Mailer: MH-E 8.0.3; nmh 1.2; GNU Emacs 23.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41279>


Add .git to the list of extensions to be ignored

Signed-off-by: Xavier Maillard <zedek@gnu.org>
---
 contrib/emacs/vc-git.el |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index a2d3932..3d43ca0 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -149,4 +149,7 @@
 ;;    (and (looking-at "[0-9a-f]+")
 ;;         (buffer-substring (match-beginning 0) (match-end 0)))))
 
+;;;###autoload
+(add-to-list 'completion-ignored-extensions ".git/")
+
 (provide 'vc-git)
-- 
1.5.0
