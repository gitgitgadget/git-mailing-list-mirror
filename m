From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/3] Make the documentation of options more consistent.
Date: Sun, 08 Apr 2007 17:12:11 +0200
Message-ID: <20070408151211.8884.26754.stgit@gandelf.nowhere.earth>
References: <20070408150822.8884.67664.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 17:15:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaZ4J-00023T-Lm
	for gcvg-git@gmane.org; Sun, 08 Apr 2007 17:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbXDHPMc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 11:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbXDHPMc
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 11:12:32 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:57739 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbXDHPMb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 11:12:31 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D69455DF91;
	Sun,  8 Apr 2007 17:12:29 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 35A451F094;
	Sun,  8 Apr 2007 17:12:11 +0200 (CEST)
In-Reply-To: <20070408150822.8884.67664.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44005>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/COMMAND-TEMPLATE.txt |    3 +-
 Documentation/stg-branch.txt       |   51 +++++++++++++-----------------------
 Documentation/stg-clone.txt        |    8 +-----
 Documentation/stg-cp.txt           |    9 ++++--
 Documentation/stg-init.txt         |    8 +-----
 Documentation/stg-new.txt          |   11 ++++----
 Documentation/stg.txt              |    8 +++++-
 7 files changed, 43 insertions(+), 55 deletions(-)

diff --git a/Documentation/COMMAND-TEMPLATE.txt b/Documentation/COMMAND-TEMPLATE.txt
index e49a44d..7bc029a 100644
--- a/Documentation/COMMAND-TEMPLATE.txt
+++ b/Documentation/COMMAND-TEMPLATE.txt
@@ -9,7 +9,8 @@ stg-NAME - stgdesc:NAME[]
 
 SYNOPSIS
 --------
-stg NAME [OPTIONS] XXX
+[verse]
+'stg' NAME [OPTIONS] XXX
 
 DESCRIPTION
 -----------
diff --git a/Documentation/stg-branch.txt b/Documentation/stg-branch.txt
index 28a9a28..2efe7b1 100644
--- a/Documentation/stg-branch.txt
+++ b/Documentation/stg-branch.txt
@@ -9,25 +9,17 @@ stg-branch - stgdesc:branch[]
 
 SYNOPSIS
 --------
-stg branch
-
-stg branch <branch>
-
-stg branch --list
-
-stg branch --create <newstack> [<commit-id>]
-
-stg branch --clone [<newstack>]
-
-stg branch --rename <oldname> <newname>
-
-stg branch --protect [<branch>]
-
-stg branch --unprotect [<branch>]
-
-stg branch --delete [--force] <branch>
-
-stg branch --convert
+[verse]
+'stg' branch
+'stg' branch <branch>
+'stg' branch --list
+'stg' branch --create <newstack> [<commit-id>]
+'stg' branch --clone [<newstack>]
+'stg' branch --rename <oldname> <newname>
+'stg' branch --protect [<branch>]
+'stg' branch --unprotect [<branch>]
+'stg' branch --delete [--force] <branch>
+'stg' branch --convert
 
 DESCRIPTION
 -----------
@@ -40,16 +32,14 @@ no command, no argument::
 no command, one argument::
 	Switch to the named <branch>.
 
---list::
--l::
+'stg' branch [-l | --list]::
 	Display the list of branches in the current repository,
 	suffixed by the branch description if any, and optionally
 	prefixed by the letter flags 's' if the branch is an StGIT
 	stack, and 'p' if the StGIT stack is protected.  The current
 	branch is shown with a leading ">" character.
 
---create::
--c::
+'stg' branch [-c | --create]::
 	Create a new StGIT stack based at the specified commit, or at
 	the current HEAD if not specified.  The repository HEAD is
 	switched to the new stack.
@@ -61,7 +51,7 @@ commits from the correct branch.  It will warn if it cannot guess the
 parent branch (eg. if you do not specify a branch name as
 <commit-id>).
 
---clone::
+'stg' branch --clone::
 	Clone the current stack, under the name <newstack> if
 	specified, or using the current stack's name suffixed by a
 	timestamp.
@@ -73,20 +63,17 @@ the current stack.
 Cloning a GIT branch that is not an StGIT stack is similar to creating
 a new stack off the current branch.
 
---rename::
--r::
+'stg' branch [-r | --rename]::
 	Rename the stack named <oldname> to <newname>.
 
---protect::
--p::
+'stg' branch [-p | --protect]::
 	Protect the named stack or the current one, preventing
 	further StGIT operations from modifying this stack.
 
---unprotect::
--u::
+'stg' branch [-u | --unprotect]::
 	Remove a "protected" flag previously set with '--protect'.
 
---delete::
+'stg' branch --delete::
 	Delete the named <branch>.  If there are any patches left in
 	the series, StGIT will refuse to delete it, unless '--force'
 	is specified.
@@ -100,7 +87,7 @@ the "master" branch if it exists.
 Branch "master" is treated specially (see bug #8732), in that only the
 StGIT metadata are removed, the GIT branch itself is not destroyed.
 
---convert::
+'stg' branch --convert::
 	Switch current stack between old and new format.
 
 OPTIONS
diff --git a/Documentation/stg-clone.txt b/Documentation/stg-clone.txt
index 126b0f2..19a8b79 100644
--- a/Documentation/stg-clone.txt
+++ b/Documentation/stg-clone.txt
@@ -9,7 +9,8 @@ stg-clone - stgdesc:clone[]
 
 SYNOPSIS
 --------
-stg clone [OPTIONS] <repository> <dir>
+[verse]
+'stg' clone <repository> <dir>
 
 DESCRIPTION
 -----------
@@ -26,11 +27,6 @@ commands of stglink:branch[].
 The target directory named by <dir> will be created by this command,
 and must not exist beforehand.
 
-OPTIONS
--------
-
-No specific options.
-
 StGIT
 -----
 Part of the StGIT suite - see gitlink:stg[1].
diff --git a/Documentation/stg-cp.txt b/Documentation/stg-cp.txt
index d28c619..2314925 100644
--- a/Documentation/stg-cp.txt
+++ b/Documentation/stg-cp.txt
@@ -9,9 +9,9 @@ stg-cp - stgdesc:cp[]
 
 SYNOPSIS
 --------
-stg cp [OPTIONS] <file|dir> <newname>
-
-stg cp [OPTIONS] <files|dirs...> <dir>
+[verse]
+'stg' cp [OPTIONS] <file|dir> <newname>
+'stg' cp [OPTIONS] <files|dirs...> <dir>
 
 DESCRIPTION
 -----------
@@ -44,6 +44,9 @@ that directory would be overwritten.
 FUTURE OPTIONS
 --------------
 
+No options are supported yet.  The following options may be
+implemented in the future.
+
 --all::
 	Also copy files not known to Git when copying a directory.
 
diff --git a/Documentation/stg-init.txt b/Documentation/stg-init.txt
index e692a04..03877e0 100644
--- a/Documentation/stg-init.txt
+++ b/Documentation/stg-init.txt
@@ -9,7 +9,8 @@ stg-init - stgdesc:init[]
 
 SYNOPSIS
 --------
-stg init [OPTIONS]
+[verse]
+'stg' init
 
 DESCRIPTION
 -----------
@@ -23,11 +24,6 @@ This operation is for example suitable to start working using the
 an StGIT stack are stglink:clone[] and the '--create' and '--clone'
 commands of stglink:branch[].
 
-OPTIONS
--------
-
-No specific options.
-
 StGIT
 -----
 Part of the StGIT suite - see gitlink:stg[1].
diff --git a/Documentation/stg-new.txt b/Documentation/stg-new.txt
index 5775559..009659a 100644
--- a/Documentation/stg-new.txt
+++ b/Documentation/stg-new.txt
@@ -9,7 +9,8 @@ stg-new - stgdesc:new[]
 
 SYNOPSIS
 --------
-stg new [OPTIONS] <name>
+[verse]
+'stg' new [OPTIONS] <name>
 
 DESCRIPTION
 -----------
@@ -20,6 +21,9 @@ is made the new top of the stack.  The local changes in the working
 tree are not included in the patch. A stglink:refresh[] command is
 needed for this.
 
+The given <name> must be unique in the stack, and may only contain
+alphanumeric characters, dashes and underscores.
+
 An editor will be launched to edit the commit message to be used for
 the patch, unless the '--message' flag already specified one.  The
 'patchdescr.tmpl' template file is used if available to pre-fill the
@@ -57,11 +61,6 @@ described in gitlink:git-commit-tree[1].
 OPTIONS
 -------
 
-<name>::
-	The short name that will be used as to identify the patch in
-	other StGIT commands.  Must be unique in the stack.  May only
-	contain alphanumeric characters, dashes and underscores.
-
 --message=<message>::
 -m <message>::
 	Use <message> as the patch description.
diff --git a/Documentation/stg.txt b/Documentation/stg.txt
index 47934a5..a91b600 100644
--- a/Documentation/stg.txt
+++ b/Documentation/stg.txt
@@ -10,7 +10,9 @@ stg - manage stacks of patches using the GIT content tracker
 SYNOPSIS
 --------
 [verse]
-'stg' [--version] [--help] <command> [OPTIONS] [ARGS]
+'stg' [--version | --help]
+'stg' [--help <command> | <command> --help]
+'stg' <command> [COMMAND OPTIONS] [ARGS]
 
 DESCRIPTION
 -----------
@@ -52,6 +54,10 @@ patches; there may be regular GIT commits below your stack base.
 OPTIONS
 -------
 
+The following generic option flags are available.  Additional options
+are available per-command, and documented in the command-specific
+documentation.
+
 --version::
 	Prints the StGIT suite version that the 'stg' program came
 	from, as well as version of other components used, such as GIT
