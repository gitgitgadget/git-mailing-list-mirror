From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Add missing files to stgit manifest.
Date: Mon, 26 Feb 2007 23:13:06 +0100
Message-ID: <20070226221305.12278.49103.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 26 23:13:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLo5s-0004Tl-NR
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 23:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161274AbXBZWNO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 17:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161281AbXBZWNO
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 17:13:14 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:54121 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161274AbXBZWNN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 17:13:13 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 2A27D49F44;
	Mon, 26 Feb 2007 23:13:12 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 1A7851F084;
	Mon, 26 Feb 2007 23:13:06 +0100 (CET)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40670>


Many things, including Makefile and all documentation were left out of
various packaging because they're not included in the tarball.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 MANIFEST.in |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/MANIFEST.in b/MANIFEST.in
index c720022..6b634e0 100644
--- a/MANIFEST.in
+++ b/MANIFEST.in
@@ -1,4 +1,4 @@
-include README MANIFEST.in AUTHORS COPYING INSTALL ChangeLog TODO
+include README Makefile MANIFEST.in AUTHORS COPYING INSTALL ChangeLog TODO
 include stg-prof
 include templates/*.tmpl
 include examples/*.tmpl
@@ -6,3 +6,6 @@ include examples/gitconfig
 include contrib/diffcol.sh
 include contrib/stgbashprompt.sh
 include contrib/stgit-completion.bash
+include t/t*.sh t/t*/* t/Makefile t/README
+include Documentation/*.txt Documentation/Makefile Documentation/*.conf
+include Documentation/build-docdep.perl Documentation/callouts.xsl
