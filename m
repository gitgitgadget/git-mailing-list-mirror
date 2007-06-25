From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 4/7] Fixed thinko in error message.
Date: Mon, 25 Jun 2007 23:24:41 +0200
Message-ID: <20070625212441.17189.25324.stgit@gandelf.nowhere.earth>
References: <20070625212229.17189.79919.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 23:24:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2w3M-0004le-GV
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 23:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbXFYVYx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 17:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbXFYVYx
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 17:24:53 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51251 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731AbXFYVYw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 17:24:52 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C43415A1EC;
	Mon, 25 Jun 2007 23:24:51 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 887E21F150;
	Mon, 25 Jun 2007 23:24:41 +0200 (CEST)
In-Reply-To: <20070625212229.17189.79919.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50924>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/rebase.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index e47772c..c68f8e7 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -54,7 +54,7 @@ def func(parser, options, args):
 
     # ensure an exception is raised before popping on non-existent target
     if git_id(args[0]) == None:
-        raise GitException, 'Unknown revision: %s' % git_id
+        raise GitException, 'Unknown revision: %s' % args[0]
         
     applied = prepare_rebase(force=options.force)
     rebase(args[0])
