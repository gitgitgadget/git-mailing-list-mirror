From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: [PATCH 3/4] Documentation: minor grammatical fixes in git-blame.txt.
Date: Mon, 16 Mar 2009 23:16:16 -0700
Message-ID: <1237270577-17261-3-git-send-email-dmellor@whistlingcat.com>
References: <1237270577-17261-1-git-send-email-dmellor@whistlingcat.com>
 <1237270577-17261-2-git-send-email-dmellor@whistlingcat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 17 07:21:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjSfD-0004Lb-AD
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 07:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762165AbZCQGSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 02:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758357AbZCQGSu
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 02:18:50 -0400
Received: from quartz.whistlingcat.com ([67.223.228.111]:40605 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbZCQGSs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 02:18:48 -0400
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id 44C4048800A;
	Mon, 16 Mar 2009 23:18:46 -0700 (PDT)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id 4D7E038E74F4;
	Mon, 16 Mar 2009 23:18:45 -0700 (PDT)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id 0ED7517A62; Mon, 16 Mar 2009 23:16:17 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1237270577-17261-2-git-send-email-dmellor@whistlingcat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113422>


Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 Documentation/blame-options.txt |    2 +-
 Documentation/git-blame.txt     |   56 +++++++++++++++++++-------------------
 Documentation/mailmap.txt       |   17 +++++------
 3 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 63fc197..1625ffc 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -39,7 +39,7 @@ of lines before or after the line given by <start>.
 	Show raw timestamp (Default: off).
 
 -S <revs-file>::
-	Use revs from revs-file instead of calling linkgit:git-rev-list[1].
+	Use revisions from revs-file instead of calling linkgit:git-rev-list[1].
 
 --reverse::
 	Walk history forward instead of backward. Instead of showing
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 4ef54d6..8c7b7b0 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -18,9 +18,9 @@ DESCRIPTION
 Annotates each line in the given file with information from the revision which
 last modified the line. Optionally, start annotating from the given revision.
 
-Also it can limit the range of lines annotated.
+The command can also limit the range of lines annotated.
 
-This report doesn't tell you anything about lines which have been deleted or
+The report does not tell you anything about lines which have been deleted or
 replaced; you need to use a tool such as 'git-diff' or the "pickaxe"
 interface briefly mentioned in the following paragraph.
 
@@ -48,26 +48,26 @@ include::blame-options.txt[]
 	lines between files (see `-C`) and lines moved within a
 	file (see `-M`).  The first number listed is the score.
 	This is the number of alphanumeric characters detected
-	to be moved between or within files.  This must be above
+	as having been moved between or within files.  This must be above
 	a certain threshold for 'git-blame' to consider those lines
 	of code to have been moved.
 
 -f::
 --show-name::
-	Show filename in the original commit.  By default
-	filename is shown if there is any line that came from a
-	file with different name, due to rename detection.
+	Show the filename in the original commit.  By default
+	the filename is shown if there is any line that came from a
+	file with a different name, due to rename detection.
 
 -n::
 --show-number::
-	Show line number in the original commit (Default: off).
+	Show the line number in the original commit (Default: off).
 
 -s::
-	Suppress author name and timestamp from the output.
+	Suppress the author name and timestamp from the output.
 
 -w::
-	Ignore whitespace when comparing parent's version and
-	child's to find where the lines came from.
+	Ignore whitespace when comparing the parent's version and
+	the child's to find where the lines came from.
 
 
 THE PORCELAIN FORMAT
@@ -79,17 +79,17 @@ header at the minimum has the first line which has:
 - 40-byte SHA-1 of the commit the line is attributed to;
 - the line number of the line in the original file;
 - the line number of the line in the final file;
-- on a line that starts a group of line from a different
+- on a line that starts a group of lines from a different
   commit than the previous one, the number of lines in this
   group.  On subsequent lines this field is absent.
 
 This header line is followed by the following information
 at least once for each commit:
 
-- author name ("author"), email ("author-mail"), time
+- the author name ("author"), email ("author-mail"), time
   ("author-time"), and timezone ("author-tz"); similarly
   for committer.
-- filename in the commit the line is attributed to.
+- the filename in the commit that the line is attributed to.
 - the first line of the commit log message ("summary").
 
 The contents of the actual line is output after the above
@@ -100,23 +100,23 @@ header elements later.
 SPECIFYING RANGES
 -----------------
 
-Unlike 'git-blame' and 'git-annotate' in older git, the extent
-of annotation can be limited to both line ranges and revision
+Unlike 'git-blame' and 'git-annotate' in older versions of git, the extent
+of the annotation can be limited to both line ranges and revision
 ranges.  When you are interested in finding the origin for
-ll. 40-60 for file `foo`, you can use `-L` option like these
+lines 40-60 for file `foo`, you can use the `-L` option like so
 (they mean the same thing -- both ask for 21 lines starting at
 line 40):
 
 	git blame -L 40,60 foo
 	git blame -L 40,+21 foo
 
-Also you can use regular expression to specify the line range.
+Also you can use a regular expression to specify the line range:
 
 	git blame -L '/^sub hello {/,/^}$/' foo
 
-would limit the annotation to the body of `hello` subroutine.
+which limits the annotation to the body of the `hello` subroutine.
 
-When you are not interested in changes older than the version
+When you are not interested in changes older than version
 v2.6.18, or changes older than 3 weeks, you can use revision
 range specifiers  similar to 'git-rev-list':
 
@@ -129,7 +129,7 @@ commit v2.6.18 or the most recent commit that is more than 3
 weeks old in the above example) are blamed for that range
 boundary commit.
 
-A particularly useful way is to see if an added file have lines
+A particularly useful way is to see if an added file has lines
 created by copy-and-paste from existing files.  Sometimes this
 indicates that the developer was being sloppy and did not
 refactor the code properly.  You can first find the commit that
@@ -162,26 +162,26 @@ annotated.
 +
 Line numbers count from 1.
 
-. The first time that commit shows up in the stream, it has various
+. The first time that a commit shows up in the stream, it has various
   other information about it printed out with a one-word tag at the
-  beginning of each line about that "extended commit info" (author,
-  email, committer, dates, summary etc).
+  beginning of each line describing the extra commit information (author,
+  email, committer, dates, summary, etc.).
 
-. Unlike Porcelain format, the filename information is always
+. Unlike the Porcelain format, the filename information is always
   given and terminates the entry:
 
 	"filename" <whitespace-quoted-filename-goes-here>
 +
-and thus it's really quite easy to parse for some line- and word-oriented
+and thus it is really quite easy to parse for some line- and word-oriented
 parser (which should be quite natural for most scripting languages).
 +
 [NOTE]
 For people who do parsing: to make it more robust, just ignore any
-lines in between the first and last one ("<sha1>" and "filename" lines)
-where you don't recognize the tag-words (or care about that particular
+lines between the first and last one ("<sha1>" and "filename" lines)
+where you do not recognize the tag words (or care about that particular
 one) at the beginning of the "extended information" lines. That way, if
 there is ever added information (like the commit encoding or extended
-commit commentary), a blame viewer won't ever care.
+commit commentary), a blame viewer will not care.
 
 
 MAPPING AUTHORS
diff --git a/Documentation/mailmap.txt b/Documentation/mailmap.txt
index e25b154..288f04e 100644
--- a/Documentation/mailmap.txt
+++ b/Documentation/mailmap.txt
@@ -5,22 +5,21 @@ canonical real names and email addresses.
 
 In the simple form, each line in the file consists of the canonical
 real name of an author, whitespace, and an email address used in the
-commit (enclosed by '<' and '>') to map to the name. Thus, looks like
-this
+commit (enclosed by '<' and '>') to map to the name. For example:
 --
 	Proper Name <commit@email.xx>
 --
 
-The more complex forms are
+The more complex forms are:
 --
 	<proper@email.xx> <commit@email.xx>
 --
-which allows mailmap to replace only the email part of a commit, and
+which allows mailmap to replace only the email part of a commit, and:
 --
 	Proper Name <proper@email.xx> <commit@email.xx>
 --
 which allows mailmap to replace both the name and the email of a
-commit matching the specified commit email address, and
+commit matching the specified commit email address, and:
 --
 	Proper Name <proper@email.xx> Commit Name <commit@email.xx>
 --
@@ -47,8 +46,8 @@ Jane Doe         <jane@desktop.(none)>
 Joe R. Developer <joe@example.com>
 ------------
 
-Note how we don't need an entry for <jane@laptop.(none)>, because the
-real name of that author is correct already.
+Note how there is no need for an entry for <jane@laptop.(none)>, because the
+real name of that author is already correct.
 
 Example 2: Your repository contains commits from the following
 authors:
@@ -62,7 +61,7 @@ claus <me@company.xx>
 CTO <cto@coompany.xx>
 ------------
 
-Then, you might want a `.mailmap` file looking like:
+Then you might want a `.mailmap` file that looks like:
 ------------
 <cto@company.xx>                       <cto@coompany.xx>
 Some Dude <some@dude.xx>         nick1 <bugs@company.xx>
@@ -72,4 +71,4 @@ Santa Claus <santa.claus@northpole.xx> <me@company.xx>
 ------------
 
 Use hash '#' for comments that are either on their own line, or after
-the email address.
\ No newline at end of file
+the email address.
-- 
1.6.2.1
