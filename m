From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Homogenize buffer names
Date: Thu, 24 Jan 2008 08:55:59 +0100
Message-ID: <20080124075530.25461.20753.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 08:56:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHwx2-00035w-KK
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 08:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbYAXH4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 02:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbYAXH4K
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 02:56:10 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4425 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbYAXH4H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 02:56:07 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JHwwM-0005Hx-00; Thu, 24 Jan 2008 07:56:02 +0000
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71597>

It was driving me crazy that I couldn't tab-complete "*stg" to
"*stgit*" because there was always a "*stgit edit*" buffer lying
around.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

David, do you agree with this fix?

 contrib/stgit.el |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index 4d0faca..e8bbb2c 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -293,7 +293,7 @@ Commands:
   (let ((patch (if (stgit-applied-at-point)
                    (stgit-patch-at-point)
                  (error "This patch is not applied")))
-        (edit-buf (get-buffer-create "*stgit edit*"))
+        (edit-buf (get-buffer-create "*StGit edit*"))
         (dir default-directory))
     (log-edit 'stgit-confirm-edit t nil edit-buf)
     (set (make-local-variable 'stgit-edit-patch) patch)
@@ -313,7 +313,7 @@ Commands:
 (defun stgit-new ()
   "Create a new patch"
   (interactive)
-  (let ((edit-buf (get-buffer-create "*stgit edit*")))
+  (let ((edit-buf (get-buffer-create "*StGit edit*")))
     (log-edit 'stgit-confirm-new t nil edit-buf)))
=20
 (defun stgit-confirm-new ()
@@ -352,7 +352,7 @@ Commands:
 (defun stgit-coalesce (patch-names)
   "Run stg coalesce on the named patches"
   (interactive (list (stgit-marked-patches)))
-  (let ((edit-buf (get-buffer-create "*stgit edit*"))
+  (let ((edit-buf (get-buffer-create "*StGit edit*"))
         (dir default-directory))
     (log-edit 'stgit-confirm-coalesce t nil edit-buf)
     (set (make-local-variable 'stgit-patches) patch-names)
