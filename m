From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 1/2] Documentation: use [verse] for SYNOPSIS sections
Date: Fri,  1 Jul 2011 22:38:26 -0400
Message-ID: <1309574306-6787-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 04:38:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qcq6Y-0007vP-Rv
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 04:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144Ab1GBCik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jul 2011 22:38:40 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58666 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab1GBCij (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 22:38:39 -0400
Received: by vws1 with SMTP id 1so2729076vws.19
        for <git@vger.kernel.org>; Fri, 01 Jul 2011 19:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=5DLQ8uN+2x0TTAWPna/kj3D4g57VDg8+47DouBxwi44=;
        b=eo5zfT6xvKBg1Axzhr0wWWHRFhg7qjxz0MwT2NUDgNsS6dlBFK5S/TxcG4owyJujDl
         XzDIQTH/s+vKqTWvaeosNH3dQL6wxwIJioNEuBiZDJ80eqmJh892tSXgqjwyVpJVb/lv
         UECR+jUKxuV7b8Q5vzrEliuT3hUA6sL1jnsBE=
Received: by 10.52.95.148 with SMTP id dk20mr1891796vdb.120.1309574318002;
        Fri, 01 Jul 2011 19:38:38 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id cf7sm1477929vdb.26.2011.07.01.19.38.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Jul 2011 19:38:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.51.g07e0e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176543>

The SYNOPSIS sections of most commands that span several lines already
use [verse] to retain line breaks. Most commands that don't span
several lines seem not to use [verse]. In the HTML output, [verse]
does not only preserve line breaks, but also makes the section
indented, which causes a slight inconsistency between commands that
use [verse] and those that don't. Use [verse] in all SYNOPSIS sections
for consistency.

Also remove the blank lines from git-fetch.txt and git-rebase.txt to
align with the other man pages. In the case of git-rebase.txt, which
already uses [verse], the blank line makes the [verse] not apply to
the last line, so removing the blank line also makes the formatting
within the document more consistent.

While at it, add single quotes to 'git cvsimport' for consistency with
other commands.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

Not the most fun patch I have ever written, but at least it improves
consistency a bit. I was not sure what to do with e.g. gitrevisions,
gitrepository-layout, gittutorial. Just leave them as is?


 Documentation/git-annotate.txt                  |    1 +
 Documentation/git-bisect.txt                    |    1 +
 Documentation/git-cherry-pick.txt               |    1 +
 Documentation/git-cherry.txt                    |    1 +
 Documentation/git-citool.txt                    |    1 +
 Documentation/git-commit-tree.txt               |    1 +
 Documentation/git-count-objects.txt             |    1 +
 Documentation/git-cvsexportcommit.txt           |    1 +
 Documentation/git-diff-files.txt                |    1 +
 Documentation/git-diff-index.txt                |    1 +
 Documentation/git-difftool.txt                  |    1 +
 Documentation/git-fast-export.txt               |    1 +
 Documentation/git-fast-import.txt               |    1 +
 Documentation/git-fetch-pack.txt                |    1 +
 Documentation/git-fetch.txt                     |    4 +---
 Documentation/git-fsck-objects.txt              |    1 +
 Documentation/git-gc.txt                        |    1 +
 Documentation/git-get-tar-commit-id.txt         |    1 +
 Documentation/git-gui.txt                       |    1 +
 Documentation/git-help.txt                      |    1 +
 Documentation/git-http-fetch.txt                |    1 +
 Documentation/git-http-push.txt                 |    1 +
 Documentation/git-imap-send.txt                 |    1 +
 Documentation/git-init-db.txt                   |    1 +
 Documentation/git-init.txt                      |    1 +
 Documentation/git-log.txt                       |    1 +
 Documentation/git-lost-found.txt                |    1 +
 Documentation/git-mailinfo.txt                  |    1 +
 Documentation/git-mailsplit.txt                 |    1 +
 Documentation/git-merge-index.txt               |    1 +
 Documentation/git-merge-one-file.txt            |    1 +
 Documentation/git-merge-tree.txt                |    1 +
 Documentation/git-mergetool--lib.txt            |    1 +
 Documentation/git-mergetool.txt                 |    1 +
 Documentation/git-mktag.txt                     |    1 +
 Documentation/git-mktree.txt                    |    1 +
 Documentation/git-mv.txt                        |    1 +
 Documentation/git-pack-redundant.txt            |    1 +
 Documentation/git-pack-refs.txt                 |    1 +
 Documentation/git-parse-remote.txt              |    1 +
 Documentation/git-patch-id.txt                  |    1 +
 Documentation/git-peek-remote.txt               |    1 +
 Documentation/git-prune-packed.txt              |    1 +
 Documentation/git-prune.txt                     |    1 +
 Documentation/git-pull.txt                      |    1 +
 Documentation/git-read-tree.txt                 |    1 +
 Documentation/git-rebase.txt                    |    1 -
 Documentation/git-receive-pack.txt              |    1 +
 Documentation/git-reflog.txt                    |    1 +
 Documentation/git-relink.txt                    |    1 +
 Documentation/git-remote-ext.txt                |    1 +
 Documentation/git-remote-helpers.txt            |    1 +
 Documentation/git-repack.txt                    |    1 +
 Documentation/git-repo-config.txt               |    1 +
 Documentation/git-request-pull.txt              |    1 +
 Documentation/git-rerere.txt                    |    1 +
 Documentation/git-rev-parse.txt                 |    1 +
 Documentation/git-revert.txt                    |    1 +
 Documentation/git-rm.txt                        |    1 +
 Documentation/git-send-email.txt                |    1 +
 Documentation/git-send-pack.txt                 |    1 +
 Documentation/git-sh-i18n.txt                   |    1 +
 Documentation/git-sh-setup.txt                  |    1 +
 Documentation/git-shell.txt                     |    1 +
 Documentation/git-show-branch.txt               |    1 -
 Documentation/git-show-index.txt                |    1 +
 Documentation/git-show.txt                      |    1 +
 Documentation/git-status.txt                    |    1 +
 Documentation/git-stripspace.txt                |    1 +
 Documentation/git-svn.txt                       |    1 +
 Documentation/git-symbolic-ref.txt              |    1 +
 Documentation/git-tar-tree.txt                  |    1 +
 Documentation/git-unpack-file.txt               |    1 +
 Documentation/git-unpack-objects.txt            |    1 +
 Documentation/git-update-ref.txt                |    1 +
 Documentation/git-update-server-info.txt        |    1 +
 Documentation/git-upload-archive.txt            |    1 +
 Documentation/git-upload-pack.txt               |    1 +
 Documentation/git-var.txt                       |    1 +
 Documentation/git-verify-pack.txt               |    1 +
 Documentation/git-verify-tag.txt                |    1 +
 Documentation/git-web--browse.txt               |    1 +
 Documentation/git-whatchanged.txt               |    1 +
 Documentation/git-write-tree.txt                |    1 +
 Documentation/gitcvs-migration.txt              |    3 ++-
 Documentation/gitdiffcore.txt                   |    1 +
 Documentation/gitk.txt                          |    1 +
 Documentation/gittutorial-2.txt                 |    1 +
 Documentation/gittutorial.txt                   |    1 +
 Documentation/gitworkflows.txt                  |    1 +
 contrib/convert-objects/git-convert-objects.txt |    1 +
 contrib/gitview/gitview.txt                     |    1 +
 contrib/svn-fe/svn-fe.txt                       |    1 +
 93 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.txt
index 9eb75c3..05fd482 100644
--- a/Documentation/git-annotate.txt
+++ b/Documentation/git-annotate.txt
@@ -7,6 +7,7 @@ git-annotate - Annotate file lines with commit information
 
 SYNOPSIS
 --------
+[verse]
 'git annotate' [options] file [revision]
 
 DESCRIPTION
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 7b7bafb..ab60a18 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -8,6 +8,7 @@ git-bisect - Find by binary search the change that introduced a bug
 
 SYNOPSIS
 --------
+[verse]
 'git bisect' <subcommand> <options>
 
 DESCRIPTION
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 9d8fe0d..6c9c2cb 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -7,6 +7,7 @@ git-cherry-pick - Apply the changes introduced by some existing commits
 
 SYNOPSIS
 --------
+[verse]
 'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>...
 
 DESCRIPTION
diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 79448c5..f6c19c7 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -7,6 +7,7 @@ git-cherry - Find commits not merged upstream
 
 SYNOPSIS
 --------
+[verse]
 'git cherry' [-v] [<upstream> [<head> [<limit>]]]
 
 DESCRIPTION
diff --git a/Documentation/git-citool.txt b/Documentation/git-citool.txt
index 6e5c812..c7a11c3 100644
--- a/Documentation/git-citool.txt
+++ b/Documentation/git-citool.txt
@@ -7,6 +7,7 @@ git-citool - Graphical alternative to git-commit
 
 SYNOPSIS
 --------
+[verse]
 'git citool'
 
 DESCRIPTION
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index f524d76..0fdb82e 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -8,6 +8,7 @@ git-commit-tree - Create a new commit object
 
 SYNOPSIS
 --------
+[verse]
 'git commit-tree' <tree> [(-p <parent commit>)...] < changelog
 
 DESCRIPTION
diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index a73933a..23c80ce 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -7,6 +7,7 @@ git-count-objects - Count unpacked number of objects and their disk consumption
 
 SYNOPSIS
 --------
+[verse]
 'git count-objects' [-v]
 
 DESCRIPTION
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index ad93a3e..7f79cec 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -8,6 +8,7 @@ git-cvsexportcommit - Export a single commit to a CVS checkout
 
 SYNOPSIS
 --------
+[verse]
 'git cvsexportcommit' [-h] [-u] [-v] [-c] [-P] [-p] [-a] [-d cvsroot]
 	[-w cvsworkdir] [-W] [-f] [-m msgprefix] [PARENTCOMMIT] COMMITID
 
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index 8d48194..906774f 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -8,6 +8,7 @@ git-diff-files - Compares files in the working tree and the index
 
 SYNOPSIS
 --------
+[verse]
 'git diff-files' [-q] [-0|-1|-2|-3|-c|--cc] [<common diff options>] [<path>...]
 
 DESCRIPTION
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 2ea22ab..c0b7c58 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -8,6 +8,7 @@ git-diff-index - Compares content and mode of blobs between the index and reposi
 
 SYNOPSIS
 --------
+[verse]
 'git diff-index' [-m] [--cached] [<common diff options>] <tree-ish> [<path>...]
 
 DESCRIPTION
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 590f410..a03515f 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -7,6 +7,7 @@ git-difftool - Show changes using common diff tools
 
 SYNOPSIS
 --------
+[verse]
 'git difftool' [<options>] [<commit> [<commit>]] [--] [<path>...]
 
 DESCRIPTION
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 781bd6e..a29ac02 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -8,6 +8,7 @@ git-fast-export - Git data exporter
 
 SYNOPSIS
 --------
+[verse]
 'git fast-export [options]' | 'git fast-import'
 
 DESCRIPTION
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 249249a..8b9f9bb 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -8,6 +8,7 @@ git-fast-import - Backend for fast Git data importers
 
 SYNOPSIS
 --------
+[verse]
 frontend | 'git fast-import' [options]
 
 DESCRIPTION
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 48d4bf6..ed1bdaa 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -8,6 +8,7 @@ git-fetch-pack - Receive missing objects from another repository
 
 SYNOPSIS
 --------
+[verse]
 'git fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]
 
 DESCRIPTION
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 60ac8d2..b41d7c1 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -8,12 +8,10 @@ git-fetch - Download objects and refs from another repository
 
 SYNOPSIS
 --------
+[verse]
 'git fetch' [<options>] [<repository> [<refspec>...]]
-
 'git fetch' [<options>] <group>
-
 'git fetch' --multiple [<options>] [(<repository> | <group>)...]
-
 'git fetch' --all [<options>]
 
 
diff --git a/Documentation/git-fsck-objects.txt b/Documentation/git-fsck-objects.txt
index 90ebb8a..eec4bdb 100644
--- a/Documentation/git-fsck-objects.txt
+++ b/Documentation/git-fsck-objects.txt
@@ -8,6 +8,7 @@ git-fsck-objects - Verifies the connectivity and validity of the objects in the
 
 SYNOPSIS
 --------
+[verse]
 'git fsck-objects' ...
 
 DESCRIPTION
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 4966cb5..815afcb 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -8,6 +8,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 
 SYNOPSIS
 --------
+[verse]
 'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune]
 
 DESCRIPTION
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
index 8035736..1e2a20d 100644
--- a/Documentation/git-get-tar-commit-id.txt
+++ b/Documentation/git-get-tar-commit-id.txt
@@ -8,6 +8,7 @@ git-get-tar-commit-id - Extract commit ID from an archive created using git-arch
 
 SYNOPSIS
 --------
+[verse]
 'git get-tar-commit-id' < <tarfile>
 
 
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index 32a833e..18f713b 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -7,6 +7,7 @@ git-gui - A portable graphical interface to Git
 
 SYNOPSIS
 --------
+[verse]
 'git gui' [<command>] [arguments]
 
 DESCRIPTION
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 42aa2b0..9e0b3f6 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -7,6 +7,7 @@ git-help - display help information about git
 
 SYNOPSIS
 --------
+[verse]
 'git help' [-a|--all|-i|--info|-m|--man|-w|--web] [COMMAND]
 
 DESCRIPTION
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index fefa752..4d42073 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -8,6 +8,7 @@ git-http-fetch - Download from a remote git repository via HTTP
 
 SYNOPSIS
 --------
+[verse]
 'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin] <commit> <url>
 
 DESCRIPTION
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 82ae34b..2e67362 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -8,6 +8,7 @@ git-http-push - Push objects over HTTP/DAV to another repository
 
 SYNOPSIS
 --------
+[verse]
 'git http-push' [--all] [--dry-run] [--force] [--verbose] <url> <ref> [<ref>...]
 
 DESCRIPTION
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 4e09708..875d283 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -8,6 +8,7 @@ git-imap-send - Send a collection of patches from stdin to an IMAP folder
 
 SYNOPSIS
 --------
+[verse]
 'git imap-send'
 
 
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 9f97f5a..a21e346 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -8,6 +8,7 @@ git-init-db - Creates an empty git repository
 
 SYNOPSIS
 --------
+[verse]
 'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
 
 
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index f2777a7..9ac2bba 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -8,6 +8,7 @@ git-init - Create an empty git repository or reinitialize an existing one
 
 SYNOPSIS
 --------
+[verse]
 'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
 	  [--separate-git-dir <git dir>]
 	  [--shared[=<permissions>]] [directory]
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index de5c0d3..59f8be0 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -8,6 +8,7 @@ git-log - Show commit logs
 
 SYNOPSIS
 --------
+[verse]
 'git log' [<options>] [<since>..<until>] [[\--] <path>...]
 
 DESCRIPTION
diff --git a/Documentation/git-lost-found.txt b/Documentation/git-lost-found.txt
index adf7e1c..c406a11 100644
--- a/Documentation/git-lost-found.txt
+++ b/Documentation/git-lost-found.txt
@@ -7,6 +7,7 @@ git-lost-found - Recover lost refs that luckily have not yet been pruned
 
 SYNOPSIS
 --------
+[verse]
 'git lost-found'
 
 DESCRIPTION
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index ed45662..51dc325 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -8,6 +8,7 @@ git-mailinfo - Extracts patch and authorship from a single e-mail message
 
 SYNOPSIS
 --------
+[verse]
 'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n] [--scissors] <msg> <patch>
 
 
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index 9b2049d..4d1b871 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -7,6 +7,7 @@ git-mailsplit - Simple UNIX mbox splitter program
 
 SYNOPSIS
 --------
+[verse]
 'git mailsplit' [-b] [-f<nn>] [-d<prec>] [--keep-cr] -o<directory> [--] [(<mbox>|<Maildir>)...]
 
 DESCRIPTION
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 6ce5467..e0df1b3 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -8,6 +8,7 @@ git-merge-index - Run a merge for files needing merging
 
 SYNOPSIS
 --------
+[verse]
 'git merge-index' [-o] [-q] <merge-program> (-a | [--] <file>*)
 
 DESCRIPTION
diff --git a/Documentation/git-merge-one-file.txt b/Documentation/git-merge-one-file.txt
index ee059de..04e803d 100644
--- a/Documentation/git-merge-one-file.txt
+++ b/Documentation/git-merge-one-file.txt
@@ -8,6 +8,7 @@ git-merge-one-file - The standard helper program to use with git-merge-index
 
 SYNOPSIS
 --------
+[verse]
 'git merge-one-file'
 
 DESCRIPTION
diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 3bfa7b4..c5f84b6 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -8,6 +8,7 @@ git-merge-tree - Show three-way merge without touching index
 
 SYNOPSIS
 --------
+[verse]
 'git merge-tree' <base-tree> <branch1> <branch2>
 
 DESCRIPTION
diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index 63edede..8c5be67 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -7,6 +7,7 @@ git-mergetool--lib - Common git merge tool shell scriptlets
 
 SYNOPSIS
 --------
+[verse]
 'TOOL_MODE=(diff|merge) . "$(git --exec-path)/git-mergetool--lib"'
 
 DESCRIPTION
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 8c79ae8..3470910 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -7,6 +7,7 @@ git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
 
 SYNOPSIS
 --------
+[verse]
 'git mergetool' [--tool=<tool>] [-y|--no-prompt|--prompt] [<file>...]
 
 DESCRIPTION
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 037ab10..65e167a 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -8,6 +8,7 @@ git-mktag - Creates a tag object
 
 SYNOPSIS
 --------
+[verse]
 'git mktag' < signature_file
 
 DESCRIPTION
diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index afe21be..5c6ebdf 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -8,6 +8,7 @@ git-mktree - Build a tree-object from ls-tree formatted text
 
 SYNOPSIS
 --------
+[verse]
 'git mktree' [-z] [--missing] [--batch]
 
 DESCRIPTION
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index db0e030..b8db373 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -8,6 +8,7 @@ git-mv - Move or rename a file, a directory, or a symlink
 
 SYNOPSIS
 --------
+[verse]
 'git mv' <options>... <args>...
 
 DESCRIPTION
diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-pack-redundant.txt
index db9f0f7..f2869da 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -8,6 +8,7 @@ git-pack-redundant - Find redundant pack files
 
 SYNOPSIS
 --------
+[verse]
 'git pack-redundant' [ --verbose ] [ --alt-odb ] < --all | .pack filename ... >
 
 DESCRIPTION
diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index 54b9253..a3c6677 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -7,6 +7,7 @@ git-pack-refs - Pack heads and tags for efficient repository access
 
 SYNOPSIS
 --------
+[verse]
 'git pack-refs' [--all] [--no-prune]
 
 DESCRIPTION
diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse-remote.txt
index 02217f6..a45ea1e 100644
--- a/Documentation/git-parse-remote.txt
+++ b/Documentation/git-parse-remote.txt
@@ -8,6 +8,7 @@ git-parse-remote - Routines to help parsing remote repository access parameters
 
 SYNOPSIS
 --------
+[verse]
 '. "$(git --exec-path)/git-parse-remote"'
 
 DESCRIPTION
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 50e26f4..90268f0 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -7,6 +7,7 @@ git-patch-id - Compute unique ID for a patch
 
 SYNOPSIS
 --------
+[verse]
 'git patch-id' < <patch>
 
 DESCRIPTION
diff --git a/Documentation/git-peek-remote.txt b/Documentation/git-peek-remote.txt
index a34d62f..87ea3fb 100644
--- a/Documentation/git-peek-remote.txt
+++ b/Documentation/git-peek-remote.txt
@@ -8,6 +8,7 @@ git-peek-remote - List the references in a remote repository
 
 SYNOPSIS
 --------
+[verse]
 'git peek-remote' [--upload-pack=<git-upload-pack>] [<host>:]<directory>
 
 DESCRIPTION
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index 9e6202c..80dc022 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -8,6 +8,7 @@ git-prune-packed - Remove extra objects that are already in pack files
 
 SYNOPSIS
 --------
+[verse]
 'git prune-packed' [-n|--dry-run] [-q|--quiet]
 
 
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index f616a73..80d01b0 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -8,6 +8,7 @@ git-prune - Prune all unreachable objects from the object database
 
 SYNOPSIS
 --------
+[verse]
 'git prune' [-n] [-v] [--expire <expire>] [--] [<head>...]
 
 DESCRIPTION
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 14609cb..e1da468 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -8,6 +8,7 @@ git-pull - Fetch from and merge with another repository or a local branch
 
 SYNOPSIS
 --------
+[verse]
 'git pull' [options] [<repository> [<refspec>...]]
 
 
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 46a96f2..c45d53c 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -8,6 +8,7 @@ git-read-tree - Reads tree information into the index
 
 SYNOPSIS
 --------
+[verse]
 'git read-tree' [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>]
 		[-u [--exclude-per-directory=<gitignore>] | -i]]
 		[--index-output=<file>] [--no-sparse-checkout]
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9a075bc..a9e0e50 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -12,7 +12,6 @@ SYNOPSIS
 	[<upstream>] [<branch>]
 'git rebase' [-i | --interactive] [options] --onto <newbase>
 	--root [<branch>]
-
 'git rebase' --continue | --skip | --abort
 
 DESCRIPTION
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index f34e0ae..459c085 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -8,6 +8,7 @@ git-receive-pack - Receive what is pushed into the repository
 
 SYNOPSIS
 --------
+[verse]
 'git-receive-pack' <directory>
 
 DESCRIPTION
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 09057bf..976dc14 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -8,6 +8,7 @@ git-reflog - Manage reflog information
 
 SYNOPSIS
 --------
+[verse]
 'git reflog' <subcommand> <options>
 
 DESCRIPTION
diff --git a/Documentation/git-relink.txt b/Documentation/git-relink.txt
index 9893376..3b33c99 100644
--- a/Documentation/git-relink.txt
+++ b/Documentation/git-relink.txt
@@ -7,6 +7,7 @@ git-relink - Hardlink common objects in local repositories
 
 SYNOPSIS
 --------
+[verse]
 'git relink' [--safe] <dir>... <master_dir>
 
 DESCRIPTION
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index 68263a6..8a8e1d7 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -7,6 +7,7 @@ git-remote-ext - Bridge smart transport to external command.
 
 SYNOPSIS
 --------
+[verse]
 git remote add <nick> "ext::<command>[ <arguments>...]"
 
 DESCRIPTION
diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 58f6ad4..930b403 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -7,6 +7,7 @@ git-remote-helpers - Helper programs to interact with remote repositories
 
 SYNOPSIS
 --------
+[verse]
 'git remote-<transport>' <repository> [<URL>]
 
 DESCRIPTION
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 0decee2..40af321 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -8,6 +8,7 @@ git-repack - Pack unpacked objects in a repository
 
 SYNOPSIS
 --------
+[verse]
 'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [--window=<n>] [--depth=<n>]
 
 DESCRIPTION
diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index a0d1fa6..9ec115b 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -8,6 +8,7 @@ git-repo-config - Get and set repository or global options
 
 SYNOPSIS
 --------
+[verse]
 'git repo-config' ...
 
 
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index 3521d8e..b99681c 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -7,6 +7,7 @@ git-request-pull - Generates a summary of pending changes
 
 SYNOPSIS
 --------
+[verse]
 'git request-pull' [-p] <start> <url> [<end>]
 
 DESCRIPTION
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 52db1d8..a6253ba 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -7,6 +7,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
 
 SYNOPSIS
 --------
+[verse]
 'git rerere' ['clear'|'forget' <pathspec>|'diff'|'status'|'gc']
 
 DESCRIPTION
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 02c44c9..42c9676 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -8,6 +8,7 @@ git-rev-parse - Pick out and massage parameters
 
 SYNOPSIS
 --------
+[verse]
 'git rev-parse' [ --option ] <args>...
 
 DESCRIPTION
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index ac10cfb..e4b46cf 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -7,6 +7,7 @@ git-revert - Revert some existing commits
 
 SYNOPSIS
 --------
+[verse]
 'git revert' [--edit | --no-edit] [-n] [-m parent-number] [-s] <commit>...
 
 DESCRIPTION
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 8c0554f..da0215d 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -7,6 +7,7 @@ git-rm - Remove files from the working tree and from the index
 
 SYNOPSIS
 --------
+[verse]
 'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <file>...
 
 DESCRIPTION
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 5a168cf..327233c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -8,6 +8,7 @@ git-send-email - Send a collection of patches as emails
 
 SYNOPSIS
 --------
+[verse]
 'git send-email' [options] <file|directory|rev-list options>...
 
 
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 17f8f55..bd3eaa6 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -8,6 +8,7 @@ git-send-pack - Push objects over git protocol to another repository
 
 SYNOPSIS
 --------
+[verse]
 'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]
 
 DESCRIPTION
diff --git a/Documentation/git-sh-i18n.txt b/Documentation/git-sh-i18n.txt
index 3b1f7ac..eafa55a 100644
--- a/Documentation/git-sh-i18n.txt
+++ b/Documentation/git-sh-i18n.txt
@@ -7,6 +7,7 @@ git-sh-i18n - Git's i18n setup code for shell scripts
 
 SYNOPSIS
 --------
+[verse]
 '. "$(git --exec-path)/git-sh-i18n"'
 
 DESCRIPTION
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 27fd8ba..a2f346c 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -7,6 +7,7 @@ git-sh-setup - Common git shell script setup code
 
 SYNOPSIS
 --------
+[verse]
 '. "$(git --exec-path)/git-sh-setup"'
 
 DESCRIPTION
diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index d7d4b92..9b92506 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -8,6 +8,7 @@ git-shell - Restricted login shell for Git-only SSH access
 
 SYNOPSIS
 --------
+[verse]
 'git shell' [-c <command> <argument>]
 
 DESCRIPTION
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index ee4559b..a8e77b5 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -13,7 +13,6 @@ SYNOPSIS
 		[--more=<n> | --list | --independent | --merge-base]
 		[--no-name | --sha1-name] [--topics]
 		[(<rev> | <glob>)...]
-
 'git show-branch' (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]
 
 DESCRIPTION
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index c4d99f1..2dcbbb2 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -8,6 +8,7 @@ git-show-index - Show packed archive index
 
 SYNOPSIS
 --------
+[verse]
 'git show-index' < idx-file
 
 
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 7f075e8..1f0e30b 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -8,6 +8,7 @@ git-show - Show various types of objects
 
 SYNOPSIS
 --------
+[verse]
 'git show' [options] <object>...
 
 DESCRIPTION
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 8ecc99d..3d51717 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -8,6 +8,7 @@ git-status - Show the working tree status
 
 SYNOPSIS
 --------
+[verse]
 'git status' [<options>...] [--] [<pathspec>...]
 
 DESCRIPTION
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 10509cc..b78f031 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -8,6 +8,7 @@ git-stripspace - Filter out empty lines
 
 SYNOPSIS
 --------
+[verse]
 'git stripspace' [-s | --strip-comments] < <stream>
 
 DESCRIPTION
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 713e523..ed5eca1 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -7,6 +7,7 @@ git-svn - Bidirectional operation between a Subversion repository and git
 
 SYNOPSIS
 --------
+[verse]
 'git svn' <command> [options] [arguments]
 
 DESCRIPTION
diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index d7795ed..75b1ae5 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -7,6 +7,7 @@ git-symbolic-ref - Read and modify symbolic refs
 
 SYNOPSIS
 --------
+[verse]
 'git symbolic-ref' [-q] [-m <reason>] <name> [<ref>]
 
 DESCRIPTION
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index 5f15754..95b135d 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -8,6 +8,7 @@ git-tar-tree - Create a tar archive of the files in the named tree object
 
 SYNOPSIS
 --------
+[verse]
 'git tar-tree' [--remote=<repo>] <tree-ish> [ <base> ]
 
 DESCRIPTION
diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.txt
index c49d727..e9f148a 100644
--- a/Documentation/git-unpack-file.txt
+++ b/Documentation/git-unpack-file.txt
@@ -9,6 +9,7 @@ git-unpack-file - Creates a temporary file with a blob's contents
 
 SYNOPSIS
 --------
+[verse]
 'git unpack-file' <blob>
 
 DESCRIPTION
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index dd77990..ff23494 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -8,6 +8,7 @@ git-unpack-objects - Unpack objects from a packed archive
 
 SYNOPSIS
 --------
+[verse]
 'git unpack-objects' [-n] [-q] [-r] [--strict] <pack-file
 
 
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index e25a65a..2a96143 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -7,6 +7,7 @@ git-update-ref - Update the object name stored in a ref safely
 
 SYNOPSIS
 --------
+[verse]
 'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] <ref> <newvalue> [<oldvalue>])
 
 DESCRIPTION
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index 775024d..bd0e364 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -8,6 +8,7 @@ git-update-server-info - Update auxiliary info file to help dumb servers
 
 SYNOPSIS
 --------
+[verse]
 'git update-server-info' [--force]
 
 DESCRIPTION
diff --git a/Documentation/git-upload-archive.txt b/Documentation/git-upload-archive.txt
index acbf634..4d52d38 100644
--- a/Documentation/git-upload-archive.txt
+++ b/Documentation/git-upload-archive.txt
@@ -8,6 +8,7 @@ git-upload-archive - Send archive back to git-archive
 
 SYNOPSIS
 --------
+[verse]
 'git upload-archive' <directory>
 
 DESCRIPTION
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 4c0ca9d..a58e90c 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -8,6 +8,7 @@ git-upload-pack - Send objects packed back to git-fetch-pack
 
 SYNOPSIS
 --------
+[verse]
 'git-upload-pack' [--strict] [--timeout=<n>] <directory>
 
 DESCRIPTION
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 6498f7c..5317cc2 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -8,6 +8,7 @@ git-var - Show a git logical variable
 
 SYNOPSIS
 --------
+[verse]
 'git var' ( -l | <variable> )
 
 DESCRIPTION
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index 7c2428d..cd23076 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -8,6 +8,7 @@ git-verify-pack - Validate packed git archive files
 
 SYNOPSIS
 --------
+[verse]
 'git verify-pack' [-v|--verbose] [-s|--stat-only] [--] <pack>.idx ...
 
 
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index 8c9a718..5ff76e8 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -7,6 +7,7 @@ git-verify-tag - Check the GPG signature of tags
 
 SYNOPSIS
 --------
+[verse]
 'git verify-tag' <tag>...
 
 DESCRIPTION
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 69d92fa..8b4f65a 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -7,6 +7,7 @@ git-web--browse - git helper script to launch a web browser
 
 SYNOPSIS
 --------
+[verse]
 'git web{litdd}browse' [OPTIONS] URL/FILE ...
 
 DESCRIPTION
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index 31f3663..99388bd 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -8,6 +8,7 @@ git-whatchanged - Show logs with difference each commit introduces
 
 SYNOPSIS
 --------
+[verse]
 'git whatchanged' <option>...
 
 DESCRIPTION
diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write-tree.txt
index e8c94c1..f22041a 100644
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -8,6 +8,7 @@ git-write-tree - Create a tree object from the current index
 
 SYNOPSIS
 --------
+[verse]
 'git write-tree' [--missing-ok] [--prefix=<prefix>/]
 
 DESCRIPTION
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index d861ec4..aeb0cdc 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -7,7 +7,8 @@ gitcvs-migration - git for CVS users
 
 SYNOPSIS
 --------
-git cvsimport *
+[verse]
+'git cvsimport' *
 
 DESCRIPTION
 -----------
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 6af29a4..370624c 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -7,6 +7,7 @@ gitdiffcore - Tweaking diff output
 
 SYNOPSIS
 --------
+[verse]
 'git diff' *
 
 DESCRIPTION
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index e10ac58..a17a354 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -7,6 +7,7 @@ gitk - The git repository browser
 
 SYNOPSIS
 --------
+[verse]
 'gitk' [<option>...] [<revs>] [--] [<path>...]
 
 DESCRIPTION
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 7fe5848..f1e4422 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -7,6 +7,7 @@ gittutorial-2 - A tutorial introduction to git: part two
 
 SYNOPSIS
 --------
+[verse]
 git *
 
 DESCRIPTION
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 0982f74..dee0505 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -7,6 +7,7 @@ gittutorial - A tutorial introduction to git (for version 1.5.1 or newer)
 
 SYNOPSIS
 --------
+[verse]
 git *
 
 DESCRIPTION
diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 1ef55ff..5e4f362 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -7,6 +7,7 @@ gitworkflows - An overview of recommended workflows with git
 
 SYNOPSIS
 --------
+[verse]
 git *
 
 
diff --git a/contrib/convert-objects/git-convert-objects.txt b/contrib/convert-objects/git-convert-objects.txt
index 9718abf..0565d83 100644
--- a/contrib/convert-objects/git-convert-objects.txt
+++ b/contrib/convert-objects/git-convert-objects.txt
@@ -8,6 +8,7 @@ git-convert-objects - Converts old-style git repository
 
 SYNOPSIS
 --------
+[verse]
 'git-convert-objects'
 
 DESCRIPTION
diff --git a/contrib/gitview/gitview.txt b/contrib/gitview/gitview.txt
index 77c29de..9e12f97 100644
--- a/contrib/gitview/gitview.txt
+++ b/contrib/gitview/gitview.txt
@@ -7,6 +7,7 @@ gitview - A GTK based repository browser for git
 
 SYNOPSIS
 --------
+[verse]
 'gitview' [options] [args]
 
 DESCRIPTION
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index cd075b9..72ffea0 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -7,6 +7,7 @@ svn-fe - convert an SVN "dumpfile" to a fast-import stream
 
 SYNOPSIS
 --------
+[verse]
 svnadmin dump --incremental REPO | svn-fe [url] | git fast-import
 
 DESCRIPTION
-- 
1.7.5.3.640.gd1066
