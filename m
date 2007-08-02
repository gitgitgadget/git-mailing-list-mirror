From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 6/6] Fixed completion function hardcoding .git/.
Date: Thu, 02 Aug 2007 22:18:41 +0200
Message-ID: <20070802201841.16614.85746.stgit@gandelf.nowhere.earth>
References: <20070802200704.16614.57993.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:20:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGh9P-0007HH-EX
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 22:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760047AbXHBUTq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 16:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760041AbXHBUTq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 16:19:46 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:55185 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760019AbXHBUTp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 16:19:45 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 0D4F45A16D;
	Thu,  2 Aug 2007 22:19:45 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id EADBF5A0EC;
	Thu,  2 Aug 2007 22:19:44 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id A53C11F06F;
	Thu,  2 Aug 2007 22:18:41 +0200 (CEST)
In-Reply-To: <20070802200704.16614.57993.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54598>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stgit-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/stgit-completion.bash b/contrib/stgit-completion.bash
index 2d0d5f2..7ae9e6a 100644
--- a/contrib/stgit-completion.bash
+++ b/contrib/stgit-completion.bash
@@ -108,7 +108,7 @@ _all_other_patches ()
 _all_branches ()
 {
     local g=$(_gitdir)
-    [ "$g" ] && (cd .git/patches/ && echo *)
+    [ "$g" ] && (cd $g/patches/ && echo *)
 }
 
 _conflicting_files ()
