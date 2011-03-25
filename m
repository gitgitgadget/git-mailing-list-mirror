From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 2/3] gitweb: Update and improve comments in JavaScript files
Date: Fri, 25 Mar 2011 22:46:25 +0100
Message-ID: <1301089586-8534-3-git-send-email-jnareb@gmail.com>
References: <1301089586-8534-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 22:46:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3EqO-0003YM-8r
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 22:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079Ab1CYVqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 17:46:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35096 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112Ab1CYVqv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 17:46:51 -0400
Received: by wya21 with SMTP id 21so1471211wya.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=wE47NWJIi903ovYDvX6Tcy5+HWJT9YxCh5pUySnJHk0=;
        b=BpspQoZX4QlWnhg8EOvC2TvSB5m2Gpd/nOOA3WttrYVTCvj2aq26bMxqANdMXQaT+F
         D6VTCPlNkbrfxHH0GeTgHpGTmErcOZvh+vm0yFE6IrxjfuzyAGtNDwNvvk19RVb27mOq
         FCFdGSpQorrzWI3C0SaXk4b8Uwj9a2LBYcngY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=p9ByUicwqMmQPHC/zXbrISpW2BS5G5pbhPaCRLUwiHCAmGXGSY8Ov6iiAWeZvsImV8
         Y9cyi/aXC9doXXR9EyZ3n1fjt0cEMDqKRzUKgQ7ujYQho1PqVsQtiw8hFxgR0wz4M0qp
         dDrXPxfgeHRpQYhoyLJPCmxDblFsEdbr/chIs=
Received: by 10.227.204.131 with SMTP id fm3mr1230619wbb.199.1301089610265;
        Fri, 25 Mar 2011 14:46:50 -0700 (PDT)
Received: from localhost.localdomain (abwo211.neoplus.adsl.tpnet.pl [83.8.238.211])
        by mx.google.com with ESMTPS id g7sm647802wby.14.2011.03.25.14.46.48
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 14:46:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1301089586-8534-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170022>

Spell 'neighbor' using American spelling (and not 'neighbour').

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/static/js/blame_incremental.js |   22 +++++++++++-----------
 gitweb/static/js/common-lib.js        |   12 ++++++++----
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/gitweb/static/js/blame_incremental.js b/gitweb/static/js/blame_incremental.js
index 3317390..2067dcd 100644
--- a/gitweb/static/js/blame_incremental.js
+++ b/gitweb/static/js/blame_incremental.js
@@ -8,7 +8,7 @@
  * @license GPLv2 or later
  */
 
-
+/* ============================================================ */
 /*
  * This code uses DOM methods instead of (nonstandard) innerHTML
  * to modify page.
@@ -27,7 +27,7 @@
  */
 
 
-/* ============================================================ */
+/* ............................................................ */
 /* utility/helper functions (and variables) */
 
 var xhr;        // XMLHttpRequest object
@@ -133,7 +133,7 @@ function writeTimeInterval() {
 }
 
 /**
- * show an error message alert to user within page (in prohress info area)
+ * show an error message alert to user within page (in progress info area)
  * @param {String} str: plain text error message (no HTML)
  *
  * @globals div_progress_info
@@ -183,7 +183,7 @@ function getColorNo(tr) {
 
 var colorsFreq = [0, 0, 0];
 /**
- * return one of given possible colors (curently least used one)
+ * return one of given possible colors (currently least used one)
  * example: chooseColorNoFrom(2, 3) returns 2 or 3
  *
  * @param {Number[]} arguments: one or more numbers
@@ -204,8 +204,8 @@ function chooseColorNoFrom() {
 }
 
 /**
- * given two neigbour <tr> elements, find color which would be different
- * from color of both of neighbours; used to 3-color blame table
+ * given two neighbor <tr> elements, find color which would be different
+ * from color of both of neighbors; used to 3-color blame table
  *
  * @param {HTMLElement} tr_prev
  * @param {HTMLElement} tr_next
@@ -217,14 +217,14 @@ function findColorNo(tr_prev, tr_next) {
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
@@ -238,7 +238,7 @@ function findColorNo(tr_prev, tr_next) {
 		return chooseColorNoFrom((color % 3) + 1, ((color+1) % 3) + 1);
 	}
 
-	// neighbours have different colors
+	// neighbors have different colors
 	// THEN there is only one color left
 	return (3 - ((color_prev + color_next) % 3));
 }
@@ -259,7 +259,7 @@ function isStartOfGroup(tr) {
 
 /**
  * change colors to use zebra coloring (2 colors) instead of 3 colors
- * concatenate neighbour commit groups belonging to the same commit
+ * concatenate neighbor commit groups belonging to the same commit
  *
  * @globals colorRe
  */
diff --git a/gitweb/static/js/common-lib.js b/gitweb/static/js/common-lib.js
index 566c98a..33887d7 100644
--- a/gitweb/static/js/common-lib.js
+++ b/gitweb/static/js/common-lib.js
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
@@ -126,7 +129,8 @@ var maybeQuotedRe = /^\"(.*)\"$/;
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
