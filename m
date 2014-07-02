From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH] enums: remove trailing ',' after last item in enum
Date: Wed,  2 Jul 2014 11:24:05 -0700
Message-ID: <1404325445-17914-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 20:24:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2PCs-00023x-Sj
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 20:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641AbaGBSYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 14:24:17 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:50126 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204AbaGBSYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 14:24:16 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so2661796oac.2
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 11:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=z2+Z8PmaoNAzPaywm1jvnXaEqmLlCScLA676dpkfoCU=;
        b=NO+y6VqtjIVn4pnuTOCn+KV5WKYuW6I8BiCzmiCpP4OSUXl6UBxmvu7ysE3FyeVnlc
         F1qH3q8ZiFXkWJTeyFqDFpS2o28/vewIx2EjB0bzMpipZ+dT99TMRgRLl0N5Y7klV0sA
         R/Wq2g9VN/2FRq0WJ2wrTut5mhbGNyBAc38xVkmi3qyi0pdUp849v7wa8lyjW21DZmZM
         nWwiCIxCQSzmNeaynDFkRvXqFfqmU+T6Yv6LjysTw6AHO1c1gBQT/BvugaZ4m8+6TyIp
         kn8w5Z3vOMwshe8/pJF5rgA4m+ofkXCBLKSsD+shChVN8nWXJKvPtsQQswDfehzuMWPZ
         t+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z2+Z8PmaoNAzPaywm1jvnXaEqmLlCScLA676dpkfoCU=;
        b=JcYptaiTl37Rld3kYzHU3LIy5F5DXoOIR50i9irjzmxr4wzQWDQpbsaeMcjDW7caIU
         EeiZ4tB5RM+C/gSQxI3TlKlfrwuwE8CBK9eOleJs4NyNRFhaPe7wiuzlY5aQ+9Y0nDy9
         QhbZA/1NvaARlUZVLdoM2XYnMBJdUOYtigFBUTkIT81dJ/ZrEBcdaQYJs4q76HcbLLqW
         tCEsEouRnmQPiDNtu1Ixjd0kGFVfWDC3hSTXO3b+vn4E+rpVup4q1ScC3LOkYPqAVO8j
         Z2ZyFG7DnGVq913Ox++sW4qAAIXejKtR22kb59r2RsJ/4oX56aT0GWUO95zl5GD98t0m
         j/PQ==
X-Gm-Message-State: ALoCoQnV4LbcFOwYKbObSZ7gEBua3HRHaNsUMC8wrR5NQpxJnSlR+GZMH+oymoTrD42QIWZgoQMw
X-Received: by 10.182.55.104 with SMTP id r8mr30789434obp.11.1404325456018;
        Wed, 02 Jul 2014 11:24:16 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j43si1390741yhh.5.2014.07.02.11.24.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 11:24:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id D84CD5A431F;
	Wed,  2 Jul 2014 11:24:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7B4BBE0EFE; Wed,  2 Jul 2014 11:24:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.443.g16b6d69
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252825>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/clean.c | 2 +-
 builtin/tag.c   | 2 +-
 pretty.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 9a91515..27701d2 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -48,7 +48,7 @@ enum color_clean {
 	CLEAN_COLOR_PROMPT = 2,
 	CLEAN_COLOR_HEADER = 3,
 	CLEAN_COLOR_HELP = 4,
-	CLEAN_COLOR_ERROR = 5,
+	CLEAN_COLOR_ERROR = 5
 };
 
 #define MENU_OPTS_SINGLETON		01
diff --git a/builtin/tag.c b/builtin/tag.c
index c6e8a71..ef76556 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -83,7 +83,7 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
 enum contains_result {
 	CONTAINS_UNKNOWN = -1,
 	CONTAINS_NO = 0,
-	CONTAINS_YES = 1,
+	CONTAINS_YES = 1
 };
 
 /*
diff --git a/pretty.c b/pretty.c
index 4f51287..924bc61 100644
--- a/pretty.c
+++ b/pretty.c
@@ -274,7 +274,7 @@ static void add_rfc822_quoted(struct strbuf *out, const char *s, int len)
 
 enum rfc2047_type {
 	RFC2047_SUBJECT,
-	RFC2047_ADDRESS,
+	RFC2047_ADDRESS
 };
 
 static int is_rfc2047_special(char ch, enum rfc2047_type type)
-- 
2.0.1.442.g7fe6834.dirty
