From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] documentation: trivial style cleanups
Date: Wed,  8 May 2013 20:16:55 -0500
Message-ID: <1368062218-22440-2-git-send-email-felipe.contreras@gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 03:19:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFVq-0001Sn-95
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545Ab3EIBSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:18:38 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:58533 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab3EIBSc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:18:32 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so1781562oag.18
        for <git@vger.kernel.org>; Wed, 08 May 2013 18:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=naMwcGV+bhcUgW53J3k/JKJcN0X5jOg0aCIT557XBmQ=;
        b=tJ1iqRu5zcwmvNQ8mXysvDaeSUMYgMo11b4qhFoa9ow4lKXTfChwXSO5P3nuJFz/hd
         Ra0aEYKwSAGqLuZi+NS6jcF9g/oTRBGjr6iVHUrCvEY/K5qKlFNRJAfXDKk46gyy3wi8
         yNywRJ7k7cMogaBdLBmoyNNuBfhrFaE0XvMXfIU3euDIQRNSbXOuImMidvyrfzGMaiwC
         e7kTU3Ix+DbPMrJf6YE1fzHsOdUW2mL6x18rPv5koIcImAPhhrlrhPGyvyxNQ0CvabL+
         RqPzdzjtCZHcCYLOePC0x4mjNiVd90wwOUmTylc5qNV5fR7ddlBAR6UqHyZ9zVqeC9ex
         Vosg==
X-Received: by 10.60.33.105 with SMTP id q9mr3093152oei.54.1368062307421;
        Wed, 08 May 2013 18:18:27 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm1126012oez.4.2013.05.08.18.18.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 18:18:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.553.gac13664
In-Reply-To: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223700>

White-spaces, missing braces, standardize --[no-]foo.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-am.txt               |  7 +++----
 Documentation/git-archive.txt          |  2 +-
 Documentation/git-check-ref-format.txt |  3 +--
 Documentation/git-clone.txt            |  4 ++--
 Documentation/git-commit.txt           |  2 +-
 Documentation/git-config.txt           |  3 +--
 Documentation/git-daemon.txt           |  5 ++---
 Documentation/git-difftool.txt         |  3 +--
 Documentation/git-fast-export.txt      | 10 +++++-----
 Documentation/git-fetch-pack.txt       |  6 +++---
 Documentation/git-fmt-merge-msg.txt    |  3 +--
 Documentation/git-fsck.txt             |  6 ++----
 Documentation/git-grep.txt             |  2 +-
 Documentation/git-mailinfo.txt         |  2 +-
 Documentation/git-merge.txt            |  3 +--
 Documentation/git-mergetool.txt        |  2 +-
 Documentation/git-push.txt             |  3 +--
 Documentation/git-remote.txt           |  2 +-
 Documentation/git-revert.txt           |  2 +-
 Documentation/git-update-index.txt     | 10 ++++------
 20 files changed, 34 insertions(+), 46 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 19d57a8..5bbe7b6 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -9,12 +9,12 @@ git-am - Apply a series of patches from a mailbox
 SYNOPSIS
 --------
 [verse]
-'git am' [--signoff] [--keep] [--keep-cr | --no-keep-cr] [--utf8 | --no-utf8]
+'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
 	 [--3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
-	 [--scissors | --no-scissors]
+	 [--[no-]scissors]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort)
 
@@ -43,8 +43,7 @@ OPTIONS
 --keep-non-patch::
 	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
---keep-cr::
---no-keep-cr::
+--[no-]keep-cr::
 	With `--keep-cr`, call 'git mailsplit' (see linkgit:git-mailsplit[1])
 	with the same option, to prevent it from stripping CR at the end of
 	lines. `am.keepcr` configuration variable can be used to specify the
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 250e522..b97aaab 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>]
-	      [-o | --output=<file>] [--worktree-attributes]
+	      [-o <file> | --output=<file>] [--worktree-attributes]
 	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
 	      [<path>...]
 
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index ec1739a..a49be1b 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -83,8 +83,7 @@ typed the branch name.
 
 OPTIONS
 -------
---allow-onelevel::
---no-allow-onelevel::
+--[no-]allow-onelevel::
 	Controls whether one-level refnames are accepted (i.e.,
 	refnames that do not contain multiple `/`-separated
 	components).  The default is `--no-allow-onelevel`.
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 5c16e31..a0727d7 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
-	  [--recursive|--recurse-submodules] [--] <repository>
+	  [--recursive | --recurse-submodules] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -188,7 +188,7 @@ objects from the source repository into a pack in the cloned repository.
 	with a long history, and would want to send in fixes
 	as patches.
 
---single-branch::
+--[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
 	either specified by the `--branch` option or the primary
 	branch remote's `HEAD` points at. When creating a shallow
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 8172938..1a7616c 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
-	   [--date=<date>] [--cleanup=<mode>] [--status | --no-status]
+	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
 	   [-i | -o] [-S[<keyid>]] [--] [<file>...]
 
 DESCRIPTION
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 9ae2508..d88a6fc 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -186,8 +186,7 @@ See also <<FILES>>.
 	Opens an editor to modify the specified config file; either
 	'--system', '--global', or repository (default).
 
---includes::
---no-includes::
+--[no-]includes::
 	Respect `include.*` directives in config files when looking up
 	values. Defaults to on.
 
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index bfb106c..61a5701 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 	     [--enable=<service>] [--disable=<service>]
 	     [--allow-override=<service>] [--forbid-override=<service>]
 	     [--access-hook=<path>]
-	     [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>] [--user=<user> [--group=<group>]]
+	     [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>] [--user=<user> [--group=<group>]]]
 	     [<directory>...]
 
 DESCRIPTION
@@ -169,8 +169,7 @@ Git configuration files in that directory are readable by `<user>`.
 	repository configuration.  By default, all the services
 	are overridable.
 
---informative-errors::
---no-informative-errors::
+--[no-]informative-errors::
 	When informative errors are turned on, git-daemon will report
 	more verbose errors to the client, differentiating conditions
 	like "no such repository" from "repository not exported". This
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 8361e6e..11887e6 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -69,8 +69,7 @@ with custom merge tool commands and has the same value as `$MERGED`.
 --tool-help::
 	Print a list of diff tools that may be used with `--tool`.
 
---symlinks::
---no-symlinks::
+--[no-]symlinks::
 	'git difftool''s default behavior is create symlinks to the
 	working tree when run in `--dir-diff` mode and the right-hand
 	side of the comparison yields the same content as the file in
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 03fc8c3..efb0380 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -106,11 +106,11 @@ marks the same across runs.
 	different from the commit's first parent).
 
 [<git-rev-list-args>...]::
-       A list of arguments, acceptable to 'git rev-parse' and
-       'git rev-list', that specifies the specific objects and references
-       to export.  For example, `master~10..master` causes the
-       current master reference to be exported along with all objects
-       added since its 10th ancestor commit.
+	A list of arguments, acceptable to 'git rev-parse' and
+	'git rev-list', that specifies the specific objects and references
+	to export.  For example, `master~10..master` causes the
+	current master reference to be exported along with all objects
+	added since its 10th ancestor commit.
 
 EXAMPLES
 --------
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index b81e90d..1e71754 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -10,9 +10,9 @@ SYNOPSIS
 --------
 [verse]
 'git fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag]
-				[--upload-pack=<git-upload-pack>]
-				[--depth=<n>] [--no-progress]
-				[-v] [<host>:]<directory> [<refs>...]
+	[--upload-pack=<git-upload-pack>]
+	[--depth=<n>] [--no-progress]
+	[-v] [<host>:]<directory> [<refs>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 3a0f55e..bb1232a 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -35,8 +35,7 @@ OPTIONS
 	Do not list one-line descriptions from the actual commits being
 	merged.
 
---summary::
---no-summary::
+--[no-]summary::
 	Synonyms to --log and --no-log; these are deprecated and will be
 	removed in the future.
 
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index e5878bd..25c431d 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -30,8 +30,7 @@ index file, all SHA-1 references in `refs` namespace, and all reflogs
 	Print out objects that exist but that aren't reachable from any
 	of the reference nodes.
 
---dangling::
---no-dangling::
+--[no-]dangling::
 	Print objects that exist but that are never 'directly' used (default).
 	`--no-dangling` can be used to omit this information from the output.
 
@@ -78,8 +77,7 @@ index file, all SHA-1 references in `refs` namespace, and all reflogs
 	a blob, the contents are written into the file, rather than
 	its object name.
 
---progress::
---no-progress::
+--[no-]progress::
 	Progress status is reported on the standard error stream by
 	default when it is attached to a terminal, unless
 	--no-progress or --verbose is specified. --progress forces
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 50d46e1..8497aa4 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -25,7 +25,7 @@ SYNOPSIS
 	   [-W | --function-context]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
-	   [ [--exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
+	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 97e7a8e..164a3c6 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -9,7 +9,7 @@ git-mailinfo - Extracts patch and authorship from a single e-mail message
 SYNOPSIS
 --------
 [verse]
-'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n] [--scissors] <msg> <patch>
+'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n] [--[no-]scissors] <msg> <patch>
 
 
 DESCRIPTION
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 42391f2..67ca99c 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -76,8 +76,7 @@ The 'git fmt-merge-msg' command can be
 used to give a good default for automated 'git merge'
 invocations.
 
---rerere-autoupdate::
---no-rerere-autoupdate::
+--[no-]rerere-autoupdate::
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 6b563c5..d758f3a 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -8,7 +8,7 @@ git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
 SYNOPSIS
 --------
 [verse]
-'git mergetool' [--tool=<tool>] [-y|--no-prompt|--prompt] [<file>...]
+'git mergetool' [--tool=<tool>] [-y|--[no-]prompt] [<file>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index eb2883c..d514813 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -162,8 +162,7 @@ useful if you write an alias or script around 'git push'.
 	linkgit:git-pull[1] and other commands. For more information,
 	see 'branch.<name>.merge' in linkgit:git-config[1].
 
---thin::
---no-thin::
+--[no-]thin::
 	These options are passed to linkgit:git-send-pack[1]. A thin transfer
 	significantly reduces the amount of sent data when the sender and
 	receiver share many of the same objects in common. The default is
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 7a6f354..581bb4c 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git remote' [-v | --verbose]
-'git remote add' [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [--mirror=<fetch|push>] <name> <url>
+'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=<fetch|push>] <name> <url>
 'git remote rename' <old> <new>
 'git remote remove' <name>
 'git remote set-head' <name> (-a | -d | <branch>)
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 70152e8..f79c9d8 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -8,7 +8,7 @@ git-revert - Revert some existing commits
 SYNOPSIS
 --------
 [verse]
-'git revert' [--edit | --no-edit] [-n] [-m parent-number] [-s] <commit>...
+'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] <commit>...
 'git revert' --continue
 'git revert' --quit
 'git revert' --abort
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 670e9fb..e0a8702 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -14,8 +14,8 @@ SYNOPSIS
 	     [--refresh] [-q] [--unmerged] [--ignore-missing]
 	     [(--cacheinfo <mode> <object> <file>)...]
 	     [--chmod=(+|-)x]
-	     [--assume-unchanged | --no-assume-unchanged]
-	     [--skip-worktree | --no-skip-worktree]
+	     [--[no-]assume-unchanged]
+	     [--[no-]skip-worktree]
 	     [--ignore-submodules]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
@@ -77,8 +77,7 @@ OPTIONS
 --chmod=(+|-)x::
         Set the execute permissions on the updated files.
 
---assume-unchanged::
---no-assume-unchanged::
+--[no-]assume-unchanged::
 	When these flags are specified, the object names recorded
 	for the paths are not updated.  Instead, these options
 	set and unset the "assume unchanged" bit for the
@@ -102,8 +101,7 @@ you will need to handle the situation manually.
 	Like '--refresh', but checks stat information unconditionally,
 	without regard to the "assume unchanged" setting.
 
---skip-worktree::
---no-skip-worktree::
+--[no-]skip-worktree::
 	When one of these flags is specified, the object name recorded
 	for the paths are not updated. Instead, these options
 	set and unset the "skip-worktree" bit for the paths. See
-- 
1.8.3.rc1.553.gac13664
