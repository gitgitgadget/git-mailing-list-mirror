From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 4/9] Fixed thinko in error message.
Date: Sun, 17 Jun 2007 00:00:50 +0200
Message-ID: <20070616220049.14941.26563.stgit@gandelf.nowhere.earth>
References: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 00:00:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzgK9-0000AN-S9
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 00:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757566AbXFPWAn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 18:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757519AbXFPWAm
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 18:00:42 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45538 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757504AbXFPWAl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 18:00:41 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 99B5A5A24D;
	Sun, 17 Jun 2007 00:00:40 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 09EDC1F08A;
	Sun, 17 Jun 2007 00:00:50 +0200 (CEST)
In-Reply-To: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50314>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/rebase.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index 1cde2ad..111d78e 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -55,7 +55,7 @@ class concreteCommand(Command):
 
         # ensure an exception is raised before popping on non-existent target
         if git_id(self.args[0]) == None:
-            raise GitException, 'Unknown revision: %s' % git_id
+            raise GitException, 'Unknown revision: %s' % git_id(self.args[0])
 
         applied = prepare_rebase(force=self.flags.force)
         rebase(self.args[0])
