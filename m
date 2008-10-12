From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/4] Tutorial: Talk about conflicts when introducing
	StGit
Date: Sun, 12 Oct 2008 17:11:33 +0200
Message-ID: <20081012151133.17648.7945.stgit@yoghurt>
References: <20081012150825.17648.3315.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 17:13:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp2cz-0004du-5c
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 17:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749AbYJLPLh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Oct 2008 11:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753653AbYJLPLg
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 11:11:36 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1048 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbYJLPLg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 11:11:36 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Kp2bV-0006WB-00; Sun, 12 Oct 2008 16:11:33 +0100
In-Reply-To: <20081012150825.17648.3315.stgit@yoghurt>
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98028>

Conflicts and conflict resolving are essential features of StGit, so
we'd better tell the user about them.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 Documentation/stg.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)


diff --git a/Documentation/stg.txt b/Documentation/stg.txt
index 5973a6b..fc8fd7c 100644
--- a/Documentation/stg.txt
+++ b/Documentation/stg.txt
@@ -38,6 +38,14 @@ to maintain a 'patch stack' on top of a Git branch:
     an updated branch, you can take all your patches and apply them on
     top of the updated branch.
=20
+  * As you would expect, changing what is below a patch can cause that
+    patch to no longer apply cleanly -- this can occur when you
+    reorder patches, rebase patches, or refresh a non-topmost patch.
+    StGit uses Git's rename-aware three-way merge capability to
+    automatically fix up what it can; if it still fails, it lets you
+    manually resolve the conflict just like you would resolve a merge
+    conflict in Git.
+
   * The patch stack is just some extra metadata attached to regular
     Git commits, so you can continue to use most Git tools along with
     StGit.
