From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 04/13] gitweb.js: Update and improve comments in JavaScript files
Date: Thu, 28 Apr 2011 21:04:02 +0200
Message-ID: <1304017451-12283-5-git-send-email-jnareb@gmail.com>
References: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:05:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFWWY-0003Nk-Dx
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 21:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933416Ab1D1TEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 15:04:49 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62309 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933396Ab1D1TEp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 15:04:45 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so3481029wwa.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=oEyYjuRPqsyMFVFrGe92b8GNmGgjcU3G1He/mf8hRKE=;
        b=JLcivL76ls5tfXF4K17yvLY75jPEnw08PufVEPey9u0YfsqwfNXkU5kUuQBR2nYPWD
         7263BFhuF+yf3OfZl8Qmdq7WkPn2Y9UneWf3J85eOOQa4xMhjxaC43SVIWJJGTHcW7pU
         M9udGior7zVNB9lYGE39zTJgJwFGWz+8rWWOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s9mhH/GfbGm/CRhVKr/62QR98XJyvApu4S3k344+PZ6x5itwyV5oAICSTN8+UIDjls
         mbItXkr4X0H639Oupm7UXPKf+JgwrDqP2z69Jbd7yfOaTEEzwmuBxfmUkDXFoLiDeMco
         ceLAR5/7bR+3Zt2IAVfkBhWikj+jDF4/0fDj0=
Received: by 10.227.12.17 with SMTP id v17mr3903097wbv.157.1304017484346;
        Thu, 28 Apr 2011 12:04:44 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl [83.8.119.25])
        by mx.google.com with ESMTPS id w25sm1266549wbd.56.2011.04.28.12.04.42
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 12:04:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172387>

This consists of adding a few extra explanation, fixing descriptions
of functions to match names of parameters in code, adding a few
separators, and fixing spelling -- while at it spell 'neighbor' using
American spelling (and not as 'neighbour').

This is post-split cleanup.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is unchanged from first version of this series.  It of
course doesn't have equivalent in original patch by J.H.

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
