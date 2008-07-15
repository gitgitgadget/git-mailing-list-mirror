From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Documentation/git-submodule.txt: Add Description section
Date: Tue, 15 Jul 2008 12:22:07 +0200
Message-ID: <20080715102119.26321.78530.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 15 12:34:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIhpT-0006II-9H
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 12:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbYGOKbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 06:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754746AbYGOKbU
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 06:31:20 -0400
Received: from [212.249.11.140] ([212.249.11.140]:29663 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754683AbYGOKbT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 06:31:19 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jul 2008 06:31:19 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 9BCF42ACC7D;
	Tue, 15 Jul 2008 12:22:07 +0200 (CEST)
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88548>

Figuring out how submodules work conceptually is quite a bumpy
ride for a newcomer; the user manual helps (if one knows to actually
look into it), but the reference documentation should provide good
quick intro as well. This patch attempts to do that.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-submodule.txt |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 105fc2d..3413704 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -16,6 +16,24 @@ SYNOPSIS
 'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
 
 
+DESCRIPTION
+-----------
+Submodules are a special kind of tree entries which do not refer to a blob or
+a directory, but to a particular tree in another repository (living at a given
+URL).  The tree entry describes the existence of a submodule with the given
+name and the exact revision that should be used, while the location of the
+repository is described in the `/.gitmodules` file.  This command will manage
+the tree entries and contents of this file for you, as well as inspecting the
+status of your submodules and updating them.
+
+When adding a new submodule to the tree, the 'add' subcommand is to be used.
+However, when pulling a tree containing submodules, these will not be checked
+out by default; the 'init' and 'update' subcommands will maintain submodules
+checked out and at appropriate revision in your working tree. You can inspect
+the current status of your submodules using the 'submodule' subcommand and get
+an overview of changes 'update' would perform using the 'summary' subcommand.
+
+
 COMMANDS
 --------
 add::
