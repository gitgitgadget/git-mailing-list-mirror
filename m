From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: [PATCH] compat/regex: fix typos in comments.
Date: Sun,  6 May 2012 21:45:00 +0900
Message-ID: <1336308300-4858-1-git-send-email-semtlenori@gmail.com>
Cc: "Yi, EungJun" <semtlenori@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun May 06 14:45:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR0py-0006Cz-OW
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 14:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab2EFMpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 08:45:11 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:59232 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469Ab2EFMpK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 08:45:10 -0400
Received: by dajt11 with SMTP id t11so177373daj.10
        for <git@vger.kernel.org>; Sun, 06 May 2012 05:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=fliH3c/ygrWlgxTBXGBu0rfkVTvR6qvPvoOd5hEsp+g=;
        b=Z+wc2y14VmfYXLEu6QZAYdEviEib5bq22tcBmpww3neQorob/YnozXpOGPKgRoJhBg
         eF9RMWRLp0qMorLKPWEoHehG3zm6hEGFnAdP1GEk6fn1zipK0SMcHAtHlc2Ntv+mWE67
         7RY5eKPxpQgWQ4RsgqZOKPOzxshr7H+Ewpr1e0iddIo+t72EH5zNRW6H7yUDdMRjZO01
         685O8HzMH/nv1dVwCa1aRsAY0ro6+T0elptXJFh7GOJGKUQn5NIc31Gyr5Q4sdsy1NSK
         Ia8rluC6bSMu7r3XLn/Yx1zQabDGtJJfpX1dsXUBMaxL8KiDkbxblSOYIM1NSPBUbbHW
         xbaQ==
Received: by 10.68.212.195 with SMTP id nm3mr1837190pbc.98.1336308310079;
        Sun, 06 May 2012 05:45:10 -0700 (PDT)
Received: from localhost.localdomain ([121.166.67.99])
        by mx.google.com with ESMTPS id q5sm14856122pbp.28.2012.05.06.05.45.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 05:45:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197179>

From: "Yi, EungJun" <semtlenori@gmail.com>

occured => occurred

Signed-off-by: Yi, EungJun <semtlenori@gmail.com>
---
 compat/regex/regcomp.c        |    4 ++--
 compat/regex/regex_internal.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 8c96ed9..aab8153 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -2095,7 +2095,7 @@ peek_token_bracket (re_token_t *token, re_string_t *input, reg_syntax_t syntax)
 
 /* Entry point of the parser.
    Parse the regular expression REGEXP and return the structure tree.
-   If an error is occured, ERR is set by error code, and return NULL.
+   If an error is occurred, ERR is set by error code, and return NULL.
    This function build the following tree, from regular expression <reg_exp>:
 	   CAT
 	   / \
@@ -3715,7 +3715,7 @@ build_charclass_op (re_dfa_t *dfa, RE_TRANSLATE_TYPE trans,
 /* This is intended for the expressions like "a{1,3}".
    Fetch a number from `input', and return the number.
    Return -1, if the number field is empty like "{,1}".
-   Return -2, If an error is occured.  */
+   Return -2, If an error is occurred.  */
 
 static int
 fetch_number (re_string_t *input, re_token_t *token, reg_syntax_t syntax)
diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
index 193854c..237642c 100644
--- a/compat/regex/regex_internal.c
+++ b/compat/regex/regex_internal.c
@@ -1284,7 +1284,7 @@ re_node_set_merge (re_node_set *dest, const re_node_set *src)
 
 /* Insert the new element ELEM to the re_node_set* SET.
    SET should not already have ELEM.
-   return -1 if an error is occured, return 1 otherwise.  */
+   return -1 if an error is occurred, return 1 otherwise.  */
 
 static int
 internal_function
@@ -1341,7 +1341,7 @@ re_node_set_insert (re_node_set *set, int elem)
 
 /* Insert the new element ELEM to the re_node_set* SET.
    SET should not already have any element greater than or equal to ELEM.
-   Return -1 if an error is occured, return 1 otherwise.  */
+   Return -1 if an error is occurred, return 1 otherwise.  */
 
 static int
 internal_function
@@ -1416,7 +1416,7 @@ re_node_set_remove_at (re_node_set *set, int idx)
 
 
 /* Add the token TOKEN to dfa->nodes, and return the index of the token.
-   Or return -1, if an error will be occured.  */
+   Or return -1, if an error will be occurred.  */
 
 static int
 internal_function
-- 
1.7.5.4
