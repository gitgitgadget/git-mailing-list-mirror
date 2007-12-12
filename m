From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 1/3] Use "whitespace" consistently
Date: Wed, 12 Dec 2007 11:03:06 +0100
Message-ID: <1197453788-3097-2-git-send-email-win@wincent.com>
References: <1197453788-3097-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 11:03:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2ORT-00041S-EE
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 11:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756869AbXLLKDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 05:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756924AbXLLKD3
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 05:03:29 -0500
Received: from wincent.com ([72.3.236.74]:43895 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756484AbXLLKD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 05:03:29 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBCA39uj018416;
	Wed, 12 Dec 2007 04:03:12 -0600
X-Mailer: git-send-email 1.5.3.7.1159.g2f071-dirty
In-Reply-To: <1197453788-3097-1-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68028>

For consistency, change "white space" and "whitespaces" to
"whitespace", fixing a couple of adjacent grammar problems in the
docs.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 Documentation/diff-options.txt |   12 ++++++------
 Documentation/glossary.txt     |    2 +-
 diff.c                         |    4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index d0154bb..5d22b7b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -175,19 +175,19 @@ endif::git-format-patch[]
 	Shorthand for "--text".
 
 --ignore-space-at-eol::
-	Ignore changes in white spaces at EOL.
+	Ignore changes in whitespace at EOL.
 
 --ignore-space-change::
-	Ignore changes in amount of white space.  This ignores white
-	space at line end, and consider all other sequences of one or
-	more white space characters to be equivalent.
+	Ignore changes in amount of whitespace.  This ignores whitespace
+	at line end, and considers all other sequences of one or
+	more whitespace characters to be equivalent.
 
 -b::
 	Shorthand for "--ignore-space-change".
 
 --ignore-all-space::
-	Ignore white space when comparing lines.  This ignores
-	difference even if one line has white space where the other
+	Ignore whitespace when comparing lines.  This ignores
+	differences even if one line has whitespace where the other
 	line has none.
 
 -w::
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index fc18744..f9f5a32 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -245,7 +245,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 	of the object's contents using the Secure Hash Algorithm
 	1 and usually represented by the 40 character hexadecimal encoding of
 	the <<def_hash,hash>> of the object (possibly followed by
-	a white space).
+	whitespace).
 
 [[def_object_type]]object type::
 	One of the identifiers
diff --git a/diff.c b/diff.c
index f780e3e..e74a303 100644
--- a/diff.c
+++ b/diff.c
@@ -1015,7 +1015,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		if (line[i - 1] == '\t' && spaces)
 			space_before_tab = 1;
 
-		/* check white space at line end */
+		/* check whitespace at line end */
 		if (line[len - 1] == '\n')
 			len--;
 		if (isspace(line[len - 1]))
@@ -1029,7 +1029,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 					putchar(',');
 			}
 			if (white_space_at_end)
-				printf("white space at end");
+				printf("whitespace at end");
 			printf(":%s ", reset);
 			emit_line_with_ws(1, set, reset, ws, line, len,
 					  data->ws_rule);
-- 
1.5.3.7.1159.g2f071-dirty
