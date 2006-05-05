From: sean <seanlkml@sympatico.ca>
Subject: [PATCH] Fix up docs where "--" isn't displayed correctly.
Date: Fri, 5 May 2006 15:05:24 -0400
Message-ID: <BAYC1-PASMTP028B5BA39622A448E107FCAEB50@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 05 21:10:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc5h3-0001ot-V9
	for gcvg-git@gmane.org; Fri, 05 May 2006 21:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWEETKW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 15:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbWEETKW
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 15:10:22 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:39153 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751682AbWEETKU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 15:10:20 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 5 May 2006 12:10:19 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 97074644C28
	for <git@vger.kernel.org>; Fri,  5 May 2006 15:10:18 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060505150524.27855c10.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 05 May 2006 19:10:20.0073 (UTC) FILETIME=[8D4D9990:01C67077]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A bare "--" doesn't show up in man or html pages correctly
as two individual dashes unless backslashed as \--
in the asciidoc source.  Note, no backslash is needed
inside a literal block.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>


---

 Documentation/git-add.txt            |    2 +-
 Documentation/git-checkout-index.txt |    2 +-
 Documentation/git-commit.txt         |    2 +-
 Documentation/git-log.txt            |    2 +-
 Documentation/git-ls-files.txt       |    2 +-
 Documentation/git-merge-index.txt    |    4 ++--
 Documentation/git-prune.txt          |    2 +-
 Documentation/git-rm.txt             |    2 +-
 Documentation/git-update-index.txt   |    2 +-
 Documentation/git-verify-pack.txt    |    2 +-
 Documentation/git-whatchanged.txt    |    2 +-
 Documentation/gitk.txt               |    2 +-
 12 files changed, 13 insertions(+), 13 deletions(-)

32a74a984e6c1869dbebc9bc8d2fe9503e8dd624
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ae24547..5e31129 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -26,7 +26,7 @@ OPTIONS
 -v::
         Be verbose.
 
---::
+\--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
 	for command-line options).
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 09bd6a5..765c173 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -63,7 +63,7 @@ OPTIONS
 	Only meaningful with `--stdin`; paths are separated with
 	NUL character instead of LF.
 
---::
+\--::
 	Do not interpret any more arguments as options.
 
 The order of the flags used to matter, but not anymore.
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0a7365b..38df59c 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -106,7 +106,7 @@ but can be used to amend a merge commit.
 	index and the latest commit does not match on the
 	specified paths to avoid confusion.
 
---::
+\--::
 	Do not interpret any more arguments as options.
 
 <file>...::
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index af378ff..c9ffff7 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -51,7 +51,7 @@ git log v2.6.12.. include/scsi drivers/s
 	Show all commits since version 'v2.6.12' that changed any file
 	in the include/scsi or drivers/scsi subdirectories
 
-git log --since="2 weeks ago" -- gitk::
+git log --since="2 weeks ago" \-- gitk::
 
 	Show the changes during the last two weeks to the file 'gitk'.
 	The "--" is necessary to avoid confusion with the *branch* named
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 796d049..a29c633 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -106,7 +106,7 @@ OPTIONS
 	lines, show only handful hexdigits prefix.
 	Non default number of digits can be specified with --abbrev=<n>.
 
---::
+\--::
 	Do not interpret any more arguments as options.
 
 <file>::
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index fbc986a..332e023 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -8,7 +8,7 @@ git-merge-index - Runs a merge for files
 
 SYNOPSIS
 --------
-'git-merge-index' [-o] [-q] <merge-program> (-a | -- | <file>\*)
+'git-merge-index' [-o] [-q] <merge-program> (-a | \-- | <file>\*)
 
 DESCRIPTION
 -----------
@@ -19,7 +19,7 @@ files are passed as arguments 5, 6 and 7
 
 OPTIONS
 -------
---::
+\--::
 	Do not interpret any more arguments as options.
 
 -a::
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index f694fcb..a11e303 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -28,7 +28,7 @@ OPTIONS
 	Do not remove anything; just report what it would
 	remove.
 
---::
+\--::
 	Do not interpret any more arguments as options.
 
 <head>...::
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index c9c3088..66fc478 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -32,7 +32,7 @@ OPTIONS
 -v::
         Be verbose.
 
---::
+\--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
 	for command-line options).
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 23f2b6f..57177c7 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -113,7 +113,7 @@ OPTIONS
 	Only meaningful with `--stdin`; paths are separated with
 	NUL character instead of LF.
 
---::
+\--::
 	Do not interpret any more arguments as options.
 
 <file>::
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index 4962d69..7a6132b 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -25,7 +25,7 @@ OPTIONS
 -v::
 	After verifying the pack, show list of objects contained
 	in the pack.
---::
+\--::
 	Do not interpret any more arguments as options.
 
 OUTPUT FORMAT
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index 641cb7e..e8f21d0 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -58,7 +58,7 @@ git-whatchanged -p v2.6.12.. include/scs
 	Show as patches the commits since version 'v2.6.12' that changed
 	any file in the include/scsi or drivers/scsi subdirectories
 
-git-whatchanged --since="2 weeks ago" -- gitk::
+git-whatchanged --since="2 weeks ago" \-- gitk::
 
 	Show the changes during the last two weeks to the file 'gitk'.
 	The "--" is necessary to avoid confusion with the *branch* named
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index eb126d7..cb482bf 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -31,7 +31,7 @@ gitk v2.6.12.. include/scsi drivers/scsi
 	Show as the changes since version 'v2.6.12' that changed any
 	file in the include/scsi or drivers/scsi subdirectories
 
-gitk --since="2 weeks ago" -- gitk::
+gitk --since="2 weeks ago" \-- gitk::
 
 	Show the changes during the last two weeks to the file 'gitk'.
 	The "--" is necessary to avoid confusion with the *branch* named
-- 
1.3.1.g9c203
