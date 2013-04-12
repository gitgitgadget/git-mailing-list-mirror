From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/10] compat/regex: fix spelling and grammar in comments
Date: Fri, 12 Apr 2013 00:01:07 -0700
Message-ID: <20130412070107.GF5710@elie.Belkin>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
 <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com>
 <7v4nfch90r.fsf@alter.siamese.dyndns.org>
 <20130412064837.GA5710@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	sunshine@sunshineco.com, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 09:01:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQXz4-0005XJ-3F
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 09:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576Ab3DLHBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 03:01:13 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:49597 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662Ab3DLHBM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 03:01:12 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj3so1315076pad.34
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 00:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ELxKSH1OPdgytOiNANzSs3+agbAem9oy08xphOgaH+Q=;
        b=EaisCxee1mD/itNJJPTOihK2aIf4XvP3nMCxcKyzHzJF3vm51BnryhgnDcX93X/YOb
         zieNpSJ4BZt3+GUzhpHBkRQ033QonAexKbRfv5JIVS7NXMlnDcjyClx86O2MugcNEP8d
         8laLLMmXk5zPs5DsQaX7SALeRwtGQJqrVtC4mfkEP/aFN3EJBk5EKKN46c826XI3OVGQ
         96d7GfRs8+ByVATv9LzAIXJCwTgq3yg1LpYWChIz26qLl5oKhl6KX7YxUmfOoRJI9lr9
         e5DG2wY89DEPS7BJsgX2PsJXeKEwNwagmZsFn6D/buhFomKNND71IBX85kUA3HCVlanH
         GFag==
X-Received: by 10.68.117.7 with SMTP id ka7mr12965102pbb.8.1365750072041;
        Fri, 12 Apr 2013 00:01:12 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ak5sm8317302pac.4.2013.04.12.00.01.09
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 00:01:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130412064837.GA5710@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220963>

From: Stefano Lattarini <stefano.lattarini@gmail.com>
Date: Fri, 12 Apr 2013 00:36:10 +0200

Some of these were found using Lucas De Marchi's codespell tool.
Others noticed by Eric Sunshine.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Is gawk the appropriate upstream to send this sort of readability
improvement to?

 compat/regex/regcomp.c        | 4 ++--
 compat/regex/regex.c          | 2 +-
 compat/regex/regex_internal.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 8c96ed94..d0025bd5 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -2095,7 +2095,7 @@ peek_token_bracket (re_token_t *token, re_string_t *input, reg_syntax_t syntax)
 
 /* Entry point of the parser.
    Parse the regular expression REGEXP and return the structure tree.
-   If an error is occured, ERR is set by error code, and return NULL.
+   If an error has occurred, ERR is set by error code, and return NULL.
    This function build the following tree, from regular expression <reg_exp>:
 	   CAT
 	   / \
@@ -3715,7 +3715,7 @@ build_charclass_op (re_dfa_t *dfa, RE_TRANSLATE_TYPE trans,
 /* This is intended for the expressions like "a{1,3}".
    Fetch a number from `input', and return the number.
    Return -1, if the number field is empty like "{,1}".
-   Return -2, If an error is occured.  */
+   Return -2, if an error has occurred.  */
 
 static int
 fetch_number (re_string_t *input, re_token_t *token, reg_syntax_t syntax)
diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 3dd8dfa0..6aaae003 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -22,7 +22,7 @@
 #include "config.h"
 #endif
 
-/* Make sure noone compiles this code with a C++ compiler.  */
+/* Make sure no one compiles this code with a C++ compiler.  */
 #ifdef __cplusplus
 # error "This is C code, use a C compiler"
 #endif
diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
index 193854cf..d4121f2f 100644
--- a/compat/regex/regex_internal.c
+++ b/compat/regex/regex_internal.c
@@ -1284,7 +1284,7 @@ re_node_set_merge (re_node_set *dest, const re_node_set *src)
 
 /* Insert the new element ELEM to the re_node_set* SET.
    SET should not already have ELEM.
-   return -1 if an error is occured, return 1 otherwise.  */
+   return -1 if an error has occurred, return 1 otherwise.  */
 
 static int
 internal_function
@@ -1341,7 +1341,7 @@ re_node_set_insert (re_node_set *set, int elem)
 
 /* Insert the new element ELEM to the re_node_set* SET.
    SET should not already have any element greater than or equal to ELEM.
-   Return -1 if an error is occured, return 1 otherwise.  */
+   Return -1 if an error has occurred, return 1 otherwise.  */
 
 static int
 internal_function
@@ -1416,7 +1416,7 @@ re_node_set_remove_at (re_node_set *set, int idx)
 
 
 /* Add the token TOKEN to dfa->nodes, and return the index of the token.
-   Or return -1, if an error will be occured.  */
+   Or return -1, if an error has occurred.  */
 
 static int
 internal_function
-- 
1.8.2.1
