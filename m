From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/17] Documentation: remove backslashes in manpage synopses
Date: Fri, 20 Aug 2010 05:31:58 -0500
Message-ID: <20100820103158.GH10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:33:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmOux-0003Oo-4H
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316Ab0HTKdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 06:33:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49260 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab0HTKdk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 06:33:40 -0400
Received: by iwn5 with SMTP id 5so686164iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6mtHTljKoBrCu2BIVz9RP/LBWJR3Z6vz6y/gfV2ZQeI=;
        b=PKYHBHw9nRLEXzCzd6Y8V3dfoJp9MJT+jQRMXttNzSyKqZQkTww25SGTMbHiz0ca6w
         Hg+G6gvrPWG4ZPWL/qNBzvsHvMKyOUmv/09oE8llf8ZvPYVbLmTEl7+Sp7NTL7ahzKfS
         qn0peBhaKTdIZchmgOWsmJwVTwLqfQajgIWuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FJIkwm3hxeTbJEMVNcxRJ2QF+h3kcvJtTl0o/3ChLpwR6Lo1cLTlIGoXU0adhWcEph
         nJmtbJqKRIATCfqLgFDGecaWejoGnRyaI0qdp0cWyJTrXU4fn/q3HvkCO4MenYcFndnt
         1qMshCH7fYoko5h+btOPhfXIzztzBiRyjyhxE=
Received: by 10.231.157.205 with SMTP id c13mr1336103ibx.71.1282300419626;
        Fri, 20 Aug 2010 03:33:39 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm2494588ibh.22.2010.08.20.03.33.39
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:33:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154003>

For some reason, various manual pages have an asterisk escaped
with \ in the synopsis.  Since there is no other asterisk to pair it
with, Asciidoc does not consider this asterisk escapable, so it passes
the backslash through.

Each page either uses [verse] or has only one asterisk, so it
is safe to drop the backslashes (checked with asciidoc 8.5.2).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-checkout-index.txt |    2 +-
 Documentation/git-commit-tree.txt    |    2 +-
 Documentation/git-for-each-ref.txt   |    2 +-
 Documentation/git-ls-files.txt       |    6 +++---
 Documentation/git-merge-index.txt    |    2 +-
 Documentation/git-relink.txt         |    2 +-
 Documentation/git-update-index.txt   |    4 ++--
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index d6aa6e1..62f9ab2 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 		   [--stage=<number>|all]
 		   [--temp]
 		   [-z] [--stdin]
-		   [--] [<file>]\*
+		   [--] [<file>]*
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 6188854..349366e 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -8,7 +8,7 @@ git-commit-tree - Create a new commit object
 
 SYNOPSIS
 --------
-'git commit-tree' <tree> [-p <parent commit>]\* < changelog
+'git commit-tree' <tree> [-p <parent commit>]* < changelog
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 390d85c..d66fd9d 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
-		   [--sort=<key>]\* [--format=<format>] [<pattern>...]
+		   [--sort=<key>]* [--format=<format>] [<pattern>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index bd919f2..45a7f56 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -10,14 +10,14 @@ SYNOPSIS
 --------
 [verse]
 'git ls-files' [-z] [-t] [-v]
-		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])\*
-		(-[c|d|o|i|s|u|k|m])\*
+		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
+		(-[c|d|o|i|s|u|k|m])*
 		[-x <pattern>|--exclude=<pattern>]
 		[-X <file>|--exclude-from=<file>]
 		[--exclude-per-directory=<file>]
 		[--exclude-standard]
 		[--error-unmatch] [--with-tree=<tree-ish>]
-		[--full-name] [--abbrev] [--] [<file>]\*
+		[--full-name] [--abbrev] [--] [<file>]*
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 4d266de..921b38f 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -8,7 +8,7 @@ git-merge-index - Run a merge for files needing merging
 
 SYNOPSIS
 --------
-'git merge-index' [-o] [-q] <merge-program> (-a | [--] <file>\*)
+'git merge-index' [-o] [-q] <merge-program> (-a | [--] <file>*)
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-relink.txt b/Documentation/git-relink.txt
index 25ff8f9..8a5842b 100644
--- a/Documentation/git-relink.txt
+++ b/Documentation/git-relink.txt
@@ -7,7 +7,7 @@ git-relink - Hardlink common objects in local repositories
 
 SYNOPSIS
 --------
-'git relink' [--safe] <dir> [<dir>]\* <master_dir>
+'git relink' [--safe] <dir> [<dir>]* <master_dir>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 765d4b3..74d1d49 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git update-index'
 	     [--add] [--remove | --force-remove] [--replace]
 	     [--refresh] [-q] [--unmerged] [--ignore-missing]
-	     [--cacheinfo <mode> <object> <file>]\*
+	     [--cacheinfo <mode> <object> <file>]*
 	     [--chmod=(+|-)x]
 	     [--assume-unchanged | --no-assume-unchanged]
 	     [--skip-worktree | --no-skip-worktree]
@@ -21,7 +21,7 @@ SYNOPSIS
 	     [--info-only] [--index-info]
 	     [-z] [--stdin]
 	     [--verbose]
-	     [--] [<file>]\*
+	     [--] [<file>]*
 
 DESCRIPTION
 -----------
-- 
1.7.2.2.536.g42dab.dirty
