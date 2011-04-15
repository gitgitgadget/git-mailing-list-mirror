From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 02/11] gitweb.js: Update and improve comments in JavaScript files
Date: Fri, 15 Apr 2011 16:43:56 +0200
Message-ID: <1302878645-458-3-git-send-email-jnareb@gmail.com>
References: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 16:45:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAkGx-0002aV-K6
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 16:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245Ab1DOOon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 10:44:43 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49049 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab1DOOoe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 10:44:34 -0400
Received: by wwa36 with SMTP id 36so3299523wwa.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=588rNdUf60TyTL1duoFVH0eUMSL6LtBS3XvWa3dnHG0=;
        b=YRqX7EeyAnQo8sCgyZXHmCWeEJzG3/NgM/AxAyz2/aIXznai69dSJ+12YorJHuGHcA
         EgWoWkNuCdOx/fuoh9n2YH8Kjwk2+Mm1z+/cCVWwax4+3B8lyGX7TEIjoEjcahRfQFsA
         KEWyr1ExzWaYgPoEBzZCmT4yr5Nwe2Abuch6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HB5KCXbmal984MB9AXsSC3WCLd0fyReFQKQHUaIpqZDrS/gTepKX7W8qwxsCZBUvtp
         KmKC3Z9biVgc5uPkGqBeIf1IoimIA3fWKPSHWELSL5cH3F+o6f1D4TnuqXOxVVvh+gXY
         AgEZEufcanZUd1wWRpQlR+nWpUBJ+1LnV6lWQ=
Received: by 10.216.167.65 with SMTP id h43mr7891268wel.17.1302878672862;
        Fri, 15 Apr 2011 07:44:32 -0700 (PDT)
Received: from roke.localdomain (abwn60.neoplus.adsl.tpnet.pl [83.8.237.60])
        by mx.google.com with ESMTPS id u9sm1663346wbg.34.2011.04.15.07.44.30
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 07:44:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171608>

This consists of adding a few extra explanation, fixing descriptions
of functions to match names of parameters in code, adding a few
separators, and fixing spelling -- while at it spell 'neighbor' using
American spelling (and not as 'neighbour').

This is post-split cleanup.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Unchanged from v1 version.

 gitweb/static/js/blame_incremental.js |   22 +++++++++++-----------
 gitweb/static/js/lib/common-lib.js    |   12 ++++++++----
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/gitweb/static/js/blame_incremental.js b/gitweb/static/js/blame_incremental.js
index f63f78b..676da6b 100644
--- a/gitweb/static/js/blame_incremental.js
+++ b/gitweb/static/js/blame_incremental.js
@@ -7,7 +7,7 @@
  * @license GPLv2 or later
  */
 
-
+/* ============================================================ */
 /*
  * This code uses DOM methods instead of (nonstandard) innerHTML
  * to modify page.
@@ -26,7 +26,7 @@
  */
 
 
-/* ============================================================ */
+/* ............................................................ */
 /* utility/helper functions (and variables) */
 
 var xhr;        // XMLHttpRequest object
@@ -132,7 +132,7 @@ function writeTimeInterval() {
 }
 
 /**
- * show an error message alert to user within page (in prohress info area)
+ * show an error message alert to user within page (in progress info area)
  * @param {String} str: plain text error message (no HTML)
  *
  * @globals div_progress_info
@@ -182,7 +182,7 @@ function getColorNo(tr) {
 
 var colorsFreq = [0, 0, 0];
 /**
- * return one of given possible colors (curently least used one)
+ * return one of given possible colors (currently least used one)
  * example: chooseColorNoFrom(2, 3) returns 2 or 3
  *
  * @param {Number[]} arguments: one or more numbers
@@ -203,8 +203,8 @@ function chooseColorNoFrom() {
 }
 
 /**
- * given two neigbour <tr> elements, find color which would be different
- * from color of both of neighbours; used to 3-color blame table
+ * given two neighbor <tr> elements, find color which would be different
+ * from color of both of neighbors; used to 3-color blame table
  *
  * @param {HTMLElement} tr_prev
  * @param {HTMLElement} tr_next
@@ -216,14 +216,14 @@ function findColorNo(tr_prev, tr_next) {
 	var color_next = getColorNo(tr_next);
 
 
-	// neither of neighbours has color set
+	// neither of neighbors has color set
 	// THEN we can use any of 3 possible colors
 	if (!color_prev && !color_next) {
 		return chooseColorNoFrom(1,2,3);
 	}
 
-	// either both neighbours have the same color,
-	// or only one of neighbours have color set
+	// either both neighbors have the same color,
+	// or only one of neighbors have color set
 	// THEN we can use any color except given
 	var color;
 	if (color_prev === color_next) {
@@ -237,7 +237,7 @@ function findColorNo(tr_prev, tr_next) {
 		return chooseColorNoFrom((color % 3) + 1, ((color+1) % 3) + 1);
 	}
 
-	// neighbours have different colors
+	// neighbors have different colors
 	// THEN there is only one color left
 	return (3 - ((color_prev + color_next) % 3));
 }
@@ -258,7 +258,7 @@ function isStartOfGroup(tr) {
 
 /**
  * change colors to use zebra coloring (2 colors) instead of 3 colors
- * concatenate neighbour commit groups belonging to the same commit
+ * concatenate neighbor commit groups belonging to the same commit
  *
  * @globals colorRe
  */
diff --git a/gitweb/static/js/lib/common-lib.js b/gitweb/static/js/lib/common-lib.js
index 38f3b9e..6a6d200 100644
--- a/gitweb/static/js/lib/common-lib.js
+++ b/gitweb/static/js/lib/common-lib.js
@@ -13,14 +13,17 @@
 /* Padding */
 
 /**
- * pad number N with nonbreakable spaces on the left, to WIDTH characters
+ * pad INPUT on the left with STR that is assumed to have visible
+ * width of single character (for example nonbreakable spaces),
+ * to WIDTH characters
+ *
  * example: padLeftStr(12, 3, '\u00A0') == '\u00A012'
  *          ('\u00A0' is nonbreakable space)
  *
  * @param {Number|String} input: number to pad
  * @param {Number} width: visible width of output
  * @param {String} str: string to prefix to string, e.g. '\u00A0'
- * @returns {String} INPUT prefixed with (WIDTH - INPUT.length) x STR
+ * @returns {String} INPUT prefixed with STR x (WIDTH - INPUT.length)
  */
 function padLeftStr(input, width, str) {
 	var prefix = '';
@@ -34,7 +37,7 @@ function padLeftStr(input, width, str) {
 }
 
 /**
- * Pad INPUT on the left to SIZE width, using given padding character CH,
+ * Pad INPUT on the left to WIDTH, using given padding character CH,
  * for example padLeft('a', 3, '_') is '__a'.
  *
  * @param {String} input: input value converted to string.
@@ -140,7 +143,8 @@ var maybeQuotedRe = /^\"(.*)\"$/;
 /**#@-*/
 
 /**
- * unquote maybe git-quoted filename
+ * unquote maybe C-quoted filename (as used by git, i.e. it is
+ * in double quotes '"' if there is any escape character used)
  * e.g. 'aa' -> 'aa', '"a\ta"' -> 'a	a'
  *
  * @param {String} str: git-quoted string
-- 
1.7.3
