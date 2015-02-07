From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] Documentation: add trailer.trimEmpty config variable
Date: Sat, 07 Feb 2015 14:11:11 +0100
Message-ID: <20150207131112.394.31265.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 14:26:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YK5PE-0004Dv-8N
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 14:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475AbbBGN0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2015 08:26:36 -0500
Received: from delay-5y.bbox.fr ([194.158.98.76]:47899 "EHLO delay-5y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755184AbbBGN0d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2015 08:26:33 -0500
Received: from mail-3y.bbox.fr (bt8sssoh.cs.dolmen.bouyguestelecom.fr [172.24.208.141])
	by delay-5y.bbox.fr (Postfix) with ESMTP id 6D8F65E3EB
	for <git@vger.kernel.org>; Sat,  7 Feb 2015 14:12:10 +0100 (CET)
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 4664E7B;
	Sat,  7 Feb 2015 14:12:06 +0100 (CET)
X-git-sha1: 248a032d3702bb35498cf77420ecfe35d8d2b5fb 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263441>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-interpret-trailers.txt | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index d6d9231..816dd65 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -64,10 +64,12 @@ folding rules, the encoding rules and probably many other rules.
 
 OPTIONS
 -------
---trim-empty::
+--[no-]trim-empty::
 	If the <value> part of any trailer contains only whitespace,
 	the whole trailer will be removed from the resulting message.
-	This apply to existing trailers as well as new trailers.
+	This applies to existing trailers as well as new
+	trailers. This overrides a 'trailer.trimempty' configuration
+	variable.
 
 --trailer <token>[(=|:)<value>]::
 	Specify a (<token>, <value>) pair that should be applied as a
@@ -77,6 +79,11 @@ OPTIONS
 CONFIGURATION VARIABLES
 -----------------------
 
+trailer.trimempty::
+	This option tells if by default trailers with an empty <value>
+	part should be trimmed or not. See also the '--[no-]trim-empty'
+	option above.
+
 trailer.separators::
 	This option tells which characters are recognized as trailer
 	separators. By default only ':' is recognized as a trailer
-- 
2.2.1.313.gcc831f2
