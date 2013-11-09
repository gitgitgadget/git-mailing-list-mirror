From: "Jason St. John" <jstjohn@purdue.edu>
Subject: [PATCH 3/4] Correct word usage of "timezone" in "Documentation" directory
Date: Fri,  8 Nov 2013 19:48:52 -0500
Message-ID: <1383958133-4207-2-git-send-email-jstjohn@purdue.edu>
References: <1383958133-4207-1-git-send-email-jstjohn@purdue.edu>
Cc: "Jason St. John" <jstjohn@purdue.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 09 01:49:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vewjc-0003Qp-4S
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 01:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757231Ab3KIAtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 19:49:03 -0500
Received: from mailhub128.itcs.purdue.edu ([128.210.5.128]:50088 "EHLO
	mailhub128.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756955Ab3KIAtA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Nov 2013 19:49:00 -0500
Received: from megahurtz.itap.purdue.edu (pal-nat184-053-008.itap.purdue.edu [10.184.53.8])
	(authenticated bits=0)
	by mailhub128.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id rA90ms57022232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 8 Nov 2013 19:48:58 -0500
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1383958133-4207-1-git-send-email-jstjohn@purdue.edu>
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237479>

"timezone" is two words, not one (i.e. "time zone" is correct).

Correct this in these files:
-- date-formats.txt
-- git-blame.txt
-- git-cvsimport.txt
-- git-fast-import.txt
-- git-svn.txt
-- gitweb.conf.txt
-- rev-list-options.txt

Signed-off-by: Jason St. John <jstjohn@purdue.edu>
---
Sources:
(1) https://en.wikipedia.org/wiki/Time_zone
(2) https://www.google.com/trends/explore?q=%22timezone%22+%22time+zone%22#q=timezone%2C%20time%20zone&cmpt=q
(3) A search of Google Scholar (non-patent articles) for each term:
		"timezone": 8,300 results
		"time zone": 40,100 results


 Documentation/date-formats.txt     |  4 ++--
 Documentation/git-blame.txt        |  2 +-
 Documentation/git-cvsimport.txt    |  4 ++--
 Documentation/git-fast-import.txt  | 10 +++++-----
 Documentation/git-svn.txt          |  6 +++---
 Documentation/gitweb.conf.txt      | 14 +++++++-------
 Documentation/rev-list-options.txt |  4 ++--
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index c000f08..ccd1fc8 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -8,9 +8,9 @@ endif::git-commit[]
 support the following date formats:
 
 Git internal format::
-	It is `<unix timestamp> <timezone offset>`, where `<unix
+	It is `<unix timestamp> <time zone offset>`, where `<unix
 	timestamp>` is the number of seconds since the UNIX epoch.
-	`<timezone offset>` is a positive or negative offset from UTC.
+	`<time zone offset>` is a positive or negative offset from UTC.
 	For example CET (which is 2 hours ahead UTC) is `+0200`.
 
 RFC 2822::
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index f2c85cc..8e70a61 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -103,7 +103,7 @@ This header line is followed by the following information
 at least once for each commit:
 
 - the author name ("author"), email ("author-mail"), time
-  ("author-time"), and timezone ("author-tz"); similarly
+  ("author-time"), and time zone ("author-tz"); similarly
   for committer.
 - the filename in the commit that the line is attributed to.
 - the first line of the commit log message ("summary").
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index d1bcda2..2df9953 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -144,7 +144,7 @@ This option can be used several times to provide several detection regexes.
 	CVS by default uses the Unix username when writing its
 	commit logs. Using this option and an author-conv-file
 	maps the name recorded in CVS to author name, e-mail and
-	optional timezone:
+	optional time zone:
 +
 ---------
 	exon=Andreas Ericsson <ae@op5.se>
@@ -154,7 +154,7 @@ This option can be used several times to provide several detection regexes.
 +
 'git cvsimport' will make it appear as those authors had
 their GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL set properly
-all along.  If a timezone is specified, GIT_AUTHOR_DATE will
+all along.  If a time zone is specified, GIT_AUTHOR_DATE will
 have the corresponding offset applied.
 +
 For convenience, this data is saved to `$GIT_DIR/cvs-authors`
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 73f9806..fd22a9a 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -251,7 +251,7 @@ advisement to help formatting routines display the timestamp.
 If the local offset is not available in the source material, use
 ``+0000'', or the most common local offset.  For example many
 organizations have a CVS repository which has only ever been accessed
-by users who are located in the same location and timezone.  In this
+by users who are located in the same location and time zone.  In this
 case a reasonable offset from UTC could be assumed.
 +
 Unlike the `rfc2822` format, this format is very strict.  Any
@@ -271,7 +271,7 @@ the malformed string.  There are also some types of malformed
 strings which Git will parse wrong, and yet consider valid.
 Seriously malformed strings will be rejected.
 +
-Unlike the `raw` format above, the timezone/UTC offset information
+Unlike the `raw` format above, the time zone/UTC offset information
 contained in an RFC 2822 date string is used to adjust the date
 value to UTC prior to storage.  Therefore it is important that
 this information be as accurate as possible.
@@ -287,13 +287,13 @@ format, or its format is easily convertible to it, as there is no
 ambiguity in parsing.
 
 `now`::
-	Always use the current time and timezone.  The literal
+	Always use the current time and time zone.  The literal
 	`now` must always be supplied for `<when>`.
 +
-This is a toy format.  The current time and timezone of this system
+This is a toy format.  The current time and time zone of this system
 is always copied into the identity string at the time it is being
 created by fast-import.  There is no way to specify a different time or
-timezone.
+time zone.
 +
 This particular format is supplied as it's short to implement and
 may be useful to a process that wants to create a new commit
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index dcad890..30c5ee2 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -124,15 +124,15 @@ This automatically updates the rev_map if needed (see
 '$GIT_DIR/svn/\*\*/.rev_map.*' in the FILES section below for details).
 
 --localtime;;
-	Store Git commit times in the local timezone instead of UTC.  This
+	Store Git commit times in the local time zone instead of UTC.  This
 	makes 'git log' (even without --date=local) show the same times
-	that `svn log` would in the local timezone.
+	that `svn log` would in the local time zone.
 +
 This doesn't interfere with interoperating with the Subversion
 repository you cloned from, but if you wish for your local Git
 repository to be able to interoperate with someone else's local Git
 repository, either don't use this option or you should both use it in
-the same local timezone.
+the same local time zone.
 
 --parent;;
 	Fetch only from the SVN parent of the current HEAD.
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 305db63..e2113d9 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -822,18 +822,18 @@ timed::
 Project specific override is not supported.
 
 javascript-timezone::
-	Enable and configure the ability to change a common timezone for dates
+	Enable and configure the ability to change a common time zone for dates
 	in gitweb output via JavaScript.  Dates in gitweb output include
 	authordate and committerdate in "commit", "commitdiff" and "log"
 	views, and taggerdate in "tag" view.  Enabled by default.
 +
-The value is a list of three values: a default timezone (for if the client
-hasn't selected some other timezone and saved it in a cookie), a name of cookie
-where to store selected timezone, and a CSS class used to mark up
+The value is a list of three values: a default time zone (for if the client
+hasn't selected some other time zone and saved it in a cookie), a name of cookie
+where to store selected time zone, and a CSS class used to mark up
 dates for manipulation.  If you want to turn this feature off, set "default"
 to empty list: `[]`.
 +
-Typical gitweb config files will only change starting (default) timezone,
+Typical gitweb config files will only change starting (default) time zone,
 and leave other elements at their default values:
 +
 ---------------------------------------------------------------------------
@@ -843,9 +843,9 @@ $feature{'javascript-timezone'}{'default'}[0] = "utc";
 The example configuration presented here is guaranteed to be backwards
 and forward compatible.
 +
-Timezone values can be "local" (for local timezone that browser uses), "utc"
+Time zone values can be "local" (for local time zone that browser uses), "utc"
 (what gitweb uses when JavaScript or this feature is disabled), or numerical
-timezones in the form of "+/-HHMM", such as "+0200".
+time zones in the form of "+/-HHMM", such as "+0200".
 +
 Project specific override is not supported.
 
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 32c40ae..0721bf2 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -720,7 +720,7 @@ include::pretty-options.txt[]
 '\--date=relative' shows dates relative to the current time,
 e.g. "2 hours ago".
 +
-'\--date=local' shows timestamps in user's local timezone.
+'\--date=local' shows timestamps in user's local time zone.
 +
 '\--date=iso' (or '\--date=iso8601') shows timestamps in ISO 8601 format.
 +
@@ -731,7 +731,7 @@ format, often found in E-mail messages.
 +
 '\--date=raw' shows the date in the internal raw Git format `%s %z` format.
 +
-'\--date=default' shows timestamps in the original timezone
+'\--date=default' shows timestamps in the original time zone
 (either committer's or author's).
 
 ifdef::git-rev-list[]
-- 
1.8.4.2
