From: larsxschneider@gmail.com
Subject: [PATCH v3 1/2] Documentation: fix linkgit references
Date: Mon,  2 May 2016 22:20:04 +0200
Message-ID: <1462220405-12408-2-git-send-email-larsxschneider@gmail.com>
References: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com>
 <1462220405-12408-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, Matthieu.Moy@grenoble-inp.fr, sbeller@google.com,
	gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 22:20:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axKKK-00052g-E9
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 22:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116AbcEBUUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 16:20:12 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37202 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083AbcEBUUK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 16:20:10 -0400
Received: by mail-wm0-f49.google.com with SMTP id a17so4804878wme.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hLrgusWCjJfQB5AOop7Bjb2NKWMYc98BCR/15nxU32Y=;
        b=S3Y/QdfC1I75uTEY/ndXsn0aWzWHKCeCEzESL0lw54/YcWWSn2Mqm4igrU+4uknGbg
         k8paks8dvgLoeiWrrBkhMtxvUMM7gT30Hczag2ftIzP+CEfjrJ8f+r85SE5YMp2Z9SGA
         e4e7Ym4L2d5Gs5hLBPmOl0xwoxqzXZP+bARbNGfLX/f+LWAlWbcc8aRmygA9CEilKc3/
         xB44083N+M2n6H5uU4H37C/Hl9GQq5Pije1QpQbg2rRUPoKCAbHB0CkbHtcaDKLmlZRi
         H/laErEncOT7MQJQkL46FnQEeH8Dck1Biqc80HL3qJcbdaU95xc6lz0ryE2DuD5v2qYs
         uc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hLrgusWCjJfQB5AOop7Bjb2NKWMYc98BCR/15nxU32Y=;
        b=NTjX9NGvRXeKmTG0pk4zuFPmfCem2vb4ION0KnsWbx45jwV5kyxUh8b+Oa8xIHnsjS
         ltB5TbjP4hMeegLEZfHseAqpY1+e/bRsOJJa4tXC3MHaIR5ReixlLycrf/K+Q9yWlcPN
         LTHNqOG4KBhB25oQJt2D2NqDgA8u7bv4ncF+Dq0DDLdxysLB3WJ1vPM1wJPRpsgBqecZ
         Iv2esbstB3LXEcQcY37P8Mm743RUh9RUWhmrWjsbQe3+8IUkDp1Rz+cyxAo3wUGqbzKw
         ufi7tq4Fy+6bIGuwmIoxbe8yNthBS2NZKIlgOkZ/9bQuuln2vFg1J55TYtIaknWgV7Fx
         dDYw==
X-Gm-Message-State: AOPr4FXgQ6Im2O3UqEip6Ac8ZPBGyeXpJFZyGZXSWnBm/czB1O8lk1uQXuebxNAkJHHhPg==
X-Received: by 10.28.187.85 with SMTP id l82mr17718946wmf.2.1462220408800;
        Mon, 02 May 2016 13:20:08 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB4E4A.dip0.t-ipconnect.de. [93.219.78.74])
        by smtp.gmail.com with ESMTPSA id v143sm20558672wmv.4.2016.05.02.13.20.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 02 May 2016 13:20:08 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1462220405-12408-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293283>

From: Lars Schneider <larsxschneider@gmail.com>

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/config.txt            | 6 +++---
 Documentation/git-check-ignore.txt  | 2 +-
 Documentation/git-filter-branch.txt | 4 ++--
 Documentation/git-for-each-ref.txt  | 2 +-
 Documentation/git-help.txt          | 4 ++--
 Documentation/git-instaweb.txt      | 4 ++--
 Documentation/git-sh-i18n.txt       | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c7bbe98..c5f1d6b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -894,7 +894,7 @@ branch.<name>.description::
 browser.<tool>.cmd::
 	Specify the command to invoke the specified browser. The
 	specified command is evaluated in shell with the URLs passed
-	as arguments. (See linkgit:git-web{litdd}browse[1].)
+	as arguments. (See linkgit:git-web--browse[1].)
 
 browser.<tool>.path::
 	Override the path for the given tool that may be used to
@@ -1494,7 +1494,7 @@ gui.diffContext::
 	made by the linkgit:git-gui[1]. The default is "5".
 
 gui.displayUntracked::
-	Determines if linkgit::git-gui[1] shows untracked files
+	Determines if linkgit:git-gui[1] shows untracked files
 	in the file list. The default is "true".
 
 gui.encoding::
@@ -1665,7 +1665,7 @@ http.cookieFile::
 	File containing previously stored cookie lines which should be used
 	in the Git http session, if they match the server. The file format
 	of the file to read cookies from should be plain HTTP headers or
-	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
+	the Netscape/Mozilla cookie file format (see `curl(1)`).
 	NOTE that the file specified with http.cookieFile is only used as
 	input unless http.saveCookies is set.
 
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index e94367a..9a85998 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -112,7 +112,7 @@ EXIT STATUS
 SEE ALSO
 --------
 linkgit:gitignore[5]
-linkgit:gitconfig[5]
+linkgit:git-config[5]
 linkgit:git-ls-files[1]
 
 GIT
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 73fd9e8..6538cb1 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -205,8 +205,8 @@ to other tags will be rewritten to point to the underlying commit.
 Remap to ancestor
 ~~~~~~~~~~~~~~~~~
 
-By using linkgit:rev-list[1] arguments, e.g., path limiters, you can limit the
-set of revisions which get rewritten. However, positive refs on the command
+By using linkgit:git-rev-list[1] arguments, e.g., path limiters, you can limit
+the set of revisions which get rewritten. However, positive refs on the command
 line are distinguished: we don't let them be excluded by such limiters. For
 this purpose, they are instead rewritten to point at the nearest ancestor that
 was not excluded.
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index c52578b..d9d406d 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -179,7 +179,7 @@ returns an empty string instead.
 
 As a special case for the date-type fields, you may specify a format for
 the date by adding `:` followed by date format name (see the
-values the `--date` option to linkgit::git-rev-list[1] takes).
+values the `--date` option to linkgit:git-rev-list[1] takes).
 
 
 EXAMPLES
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 3956525..7af18f9 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -72,7 +72,7 @@ The web browser can be specified using the configuration variable
 'help.browser', or 'web.browser' if the former is not set. If none of
 these config variables is set, the 'git web{litdd}browse' helper script
 (called by 'git help') will pick a suitable default. See
-linkgit:git-web{litdd}browse[1] for more information about this.
+linkgit:git-web--browse[1] for more information about this.
 
 CONFIGURATION VARIABLES
 -----------------------
@@ -95,7 +95,7 @@ help.browser, web.browser and browser.<tool>.path
 The 'help.browser', 'web.browser' and 'browser.<tool>.path' will also
 be checked if the 'web' format is chosen (either by command-line
 option or configuration variable). See '-w|--web' in the OPTIONS
-section above and linkgit:git-web{litdd}browse[1].
+section above and linkgit:git-web--browse[1].
 
 man.viewer
 ~~~~~~~~~~
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index cc75b25..b95cc15 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -46,7 +46,7 @@ OPTIONS
 	The web browser that should be used to view the gitweb
 	page. This will be passed to the 'git web{litdd}browse' helper
 	script along with the URL of the gitweb instance. See
-	linkgit:git-web{litdd}browse[1] for more information about this. If
+	linkgit:git-web--browse[1] for more information about this. If
 	the script fails, the URL will be printed to stdout.
 
 start::
@@ -82,7 +82,7 @@ You may specify configuration in your .git/config
 
 If the configuration variable 'instaweb.browser' is not set,
 'web.browser' will be used instead if it is defined. See
-linkgit:git-web{litdd}browse[1] for more information about this.
+linkgit:git-web--browse[1] for more information about this.
 
 SEE ALSO
 --------
diff --git a/Documentation/git-sh-i18n.txt b/Documentation/git-sh-i18n.txt
index 60cf49c..eafa55a 100644
--- a/Documentation/git-sh-i18n.txt
+++ b/Documentation/git-sh-i18n.txt
@@ -35,7 +35,7 @@ gettext::
 eval_gettext::
 	Currently a dummy fall-through function implemented as a wrapper
 	around `printf(1)` with variables expanded by the
-	linkgit:git-sh-i18n{litdd}envsubst[1] helper. Will be replaced by a
+	linkgit:git-sh-i18n--envsubst[1] helper. Will be replaced by a
 	real gettext implementation in a later version.
 
 GIT
-- 
2.5.1
