From: Ori Avtalion <ori@avtalion.name>
Subject: [PATCH] Change mentions of "git programs" to "git commands"
Date: Fri, 7 Aug 2009 17:24:21 +0300
Message-ID: <4a7c3971.170d660a.3caa.20b3@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 07 16:26:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZQOq-0001NX-Hz
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 16:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757900AbZHGOZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 10:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757893AbZHGOZz
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 10:25:55 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:40444 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757897AbZHGOZy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 10:25:54 -0400
Received: by fxm28 with SMTP id 28so1357194fxm.17
        for <git@vger.kernel.org>; Fri, 07 Aug 2009 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:sender:from:to
         :date:subject;
        bh=P0j/a8Kin+spaxezWe0Lcl6f4cIeITVaxUr1eOB9LTg=;
        b=iJOIrWkzu+aYOZWLJX+RRo5BZqtlJrcPUaXY18VfkXOsI4sRDaUoMqtzRgy78TlYuV
         DalnXsEd/tEHCPgYm7r/xptlYtKLneiG12ZoQSz9uQ7eOpol0esWKilcINh8veZodtQd
         ueIymYrWFqFVBK2FAq8K4cXLcbSkosrOyrBF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:sender:from:to:date:subject;
        b=wF5G9f3/nhpDZ8uOF9Va5tYvYh02GHWUvfdXNTmh+AyHfUEChYLWH54goxjaU9ZTVX
         Uoka8+608WsdQY6TbiTstQK80SOw/YZNcTV9Z5aZGazw8FtCabpQCZZur8Ez5Xohw0sz
         XBFKwwaJkrZurFnw0Rm4GwioRAXw1gg91+XEw=
Received: by 10.103.131.8 with SMTP id i8mr527926mun.124.1249655154517;
        Fri, 07 Aug 2009 07:25:54 -0700 (PDT)
Received: from ?127.0.1.1? (bzq-79-176-137-245.red.bezeqint.net [79.176.137.245])
        by mx.google.com with ESMTPS id 23sm6101364mum.35.2009.08.07.07.25.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 07:25:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125199>

Most of the docs and printouts refer to "commands".
This patch changes the other terminology to be consistent.

Signed-off-by: Ori Avtalion <ori@avtalion.name>
---
 Documentation/config.txt           |    4 ++--
 Documentation/fetch-options.txt    |    2 +-
 Documentation/git-rev-list.txt     |    2 +-
 Documentation/git.txt              |    4 ++--
 Documentation/gitattributes.txt    |    2 +-
 Documentation/gitcore-tutorial.txt |    4 ++--
 Documentation/user-manual.txt      |    2 +-
 help.c                             |    2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c6f09f8..e94a8ab 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -605,7 +605,7 @@ color.interactive.<slot>::
 	Use customized color for 'git-add --interactive'
 	output. `<slot>` may be `prompt`, `header`, `help` or `error`, for
 	four distinct types of normal output from interactive
-	programs.  The values of these variables may be specified as
+	commands.  The values of these variables may be specified as
 	in color.branch.<slot>.
 
 color.pager::
@@ -1113,7 +1113,7 @@ instaweb.port::
 	linkgit:git-instaweb[1].
 
 interactive.singlekey::
-	In interactive programs, allow the user to provide one-letter
+	In interactive commands, allow the user to provide one-letter
 	input with a single key (i.e., without hitting enter).
 	Currently this is used only by the `\--patch` mode of
 	linkgit:git-add[1].  Note that this setting is silently
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index d313795..20bf512 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -1,7 +1,7 @@
 -q::
 --quiet::
 	Pass --quiet to git-fetch-pack and silence any other internally
-	used programs.
+	used utilities.
 
 -v::
 --verbose::
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index bf98c84..21ccccd 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -90,7 +90,7 @@ between the two operands.  The following two commands are equivalent:
 	$ git rev-list A...B
 -----------------------------------------------------------------------
 
-'git-rev-list' is a very essential git program, since it
+'git-rev-list' is a very essential git command, since it
 provides the ability to build and traverse commit ancestry graphs. For
 this reason, it has a lot of different options that enables it to be
 used by commands as different as 'git-bisect' and
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 5fd5953..fe13e09 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -189,7 +189,7 @@ because `git --help ...` is converted internally into `git
 help ...`.
 
 --exec-path::
-	Path to wherever your core git programs are installed.
+	Path to wherever your core git commands are installed.
 	This can also be controlled by setting the GIT_EXEC_PATH
 	environment variable. If no path is given, 'git' will print
 	the current setting and then exit.
@@ -327,7 +327,7 @@ Synching repositories
 
 include::cmds-synchingrepositories.txt[]
 
-The following are helper programs used by the above; end users
+The following are helper commands used by the above; end users
 typically do not use them directly.
 
 include::cmds-synchelpers.txt[]
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index aaa073e..1195e83 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -404,7 +404,7 @@ Performing a three-way merge
 
 The attribute `merge` affects how three versions of a file is
 merged when a file-level merge is necessary during `git merge`,
-and other programs such as `git revert` and `git cherry-pick`.
+and other commands such as `git revert` and `git cherry-pick`.
 
 Set::
 
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 7ba5e58..b3640c4 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -12,7 +12,7 @@ git *
 DESCRIPTION
 -----------
 
-This tutorial explains how to use the "core" git programs to set up and
+This tutorial explains how to use the "core" git commands to set up and
 work with a git repository.
 
 If you just need to use git as a revision control system you may prefer
@@ -1328,7 +1328,7 @@ into it later. Obviously, this repository creation needs to be
 done only once.
 
 [NOTE]
-'git-push' uses a pair of programs,
+'git-push' uses a pair of commands,
 'git-send-pack' on your local machine, and 'git-receive-pack'
 on the remote machine. The communication between the two over
 the network internally uses an SSH connection.
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 0b88a51..67ebffa 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4131,7 +4131,7 @@ What does this mean?
 
 `git rev-list` is the original version of the revision walker, which
 _always_ printed a list of revisions to stdout.  It is still functional,
-and needs to, since most new Git programs start out as scripts using
+and needs to, since most new Git commands start out as scripts using
 `git rev-list`.
 
 `git rev-parse` is not as important any more; it was only used to filter out
diff --git a/help.c b/help.c
index 6c46d8b..57a0e0e 100644
--- a/help.c
+++ b/help.c
@@ -334,7 +334,7 @@ const char *help_unknown_cmd(const char *cmd)
 		const char *assumed = main_cmds.names[0]->name;
 		main_cmds.names[0] = NULL;
 		clean_cmdnames(&main_cmds);
-		fprintf(stderr, "WARNING: You called a Git program named '%s', "
+		fprintf(stderr, "WARNING: You called a Git command named '%s', "
 			"which does not exist.\n"
 			"Continuing under the assumption that you meant '%s'\n",
 			cmd, assumed);
-- 
1.6.0.4
