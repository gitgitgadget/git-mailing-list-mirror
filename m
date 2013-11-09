From: "Jason St. John" <jstjohn@purdue.edu>
Subject: [PATCH 4/4] Correct word usage of "timezone" in "Documentation/RelNotes" directory
Date: Fri,  8 Nov 2013 19:48:53 -0500
Message-ID: <1383958133-4207-3-git-send-email-jstjohn@purdue.edu>
References: <1383958133-4207-1-git-send-email-jstjohn@purdue.edu>
Cc: "Jason St. John" <jstjohn@purdue.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 09 01:49:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vewjc-0003Qp-Vl
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 01:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757276Ab3KIAtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 19:49:05 -0500
Received: from mailhub128.itcs.purdue.edu ([128.210.5.128]:50104 "EHLO
	mailhub128.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757177Ab3KIAtD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Nov 2013 19:49:03 -0500
Received: from megahurtz.itap.purdue.edu (pal-nat184-053-008.itap.purdue.edu [10.184.53.8])
	(authenticated bits=0)
	by mailhub128.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id rA90ms58022232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 8 Nov 2013 19:49:01 -0500
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1383958133-4207-1-git-send-email-jstjohn@purdue.edu>
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237478>

"timezone" is two words, not one (i.e. "time zone" is correct).

Signed-off-by: Jason St. John <jstjohn@purdue.edu>
---
I broke this off into a separate patch in case the release notes are
essentially "fixed" in history and typos, misspellings, etc. don't get
corrected.
Sources are provided below the commit message in [PATCH 3/4].


 Documentation/RelNotes/1.5.2.txt    | 2 +-
 Documentation/RelNotes/1.7.1.1.txt  | 2 +-
 Documentation/RelNotes/1.7.12.4.txt | 2 +-
 Documentation/RelNotes/1.7.3.4.txt  | 2 +-
 Documentation/RelNotes/1.7.4.2.txt  | 2 +-
 Documentation/RelNotes/1.7.6.5.txt  | 2 +-
 Documentation/RelNotes/1.7.6.txt    | 2 +-
 Documentation/RelNotes/1.7.8.txt    | 2 +-
 Documentation/RelNotes/1.8.0.txt    | 2 +-
 Documentation/RelNotes/1.8.1.txt    | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/RelNotes/1.5.2.txt b/Documentation/RelNotes/1.5.2.txt
index e8328d0..774eaf4 100644
--- a/Documentation/RelNotes/1.5.2.txt
+++ b/Documentation/RelNotes/1.5.2.txt
@@ -76,7 +76,7 @@ Updates since v1.5.1
 
   - "git log" family of commands learned --date={local,relative,default}
     option.  --date=relative is synonym to the --relative-date.
-    --date=local gives the timestamp in local timezone.
+    --date=local gives the timestamp in local time zone.
 
 * Updated behavior of existing commands.
 
diff --git a/Documentation/RelNotes/1.7.1.1.txt b/Documentation/RelNotes/1.7.1.1.txt
index 3f6b314..1e57365 100644
--- a/Documentation/RelNotes/1.7.1.1.txt
+++ b/Documentation/RelNotes/1.7.1.1.txt
@@ -15,7 +15,7 @@ Fixes since v1.7.1
    macro that set/unset one attribute, immediately followed by an
    overriding setting; this makes attribute macros much easier to use.
 
- * We didn't recognize timezone "Z" as a synonym for "UTC" (75b37e70).
+ * We didn't recognize time zone "Z" as a synonym for "UTC" (75b37e70).
 
  * In 1.7.0, read-tree and user commands that use the mechanism such as
    checkout and merge were fixed to handle switching between branches one
diff --git a/Documentation/RelNotes/1.7.12.4.txt b/Documentation/RelNotes/1.7.12.4.txt
index c6da3cc..9d90d11 100644
--- a/Documentation/RelNotes/1.7.12.4.txt
+++ b/Documentation/RelNotes/1.7.12.4.txt
@@ -10,7 +10,7 @@ Fixes since v1.7.12.3
  * It was possible to give specific paths for "asciidoc" and other
    tools in the documentation toolchain, but not for "xmlto".
 
- * "gitweb" did not give the correct committer timezone in its feed
+ * "gitweb" did not give the correct committer time zone in its feed
    output due to a typo.
 
  * The "-Xours" (and similarly -Xtheirs) backend option to "git
diff --git a/Documentation/RelNotes/1.7.3.4.txt b/Documentation/RelNotes/1.7.3.4.txt
index e57f7c1..6223e07 100644
--- a/Documentation/RelNotes/1.7.3.4.txt
+++ b/Documentation/RelNotes/1.7.3.4.txt
@@ -10,7 +10,7 @@ Fixes since v1.7.3.3
  * "git apply" did not correctly handle patches that only change modes
    if told to apply while stripping leading paths with -p option.
 
- * "git apply" can deal with patches with timezone formatted with a
+ * "git apply" can deal with patches with time zone formatted with a
    colon between the hours and minutes part (e.g. "-08:00" instead of
    "-0800").
 
diff --git a/Documentation/RelNotes/1.7.4.2.txt b/Documentation/RelNotes/1.7.4.2.txt
index ef4ce1f..5476344 100644
--- a/Documentation/RelNotes/1.7.4.2.txt
+++ b/Documentation/RelNotes/1.7.4.2.txt
@@ -49,7 +49,7 @@ Fixes since v1.7.4.1
 
  * gitweb's "highlight" interface mishandled tabs.
 
- * gitweb didn't understand timezones with GMT offset that is not
+ * gitweb didn't understand time zones with GMT offset that is not
    multiple of a whole hour.
 
  * gitweb had a few forward-incompatible syntactic constructs and
diff --git a/Documentation/RelNotes/1.7.6.5.txt b/Documentation/RelNotes/1.7.6.5.txt
index 6713132..4b237e7 100644
--- a/Documentation/RelNotes/1.7.6.5.txt
+++ b/Documentation/RelNotes/1.7.6.5.txt
@@ -4,7 +4,7 @@ Git v1.7.6.5 Release Notes
 Fixes since v1.7.6.4
 --------------------
 
- * The date parser did not accept timezone designators that lack minutes
+ * The date parser did not accept time zone designators that lack minutes
    part and also has a colon between "hh:mm".
 
  * After fetching from a remote that has very long refname, the reporting
diff --git a/Documentation/RelNotes/1.7.6.txt b/Documentation/RelNotes/1.7.6.txt
index 9ec498e..98bc112 100644
--- a/Documentation/RelNotes/1.7.6.txt
+++ b/Documentation/RelNotes/1.7.6.txt
@@ -7,7 +7,7 @@ Updates since v1.7.5
  * Various git-svn updates.
 
  * Updates the way content tags are handled in gitweb.  Also adds
-   a UI to choose common timezone for displaying the dates.
+   a UI to choose common time zone for displaying the dates.
 
  * Similar to branch names, tagnames that begin with "-" are now
    disallowed.
diff --git a/Documentation/RelNotes/1.7.8.txt b/Documentation/RelNotes/1.7.8.txt
index 2493113..938118e 100644
--- a/Documentation/RelNotes/1.7.8.txt
+++ b/Documentation/RelNotes/1.7.8.txt
@@ -11,7 +11,7 @@ Updates since v1.7.7
  * The build procedure has been taught to take advantage of computed
    dependency automatically when the compiler supports it.
 
- * The date parser now accepts timezone designators that lack minutes
+ * The date parser now accepts time zone designators that lack minutes
    part and also has a colon between "hh:mm".
 
  * The contents of the /etc/mailname file, if exists, is used as the
diff --git a/Documentation/RelNotes/1.8.0.txt b/Documentation/RelNotes/1.8.0.txt
index 43883c1..d0c416d 100644
--- a/Documentation/RelNotes/1.8.0.txt
+++ b/Documentation/RelNotes/1.8.0.txt
@@ -263,5 +263,5 @@ to them for details).
  * "git status" honored the ignore=dirty settings in .gitmodules but
    "git commit" didn't.
 
- * "gitweb" did not give the correct committer timezone in its feed
+ * "gitweb" did not give the correct committer time zone in its feed
    output due to a typo.
diff --git a/Documentation/RelNotes/1.8.1.txt b/Documentation/RelNotes/1.8.1.txt
index d6f9555..209ec9b 100644
--- a/Documentation/RelNotes/1.8.1.txt
+++ b/Documentation/RelNotes/1.8.1.txt
@@ -107,7 +107,7 @@ UI, Workflows & Features
 
 Foreign Interface
 
- * "git cvsimport" can be told to record timezones (other than GMT)
+ * "git cvsimport" can be told to record time zones (other than GMT)
    per-author via its author info file.
 
  * The remote helper interface to interact with subversion
-- 
1.8.4.2
