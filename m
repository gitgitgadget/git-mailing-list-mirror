From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/4] Add list of bugs to TODO
Date: Thu, 13 Apr 2006 23:44:26 +0200
Message-ID: <20060413214426.8806.820.stgit@gandelf.nowhere.earth>
References: <20060413213819.8806.53300.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 23:42:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU9a0-0001hd-5K
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 23:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWDMVmS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 17:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWDMVmR
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 17:42:17 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:14517 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S964984AbWDMVmR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Apr 2006 17:42:17 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 2A578545DA;
	Thu, 13 Apr 2006 23:42:16 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FU9j4-0008WT-G1; Thu, 13 Apr 2006 23:51:42 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060413213819.8806.53300.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18670>

From: Yann Dirson <ydirson@altern.org>

Since there is no formal place to register bugs, other than the git ml,
I have added a couple of them, even mentionned on the ml, but which are
still around.
---

 TODO |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index d97ffd1..7dd099c 100644
--- a/TODO
+++ b/TODO
@@ -17,3 +17,12 @@ The future, when time allows or if someo
   synchronising with other patches (diff format or in other
   repositories)
 - write bash-completion script for the StGIT commands
+- support for branches with / in names
+  (ml: "Handle branch names with slashes")
+- "pull" argument should default to a sane value, "origin" is wrong in
+  many cases
+
+Bugs:
+
+- the following commands break in subdirs:
+  - refresh (ml: "Running StGIT in subdirectories")
