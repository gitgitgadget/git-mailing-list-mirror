From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/4] Add doc for 'clone' and 'init'.
Date: Sat, 07 Apr 2007 23:37:03 +0200
Message-ID: <20070407213703.13698.16716.stgit@gandelf.nowhere.earth>
References: <20070407213557.13698.21486.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 00:08:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaIb7-0002yD-Ka
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 23:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966357AbXDGVhV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 17:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966358AbXDGVhV
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 17:37:21 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51827 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966357AbXDGVhT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 17:37:19 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 8FD215C3C8;
	Sat,  7 Apr 2007 23:37:18 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 6B64E1F096;
	Sat,  7 Apr 2007 23:37:03 +0200 (CEST)
In-Reply-To: <20070407213557.13698.21486.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43989>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/stg-clone.txt |   36 ++++++++++++++++++++++++++++++++++++
 Documentation/stg-init.txt  |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/Documentation/stg-clone.txt b/Documentation/stg-clone.txt
new file mode 100644
index 0000000..73c0d92
--- /dev/null
+++ b/Documentation/stg-clone.txt
@@ -0,0 +1,36 @@
+stg-clone(1)
+==========
+Yann Dirson <ydirson@altern.org>
+v0.12.1, April 2007
+
+NAME
+----
+stg-clone - stgdesc:clone[]
+
+SYNOPSIS
+--------
+stg clone [OPTIONS] <repository> <dir>
+
+DESCRIPTION
+-----------
+
+Clone a GIT <repository> into the local <dir> (using
+gitlink:git-clone[1]) and initialise the resulting "master" branch as
+a patch stack.
+
+This operation is for example suitable to start working using the
+"tracking branch" workflow (see gitlink:stg[1]).  Other means to setup
+an StGIT stack are stgdesc:init[] and the '--create' and '--clone'
+commands of stgdesc:branch[].
+
+The target directory named by <dir> will be created by this command,
+and must not exist beforehand.
+
+OPTIONS
+-------
+
+No specific options.
+
+StGIT
+-----
+Part of the StGIT suite - see gitlink:stg[1].
diff --git a/Documentation/stg-init.txt b/Documentation/stg-init.txt
new file mode 100644
index 0000000..33fd387
--- /dev/null
+++ b/Documentation/stg-init.txt
@@ -0,0 +1,33 @@
+stg-init(1)
+==========
+Yann Dirson <ydirson@altern.org>
+v0.12.1, April 2007
+
+NAME
+----
+stg-init - stgdesc:init[]
+
+SYNOPSIS
+--------
+stg init [OPTIONS]
+
+DESCRIPTION
+-----------
+
+Initialise the current GIT branch to be used as an StGIT stack.  You
+must already be in a GIT repository and .git/HEAD must point to a
+valid file in refs/heads/.
+
+This operation is for example suitable to start working using the
+"development branch" workflow (see gitlink:stg[1]).  Other means to setup
+an StGIT stack are stgdesc:clone[] and the '--create' and '--clone'
+commands of stgdesc:branch[].
+
+OPTIONS
+-------
+
+No specific options.
+
+StGIT
+-----
+Part of the StGIT suite - see gitlink:stg[1].
