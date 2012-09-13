From: Jeremy White <jwhite@codeweavers.com>
Subject: [PATCH] Documentation: Use 'First Paragraph' instead of 'First Line'.
Date: Thu, 13 Sep 2012 07:42:08 -0500
Message-ID: <5051D4A0.4060608@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 14:58:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TC900-00009C-Sv
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 14:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758036Ab2IMM6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 08:58:19 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:56325 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757940Ab2IMM6S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 08:58:18 -0400
X-Greylist: delayed 952 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Sep 2012 08:58:17 EDT
Received: from jwhite-home.codeweavers.com ([209.240.253.22] helo=[10.0.0.16])
	by mail.codeweavers.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <jwhite@codeweavers.com>)
	id 1TC8kH-0003dG-UG
	for git@vger.kernel.org; Thu, 13 Sep 2012 07:42:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
X-Enigmail-Version: 1.4.1
X-Spam-Score: -2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205367>

The discussion of email subject throughout the documentation is
misleading; it indicates that the first line will become the subject.
In fact, the first and second and third lines will become the subject,
up until the first full blank line.  Describing it as the first paragraph
is more accurate.

Signed-off-by: Jeremy White <jwhite@codeweavers.com>
---
 Documentation/git-commit.txt       |    2 +-
 Documentation/git-for-each-ref.txt |    2 +-
 Documentation/git-format-patch.txt |    8 +++++---
 Documentation/git-shortlog.txt     |    2 +-
 Documentation/gitcore-tutorial.txt |    2 +-
 Documentation/gittutorial.txt      |    2 +-
 Documentation/user-manual.txt      |    2 +-
 7 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index e99bb14..a61bca9 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -349,7 +349,7 @@ DISCUSSION
 Though not required, it's a good idea to begin the commit message
 with a single short (less than 50 character) line summarizing the
 change, followed by a blank line and then a more thorough description.
-Tools that turn commits into email, for example, use the first line
+Tools that turn commits into email, for example, use the first paragraph
 on the Subject: line and the rest of the commit in the body.
 
 include::i18n.txt[]
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 7e83288..499c26a 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -100,7 +100,7 @@ Fields that have name-email-date tuple as its value (`author`,
 `committer`, and `tagger`) can be suffixed with `name`, `email`,
 and `date` to extract the named component.
 
-The first line of the message in a commit and tag object is
+The first paragraph of the message in a commit and tag object is
 `subject`, the remaining lines are `body`.  The whole message
 is `contents`.
 
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 9674f9d..e6f6d0e 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -57,10 +57,12 @@ output, unless the `--stdout` option is specified.
 If `-o` is specified, output files are created in <dir>.  Otherwise
 they are created in the current working directory.
 
-By default, the subject of a single patch is "[PATCH] First Line" and
+By default, the subject of a single patch is "[PATCH] First Paragraph" and
 the subject when multiple patches are output is "[PATCH n/m] First
-Line". To force 1/1 to be added for a single patch, use `-n`.  To omit
-patch numbers from the subject, use `-N`.
+Paragraph". Note that "First Paragraph" consists of text in the commit message
+prior to the first completely blank line (see the DISCUSSION section
+in linkgit:git-commit[1]).  To force 1/1 to be added for a single patch,
+use `-n`.  To omit patch numbers from the subject, use `-N`.
 
 If given `--thread`, `git-format-patch` will generate `In-Reply-To` and
 `References` headers to make the second and subsequent patch mails appear
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index dfd4d0c..9464932 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -15,7 +15,7 @@ DESCRIPTION
 -----------
 Summarizes 'git log' output in a format suitable for inclusion
 in release announcements. Each commit will be grouped by author and
-the first line of the commit message will be shown.
+the first paragraph of the commit message will be shown.
 
 Additionally, "[PATCH]" will be stripped from the commit description.
 
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index f7815e9..92f97e6 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -956,7 +956,7 @@ $ git show-branch --topo-order --more=1 master mybranch
 ------------------------------------------------
 
 The first two lines indicate that it is showing the two branches
-and the first line of the commit log message from their
+and the first paragraph of the commit log message from their
 top-of-the-tree commits, you are currently on `master` branch
 (notice the asterisk `\*` character), and the first column for
 the later output lines is used to show commits contained in the
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 1c16066..a1bc56c 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -139,7 +139,7 @@ A note on commit messages: Though not required, it's a good idea to
 begin the commit message with a single short (less than 50 character)
 line summarizing the change, followed by a blank line and then a more
 thorough description.  Tools that turn commits into email, for
-example, use the first line on the Subject: line and the rest of the
+example, use the first paragraph on the Subject: line and the rest of the
 commit in the body.
 
 Git tracks content not files
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index fe6fb72..dd2f985 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1126,7 +1126,7 @@ Though not required, it's a good idea to begin the commit message
 with a single short (less than 50 character) line summarizing the
 change, followed by a blank line and then a more thorough
 description.  Tools that turn commits into email, for example, use
-the first line on the Subject line and the rest of the commit in the
+the first paragraph on the Subject line and the rest of the commit in the
 body.
 
 [[ignoring-files]]
-- 
1.7.9.5
