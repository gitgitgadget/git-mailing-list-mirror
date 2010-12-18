From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 7/8] docs: use <commit> instead of <commit-ish>
Date: Sat, 18 Dec 2010 00:38:44 -0500
Message-ID: <1292650725-21149-8-git-send-email-lodatom@gmail.com>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 18 06:39:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTpVy-0006oi-Gq
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 06:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393Ab0LRFjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 00:39:22 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41326 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab0LRFjH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 00:39:07 -0500
Received: by qyj19 with SMTP id 19so2354140qyj.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 21:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qDZHVUCJFnVojhuObA0BfZuxaa+RU0o4Clu79hxUDL8=;
        b=N4vepfhtmxa6YENXFX8t3vvrC9VnjGzCWlnjlR5R3Nq7hFIMt+zMfxEac6lL9xr9XS
         i8+4Xi0uSPF/lVCboQZN5OpppULoZHyvQ/rYxnkc9/IhDHIxt8r3V21Vrve9KvgOT7fK
         OJXv1dL/VFsmm15F22coFkkW0oVxMfmauRmqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JExRp+XVJmUXitP/MFaJ0JjBOG+Ws6Lw++4Msa52c6C/ZGp/DV4aT1UUZzWoosWCQU
         yNvN2aMZzhLOERzjreDTpOey9vJ+ygVHAObhsnT2dMsaD/g1ColhdBXbgiCnVItAdaun
         c8kBt3kMSLdubEF7/EQ6v/p5WyJTgcGrY4UvM=
Received: by 10.224.54.72 with SMTP id p8mr1621203qag.126.1292650747270;
        Fri, 17 Dec 2010 21:39:07 -0800 (PST)
Received: from localhost.localdomain (c-68-49-150-7.hsd1.dc.comcast.net [68.49.150.7])
        by mx.google.com with ESMTPS id n7sm683569qcu.28.2010.12.17.21.39.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 21:39:06 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163905>

No git command accepts only a commit and not a commit-ish, so let us
remove the latter term from common usage in the documentation in order
to reduce the amount of jargon.  Note that the terms `committish' and
`commit-ish' were both previously used.

The "ish" terms were left in comments and were added to the glossary.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-describe.txt     |   14 +++++++-------
 Documentation/git-fast-import.txt  |   22 +++++++++++-----------
 Documentation/git-name-rev.txt     |    2 +-
 Documentation/git-rebase.txt       |    2 +-
 Documentation/git.txt              |   11 ++++-------
 Documentation/gitcli.txt           |    2 +-
 Documentation/glossary-content.txt |    4 ++++
 builtin/describe.c                 |    4 ++--
 builtin/revert.c                   |    4 ++--
 contrib/examples/git-reset.sh      |    2 +-
 contrib/examples/git-revert.sh     |    4 ++--
 11 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 02e015a..ad173ed 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -9,7 +9,7 @@ git-describe - Show the most recent tag that is reachable from a commit
 SYNOPSIS
 --------
 [verse]
-'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] <committish>...
+'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] <commit>...
 'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]
 
 DESCRIPTION
@@ -26,8 +26,8 @@ see the -a and -s options to linkgit:git-tag[1].
 
 OPTIONS
 -------
-<committish>...::
-	Committish object names to describe.
+<commit>...::
+	Commit object names to describe.
 
 --dirty[=<mark>]::
 	Describe the working tree.
@@ -57,7 +57,7 @@ OPTIONS
 
 --candidates=<n>::
 	Instead of considering only the 10 most recent tags as
-	candidates to describe the input committish consider
+	candidates to describe the input commit consider
 	up to <n> candidates.  Increasing <n> above 10 will take
 	slightly longer but may produce a more accurate result.
 	An <n> of 0 will cause only exact matches to be output.
@@ -139,7 +139,7 @@ be sufficient to disambiguate these commits.
 SEARCH STRATEGY
 ---------------
 
-For each committish supplied, 'git describe' will first look for
+For each commit supplied, 'git describe' will first look for
 a tag which tags exactly that commit.  Annotated tags will always
 be preferred over lightweight tags, and tags with newer dates will
 always be preferred over tags with older dates.  If an exact match
@@ -148,10 +148,10 @@ is found, its name will be output and searching will stop.
 If an exact match was not found, 'git describe' will walk back
 through the commit history to locate an ancestor commit which
 has been tagged.  The ancestor's tag will be output along with an
-abbreviation of the input committish's SHA1.
+abbreviation of the input commit's SHA1.
 
 If multiple tags were found during the walk then the tag which
-has the fewest commits different from the input committish will be
+has the fewest commits different from the input commit will be
 selected and output.  Here fewest commits different is defined as
 the number of commits which would be shown by `git log tag..input`
 will be the smallest number of commits possible.
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index f56dfca..0509213 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -350,8 +350,8 @@ change to the project.
 	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
 	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
 	data
-	('from' SP <committish> LF)?
-	('merge' SP <committish> LF)?
+	('from' SP <commit> LF)?
+	('merge' SP <commit> LF)?
 	(filemodify | filedelete | filecopy | filerename | filedeleteall | notemodify)*
 	LF?
 ....
@@ -428,9 +428,9 @@ as the current commit on that branch is automatically assumed to
 be the first ancestor of the new commit.
 
 As `LF` is not valid in a Git refname or SHA-1 expression, no
-quoting or escaping syntax is supported within `<committish>`.
+quoting or escaping syntax is supported within `<commit>`.
 
-Here `<committish>` is any of the following:
+Here `<commit>` is any of the following:
 
 * The name of an existing branch already in fast-import's internal branch
   table.  If fast-import doesn't know the name, it's treated as a SHA-1
@@ -475,7 +475,7 @@ additional ancestors (forming a 16-way merge).  For this reason
 it is suggested that frontends do not use more than 15 `merge`
 commands per commit; 16, if starting a new, empty branch.
 
-Here `<committish>` is any of the commit specification expressions
+Here `<commit>` is any of the commit specification expressions
 also accepted by `from` (see above).
 
 `filemodify`
@@ -649,7 +649,7 @@ External data format::
 	commit that is to be annotated.
 +
 ....
-	'N' SP <dataref> SP <committish> LF
+	'N' SP <dataref> SP <commit> LF
 ....
 +
 Here `<dataref>` can be either a mark reference (`:<idnum>`)
@@ -662,13 +662,13 @@ Inline data format::
 	command.
 +
 ....
-	'N' SP 'inline' SP <committish> LF
+	'N' SP 'inline' SP <commit> LF
 	data
 ....
 +
 See below for a detailed description of the `data` command.
 
-In both formats `<committish>` is any of the commit specification
+In both formats `<commit>` is any of the commit specification
 expressions also accepted by `from` (see above).
 
 `mark`
@@ -699,7 +699,7 @@ lightweight (non-annotated) tags see the `reset` command below.
 
 ....
 	'tag' SP <name> LF
-	'from' SP <committish> LF
+	'from' SP <commit> LF
 	'tagger' (SP <name>)? SP LT <email> GT SP <when> LF
 	data
 ....
@@ -744,11 +744,11 @@ branch from an existing commit without creating a new commit.
 
 ....
 	'reset' SP <ref> LF
-	('from' SP <committish> LF)?
+	('from' SP <commit> LF)?
 	LF?
 ....
 
-For a detailed description of `<ref>` and `<committish>` see above
+For a detailed description of `<ref>` and `<commit>` see above
 under `commit` and `from`.
 
 The `LF` after the command is optional (it used to be required).
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 2108237..40af544 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git name-rev' [--tags] [--refs=<pattern>]
-	       ( --all | --stdin | <committish>... )
+	       ( --all | --stdin | <commit>... )
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 96680c8..dbb5484 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -168,7 +168,7 @@ would result in the removal of commits F and G:
 
 This is useful if F and G were flawed in some way, or should not be
 part of topicA.  Note that the argument to --onto and the <upstream>
-parameter can be any valid commit-ish.
+parameter can be any valid <commit>.
 
 In case of conflict, 'git rebase' will stop at the first problematic commit
 and leave conflict markers in the tree.  You can use 'git diff' to locate
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 376397c..734acbe 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -475,13 +475,10 @@ Identifier Terminology
 	tag and commit objects until it finds a tree.
 
 <commit>::
-	Indicates a commit object name.
-
-<commit-ish>::
-	Indicates a commit or tag object name.  A
-	command that takes a <commit-ish> argument ultimately wants to
-	operate on a <commit> object but automatically dereferences
-	<tag> objects that point at a <commit>.
+	Indicates a commit object name, or the name of a tag object that
+	points at a commit. A command that takes a <commit> argument
+	ultimately wants to operate on a commit object but automatically
+	dereferences tag objects until it finds a commit.
 
 <type>::
 	Indicates that an object type is required.
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index eefee3d..b56e7c3 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -81,7 +81,7 @@ couple of magic command line options:
 +
 ---------------------------------------------
 $ git describe -h
-usage: git describe [options] <committish>...
+usage: git describe [options] <commit>...
 
     --contains            find the tag that comes after the commit
     --debug               debug search strategy on stderr
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index f04b48e..40a1f11 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -82,6 +82,10 @@ to point at the new commit.
 	to the top <<def_directory,directory>> of the stored
 	revision.
 
+[[def_commit-ish]][[def_committish]]commit-ish / committish::
+	A <<def_ref,ref>> pointing to either a <<def_commit_object,commit
+	object>>, or a <<def_tag_object,tag object>> pointing to a tag or commit object.
+
 [[def_core_git]]core git::
 	Fundamental data structures and utilities of git. Exposes only limited
 	source code management tools.
diff --git a/builtin/describe.c b/builtin/describe.c
index 34a8031..4b5a217 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -12,7 +12,7 @@
 #define MAX_TAGS	(FLAG_BITS - 1)
 
 static const char * const describe_usage[] = {
-	"git describe [options] <committish>...",
+	"git describe [options] <commit>...",
 	"git describe [options] --dirty",
 	NULL
 };
@@ -462,7 +462,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			dirty = NULL;
 		describe("HEAD", 1);
 	} else if (dirty) {
-		die("--dirty is incompatible with committishes");
+		die("--dirty is incompatible with commits");
 	} else {
 		while (argc-- > 0) {
 			describe(*argv++, argc == 0);
diff --git a/builtin/revert.c b/builtin/revert.c
index bb6e9e8..f00b6d6 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -27,12 +27,12 @@
  */
 
 static const char * const revert_usage[] = {
-	"git revert [options] <commit-ish>",
+	"git revert [options] <commit>",
 	NULL
 };
 
 static const char * const cherry_pick_usage[] = {
-	"git cherry-pick [options] <commit-ish>",
+	"git cherry-pick [options] <commit>",
 	NULL
 };
 
diff --git a/contrib/examples/git-reset.sh b/contrib/examples/git-reset.sh
index bafeb52..d287a80 100755
--- a/contrib/examples/git-reset.sh
+++ b/contrib/examples/git-reset.sh
@@ -2,7 +2,7 @@
 #
 # Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
 #
-USAGE='[--mixed | --soft | --hard]  [<commit-ish>] [ [--] <paths>...]'
+USAGE='[--mixed | --soft | --hard]  [<commit>] [ [--] <paths>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 set_reflog_action "reset $*"
diff --git a/contrib/examples/git-revert.sh b/contrib/examples/git-revert.sh
index 60a05a8..0b6b029 100755
--- a/contrib/examples/git-revert.sh
+++ b/contrib/examples/git-revert.sh
@@ -9,12 +9,12 @@ case "$0" in
 	test -t 0 && edit=-e
 	replay=
 	me=revert
-	USAGE='[--edit | --no-edit] [-n] <commit-ish>' ;;
+	USAGE='[--edit | --no-edit] [-n] <commit>' ;;
 *-cherry-pick* )
 	replay=t
 	edit=
 	me=cherry-pick
-	USAGE='[--edit] [-n] [-r] [-x] <commit-ish>'  ;;
+	USAGE='[--edit] [-n] [-r] [-x] <commit>'  ;;
 * )
 	echo >&2 "What are you talking about?"
 	exit 1 ;;
-- 
1.7.3.2
