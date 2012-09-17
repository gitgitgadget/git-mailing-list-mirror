From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: [PATCH] Documentation: indent-with-non-tab uses "equivalent tabs" not 8
Date: Mon, 17 Sep 2012 08:22:15 -0600
Message-ID: <1347891735-10211-1-git-send-email-wjl@icecavern.net>
References: <201209170820.28489.wjl@icecavern.net>
Cc: "Wesley J. Landaker" <wjl@icecavern.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 16:22:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDcDY-0005ZB-CT
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 16:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756466Ab2IQOWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 10:22:24 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:60704 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756446Ab2IQOWY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 10:22:24 -0400
Received: from jenova.icecavern.net (c-76-113-27-84.hsd1.nm.comcast.net [76.113.27.84])
	by icecavern.net (Postfix) with ESMTPSA id 1409535C24;
	Mon, 17 Sep 2012 08:22:19 -0600 (MDT)
Received: from tonberry.icecavern.net (tonberry.icecavern.net [10.0.0.9])
	by jenova.icecavern.net (Postfix) with ESMTP id CF6B074C009;
	Mon, 17 Sep 2012 08:22:17 -0600 (MDT)
Received: by tonberry.icecavern.net (Postfix, from userid 1000)
	id BA5161E7203; Mon, 17 Sep 2012 08:22:17 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <201209170820.28489.wjl@icecavern.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205693>

From: "Wesley J. Landaker" <wjl@icecavern.net>

Update the documentation of the core.whitespace option
"indent-with-non-tab" to correctly reflect that it catches the use of
spaces instead of the equivalent tabs, rather than a fixed number.

Signed-off-by: Wesley J. Landaker <wjl@icecavern.net>
---
 Documentation/config.txt |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6416cae..11f320b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -559,8 +559,9 @@ core.whitespace::
 * `space-before-tab` treats a space character that appears immediately
   before a tab character in the initial indent part of the line as an
   error (enabled by default).
-* `indent-with-non-tab` treats a line that is indented with 8 or more
-  space characters as an error (not enabled by default).
+* `indent-with-non-tab` treats a line that is indented with space
+  characters instead of the equivalent tabs as an error (not enabled by
+  default).
 * `tab-in-indent` treats a tab character in the initial indent part of
   the line as an error (not enabled by default).
 * `blank-at-eof` treats blank lines added at the end of file as an error
-- 
1.7.10.4
