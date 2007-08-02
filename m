From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 1/6] Improve stg-fold-files-from doc.
Date: Thu, 02 Aug 2007 22:18:15 +0200
Message-ID: <20070802201815.16614.75785.stgit@gandelf.nowhere.earth>
References: <20070802200704.16614.57993.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:19:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGh9L-0007HH-23
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 22:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759876AbXHBUTV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 16:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759407AbXHBUTV
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 16:19:21 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:55021 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758184AbXHBUTU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 16:19:20 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 6047B5A0B0;
	Thu,  2 Aug 2007 22:19:19 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 4871838F2;
	Thu,  2 Aug 2007 22:19:19 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 04C2F1F06F;
	Thu,  2 Aug 2007 22:18:16 +0200 (CEST)
In-Reply-To: <20070802200704.16614.57993.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54593>

From: Yann Dirson <yann.dirson@sagem.com>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-fold-files-from |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/stg-fold-files-from b/contrib/stg-fold-files-from
index bfb4a1f..53d3d02 100755
--- a/contrib/stg-fold-files-from
+++ b/contrib/stg-fold-files-from
@@ -2,12 +2,12 @@
 set -e
 
 # stg-fold-files-from - picks changes to one file from another patch.
-# Only supports picking from one file, but allows to select any range
+# Only supports picking from one file pattern, but allows to select any range
 # of hunks from the file, using the -# flag to filterdiff.
 # Use together with "filterdiff --annotate" in your diff pager, to
 # identify hunk numbers easily.
 
-# usage: stg-fold-files-from <patch> [-#<n>[-<n>][,<n>]...] <file>
+# usage: stg-fold-files-from <patch> [-#<n>[-<n>][,<n>]...] <file-pattern>
 
 # Copyright (c) 2006-2007 Yann Dirson <ydirson@altern.org>
 # Subject to the GNU GPL, version 2.
