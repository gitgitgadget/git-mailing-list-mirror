From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 2/2] git-add/rm doc: Consistently back-quote
Date: Mon, 07 Dec 2009 00:04:03 +0100
Message-ID: <4B1C3863.5080504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 00:04:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHQ9F-0004Ut-7s
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 00:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757957AbZLFXEB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Dec 2009 18:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757814AbZLFXEA
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 18:04:00 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:60427 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757766AbZLFXD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 18:03:59 -0500
Received: by ewy19 with SMTP id 19so4955907ewy.1
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 15:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=DT6vBH5dbCvzJvo9vtSspRKO/ZXi/tZuOGcv96zIBl8=;
        b=G36avCRmBmDIE/D85NU0SXrQ0JkX6mDU/JBEs3/C/FZOlaaT2dJ21ekMS2qUB9Gvrm
         +/Wn0GH90yJNZzBz+OD5U8Cx2WYS1LFzQiLQrEfrQwSuk2zVZexzozUJT8e1GifJ2t4c
         ouTKcHUls8DxyGPlphIXrja624sUm46B0pOGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=sTiPyuwWb9RrpMdCWwrswSUjXz7D0wepk3HvA4QZA20y18vBgMFMs/q2NugIImEOez
         67xM7M4/HYWDIUdVP9bzgVwK4AIMhFaZtFgBhOVtDufqZaniTbg3FYDQ0L44/4Dn49HI
         7mrbTwl3kSI9zMQqcbW/4SERINfwAaxxSJWqY=
Received: by 10.213.100.11 with SMTP id w11mr6325945ebn.34.1260140644958;
        Sun, 06 Dec 2009 15:04:04 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 15sm3126311ewy.4.2009.12.06.15.04.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Dec 2009 15:04:04 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134692>

Consistently back-quote commands, options and file names.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 Documentation/git-add.txt |   30 +++++++++++++++---------------
 Documentation/git-rm.txt  |    6 +++---
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 6d3e76f..4e33b30 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -24,22 +24,22 @@ remove paths that do not exist in the work tree any=
more.
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
@@ -99,15 +99,15 @@ apply.
 	Update only files that git already knows about, staging modified
 	content for commit and marking deleted files for removal. This
 	is similar
-	to what "git commit -a" does in preparation for making a commit,
+	to what `git commit -a` does in preparation for making a commit,
 	except that the update is limited to paths specified on the
 	command line. If no paths are specified, all tracked files in the
 	current directory and its subdirectories are updated.
=20
 -A::
 --all::
-	Update files that git already knows about (same as '\--update'),
-	add all untracked files that are not ignored by the '.gitignore'
+	Update files that git already knows about (same as `\--update`),
+	add all untracked files that are not ignored by the `.gitignore`
 	mechanism and remove files from the index that are no longer
 	present in the working tree.
 +
@@ -120,8 +120,8 @@ it will operate on those paths and their subdirecto=
ries.
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
@@ -141,7 +141,7 @@ it will operate on those paths and their subdirecto=
ries.
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
@@ -189,7 +189,7 @@ and type return, like this:
     What now> 1
 ------------
=20
-You also could say "s" or "sta" or "status" above as long as the
+You also could say `s` or `sta` or `status` above as long as the
 choice is unique.
=20
 The main command loop has 6 subcommands (plus help and quit).
@@ -197,9 +197,9 @@ The main command loop has 6 subcommands (plus help =
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
