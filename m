From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: [PATCH 1/3] Documentation: minor grammatical fixes.
Date: Sun, 1 Mar 2009 22:37:41 -0800
Message-ID: <20090302163415.563D217A49@sandstone.whistlingcat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 02 17:36:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeB7S-0007fs-5R
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 17:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738AbZCBQeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 11:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758566AbZCBQeV
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 11:34:21 -0500
Received: from quartz.whistlingcat.com ([67.223.228.111]:55460 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591AbZCBQeU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 11:34:20 -0500
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id 06723488006;
	Mon,  2 Mar 2009 08:34:16 -0800 (PST)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id 95F7538E74F0;
	Mon,  2 Mar 2009 08:34:15 -0800 (PST)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id 563D217A49; Mon,  2 Mar 2009 08:34:15 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111945>


Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 Documentation/git-am.txt |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index ff307eb..1e71dd5 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -27,8 +27,8 @@ OPTIONS
 -------
 <mbox>|<Maildir>...::
 	The list of mailbox files to read patches from. If you do not
-	supply this argument, reads from the standard input. If you supply
-	directories, they'll be treated as Maildirs.
+	supply this argument, the command reads from the standard input.
+	If you supply directories, they will be treated as Maildirs.
 
 -s::
 --signoff::
@@ -48,7 +48,7 @@ OPTIONS
 	preferred encoding if it is not UTF-8).
 +
 This was optional in prior versions of git, but now it is the
-default.   You could use `--no-utf8` to override this.
+default.   You can use `--no-utf8` to override this.
 
 --no-utf8::
 	Pass `-n` flag to 'git-mailinfo' (see
@@ -57,8 +57,8 @@ default.   You could use `--no-utf8` to override this.
 -3::
 --3way::
 	When the patch does not apply cleanly, fall back on
-	3-way merge, if the patch records the identity of blobs
-	it is supposed to apply to, and we have those blobs
+	3-way merge if the patch records the identity of blobs
+	it is supposed to apply to and we have those blobs
 	available locally.
 
 --whitespace=<option>::
@@ -121,18 +121,18 @@ the commit, after stripping common prefix "[PATCH <anything>]".
 It is supposed to describe what the commit is about concisely as
 a one line text.
 
-The body of the message (iow, after a blank line that terminates
-RFC2822 headers) can begin with "Subject: " and "From: " lines
-that are different from those of the mail header, to override
-the values of these fields.
+The body of the message (the rest of the message after the blank line
+that terminates the RFC2822 headers) can begin with "Subject: " and
+"From: " lines that are different from those of the mail header,
+to override the values of these fields.
 
 The commit message is formed by the title taken from the
 "Subject: ", a blank line and the body of the message up to
-where the patch begins.  Excess whitespaces at the end of the
+where the patch begins.  Excess whitespace characters at the end of the
 lines are automatically stripped.
 
 The patch is expected to be inline, directly following the
-message.  Any line that is of form:
+message.  Any line that is of the form:
 
 * three-dashes and end-of-line, or
 * a line that begins with "diff -", or
@@ -141,18 +141,18 @@ message.  Any line that is of form:
 is taken as the beginning of a patch, and the commit log message
 is terminated before the first occurrence of such a line.
 
-When initially invoking it, you give it names of the mailboxes
-to crunch.  Upon seeing the first patch that does not apply, it
-aborts in the middle,.  You can recover from this in one of two ways:
+When initially invoking it, you give it the names of the mailboxes
+to process.  Upon seeing the first patch that does not apply, it
+aborts in the middle.  You can recover from this in one of two ways:
 
-. skip the current patch by re-running the command with '--skip'
+. skip the current patch by re-running the command with the '--skip'
   option.
 
 . hand resolve the conflict in the working directory, and update
-  the index file to bring it in a state that the patch should
-  have produced.  Then run the command with '--resolved' option.
+  the index file to bring it into a state that the patch should
+  have produced.  Then run the command with the '--resolved' option.
 
-The command refuses to process new mailboxes while `.git/rebase-apply`
+The command refuses to process new mailboxes while the `.git/rebase-apply`
 directory exists, so if you decide to start over from scratch,
 run `rm -f -r .git/rebase-apply` before running the command with mailbox
 names.
-- 
1.6.1.3
