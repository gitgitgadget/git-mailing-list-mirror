From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/2] difftool: fix documentation problems
Date: Sun, 18 Jan 2009 21:27:19 -0800
Message-ID: <1232342840-27459-1-git-send-email-davvid@gmail.com>
Cc: gitster@pobox.com, David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 06:28:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOmg9-0002s4-4g
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 06:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609AbZASF0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 00:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754460AbZASF0j
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 00:26:39 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:34302 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbZASF0i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 00:26:38 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2463014rvb.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 21:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=wABE3J0qgpTl23phia00/QlPQXmTM+xBSvPemcQrdvY=;
        b=Rf2PZxoPkzxDSWJsfdhz1l/hJIN0ZhBV4u85MPTd6p0M5jVXI4ZhvhAEEdCHvkrHvq
         FaQmVZqUAbwxqS+6/So+yCIdSk7Feqj23eHOihw2GzgiWzauAboOteL0rTcZgQDyh02P
         dfSGozti1YRX13dY1TL86xrpD/zwqFYTNC3HQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nrZDtCEH5Kn5Bj2KOvhK3DHDf+hq/4Mok0PZ4hr+u0/lJmuP6JUL9GubYr1XiaH9e5
         d8kJkBH6lNLeUrLhMPYk69xZvFtkmvk6gDhvcyaKA5EXNt+QIB1c82qGmBLZDSPUmrAA
         /vlLYd0E2ZkMMJZhocZe32mvpSYsuwOOBWp2o=
Received: by 10.141.129.14 with SMTP id g14mr1302515rvn.8.1232342797451;
        Sun, 18 Jan 2009 21:26:37 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id g14sm3716522rvb.0.2009.01.18.21.26.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Jan 2009 21:26:36 -0800 (PST)
X-Mailer: git-send-email 1.6.1.149.g7bbd8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106322>

This patch makes the difftool docs always refer to the
git-difftool script using the dashed form of the name.
Only command examples use the non-dashed form now.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/difftool/git-difftool     |    5 ++---
 contrib/difftool/git-difftool.txt |   20 ++++++++++----------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/contrib/difftool/git-difftool b/contrib/difftool/git-difftool
index 1fc087c..0cda3d2 100755
--- a/contrib/difftool/git-difftool
+++ b/contrib/difftool/git-difftool
@@ -4,7 +4,7 @@
 # This is a wrapper around the GIT_EXTERNAL_DIFF-compatible
 # git-difftool-helper script.  This script exports
 # GIT_EXTERNAL_DIFF and GIT_PAGER for use by git, and
-# GIT_NO_PROMPT and GIT_MERGE_TOOL for use by git-difftool-helper.
+# GIT_DIFFTOOL_NO_PROMPT and GIT_MERGE_TOOL for use by git-difftool-helper.
 # Any arguments that are unknown to this script are forwarded to 'git diff'.
 
 use strict;
@@ -18,8 +18,7 @@ my $DIR = abs_path(dirname($0));
 sub usage
 {
 	print << 'USAGE';
-
-usage: git difftool [--no-prompt] [--tool=tool] ["git diff" options]
+usage: git difftool [--tool=<tool>] [--no-prompt] ["git diff" options]
 USAGE
 	exit 1;
 }
diff --git a/contrib/difftool/git-difftool.txt b/contrib/difftool/git-difftool.txt
index 3940c70..ca3dbd2 100644
--- a/contrib/difftool/git-difftool.txt
+++ b/contrib/difftool/git-difftool.txt
@@ -11,16 +11,16 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-'git difftool' is a git command that allows you to compare and edit files
+'git-difftool' is a git command that allows you to compare and edit files
 between revisions using common merge tools.  At its most basic level,
-'git difftool' does what 'git mergetool' does but its use is for non-merge
+'git-difftool' does what 'git-mergetool' does but its use is for non-merge
 situations such as when preparing commits or comparing changes against
 the index.
 
 'git difftool' is a frontend to 'git diff' and accepts the same
 arguments and options.
 
-See linkgit:git-diff[7] for the full list of supported options.
+See linkgit:git-diff[1] for the full list of supported options.
 
 OPTIONS
 -------
@@ -30,7 +30,7 @@ OPTIONS
 	Valid merge tools are:
 	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge, and opendiff
 +
-If a merge resolution program is not specified, 'git difftool'
+If a merge resolution program is not specified, 'git-difftool'
 will use the configuration variable `merge.tool`.  If the
 configuration variable `merge.tool` is not set, 'git difftool'
 will pick a suitable default.
@@ -38,15 +38,15 @@ will pick a suitable default.
 You can explicitly provide a full path to the tool by setting the
 configuration variable `mergetool.<tool>.path`. For example, you
 can configure the absolute path to kdiff3 by setting
-`mergetool.kdiff3.path`. Otherwise, 'git difftool' assumes the
+`mergetool.kdiff3.path`. Otherwise, 'git-difftool' assumes the
 tool is available in PATH.
 +
 Instead of running one of the known merge tool programs,
-'git difftool' can be customized to run an alternative program
+'git-difftool' can be customized to run an alternative program
 by specifying the command line to invoke in a configuration
 variable `mergetool.<tool>.cmd`.
 +
-When 'git difftool' is invoked with this tool (either through the
+When 'git-difftool' is invoked with this tool (either through the
 `-t` or `--tool` option or the `merge.tool` configuration variable)
 the configured command line will be invoked with the following
 variables available: `$LOCAL` is set to the name of the temporary
@@ -56,7 +56,7 @@ of the diff post-image.  `$BASE` is provided for compatibility
 with custom merge tool commands and has the same value as `$LOCAL`.
 
 --no-prompt::
-	Do not prompt before launching a merge tool.
+	Do not prompt before launching a diff tool.
 
 CONFIG VARIABLES
 ----------------
@@ -81,13 +81,13 @@ See the `--tool=<tool>` option above for more details.
 
 SEE ALSO
 --------
-linkgit:git-diff[7]::
+linkgit:git-diff[1]::
 	 Show changes between commits, commit and working tree, etc
 
 linkgit:git-mergetool[1]::
 	Run merge conflict resolution tools to resolve merge conflicts
 
-linkgit:git-config[7]::
+linkgit:git-config[1]::
 	 Get and set repository or global options
 
 
-- 
1.6.1.149.g7bbd8
