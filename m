From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Document patch syntax.
Date: Sat, 12 May 2007 14:07:04 +0200
Message-ID: <20070512120704.22970.45140.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 14:30:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmqkM-00076K-5E
	for gcvg-git@gmane.org; Sat, 12 May 2007 14:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409AbXELMao (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 08:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756304AbXELMao
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 08:30:44 -0400
Received: from postfix2-g20.free.fr ([212.27.60.43]:49602 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754409AbXELMan (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 08:30:43 -0400
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 268B9FF4452
	for <git@vger.kernel.org>; Sat, 12 May 2007 13:27:22 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 9F01D5F4BE;
	Sat, 12 May 2007 14:25:26 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id DC8391F15F;
	Sat, 12 May 2007 14:07:04 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47042>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/stg.txt |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/Documentation/stg.txt b/Documentation/stg.txt
index af57c37..3ea51c3 100644
--- a/Documentation/stg.txt
+++ b/Documentation/stg.txt
@@ -51,6 +51,31 @@ Development branch::
 In such a setup, not all commits on your branch need to be StGIT
 patches; there may be regular GIT commits below your stack base.
 
+Patches
+~~~~~~~
+
+Many StGIT commands take references to StGIT patches as arguments.
+Patches in the stack are identified with a short name, which must be
+unique in the stack.
+
+Patches in the current stack are just refered to by their name.  Some
+commands allow to specify a patch in another stack of the repository;
+this is done by suffixing the patch name with a '@' sign followed by the
+branch name (eg. 'thispatch@otherbranch').
+
+A number of position in the stack related to the patch are also
+accessible through '//' suffixes.  For example, 'patch//top'' is
+equivalent to 'patch', and 'patch//bottom' refers to the commit below
+'patch' (ie. the patch below, or the stack base if this is the
+bottom-most patch).  Similarly ''//top.old'' and ''//bottom.old''
+refer to the previous version of the patch (before the last
+stglink:push[] or stglink:refresh[] operation).  When refering to the
+current patch, its name can be omitted (eg. 'currentpatch//bottom.old'
+can be abbreviated as 'bottom.old').
+
+If you need to pass a given StGIT reference to a git command,
+stglink:id[] will convert it to a git commit id.
+
 OPTIONS
 -------
 
