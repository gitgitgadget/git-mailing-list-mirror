Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38E6C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6B1611EE
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhKFSwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 14:52:20 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:64126 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234059AbhKFSwT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 14:52:19 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 928DA19F4B5;
        Sat,  6 Nov 2021 19:49:33 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/10] doc: express grammar placeholders between angle brackets
Date:   Sat,  6 Nov 2021 19:48:51 +0100
Message-Id: <20211106184858.11500-4-jn.avila@free.fr>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211106184858.11500-1-jn.avila@free.fr>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <20211106184858.11500-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This discerns user inputs from verbatim options in the synopsis.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-cherry-pick.txt     |  6 ++--
 Documentation/git-config.txt          | 46 +++++++++++++--------------
 Documentation/git-cvsexportcommit.txt |  4 +--
 Documentation/git-gui.txt             |  2 +-
 Documentation/git-help.txt            |  6 ++--
 Documentation/git-http-fetch.txt      |  2 +-
 Documentation/git-init.txt            |  2 +-
 Documentation/git-pack-objects.txt    |  4 +--
 Documentation/git-pack-redundant.txt  |  2 +-
 Documentation/git-reflog.txt          |  4 +--
 Documentation/git-sparse-checkout.txt |  2 +-
 Documentation/git-stage.txt           |  2 +-
 12 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 5d750314b2..78dcc9171f 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -8,7 +8,7 @@ git-cherry-pick - Apply the changes introduced by some existing commits
 SYNOPSIS
 --------
 [verse]
-'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff]
+'git cherry-pick' [--edit] [-n] [-m <parent-number>] [-s] [-x] [--ff]
 		  [-S[<keyid>]] <commit>...
 'git cherry-pick' (--continue | --skip | --abort | --quit)
 
@@ -81,8 +81,8 @@ OPTIONS
 	described above, and `-r` was to disable it.  Now the
 	default is not to do `-x` so this option is a no-op.
 
--m parent-number::
---mainline parent-number::
+-m <parent-number>::
+--mainline <parent-number>::
 	Usually you cannot cherry-pick a merge because you do not know which
 	side of the merge should be considered the mainline.  This
 	option specifies the parent number (starting from 1) of
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 992225f612..2285effb36 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,20 +9,20 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [--type=<type>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] name [value [value-pattern]]
-'git config' [<file-option>] [--type=<type>] --add name value
-'git config' [<file-option>] [--type=<type>] [--fixed-value] --replace-all name value [value-pattern]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get name [value-pattern]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all name [value-pattern]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp name_regex [value-pattern]
-'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
-'git config' [<file-option>] [--fixed-value] --unset name [value-pattern]
-'git config' [<file-option>] [--fixed-value] --unset-all name [value-pattern]
-'git config' [<file-option>] --rename-section old_name new_name
-'git config' [<file-option>] --remove-section name
+'git config' [<file-option>] [--type=<type>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] <name> [<value> [<value-pattern>]]
+'git config' [<file-option>] [--type=<type>] --add <name> <value>
+'git config' [<file-option>] [--type=<type>] [--fixed-value] --replace-all <name> <value> [<value-pattern>]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get <name> [<value-pattern>]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all <name> [<value-pattern>]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp <name-regex> [<value-pattern>]
+'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch <name> <URL>
+'git config' [<file-option>] [--fixed-value] --unset <name> [<value-pattern>]
+'git config' [<file-option>] [--fixed-value] --unset-all <name> [<value-pattern>]
+'git config' [<file-option>] --rename-section <old-name> <new-name>
+'git config' [<file-option>] --remove-section <name>
 'git config' [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
-'git config' [<file-option>] --get-color name [default]
-'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
+'git config' [<file-option>] --get-color <name> [<default>]
+'git config' [<file-option>] --get-colorbool <name> [<stdout-is-tty>]
 'git config' [<file-option>] -e | --edit
 
 DESCRIPTION
@@ -102,9 +102,9 @@ OPTIONS
 	in which section and variable names are lowercased, but subsection
 	names are not.
 
---get-urlmatch name URL::
+--get-urlmatch <name> <URL>::
 	When given a two-part name section.key, the value for
-	section.<url>.key whose <url> part matches the best to the
+	section.<URL>.key whose <URL> part matches the best to the
 	given URL is returned (if no such key exists, the value for
 	section.key is used as a fallback).  When given just the
 	section as name, do so for all the keys in the section and
@@ -145,8 +145,8 @@ See also <<FILES>>.
 	read from or written to if `extensions.worktreeConfig` is
 	present. If not it's the same as `--local`.
 
--f config-file::
---file config-file::
+-f <config-file>::
+--file <config-file>::
 	For writing options: write to the specified file rather than the
 	repository `.git/config`.
 +
@@ -155,7 +155,7 @@ available files.
 +
 See also <<FILES>>.
 
---blob blob::
+--blob <blob>::
 	Similar to `--file` but use the given blob instead of a file. E.g.
 	you can use 'master:.gitmodules' to read values from the file
 	'.gitmodules' in the master branch. See "SPECIFYING REVISIONS"
@@ -246,18 +246,18 @@ Valid `<type>`'s include:
 	all queried config options with the scope of that value
 	(local, global, system, command).
 
---get-colorbool name [stdout-is-tty]::
+--get-colorbool <name> [<stdout-is-tty>]::
 
-	Find the color setting for `name` (e.g. `color.diff`) and output
-	"true" or "false".  `stdout-is-tty` should be either "true" or
+	Find the color setting for `<name>` (e.g. `color.diff`) and output
+	"true" or "false".  `<stdout-is-tty>` should be either "true" or
 	"false", and is taken into account when configuration says
-	"auto".  If `stdout-is-tty` is missing, then checks the standard
+	"auto".  If `<stdout-is-tty>` is missing, then checks the standard
 	output of the command itself, and exits with status 0 if color
 	is to be used, or exits with status 1 otherwise.
 	When the color setting for `name` is undefined, the command uses
 	`color.ui` as fallback.
 
---get-color name [default]::
+--get-color <name> [<default>]::
 
 	Find the color configured for `name` (e.g. `color.diff.new`) and
 	output it as the ANSI color escape sequence to the standard
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 00154b6c85..41c8a8a05c 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -9,8 +9,8 @@ git-cvsexportcommit - Export a single commit to a CVS checkout
 SYNOPSIS
 --------
 [verse]
-'git cvsexportcommit' [-h] [-u] [-v] [-c] [-P] [-p] [-a] [-d cvsroot]
-	[-w cvsworkdir] [-W] [-f] [-m msgprefix] [PARENTCOMMIT] COMMITID
+'git cvsexportcommit' [-h] [-u] [-v] [-c] [-P] [-p] [-a] [-d <cvsroot>]
+	[-w <cvs-workdir>] [-W] [-f] [-m <msgprefix>] [<parent-commit>] <commit-id>
 
 
 DESCRIPTION
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index c9d7e96214..e8f3ccb433 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -8,7 +8,7 @@ git-gui - A portable graphical interface to Git
 SYNOPSIS
 --------
 [verse]
-'git gui' [<command>] [arguments]
+'git gui' [<command>] [<arguments>]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 96d5f598b4..44ea63cc6d 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -9,14 +9,14 @@ SYNOPSIS
 --------
 [verse]
 'git help' [-a|--all [--[no-]verbose]]
-	   [[-i|--info] [-m|--man] [-w|--web]] [COMMAND|GUIDE]
+	   [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
 'git help' [-g|--guides]
 'git help' [-c|--config]
 
 DESCRIPTION
 -----------
 
-With no options and no COMMAND or GUIDE given, the synopsis of the 'git'
+With no options and no '<command>' or '<guide>' given, the synopsis of the 'git'
 command and a list of the most commonly used Git commands are printed
 on the standard output.
 
@@ -33,7 +33,7 @@ variables.
 
 If an alias is given, git shows the definition of the alias on
 standard output. To get the manual page for the aliased command, use
-`git COMMAND --help`.
+`git <command> --help`.
 
 Note that `git --help ...` is identical to `git help ...` because the
 former is internally converted into the latter.
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 9fa17b60e4..fa4bb6cbc3 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -9,7 +9,7 @@ git-http-fetch - Download from a remote Git repository via HTTP
 SYNOPSIS
 --------
 [verse]
-'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin | --packfile=<hash> | <commit>] <url>
+'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w <filename>] [--recover] [--stdin | --packfile=<hash> | <commit>] <url>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index b611d80697..7781d0b354 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
 	  [--separate-git-dir <git dir>] [--object-format=<format>]
 	  [-b <branch-name> | --initial-branch=<branch-name>]
-	  [--shared[=<permissions>]] [directory]
+	  [--shared[=<permissions>]] [<directory>]
 
 
 DESCRIPTION
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index dbfd1f9017..f8344e1e5b 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -13,8 +13,8 @@ SYNOPSIS
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
 	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
-	[--stdout [--filter=<filter-spec>] | base-name]
-	[--shallow] [--keep-true-parents] [--[no-]sparse] < object-list
+	[--stdout [--filter=<filter-spec>] | <base-name>]
+	[--shallow] [--keep-true-parents] [--[no-]sparse] < <object-list>
 
 
 DESCRIPTION
diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-pack-redundant.txt
index f2869da572..ee7034b5e5 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -9,7 +9,7 @@ git-pack-redundant - Find redundant pack files
 SYNOPSIS
 --------
 [verse]
-'git pack-redundant' [ --verbose ] [ --alt-odb ] < --all | .pack filename ... >
+'git pack-redundant' [ --verbose ] [ --alt-odb ] ( --all | <pack-filename>... )
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index ff487ff77d..5ced7ad4f8 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -17,12 +17,12 @@ The command takes various subcommands, and different options
 depending on the subcommand:
 
 [verse]
-'git reflog' ['show'] [log-options] [<ref>]
+'git reflog' ['show'] [<log-options>] [<ref>]
 'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
 	[--rewrite] [--updateref] [--stale-fix]
 	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
 'git reflog delete' [--rewrite] [--updateref]
-	[--dry-run | -n] [--verbose] ref@\{specifier\}...
+	[--dry-run | -n] [--verbose] <ref>@\{<specifier>\}...
 'git reflog exists' <ref>
 
 Reference logs, or "reflogs", record when the tips of branches and
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 42056ee9ff..9a78dd721e 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -11,7 +11,7 @@ given by a list of patterns.
 SYNOPSIS
 --------
 [verse]
-'git sparse-checkout <subcommand> [options]'
+'git sparse-checkout <subcommand> [<options>]'
 
 
 DESCRIPTION
diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
index 25bcda936d..2f6aaa75b9 100644
--- a/Documentation/git-stage.txt
+++ b/Documentation/git-stage.txt
@@ -9,7 +9,7 @@ git-stage - Add file contents to the staging area
 SYNOPSIS
 --------
 [verse]
-'git stage' args...
+'git stage' <arg>...
 
 
 DESCRIPTION
-- 
2.33.1

