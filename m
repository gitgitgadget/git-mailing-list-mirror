From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/3] Fix doc cross-refs.
Date: Sun, 08 Apr 2007 17:12:06 +0200
Message-ID: <20070408151205.8884.44977.stgit@gandelf.nowhere.earth>
References: <20070408150822.8884.67664.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 17:14:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaZ4B-00022T-U9
	for gcvg-git@gmane.org; Sun, 08 Apr 2007 17:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbXDHPM1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 11:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbXDHPM1
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 11:12:27 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:57730 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbXDHPMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 11:12:25 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B5BD85DFD8;
	Sun,  8 Apr 2007 17:12:24 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 14BAD1F094;
	Sun,  8 Apr 2007 17:12:06 +0200 (CEST)
In-Reply-To: <20070408150822.8884.67664.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44002>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/stg-branch.txt |    2 +-
 Documentation/stg-clone.txt  |    4 ++--
 Documentation/stg-init.txt   |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/stg-branch.txt b/Documentation/stg-branch.txt
index 53f333b..28a9a28 100644
--- a/Documentation/stg-branch.txt
+++ b/Documentation/stg-branch.txt
@@ -56,7 +56,7 @@ no command, one argument::
 +
 StGIT will try to detect the branch off which the new stack is forked,
 as well as the remote repository from which that parent branch is
-taken (if any), so running stgdesc:pull[] will effectively pull new
+taken (if any), so running stglink:pull[] will effectively pull new
 commits from the correct branch.  It will warn if it cannot guess the
 parent branch (eg. if you do not specify a branch name as
 <commit-id>).
diff --git a/Documentation/stg-clone.txt b/Documentation/stg-clone.txt
index 73c0d92..126b0f2 100644
--- a/Documentation/stg-clone.txt
+++ b/Documentation/stg-clone.txt
@@ -20,8 +20,8 @@ a patch stack.
 
 This operation is for example suitable to start working using the
 "tracking branch" workflow (see gitlink:stg[1]).  Other means to setup
-an StGIT stack are stgdesc:init[] and the '--create' and '--clone'
-commands of stgdesc:branch[].
+an StGIT stack are stglink:init[] and the '--create' and '--clone'
+commands of stglink:branch[].
 
 The target directory named by <dir> will be created by this command,
 and must not exist beforehand.
diff --git a/Documentation/stg-init.txt b/Documentation/stg-init.txt
index 33fd387..e692a04 100644
--- a/Documentation/stg-init.txt
+++ b/Documentation/stg-init.txt
@@ -20,8 +20,8 @@ valid file in refs/heads/.
 
 This operation is for example suitable to start working using the
 "development branch" workflow (see gitlink:stg[1]).  Other means to setup
-an StGIT stack are stgdesc:clone[] and the '--create' and '--clone'
-commands of stgdesc:branch[].
+an StGIT stack are stglink:clone[] and the '--create' and '--clone'
+commands of stglink:branch[].
 
 OPTIONS
 -------
