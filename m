From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/5] Various cleanups for clarity.
Date: Tue, 20 Feb 2007 01:14:13 +0100
Message-ID: <20070220001413.31139.18688.stgit@gandelf.nowhere.earth>
References: <20070220000908.31139.36841.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJJE0-0000P4-SD
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965816AbXBTAul (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965814AbXBTAul
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:50:41 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:43666 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965816AbXBTAuk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:50:40 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C632B591D9;
	Tue, 20 Feb 2007 01:15:37 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id DCB551F090;
	Tue, 20 Feb 2007 01:14:13 +0100 (CET)
In-Reply-To: <20070220000908.31139.36841.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40186>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/stack.py |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index dc6caa6..3185d64 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -518,8 +518,6 @@ class Series(StgitObject):
     def init(self, create_at=False, parent_remote=None, parent_branch=None):
         """Initialises the stgit series
         """
-        bases_dir = os.path.join(self.__base_dir, 'refs', 'bases')
-
         if os.path.exists(self.__patch_dir):
             raise StackException, self.__patch_dir + ' already exists'
         if os.path.exists(self.__refs_dir):
@@ -534,7 +532,7 @@ class Series(StgitObject):
 
         self.set_parent(parent_remote, parent_branch)
         
-        create_dirs(bases_dir)
+        create_dirs(os.path.join(self.__base_dir, 'refs', 'bases'))
 
         self.create_empty_field('applied')
         self.create_empty_field('unapplied')
