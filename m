From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH] Include contrib scripts in the release tarball.
Date: Sun, 29 Jul 2007 15:32:10 +0200
Message-ID: <20070729133122.17124.12320.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 15:33:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF8tj-0005Hv-6N
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 15:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762199AbXG2NdL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 09:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760674AbXG2NdK
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 09:33:10 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:34362 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761543AbXG2NdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 09:33:09 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 473C45A19C;
	Sun, 29 Jul 2007 15:33:08 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 2D2F55A198;
	Sun, 29 Jul 2007 15:33:08 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id CBDA01F162;
	Sun, 29 Jul 2007 15:32:10 +0200 (CEST)
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54115>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

This patch is targeted at the stable branch.

 MANIFEST.in |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/MANIFEST.in b/MANIFEST.in
index 6b634e0..583a5e8 100644
--- a/MANIFEST.in
+++ b/MANIFEST.in
@@ -3,9 +3,9 @@ include stg-prof
 include templates/*.tmpl
 include examples/*.tmpl
 include examples/gitconfig
-include contrib/diffcol.sh
-include contrib/stgbashprompt.sh
-include contrib/stgit-completion.bash
+include contrib/*.sh
+include contrib/*.bash
+include contrib/stg-*
 include t/t*.sh t/t*/* t/Makefile t/README
 include Documentation/*.txt Documentation/Makefile Documentation/*.conf
 include Documentation/build-docdep.perl Documentation/callouts.xsl
