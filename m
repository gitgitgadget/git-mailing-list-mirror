From: ayiehere@gmail.com
Subject: [PATCH] Update $GIT_DIR/remotes to $GIT_DIR/refs/remotes in docs
Date: Mon, 30 Nov 2009 11:38:36 +0800
Message-ID: <1259552316-20088-2-git-send-email-ayiehere@gmail.com>
References: <1259552316-20088-1-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 05:01:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NExRe-00023t-8O
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 05:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbZK3EAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 23:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753480AbZK3EAv
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 23:00:51 -0500
Received: from raven4.regentmarkets.com ([213.137.29.27]:32837 "EHLO
	raven4.regentmarkets.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267AbZK3EAu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 23:00:50 -0500
Received: from mailvz.regentmarkets.com (mindx.regentmarkets.com [202.168.70.162])
	by raven4.regentmarkets.com (Postfix) with SMTP id E917A2248293;
	Mon, 30 Nov 2009 04:00:54 +0000 (UTC)
Received: from mailvz.regentmarkets.com (localhost.localdomain [127.0.0.1])
	by mailvz.regentmarkets.com (Postfix) with ESMTP id 3059F4E84732;
	Mon, 30 Nov 2009 12:00:53 +0800 (MYT)
Received: from nazri (harimau [192.168.12.202])
	by mailvz.regentmarkets.com (Postfix) with ESMTP id 1C0794E843E2;
	Mon, 30 Nov 2009 12:00:52 +0800 (MYT)
Received: by nazri (sSMTP sendmail emulation); Mon, 30 Nov 2009 12:00:59 +0800
X-Mailer: git-send-email 1.6.6.rc0.63.g66abc
In-Reply-To: <1259552316-20088-1-git-send-email-ayiehere@gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134046>

From: Nazri Ramliy <ayiehere@gmail.com>

---
 Documentation/git-parse-remote.txt |    2 +-
 Documentation/git-pull.txt         |    6 +++---
 Documentation/git-remote.txt       |   14 +++++++-------
 Documentation/git-show-branch.txt  |    2 +-
 Documentation/urls-remotes.txt     |    8 ++++----
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse-remote.txt
index 39d9daa..9d27489 100644
--- a/Documentation/git-parse-remote.txt
+++ b/Documentation/git-parse-remote.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 This script is included in various scripts to supply
-routines to parse files under $GIT_DIR/remotes/ and
+routines to parse files under $GIT_DIR/refs/remotes/ and
 $GIT_DIR/branches/ and configuration variables that are related
 to fetching, pulling and pushing.
 
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index b932011..250d64c 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -74,13 +74,13 @@ present while on branch `<name>`, that value is used instead of
 In order to determine what URL to use to fetch from, the value
 of the configuration `remote.<origin>.url` is consulted
 and if there is not any such variable, the value on `URL: ` line
-in `$GIT_DIR/remotes/<origin>` file is used.
+in `$GIT_DIR/refs/remotes/<origin>` file is used.
 
 In order to determine what remote branches to fetch (and
 optionally store in the tracking branches) when the command is
 run without any refspec parameters on the command line, values
 of the configuration variable `remote.<origin>.fetch` are
-consulted, and if there aren't any, `$GIT_DIR/remotes/<origin>`
+consulted, and if there aren't any, `$GIT_DIR/refs/remotes/<origin>`
 file is consulted and its `Pull: ` lines are used.
 In addition to the refspec formats described in the OPTIONS
 section, you can have a globbing refspec that looks like this:
@@ -104,7 +104,7 @@ line of `git pull`, they are all merged.
 
 When no refspec was given on the command line, then `git pull`
 uses the refspec from the configuration or
-`$GIT_DIR/remotes/<origin>`.  In such cases, the following
+`$GIT_DIR/refs/remotes/<origin>`.  In such cases, the following
 rules apply:
 
 . If `branch.<name>.merge` configuration for the current
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index c272c92..9dbcb0b 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -50,11 +50,11 @@ the remote information is set up.
 +
 With `-t <branch>` option, instead of the default glob
 refspec for the remote to track all branches under
-`$GIT_DIR/remotes/<name>/`, a refspec to track only `<branch>`
+`$GIT_DIR/refs/remotes/<name>/`, a refspec to track only `<branch>`
 is created.  You can give more than one `-t <branch>` to track
 multiple branches without grabbing all branches.
 +
-With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
+With `-m <master>` option, `$GIT_DIR/refs/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch. See also the set-head command.
 +
 In mirror mode, enabled with `\--mirror`, the refs will not be stored
@@ -69,7 +69,7 @@ Rename the remote named <old> to <new>. All remote tracking branches and
 configuration settings for the remote are updated.
 +
 In case <old> and <new> are the same, and <old> is a file under
-`$GIT_DIR/remotes` or `$GIT_DIR/branches`, the remote is converted to
+`$GIT_DIR/refs/remotes` or `$GIT_DIR/branches`, the remote is converted to
 the configuration file format.
 
 'rm'::
@@ -79,23 +79,23 @@ configuration settings for the remote are removed.
 
 'set-head'::
 
-Sets or deletes the default branch (`$GIT_DIR/remotes/<name>/HEAD`) for
+Sets or deletes the default branch (`$GIT_DIR/refs/remotes/<name>/HEAD`) for
 the named remote. Having a default branch for a remote is not required,
 but allows the name of the remote to be specified in lieu of a specific
 branch. For example, if the default branch for `origin` is set to
 `master`, then `origin` may be specified wherever you would normally
 specify `origin/master`.
 +
-With `-d`, `$GIT_DIR/remotes/<name>/HEAD` is deleted.
+With `-d`, `$GIT_DIR/refs/remotes/<name>/HEAD` is deleted.
 +
 With `-a`, the remote is queried to determine its `HEAD`, then
-`$GIT_DIR/remotes/<name>/HEAD` is set to the same branch. e.g., if the remote
+`$GIT_DIR/refs/remotes/<name>/HEAD` is set to the same branch. e.g., if the remote
 `HEAD` is pointed at `next`, "`git remote set-head origin -a`" will set
 `$GIT_DIR/refs/remotes/origin/HEAD` to `refs/remotes/origin/next`. This will
 only work if `refs/remotes/origin/next` already exists; if not it must be
 fetched first.
 +
-Use `<branch>` to set `$GIT_DIR/remotes/<name>/HEAD` explicitly. e.g., "git
+Use `<branch>` to set `$GIT_DIR/refs/remotes/<name>/HEAD` explicitly. e.g., "git
 remote set-head origin master" will set `$GIT_DIR/refs/remotes/origin/HEAD` to
 `refs/remotes/origin/master`. This will only work if
 `refs/remotes/origin/master` already exists; if not it must be fetched first.
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 7343361..3671c2e 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -161,7 +161,7 @@ $ git show-branch master fixes mhf
   + [mhf~5] Infamous 'octopus merge'
   + [mhf~6] Retire git-parse-remote.
   + [mhf~7] Multi-head fetch.
-  + [mhf~8] Start adding the $GIT_DIR/remotes/ support.
+  + [mhf~8] Start adding the $GIT_DIR/refs/remotes/ support.
 *++ [master] Add 'git show-branch'.
 ------------------------------------------------
 
diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index 2a0e7b8..5c4deeb 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -7,7 +7,7 @@ The name of one of the following can be used instead
 of a URL as `<repository>` argument:
 
 * a remote in the git configuration file: `$GIT_DIR/config`,
-* a file in the `$GIT_DIR/remotes` directory, or
+* a file in the `$GIT_DIR/refs/remotes` directory, or
 * a file in the `$GIT_DIR/branches` directory.
 
 All of these also allow you to omit the refspec from the command line
@@ -35,11 +35,11 @@ config file would appear like this:
 The `<pushurl>` is used for pushes only. It is optional and defaults
 to `<url>`.
 
-Named file in `$GIT_DIR/remotes`
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Named file in `$GIT_DIR/refs/remotes`
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 You can choose to provide the name of a
-file in `$GIT_DIR/remotes`.  The URL
+file in `$GIT_DIR/refs/remotes`.  The URL
 in this file will be used to access the repository.  The refspec
 in this file will be used as default when you do not
 provide a refspec on the command line.  This file should have the
-- 
1.6.6.rc0.63.g66abc
