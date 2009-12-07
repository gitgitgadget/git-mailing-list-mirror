From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 1/2] git-add/rm doc: Consistently back-quote
Date: Mon, 07 Dec 2009 19:26:57 +0100
Message-ID: <4B1D48F1.1060303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 19:27:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHiId-0003G4-4G
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 19:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758208AbZLGS0y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2009 13:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757866AbZLGS0x
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 13:26:53 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:53610 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758041AbZLGS0w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 13:26:52 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so791269ewy.1
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 10:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=He2G48doV5BhZeXFI33/qVpY0lrJcm6u1VaEEUGFZEE=;
        b=VbARPpEZjlys2s3eeLkQJr6FlGJfVcxQXNJ62ucHrj/jeBSHAWj2rjKHmuquwUisAD
         97EOBpqY34hKbDTHg+C9mKgj3Y7Hf605QlECWQl56DR2F1g5qeuGT6LaiA1cTh9W/MZc
         N2WVEt7rKrF/Q+ZLizhw+Vn0a4CqPEDxKpm9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=bgjCwR1onFWOgA67ZHGC782mgcGf6IaRK2Cjt9+GlHG0VOmnmoDursyOnaAQ58KNht
         s9XvJUqrcjIx203/XASEk9Q9+D35V/K8AeIqh6f6J+GyfxPP8/G3JUgQagPQKKR32phw
         sCT51rbPQTx/0QsKl0nkMONcYjlVpZEJ5e5zA=
Received: by 10.213.100.138 with SMTP id y10mr7308177ebn.96.1260210419097;
        Mon, 07 Dec 2009 10:26:59 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 14sm3544977ewy.15.2009.12.07.10.26.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 10:26:58 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134771>

Consistently back-quote commands, options and file names.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 Documentation/git-add.txt |   24 ++++++++++++------------
 Documentation/git-rm.txt  |    6 +++---
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ed68ea3..1f1b199 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -24,22 +24,22 @@ remove paths that do not exist in the working tree =
anymore.
 The "index" holds a snapshot of the content of the working tree, and i=
t
 is this snapshot that is taken as the contents of the next commit.  Th=
us
 after making any changes to the working directory, and before running
-the commit command, you must use the 'add' command to add any new or
+the commit command, you must use the `add` command to add any new or
 modified files to the index.
=20
 This command can be performed multiple times before a commit.  It only
 adds the content of the specified file(s) at the time the add command =
is
 run; if you want subsequent changes included in the next commit, then
-you must run 'git add' again to add the new content to the index.
+you must run `git add` again to add the new content to the index.
=20
-The 'git status' command can be used to obtain a summary of which
+The `git status` command can be used to obtain a summary of which
 files have changes that are staged for the next commit.
=20
-The 'git add' command will not add ignored files by default.  If any
-ignored files were explicitly specified on the command line, 'git add'
+The `git add` command will not add ignored files by default.  If any
+ignored files were explicitly specified on the command line, `git add`
 will fail with a list of ignored files.  Ignored files reached by
 directory recursion or filename globbing performed by Git (quote your
-globs before the shell) will be silently ignored.  The 'add' command c=
an
+globs before the shell) will be silently ignored.  The `add` command c=
an
 be used to add ignored files with the `-f` (force) option.
=20
 Please see linkgit:git-commit[1] for alternative ways to add content t=
o a
@@ -119,8 +119,8 @@ subdirectories.
 	Record only the fact that the path will be added later. An entry
 	for the path is placed in the index with no content. This is
 	useful for, among other things, showing the unstaged content of
-	such files with 'git diff' and committing them with 'git commit
-	-a'.
+	such files with `git diff` and committing them with `git commit
+	-a`.
=20
 --refresh::
 	Don't add the file(s), but only refresh their stat()
@@ -140,7 +140,7 @@ subdirectories.
 Configuration
 -------------
=20
-The optional configuration variable 'core.excludesfile' indicates a pa=
th to a
+The optional configuration variable `core.excludesfile` indicates a pa=
th to a
 file containing patterns of file names to exclude from git-add, simila=
r to
 $GIT_DIR/info/exclude.  Patterns in the exclude file are used in addit=
ion to
 those in info/exclude.  See linkgit:gitrepository-layout[5].
@@ -188,7 +188,7 @@ and type return, like this:
     What now> 1
 ------------
=20
-You also could say "s" or "sta" or "status" above as long as the
+You also could say `s` or `sta` or `status` above as long as the
 choice is unique.
=20
 The main command loop has 6 subcommands (plus help and quit).
@@ -196,9 +196,9 @@ The main command loop has 6 subcommands (plus help =
and quit).
 status::
=20
    This shows the change between HEAD and index (i.e. what will be
-   committed if you say "git commit"), and between index and
+   committed if you say `git commit`), and between index and
    working tree files (i.e. what you could stage further before
-   "git commit" using "git-add") for each path.  A sample output
+   `git commit` using `git add`) for each path.  A sample output
    looks like this:
 +
 ------------
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 5afb1e7..d4162f6 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -12,13 +12,13 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Remove files from the index, or from the working tree and the index.
-'git-rm' will not remove a file from just your working directory.
+`git rm` will not remove a file from just your working directory.
 (There is no option to remove a file only from the work tree
 and yet keep it in the index; use `/bin/rm` if you want to do that.)
 The files being removed have to be identical to the tip of the branch,
 and no updates to their contents can be staged in the index,
 though that default behavior can be overridden with the `-f` option.
-When '--cached' is given, the staged content has to
+When `--cached` is given, the staged content has to
 match either the tip of the branch or the file on disk,
 allowing the file to be removed from just the index.
=20
@@ -64,7 +64,7 @@ OPTIONS
=20
 -q::
 --quiet::
-	'git-rm' normally outputs one line (in the form of an "rm" command)
+	`git rm` normally outputs one line (in the form of an `rm` command)
 	for each file removed. This option suppresses that output.
=20
=20
--=20
1.6.6.rc1.31.g1a56b
