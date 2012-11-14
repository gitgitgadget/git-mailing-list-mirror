From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] docs: move submodule section
Date: Wed, 14 Nov 2012 10:49:04 -0800
Message-ID: <1352918944-26606-1-git-send-email-kraai@ftbfs.org>
References: <201211141815.qAEIFTBi017644@netbook1.inf.utfsm.cl>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org, gitster@pobox.com,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Wed Nov 14 19:49:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYi23-00067c-7x
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 19:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423217Ab2KNStg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 13:49:36 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:43847 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423191Ab2KNStf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 13:49:35 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1TYi1g-0006vg-Rj; Wed, 14 Nov 2012 10:49:28 -0800
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <201211141815.qAEIFTBi017644@netbook1.inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209737>

293ab15e ("submodule: teach rm to remove submodules unless they
contain a git directory", 2012-09-26) inserted the "Submodules"
section between a sentence describing a command and the command.  Move
the "Submodules" section further down.

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 Documentation/git-rm.txt |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 882cb11..262436b 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -107,21 +107,6 @@ as well as modifications of existing paths.
 Typically you would first remove all tracked files from the working
 tree using this command:
 
-Submodules
-~~~~~~~~~~
-Only submodules using a gitfile (which means they were cloned
-with a git version 1.7.8 or newer) will be removed from the work
-tree, as their repository lives inside the .git directory of the
-superproject. If a submodule (or one of those nested inside it)
-still uses a .git directory, `git rm` will fail - no matter if forced
-or not - to protect the submodule's history.
-
-A submodule is considered up-to-date when the HEAD is the same as
-recorded in the index, no tracked files are modified and no untracked
-files that aren't ignored are present in the submodules work tree.
-Ignored files are deemed expendable and won't stop a submodule's work
-tree from being removed.
-
 ----------------
 git ls-files -z | xargs -0 rm -f
 ----------------
@@ -149,6 +134,21 @@ use the following command:
 git diff --name-only --diff-filter=D -z | xargs -0 git rm --cached
 ----------------
 
+Submodules
+~~~~~~~~~~
+Only submodules using a gitfile (which means they were cloned
+with a git version 1.7.8 or newer) will be removed from the work
+tree, as their repository lives inside the .git directory of the
+superproject. If a submodule (or one of those nested inside it)
+still uses a .git directory, `git rm` will fail - no matter if forced
+or not - to protect the submodule's history.
+
+A submodule is considered up-to-date when the HEAD is the same as
+recorded in the index, no tracked files are modified and no untracked
+files that aren't ignored are present in the submodules work tree.
+Ignored files are deemed expendable and won't stop a submodule's work
+tree from being removed.
+
 EXAMPLES
 --------
 `git rm Documentation/\*.txt`::
-- 
1.7.2.5
