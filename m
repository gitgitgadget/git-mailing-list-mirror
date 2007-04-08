From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/3] Stop advertising 'pull' as the only operation blocked on
	protected stacks.
Date: Sun, 08 Apr 2007 17:12:16 +0200
Message-ID: <20070408151216.8884.71420.stgit@gandelf.nowhere.earth>
References: <20070408150822.8884.67664.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 17:14:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaZ4K-00023T-C4
	for gcvg-git@gmane.org; Sun, 08 Apr 2007 17:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbXDHPMg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 11:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbXDHPMg
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 11:12:36 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:57753 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbXDHPMf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 11:12:35 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 015AE5DF73;
	Sun,  8 Apr 2007 17:12:35 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 540EA1F094;
	Sun,  8 Apr 2007 17:12:16 +0200 (CEST)
In-Reply-To: <20070408150822.8884.67664.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44003>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/branch.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index eff0121..5f79f7e 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -58,13 +58,13 @@ options = [make_option('-c', '--create',
                        help = 'list branches contained in this repository',
                        action = 'store_true'),
            make_option('-p', '--protect',
-                       help = 'prevent "stg pull" from modifying this branch',
+                       help = 'prevent StGIT from modifying this branch',
                        action = 'store_true'),
            make_option('-r', '--rename',
                        help = 'rename an existing development branch',
                        action = 'store_true'),
            make_option('-u', '--unprotect',
-                       help = 'allow "stg pull" to modify this branch',
+                       help = 'allow StGIT to modify this branch',
                        action = 'store_true')]
 
 
