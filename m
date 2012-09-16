From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: [PATCH] Documentation: indent-with-non-tab uses tabwidth setting, not just 8
Date: Sun, 16 Sep 2012 11:12:28 -0600
Message-ID: <1347815548-19305-1-git-send-email-wjl@icecavern.net>
Cc: "Wesley J. Landaker" <wjl@icecavern.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 19:22:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDIY9-0007jP-1L
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 19:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab2IPRVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 13:21:36 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:43000 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751414Ab2IPRVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 13:21:36 -0400
X-Greylist: delayed 535 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Sep 2012 13:21:35 EDT
Received: from jenova.icecavern.net (c-76-113-27-84.hsd1.nm.comcast.net [76.113.27.84])
	by icecavern.net (Postfix) with ESMTPSA id C36F4369BB;
	Sun, 16 Sep 2012 11:12:35 -0600 (MDT)
Received: from tonberry.icecavern.net (tonberry.icecavern.net [10.0.0.9])
	by jenova.icecavern.net (Postfix) with ESMTP id 847A474C009;
	Sun, 16 Sep 2012 11:12:34 -0600 (MDT)
Received: by tonberry.icecavern.net (Postfix, from userid 1000)
	id 70E731E6ECC; Sun, 16 Sep 2012 11:12:34 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205634>

From: "Wesley J. Landaker" <wjl@icecavern.net>

Update the documentation of the core.whitespace option
"indent-with-non-tab" to correctly reflect that it uses the currently
set tab width, set by the "tabwidth" option, rather than a fixed number.

Signed-off-by: Wesley J. Landaker <wjl@icecavern.net>
---
 Documentation/config.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6416cae..113a196 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -559,8 +559,8 @@ core.whitespace::
 * `space-before-tab` treats a space character that appears immediately
   before a tab character in the initial indent part of the line as an
   error (enabled by default).
-* `indent-with-non-tab` treats a line that is indented with 8 or more
-  space characters as an error (not enabled by default).
+* `indent-with-non-tab` treats a line that is indented with `tabwidth` space
+  characters or more as an error (not enabled by default).
 * `tab-in-indent` treats a tab character in the initial indent part of
   the line as an error (not enabled by default).
 * `blank-at-eof` treats blank lines added at the end of file as an error
-- 
1.7.10.4
