From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] Change mentions of "git programs" to "git commands"
Date: Tue, 11 Aug 2009 12:58:13 +0900
Message-ID: <20090811125813.6117@nanako3.lavabit.com>
References: <4a7c3971.170d660a.3caa.20b3@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Ori Avtalion <ori@avtalion.name>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 15:04:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mar1P-0003ny-Fm
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 15:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663AbZHKNCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 09:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754660AbZHKNCt
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 09:02:49 -0400
Received: from karen.lavabit.com ([72.249.41.33]:47110 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754637AbZHKNCr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 09:02:47 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 125D511B864;
	Mon, 10 Aug 2009 22:59:14 -0500 (CDT)
Received: from 5125.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id ILEXN47P5L78; Mon, 10 Aug 2009 22:59:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Qib1Zztr6CEtsq7XeLHEWn/aMSaNHG3Ut6806UjEAviTyPtE72kxfLLY26cCtjJJcMV6dOxk5jIkLfpFd8VhihBYKHkW6XOHjZWADJsezv70rnuPVFRWupTmXVWqn2shxl0yYge54wK/pj7yig2mezelresg/3kuidDb42CWkrc=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <4a7c3971.170d660a.3caa.20b3@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125546>

From: Ori Avtalion <ori@avtalion.name>
Date: Fri, 7 Aug 2009 17:24:21 +0300
Subject: [PATCH] Change mentions of "git programs" to "git commands"

Most of the docs and printouts refer to "commands" when discussing what
the end users call via the "git" top-level program. We should refer them
as "git programs" when we discuss the fact that the commands are
implemented as separate programs, but in other contexts, it is better to
use the term "git commands" consistently.

Signed-off-by: Ori Avtalion <ori@avtalion.name>
Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

 Junio, it appeard to me that you had some minor issues with Ori's patch but you knew exactly how they should be addressed and you thought it was a good change overall.

 I copy-edited Ori's patch for your convenience, and tried to clarify the criteria you used to decide which "program" should become "command" in the updated commit log message, in case you forgot to apply it yourself.

 I just didn't want to see the time you and others spent on submitting and reviewing wasted due to lack of resubmission of a revised patch.

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
+	used git commands.
 
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
+'rev-list' is a very essential git command, since it
 provides the ability to build and traverse commit ancestry graphs. For
 this reason, it has a lot of different options that enables it to be
 used by commands as different as 'git-bisect' and
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 5fd5953..fe13e09 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
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
1.6.2.GIT

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
