From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/9] Add list of bugs to TODO
Date: Sun, 16 Apr 2006 12:52:30 +0200
Message-ID: <20060416105230.9884.27600.stgit@gandelf.nowhere.earth>
References: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 12:50:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FV4pi-0001Gt-FY
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 12:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWDPKuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 06:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWDPKuQ
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 06:50:16 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:7040 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750706AbWDPKuL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 06:50:11 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1BFFB9A9A7;
	Sun, 16 Apr 2006 12:50:11 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FV4yq-0004AK-Np; Sun, 16 Apr 2006 12:59:48 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18778>


Since there is no formal place to register bugs, other than the git
ml, I have added a couple of them, some of them already mentionned on
the ml but still around.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 TODO |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index d97ffd1..a13e511 100644
--- a/TODO
+++ b/TODO
@@ -7,6 +7,7 @@ The TODO list until 1.0:
 - man page
 - code execution allowed from templates
 - more regression tests
+- stg help should probably pipe through the $PAGER
 - release 1.0
 
 
@@ -17,3 +18,17 @@ The future, when time allows or if someo
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
+- "stg show" on empty patch shows previous patch
+- "stg add" is accepted when no patch is applied, then any push says
+  one must refresh first, which is obviously wrong
+- "stg add" on files already added should print a notice, so that the
+  user can catch a possible typo
