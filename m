From: "Jason St. John" <jstjohn@purdue.edu>
Subject: [PATCHv3 2/2] Documentation/rev-list-options.txt: fix some grammatical issues and typos
Date: Thu, 14 Nov 2013 20:34:02 -0500
Message-ID: <1384479242-21144-2-git-send-email-jstjohn@purdue.edu>
References: <1384479242-21144-1-git-send-email-jstjohn@purdue.edu>
Cc: "Jason St. John" <jstjohn@purdue.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 15 02:34:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh8Ix-0001Hw-GX
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 02:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942Ab3KOBee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 20:34:34 -0500
Received: from mailhub246.itcs.purdue.edu ([128.210.5.246]:55619 "EHLO
	mailhub246.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754726Ab3KOBec (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Nov 2013 20:34:32 -0500
Received: from megahurtz.wl.stjohn.lcl (41.117.244.66.bay.smithvilledigital.net [66.244.117.41])
	(authenticated bits=0)
	by mailhub246.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id rAF1Y83Z007783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Nov 2013 20:34:31 -0500
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1384479242-21144-1-git-send-email-jstjohn@purdue.edu>
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237885>

Various fixes:
-- fix typos (e.g. "show" -> "shown")
-- use "regular expression(s)" instead of "regexp" where appropriate
-- reword some sentences for easier reading
-- fix/improve some grammatical issues (e.g. comma usage)
-- add missing articles (e.g. "the")
-- change "E-mail" to "email"

Signed-off-by: Jason St. John <jstjohn@purdue.edu>
---
I changed "E-mail" to "email" because that is clearly the dominant form:
http://www.google.com/trends/explore?q=#q=%22email%22%2C%20%22E-mail%22&cmpt=q


 Documentation/rev-list-options.txt | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index eb4b6bf..2991d70 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -68,7 +68,8 @@ if it is part of the log message.
 
 -i::
 --regexp-ignore-case::
-	Match the regexp limiting patterns without regard to letters case.
+	Match the regular expression limiting patterns without regard to letter
+	case.
 
 --basic-regexp::
 	Consider the limiting patterns to be basic regular expressions;
@@ -85,7 +86,7 @@ if it is part of the log message.
 	pattern as a regular expression).
 
 --perl-regexp::
-	Consider the limiting patterns to be Perl-compatible regexp.
+	Consider the limiting patterns to be Perl-compatible regular expressions.
 	Requires libpcre to be compiled in.
 
 --remove-empty::
@@ -191,9 +192,9 @@ endif::git-rev-list[]
 For example, if you have two branches, `A` and `B`, a usual way
 to list all commits on only one side of them is with
 `--left-right` (see the example below in the description of
-the `--left-right` option).  It however shows the commits that were cherry-picked
-from the other branch (for example, ``3rd on b'' may be cherry-picked
-from branch A).  With this option, such pairs of commits are
+the `--left-right` option). However, it shows the commits that were
+cherry-picked from the other branch (for example, ``3rd on b'' may be
+cherry-picked from branch A). With this option, such pairs of commits are
 excluded from the output.
 
 --left-only::
@@ -447,7 +448,7 @@ The effect of this is best shown by way of comparing to
 	  `---------'
 -----------------------------------------------------------------------
 +
-Note the major differences in `N`, `P` and `Q` over `--full-history`:
+Note the major differences in `N`, `P`, and `Q` over `--full-history`:
 +
 --
 * `N`'s parent list had `I` removed, because it is an ancestor of the
@@ -467,7 +468,7 @@ Finally, there is a fifth simplification mode available:
 	Limit the displayed commits to those directly on the ancestry
 	chain between the ``from'' and ``to'' commits in the given commit
 	range. I.e. only display commits that are ancestor of the ``to''
-	commit, and descendants of the ``from'' commit.
+	commit and descendants of the ``from'' commit.
 +
 As an example use case, consider the following commit history:
 +
@@ -631,9 +632,9 @@ These options are mostly targeted for packing of Git repositories.
 --no-walk[=(sorted|unsorted)]::
 	Only show the given commits, but do not traverse their ancestors.
 	This has no effect if a range is specified. If the argument
-	`unsorted` is given, the commits are show in the order they were
+	`unsorted` is given, the commits are shown in the order they were
 	given on the command line. Otherwise (if `sorted` or no argument
-	was given), the commits are show in reverse chronological order
+	was given), the commits are shown in reverse chronological order
 	by commit time.
 
 --do-walk::
@@ -656,7 +657,7 @@ include::pretty-options.txt[]
 --date=(relative|local|default|iso|rfc|short|raw)::
 	Only takes effect for dates shown in human-readable format, such
 	as when using `--pretty`. `log.date` config variable sets a default
-	value for log command's `--date` option.
+	value for the log command's `--date` option.
 +
 `--date=relative` shows dates relative to the current time,
 e.g. ``2 hours ago''.
@@ -666,9 +667,9 @@ e.g. ``2 hours ago''.
 `--date=iso` (or `--date=iso8601`) shows timestamps in ISO 8601 format.
 +
 `--date=rfc` (or `--date=rfc2822`) shows timestamps in RFC 2822
-format, often found in E-mail messages.
+format, often found in email messages.
 +
-`--date=short` shows only date but not time, in `YYYY-MM-DD` format.
+`--date=short` shows only the date, but not the time, in `YYYY-MM-DD` format.
 +
 `--date=raw` shows the date in the internal raw Git format `%s %z` format.
 +
@@ -749,7 +750,7 @@ ifndef::git-rev-list[]
 Diff Formatting
 ~~~~~~~~~~~~~~~
 
-Below are listed options that control the formatting of diff output.
+Listed below are options that control the formatting of diff output.
 Some of them are specific to linkgit:git-rev-list[1], however other diff
 options may be given. See linkgit:git-diff-files[1] for more options.
 
-- 
1.8.4.2
