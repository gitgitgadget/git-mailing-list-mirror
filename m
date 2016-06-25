Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E16F81FE4E
	for <e@80x24.org>; Sat, 25 Jun 2016 05:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbcFYFYI (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 01:24:08 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33060 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbcFYFYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 01:24:06 -0400
Received: by mail-lf0-f68.google.com with SMTP id l188so23746706lfe.0
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 22:24:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mefTUAaVBYpFwJK/OR1XCtTP+DToqtE+SHj8+Q4rnt0=;
        b=GnGUOcdp4OKueNVKJqNnMaljUuNnXq0sGbSKDAxQhdE5uLMGW+mehgR26oA3g56WLg
         J9IVQv78+vWSoJXMjKWLybZcwRx2fZijaxsqEwmbmVCWxRqj3I6R+CtgveVcpBwjip2r
         GLLO3CquGZp+WsIuBKvsSatkVgfnGSlY2tT0Zm1EbGQj/a6BF52i2hCJhyPNUYrUKU/x
         NrFT7b5H3vlna8SKjMm2pyYQ1OlYSs7aPJGTN2mr4mZzZzOBGQEXE4rA2KySNct9rqnh
         C8vI0f4ZNdQPxKyMwoLpCkKZnS0aQMOXe+CX8Xl4cCY/LvacJYCgDwZiCwMJg3nVw+1X
         ZIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mefTUAaVBYpFwJK/OR1XCtTP+DToqtE+SHj8+Q4rnt0=;
        b=FQI+UNvrxJ1eUgnS9frjiEvrFZ4/UCRlcgLGDwPYdw6Be1lbVVqi6DroyLYiqF8XQv
         +jBtRP8zz2mClzxHZdb4mFxeg0rEwp2Ye0lDGBpQI1QSdu8TAPmQeCdkSDDBJPLL27R/
         8I/ityF6RR2elMahlnxI/kNoWISJ6QFafMHXMrYeYmVmPK3KLotcG/07c+5e3Bc/H3gO
         nyUuSll8Hp1zlpLaw3wB9Xz89kDQctedqTcdT+FHvSpQFZvhpHOg7vqPpG6x42NaduQD
         TAum0zdWbkIxBTaoGDZRR3aBRj5uyxSSrBONl1vRBsmZ93D7/aep383SAkk0kgy7/lJ5
         u7Yw==
X-Gm-Message-State: ALyK8tKSwWSj/Tr1f41/jfZOFKX7BSqIAH8hIxTyKh5t0rcRXJS0hJMvUkxhleNWBVe3/g==
X-Received: by 10.25.5.3 with SMTP id 3mr2426319lff.6.1466832243151;
        Fri, 24 Jun 2016 22:24:03 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id s87sm1450921lfg.46.2016.06.24.22.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jun 2016 22:24:01 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/12] nd/icase updates
Date:	Sat, 25 Jun 2016 07:22:26 +0200
Message-Id: <20160625052238.13615-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160623162907.23295-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

v2 fixes Junio's and Jeff's comments (both good). The sharing "!icase
|| ascii_only" is made a separate commit (6/12) because I think it
takes some seconds to realize that the conversion is correct and it's
technically not needed in 5/12 (and it's sort of the opposite of 1/12)

Interdiff

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 0a5f877..55067ca 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -200,19 +200,30 @@ static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
 	*q = outq;
 }
 
+static void regcomp_or_die(regex_t *regex, const char *needle, int cflags)
+{
+	int err = regcomp(regex, needle, cflags);
+	if (err) {
+		/* The POSIX.2 people are surely sick */
+		char errbuf[1024];
+		regerror(err, regex, errbuf, 1024);
+		regfree(regex);
+		die("invalid regex: %s", errbuf);
+	}
+}
+
 void diffcore_pickaxe(struct diff_options *o)
 {
 	const char *needle = o->pickaxe;
 	int opts = o->pickaxe_opts;
 	regex_t regex, *regexp = NULL;
 	kwset_t kws = NULL;
-	int err = 0;
 
 	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
 		int cflags = REG_EXTENDED | REG_NEWLINE;
 		if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE))
 			cflags |= REG_ICASE;
-		err = regcomp(&regex, needle, cflags);
+		regcomp_or_die(&regex, needle, cflags);
 		regexp = &regex;
 	} else if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE) &&
 		   has_non_ascii(needle)) {
@@ -220,7 +231,7 @@ void diffcore_pickaxe(struct diff_options *o)
 		int cflags = REG_NEWLINE | REG_ICASE;
 
 		basic_regex_quote_buf(&sb, needle);
-		err = regcomp(&regex, sb.buf, cflags);
+		regcomp_or_die(&regex, sb.buf, cflags);
 		strbuf_release(&sb);
 		regexp = &regex;
 	} else {
@@ -229,13 +240,6 @@ void diffcore_pickaxe(struct diff_options *o)
 		kwsincr(kws, needle, strlen(needle));
 		kwsprep(kws);
 	}
-	if (err) {
-		/* The POSIX.2 people are surely sick */
-		char errbuf[1024];
-		regerror(err, &regex, errbuf, 1024);
-		regfree(&regex);
-		die("invalid regex: %s", errbuf);
-	}
 
 	/* Might want to warn when both S and G are on; I don't care... */
 	pickaxe(&diff_queued_diff, o, regexp, kws,
diff --git a/grep.c b/grep.c
index cb058a5..92587a8 100644
--- a/grep.c
+++ b/grep.c
@@ -432,15 +432,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	icase	       = opt->regflags & REG_ICASE || p->ignore_case;
 	ascii_only     = !has_non_ascii(p->pattern);
 
-	if (opt->fixed) {
+	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
 		p->fixed = !icase || ascii_only;
-		if (!p->fixed) {
-			compile_fixed_regexp(p, opt);
-			return;
-		}
-	} else if ((!icase || ascii_only) &&
-		   is_fixed(p->pattern, p->patternlen))
-		p->fixed = 1;
 	else
 		p->fixed = 0;
 
@@ -449,6 +442,9 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		kwsincr(p->kws, p->pattern, p->patternlen);
 		kwsprep(p->kws);
 		return;
+	} else if (opt->fixed) {
+		compile_fixed_regexp(p, opt);
+		return;
 	}
 
 	if (opt->pcre) {

Nguyễn Thái Ngọc Duy (12):
  grep: break down an "if" stmt in preparation for next changes
  test-regex: isolate the bug test code
  test-regex: expose full regcomp() to the command line
  grep/icase: avoid kwsset on literal non-ascii strings
  grep/icase: avoid kwsset when -F is specified
  grep: rewrite an if/else condition to avoid duplicate expression
  grep/pcre: prepare locale-dependent tables for icase matching
  gettext: add is_utf8_locale()
  grep/pcre: support utf-8
  diffcore-pickaxe: Add regcomp_or_die()
  diffcore-pickaxe: support case insensitive match on non-ascii
  grep.c: reuse "icase" variable

 diffcore-pickaxe.c                       | 33 +++++++++++----
 gettext.c                                | 24 ++++++++++-
 gettext.h                                |  1 +
 grep.c                                   | 43 +++++++++++++++----
 grep.h                                   |  1 +
 quote.c                                  | 37 +++++++++++++++++
 quote.h                                  |  1 +
 t/t0070-fundamental.sh                   |  2 +-
 t/t7812-grep-icase-non-ascii.sh (new +x) | 71 ++++++++++++++++++++++++++++++++
 t/t7813-grep-icase-iso.sh (new +x)       | 19 +++++++++
 test-regex.c                             | 59 +++++++++++++++++++++++++-
 11 files changed, 270 insertions(+), 21 deletions(-)
 create mode 100755 t/t7812-grep-icase-non-ascii.sh
 create mode 100755 t/t7813-grep-icase-iso.sh

-- 
2.8.2.526.g02eed6d

