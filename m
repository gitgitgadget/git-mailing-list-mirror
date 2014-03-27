From: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>
Subject: [PATCH 10/10] Documentation: Document --function-name usage
Date: Thu, 27 Mar 2014 14:50:56 -0400
Message-ID: <c5de064075e6a2192817aafde75d8075ae82c974.1395942768.git.davidad@alum.mit.edu>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
Cc: peff@peff.net, l.s.r@web.de,
	"Bhushan Lodha & David A. Dalrymple" <dad-bgl@mit.edu>,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 19:51:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTFP4-00052A-7r
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757233AbaC0Svn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 14:51:43 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43582 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757142AbaC0Svh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 14:51:37 -0400
X-AuditID: 1207440c-f79656d000003eba-a3-53347338f745
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A8.32.16058.83374335; Thu, 27 Mar 2014 14:51:36 -0400 (EDT)
Received: from zayin.local.com ([74.212.183.186])
	(authenticated bits=0)
        (User authenticated as davidad@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2RIp9TS013586
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 27 Mar 2014 14:51:35 -0400
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
In-Reply-To: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
In-Reply-To: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
References: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsUixO6iqGtRbBJssGwjv8XclU1MFl/O3WKz
	6LrSzWRxZms/s8WPlh5mB1aPv+8/MHk0nTnK7PGsdw+jx+dNch63n21jCWCN4rJJSc3JLEst
	0rdL4Mr429XHVnBNoqL37g+2BsaXIl2MHBwSAiYSVy6ydjFyApliEhfurWcDsYUELjNKXGgu
	7WLkArJXMkk82/+HCSTBJuAssenXfjBbREBc4u3xmewgRcwC8xglfvZ1sYMkhAVcJM4unQFm
	swioSqyaehDM5hWIkjjf84IFYpuBxKdnZ5hBbE4BB4nJ8zcygxwkJGAv8XGpLUQ4WuL11sVQ
	B0UB2SdZJjDyL2BkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6iXm1mil5pSuokREoA8Oxi/
	rZM5xCjAwajEw+tgYRIsxJpYVlyZe4hRgoNZSYR3bgFQiDclsbIqtSg/vqg0J7X4EKM0B4uS
	OK/qEnU/IYH0xJLU7NTUgtQimCwTB6dUA6PilqzdLhO1M5/fa7zMqi+wdPPWX8qiTHZn/FVy
	PL9lTokXftD21npeiKDJQqXlTD+11047aLD8WVHjk7I1T+ff3nvoeYvRXJEXc9MPeDA/eqRo
	5NV0b2d31RnrVqsj/Bt+uOx2yuvp+OHzUuv0oZO2kw2EVCI4bgWduKMYr6Rz9IHLV/4Eq1Al
	luKMREMt5qLiRADqfDRlPAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245315>

From: "Bhushan Lodha & David A. Dalrymple" <dad-bgl@mit.edu>

Signed-off-by: David Dalrymple (on zayin) <davidad@alum.mit.edu>
---
 Documentation/diff-options.txt |  9 +++++++++
 Documentation/gitdiffcore.txt  | 17 ++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9b37b2a..a778dff 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -427,6 +427,15 @@ information.
 --pickaxe-regex::
 	Treat the <string> given to `-S` as an extended POSIX regular
 	expression to match.
+
+--function-name<regex>::
+	Look for differences whose patch text contains hunk headers that match
+	<regex>. This can be useful to locate changes to a particular function
+	or other semantic element in a program, since hunk headers are intended
+	to indicate the "function context" (in the sense of
+	`--function-context`) in which the particular change occurs. The
+	function context is determined by the diff driver corresponding to the
+	file in question; see linkgit:gitattributes[7] for details.
 endif::git-format-patch[]
 
 -O<orderfile>::
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index c8b3e51..b8477ce 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -222,10 +222,11 @@ version prefixed with '+'.
 diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
 ---------------------------------------------------------------------
 
-This transformation limits the set of filepairs to those that change
+This transformation limits the set of filepairs to those that involve
 specified strings between the preimage and the postimage in a certain
-way.  -S<block of text> and -G<regular expression> options are used to
-specify different ways these strings are sought.
+way.  -S<block of text>, -G<regular expression>, and
+--function-name<regular expression> options are used to specify
+different ways these strings are sought.
 
 "-S<block of text>" detects filepairs whose preimage and postimage
 have different number of occurrences of the specified block of text.
@@ -251,6 +252,16 @@ criterion in a changeset, the entire changeset is kept.  This behavior
 is designed to make reviewing changes in the context of the whole
 changeset easier.
 
+"--function-name<regular expression>" detects filepairs whose textual
+diff contains a hunk header that matches the given regular expression.
+The hunk header is generated via the diff driver specified in
+`.gitattributes`, and is intended to reflect the "function context"
+(in the sense of `--function-context`) in which the change occurs,
+with programming-language-dependent heuristics. As of now, the
+programming language is not auto-detected in any way. Also note that
+hunks whose headers do not match the regular expression are not
+currently filtered out; this is only a filepair filter.
+
 diffcore-order: For Sorting the Output Based on Filenames
 ---------------------------------------------------------
 
-- 
1.7.12.4 (Apple Git-37)
