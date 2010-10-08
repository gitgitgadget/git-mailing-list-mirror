From: "=?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?=" 
	<stepan.nemec@gmail.com>
Subject: [PATCH 3/6] Use parentheses and `...' where appropriate
Date: Fri,  8 Oct 2010 19:31:17 +0200
Message-ID: <1286559080-27257-4-git-send-email-stepnem@gmail.com>
References: <87fwwhszsf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 19:35:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Gqk-0000hg-AV
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 19:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509Ab0JHReN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 13:34:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46375 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759260Ab0JHReE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 13:34:04 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so456728bwz.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 10:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=O1bo6X0dqPbChOyv1HB7Akb1tjBAiL4cZQOt3/EQ8aI=;
        b=heyKhc1QRn8MSrOAJt74aQma3/wHdbtQI9X5ONON4HhbPf2Oe06LU356jR5X/bvRey
         om+6CwQnYZ9XmLqXs/8FN28R9yK1FehAM1xNp2e8maJT5FjjCZJ7xFbHSVeOZMfkksLo
         TCeQwmc0a4Ix1M/w2nfu93giQkqD8ukZMhMdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=i9jZdTaiQ/GD36WzQFm/laT69KCORxCOj8mj0PzUrZJUIRTnBTNlTiFYPy88OQ5hXk
         1E+fHxxDT9PcHHTiHxDsc+qe6PW8ED6LxWfq4etSXv+UvSDZMpgFfJJqeGWvapxSTdC4
         DsohKq9w+uNNZ5fq/xtBk9I7HduWD1MI95Nac=
Received: by 10.204.51.3 with SMTP id b3mr2330130bkg.44.1286559241982;
        Fri, 08 Oct 2010 10:34:01 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id l14sm1518153bkb.19.2010.10.08.10.33.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 10:34:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc2.221.gbf93f.dirty
In-Reply-To: <87fwwhszsf.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158511>

Remove some stray usage of other bracket types and asterisks for the
same purpose.

Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
---
 Documentation/git-am.txt             |    4 ++--
 Documentation/git-apply.txt          |    2 +-
 Documentation/git-checkout-index.txt |    2 +-
 Documentation/git-commit-tree.txt    |    2 +-
 Documentation/git-fetch.txt          |    2 +-
 Documentation/git-filter-branch.txt  |    2 +-
 Documentation/git-for-each-ref.txt   |    2 +-
 Documentation/git-init.txt           |    2 +-
 Documentation/git-ls-files.txt       |    2 +-
 Documentation/git-mailsplit.txt      |    2 +-
 Documentation/git-mergetool.txt      |    2 +-
 Documentation/git-pack-objects.txt   |    2 +-
 Documentation/git-relink.txt         |    2 +-
 Documentation/git-remote.txt         |    2 +-
 Documentation/git-rev-list.txt       |    2 +-
 Documentation/git-rev-parse.txt      |    2 +-
 Documentation/git-show-branch.txt    |    2 +-
 Documentation/git-svn.txt            |    2 +-
 Documentation/git-update-index.txt   |    4 ++--
 Documentation/rev-list-options.txt   |    2 +-
 Documentation/user-manual.txt        |    2 +-
 builtin/commit-tree.c                |    2 +-
 builtin/fetch.c                      |    2 +-
 builtin/index-pack.c                 |    2 +-
 builtin/ls-files.c                   |    2 +-
 builtin/mailsplit.c                  |    2 +-
 builtin/pack-objects.c               |    2 +-
 builtin/remote.c                     |    2 +-
 builtin/show-branch.c                |    2 +-
 git-am.sh                            |    2 +-
 git-relink.perl                      |    2 +-
 31 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 9e62f87..51297d0 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=3D<option>] [-C<n>] [-p<n>] [--directory=3D<dir>]
 	 [--reject] [-q | --quiet] [--scissors | --no-scissors]
-	 [<mbox> | <Maildir>...]
+	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort)
=20
 DESCRIPTION
@@ -25,7 +25,7 @@ current branch.
=20
 OPTIONS
 -------
-<mbox>|<Maildir>...::
+(<mbox>|<Maildir>)...::
 	The list of mailbox files to read patches from. If you do not
 	supply this argument, the command reads from the standard input.
 	If you supply directories, they will be treated as Maildirs.
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 08bf6e7..881652f 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
 	  [--ignore-space-change | --ignore-whitespace ]
-	  [--whitespace=3D<nowarn|warn|fix|error|error-all>]
+	  [--whitespace=3D(nowarn|warn|fix|error|error-all)]
 	  [--exclude=3D<path>] [--include=3D<path>] [--directory=3D<root>]
 	  [--verbose] [<patch>...]
=20
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-c=
heckout-index.txt
index 62f9ab2..0c0a9c1 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 		   [--stage=3D<number>|all]
 		   [--temp]
 		   [-z] [--stdin]
-		   [--] [<file>]*
+		   [--] [<file>...]
=20
 DESCRIPTION
 -----------
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-comm=
it-tree.txt
index 349366e..5dcf427 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -8,7 +8,7 @@ git-commit-tree - Create a new commit object
=20
 SYNOPSIS
 --------
-'git commit-tree' <tree> [-p <parent commit>]* < changelog
+'git commit-tree' <tree> [(-p <parent commit>)...] < changelog
=20
 DESCRIPTION
 -----------
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 400fe7f..d159e88 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -12,7 +12,7 @@ SYNOPSIS
=20
 'git fetch' [<options>] <group>
=20
-'git fetch' --multiple [<options>] [<repository> | <group>]...
+'git fetch' --multiple [<options>] [(<repository> | <group>)...]
=20
 'git fetch' --all [<options>]
=20
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-fi=
lter-branch.txt
index f51860d..796e748 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -117,7 +117,7 @@ OPTIONS
 	This is the filter for performing the commit.
 	If this filter is specified, it will be called instead of the
 	'git commit-tree' command, with arguments of the form
-	"<TREE_ID> [-p <PARENT_COMMIT_ID>]..." and the log message on
+	"<TREE_ID> [(-p <PARENT_COMMIT_ID>)...]" and the log message on
 	stdin.  The commit id is expected on stdout.
 +
 As a special extension, the commit filter may emit multiple
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
index d66fd9d..fac1cf5 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git for-each-ref' [--count=3D<count>] [--shell|--perl|--python|--tcl]
-		   [--sort=3D<key>]* [--format=3D<format>] [<pattern>...]
+		   [(--sort=3D<key>)...] [--format=3D<format>] [<pattern>...]
=20
 DESCRIPTION
 -----------
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 246b07e..00d4a12 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -31,7 +31,7 @@ current working directory.
 Specify the directory from which templates will be used.  (See the "TE=
MPLATE
 DIRECTORY" section below.)
=20
---shared[=3D{false|true|umask|group|all|world|everybody|0xxx}]::
+--shared[=3D(false|true|umask|group|all|world|everybody|0xxx)]::
=20
 Specify that the git repository is to be shared amongst several users.=
  This
 allows users belonging to the same group to push into that
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index 347f447..86abd13 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 		[--exclude-per-directory=3D<file>]
 		[--exclude-standard]
 		[--error-unmatch] [--with-tree=3D<tree-ish>]
-		[--full-name] [--abbrev] [--] [<file>]*
+		[--full-name] [--abbrev] [--] [<file>...]
=20
 DESCRIPTION
 -----------
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsp=
lit.txt
index a634485..71912a1 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -7,7 +7,7 @@ git-mailsplit - Simple UNIX mbox splitter program
=20
 SYNOPSIS
 --------
-'git mailsplit' [-b] [-f<nn>] [-d<prec>] [--keep-cr] -o<directory> [--=
] [<mbox>|<Maildir>...]
+'git mailsplit' [-b] [-f<nn>] [-d<prec>] [--keep-cr] -o<directory> [--=
] [(<mbox>|<Maildir>)...]
=20
 DESCRIPTION
 -----------
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-merget=
ool.txt
index e4ed016..1f75a84 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -7,7 +7,7 @@ git-mergetool - Run merge conflict resolution tools to =
resolve merge conflicts
=20
 SYNOPSIS
 --------
-'git mergetool' [--tool=3D<tool>] [-y|--no-prompt|--prompt] [<file>]..=
=2E
+'git mergetool' [--tool=3D<tool>] [-y|--no-prompt|--prompt] [<file>...=
]
=20
 DESCRIPTION
 -----------
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pac=
k-objects.txt
index a1dd3e9..65eff66 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-=
implied]
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=3D<n>] [--depth=3D<n>]
-	[--revs [--unpacked | --all]*] [--stdout | base-name]
+	[--revs [--unpacked | --all]] [--stdout | base-name]
 	[--keep-true-parents] < object-list
=20
=20
diff --git a/Documentation/git-relink.txt b/Documentation/git-relink.tx=
t
index 8a5842b..8fc809f 100644
--- a/Documentation/git-relink.txt
+++ b/Documentation/git-relink.txt
@@ -7,7 +7,7 @@ git-relink - Hardlink common objects in local repositor=
ies
=20
 SYNOPSIS
 --------
-'git relink' [--safe] <dir> [<dir>]* <master_dir>
+'git relink' [--safe] <dir>... <master_dir>
=20
 DESCRIPTION
 -----------
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.tx=
t
index b317086..0d28feb 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 'git remote set-url --delete' [--push] <name> <url>
 'git remote' [-v | --verbose] 'show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
-'git remote' [-v | --verbose] 'update' [-p | --prune] [<group> | <remo=
te>]...
+'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <rem=
ote>)...]
=20
 DESCRIPTION
 -----------
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-lis=
t.txt
index cfb1d21..8e1e329 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -37,7 +37,7 @@ SYNOPSIS
 	     [ \--regexp-ignore-case | -i ]
 	     [ \--extended-regexp | -E ]
 	     [ \--fixed-strings | -F ]
-	     [ \--date=3D{local|relative|default|iso|rfc|short} ]
+	     [ \--date=3D(local|relative|default|iso|rfc|short) ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index 341ca90..4a27643 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -95,7 +95,7 @@ OPTIONS
 	unfortunately named tag "master"), and show them as full
 	refnames (e.g. "refs/heads/master").
=20
---abbrev-ref[=3D{strict|loose}]::
+--abbrev-ref[=3D(strict|loose)]::
 	A non-ambiguous short name of the objects name.
 	The option core.warnAmbiguousRefs is used to select the strict
 	abbreviation mode.
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show=
-branch.txt
index 6453263..bd9f886 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 		[--current] [--color[=3D<when>] | --no-color] [--sparse]
 		[--more=3D<n> | --list | --independent | --merge-base]
 		[--no-name | --sha1-name] [--topics]
-		[<rev> | <glob>]...
+		[(<rev> | <glob>)...]
=20
 'git show-branch' (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref>]
=20
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index be8a51f..139d314 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -438,7 +438,7 @@ git rebase --onto remotes/git-svn A^ master
 OPTIONS
 -------
=20
---shared[=3D{false|true|umask|group|all|world|everybody}]::
+--shared[=3D(false|true|umask|group|all|world|everybody)]::
 --template=3D<template_directory>::
 	Only used with the 'init' command.
 	These are passed directly to 'git init'.
diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index 74d1d49..a5782a6 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git update-index'
 	     [--add] [--remove | --force-remove] [--replace]
 	     [--refresh] [-q] [--unmerged] [--ignore-missing]
-	     [--cacheinfo <mode> <object> <file>]*
+	     [(--cacheinfo <mode> <object> <file>)...]
 	     [--chmod=3D(+|-)x]
 	     [--assume-unchanged | --no-assume-unchanged]
 	     [--skip-worktree | --no-skip-worktree]
@@ -21,7 +21,7 @@ SYNOPSIS
 	     [--info-only] [--index-info]
 	     [-z] [--stdin]
 	     [--verbose]
-	     [--] [<file>]*
+	     [--] [<file>...]
=20
 DESCRIPTION
 -----------
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index 1b13c1f..7a42567 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -13,7 +13,7 @@ include::pretty-options.txt[]
=20
 	Synonym for `--date=3Drelative`.
=20
---date=3D{relative,local,default,iso,rfc,short,raw}::
+--date=3D(relative|local|default|iso|rfc|short|raw)::
=20
 	Only takes effect for dates shown in human-readable format, such
 	as when using "--pretty". `log.date` config variable sets a default
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index ce45bfc..cb3b98a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3850,7 +3850,7 @@ You create a commit object by giving it the tree =
that describes the
 state at the time of the commit, and a list of parents:
=20
 -------------------------------------------------
-$ git commit-tree <tree> -p <parent> [-p <parent2> ..]
+$ git commit-tree <tree> -p <parent> [(-p <parent2>)...]
 -------------------------------------------------
=20
 and then giving the reason for the commit on stdin (either through
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 87f0591..e065739 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -9,7 +9,7 @@
 #include "builtin.h"
 #include "utf8.h"
=20
-static const char commit_tree_usage[] =3D "git commit-tree <sha1> [-p =
<sha1>]* < changelog";
+static const char commit_tree_usage[] =3D "git commit-tree <sha1> [(-p=
 <sha1>)...] < changelog";
=20
 static void new_parent(struct commit *parent, struct commit_list **par=
ents_p)
 {
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6fc5047..d35f000 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -16,7 +16,7 @@
 static const char * const builtin_fetch_usage[] =3D {
 	"git fetch [<options>] [<repository> [<refspec>...]]",
 	"git fetch [<options>] <group>",
-	"git fetch --multiple [<options>] [<repository> | <group>]...",
+	"git fetch --multiple [<options>] [(<repository> | <group>)...]",
 	"git fetch --all [<options>]",
 	NULL
 };
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index e243d9d..8dc5c0b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -11,7 +11,7 @@
 #include "exec_cmd.h"
=20
 static const char index_pack_usage[] =3D
-"git index-pack [-v] [-o <index-file>] [{ --keep | --keep=3D<msg> }] [=
--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
+"git index-pack [-v] [-o <index-file>] [ --keep | --keep=3D<msg> ] [--=
strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
=20
 struct object_entry
 {
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index bb4f612..6a307ab 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -424,7 +424,7 @@ int report_path_error(const char *ps_matched, const=
 char **pathspec, int prefix_
 }
=20
 static const char * const ls_files_usage[] =3D {
-	"git ls-files [options] [<file>]*",
+	"git ls-files [options] [<file>...]",
 	NULL
 };
=20
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 99654d0..2d43278 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -10,7 +10,7 @@
 #include "strbuf.h"
=20
 static const char git_mailsplit_usage[] =3D
-"git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] -o<directory> [<mbo=
x>|<Maildir>...]";
+"git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] -o<directory> [(<mb=
ox>|<Maildir>)...]";
=20
 static int is_from_line(const char *line, int len)
 {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1e4c386..26f2304 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -23,7 +23,7 @@
 #endif
=20
 static const char pack_usage[] =3D
-  "git pack-objects [{ -q | --progress | --all-progress }]\n"
+  "git pack-objects [ -q | --progress | --all-progress ]\n"
   "        [--all-progress-implied]\n"
   "        [--max-pack-size=3D<n>] [--local] [--incremental]\n"
   "        [--window=3D<n>] [--window-memory=3D<n>] [--depth=3D<n>]\n"
diff --git a/builtin/remote.c b/builtin/remote.c
index c0198fc..e9a6e09 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -15,7 +15,7 @@ static const char * const builtin_remote_usage[] =3D =
{
 	"git remote set-head <name> (-a | -d | <branch>)",
 	"git remote [-v | --verbose] show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
-	"git remote [-v | --verbose] update [-p | --prune] [<group> | <remote=
>]",
+	"git remote [-v | --verbose] update [-p | --prune] [(<group> | <remot=
e>)...]",
 	"git remote set-branches <name> [--add] <branch>...",
 	"git remote set-url <name> <newurl> [<oldurl>]",
 	"git remote set-url --add <name> <newurl>",
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e8719aa..8663cca 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -6,7 +6,7 @@
 #include "parse-options.h"
=20
 static const char* show_branch_usage[] =3D {
-    "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-=
order] [--current] [--color[=3D<when>] | --no-color] [--sparse] [--more=
=3D<n> | --list | --independent | --merge-base] [--no-name | --sha1-nam=
e] [--topics] [<rev> | <glob>]...",
+    "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-=
order] [--current] [--color[=3D<when>] | --no-color] [--sparse] [--more=
=3D<n> | --list | --independent | --merge-base] [--no-name | --sha1-nam=
e] [--topics] [(<rev> | <glob>)...]",
     "git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref>]",
     NULL
 };
diff --git a/git-am.sh b/git-am.sh
index 9317b38..763fd20 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -5,7 +5,7 @@
 SUBDIRECTORY_OK=3DYes
 OPTIONS_KEEPDASHDASH=3D
 OPTIONS_SPEC=3D"\
-git am [options] [<mbox>|<Maildir>...]
+git am [options] [(<mbox>|<Maildir>)...]
 git am [options] (--resolved | --skip | --abort)
 --
 i,interactive   run interactively
diff --git a/git-relink.perl b/git-relink.perl
index 937c69a..c2a0ef8 100755
--- a/git-relink.perl
+++ b/git-relink.perl
@@ -163,7 +163,7 @@ sub link_two_files($$) {
=20
=20
 sub usage() {
-	print("Usage: git relink [--safe] <dir> [<dir> ...] <master_dir> \n")=
;
+	print("Usage: git relink [--safe] <dir>... <master_dir> \n");
 	print("All directories should contain a .git/objects/ subdirectory.\n=
");
 	print("Options\n");
 	print("\t--safe\t" .
--=20
1.7.3.rc2.221.gbf93f.dirty
