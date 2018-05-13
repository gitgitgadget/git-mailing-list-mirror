Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD01C1F406
	for <e@80x24.org>; Sun, 13 May 2018 05:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbeEMFwT (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 01:52:19 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39925 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeEMFwS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 01:52:18 -0400
Received: by mail-lf0-f65.google.com with SMTP id j193-v6so13376445lfg.6
        for <git@vger.kernel.org>; Sat, 12 May 2018 22:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OsDJ+k4W54xjGtA82pjEP2ka7cVKNjwXX6DVGUrA8+8=;
        b=XG93cM7LHB5kDITTAoaXhOSYlRl2fw+fRmqC02qLBwgsNY0M6wXFWyC36KFZ4IcZdi
         ERDK2LuN3GfWU1BH1X4dK2wZeCxyqhr4JLtS3h8YTG7WNBBlXkeCA02Bi03aK8Ld753H
         f9BHE3gloN9hpDCGZMJTE0tClGYXmgzNUXDz3Imkz4/c1+yCNuS2v+dtzxlTZf3NhVA4
         Uaflc6oFj+4/UgxyTiJeooqjGIKxqjO4Ho96P2BuflTIJLPpxDiEvIHETqoAkmZzcd5g
         1bi9zrBPHfJDMKmCp2B/Ez0QwqXo66hikj1g+6RG1HhMuwxQvSrb5Zg2Uzc8Cb05/aIE
         i6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OsDJ+k4W54xjGtA82pjEP2ka7cVKNjwXX6DVGUrA8+8=;
        b=tuaju/FWNwWd+B1N5F8iDdaz1nO6QnWaoqKYzbd7raTLqBmIiNkAeoPs8iS3MXUl4A
         27we7FpxzwrhZKOYO5B6ch+wWfoO4YkFse96TIGzzB8uVYl0S80Go71vyBwOotDa3LPs
         SkieIofNAkaeasjm/CE6ijpTnp4Mg/lBxyVw1cPSD0NYgzanUH7On/m6BFLsWhMcZBMe
         123ADgPJundKs5G6ub/LRuPRuGax58UlI/n2N89vXs9sICIMLlMPl3j6jfIBPDh6XFnO
         wooIe1nb6MK5lKTSSWfWO+lPRyfQ5U65A9yyenXcq7o9wZwYfqjUZeFaXu9+sSy6MWvl
         A4EA==
X-Gm-Message-State: ALKqPwfiDKhzzbYiUyDSk5xPUNbeMMaLNLjt8uwL+O7H+kNMiefbDDMx
        dGS/5o/WWdlh7CopVQF6DAe8Fg==
X-Google-Smtp-Source: AB8JxZoQPG0W2AeB71M2BJ4KctLVRcH4Xd+dd43wG4rVRO3cHKUaED3ax8Vmggd1gFm2srXKuCuiNg==
X-Received: by 2002:a2e:5718:: with SMTP id l24-v6mr1850801ljb.51.1526190736747;
        Sat, 12 May 2018 22:52:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y5-v6sm1257779ljd.12.2018.05.12.22.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 22:52:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 02/14] commit-slab: support shared commit-slab
Date:   Sun, 13 May 2018 07:51:56 +0200
Message-Id: <20180513055208.17952-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180513055208.17952-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180513055208.17952-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

define_shared_commit_slab() could be used in a header file to define a
commit-slab. One of these C files must include commit-slab-impl.h and
"call" implement_shared_commit_slab().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 commit-slab-hdr.h  | 13 +++++++++++++
 commit-slab-impl.h | 20 +++++++++++++-------
 commit-slab.h      |  2 +-
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/commit-slab-hdr.h b/commit-slab-hdr.h
index fb5220fb7d..adc7b46c83 100644
--- a/commit-slab-hdr.h
+++ b/commit-slab-hdr.h
@@ -27,4 +27,17 @@ struct slabname {							\
 	(stride), 0, NULL \
 }
 
+#define declare_commit_slab_prototypes(slabname, elemtype)		\
+									\
+void init_ ##slabname## _with_stride(struct slabname *s, unsigned stride); \
+void init_ ##slabname(struct slabname *s);				\
+void clear_ ##slabname(struct slabname *s);				\
+elemtype *slabname## _at_peek(struct slabname *s, const struct commit *c, int add_if_missing); \
+elemtype *slabname## _at(struct slabname *s, const struct commit *c);	\
+elemtype *slabname## _peek(struct slabname *s, const struct commit *c)
+
+#define define_shared_commit_slab(slabname, elemtype) \
+	declare_commit_slab(slabname, elemtype); \
+	declare_commit_slab_prototypes(slabname, elemtype)
+
 #endif /* COMMIT_SLAB_HDR_H */
diff --git a/commit-slab-impl.h b/commit-slab-impl.h
index 234d9ee5f0..19a88d7d8f 100644
--- a/commit-slab-impl.h
+++ b/commit-slab-impl.h
@@ -3,11 +3,17 @@
 
 #define MAYBE_UNUSED __attribute__((__unused__))
 
-#define implement_commit_slab(slabname, elemtype) 			\
+#define implement_static_commit_slab(slabname, elemtype) \
+	implement_commit_slab(slabname, elemtype, static MAYBE_UNUSED)
+
+#define implement_shared_commit_slab(slabname, elemtype) \
+	implement_commit_slab(slabname, elemtype, )
+
+#define implement_commit_slab(slabname, elemtype, scope)		\
 									\
 static int stat_ ##slabname## realloc;					\
 									\
-static MAYBE_UNUSED void init_ ##slabname## _with_stride(struct slabname *s, \
+scope void init_ ##slabname## _with_stride(struct slabname *s,		\
 						   unsigned stride)	\
 {									\
 	unsigned int elem_size;						\
@@ -20,12 +26,12 @@ static MAYBE_UNUSED void init_ ##slabname## _with_stride(struct slabname *s, \
 	s->slab = NULL;							\
 }									\
 									\
-static MAYBE_UNUSED void init_ ##slabname(struct slabname *s)		\
+scope void init_ ##slabname(struct slabname *s)				\
 {									\
 	init_ ##slabname## _with_stride(s, 1);				\
 }									\
 									\
-static MAYBE_UNUSED void clear_ ##slabname(struct slabname *s)		\
+scope void clear_ ##slabname(struct slabname *s)			\
 {									\
 	unsigned int i;							\
 	for (i = 0; i < s->slab_count; i++)				\
@@ -34,7 +40,7 @@ static MAYBE_UNUSED void clear_ ##slabname(struct slabname *s)		\
 	FREE_AND_NULL(s->slab);						\
 }									\
 									\
-static MAYBE_UNUSED elemtype *slabname## _at_peek(struct slabname *s,	\
+scope elemtype *slabname## _at_peek(struct slabname *s,			\
 						  const struct commit *c, \
 						  int add_if_missing)   \
 {									\
@@ -62,13 +68,13 @@ static MAYBE_UNUSED elemtype *slabname## _at_peek(struct slabname *s,	\
 	return &s->slab[nth_slab][nth_slot * s->stride];		\
 }									\
 									\
-static MAYBE_UNUSED elemtype *slabname## _at(struct slabname *s,	\
+scope elemtype *slabname## _at(struct slabname *s,			\
 					     const struct commit *c)	\
 {									\
 	return slabname##_at_peek(s, c, 1);				\
 }									\
 									\
-static MAYBE_UNUSED elemtype *slabname## _peek(struct slabname *s,	\
+scope elemtype *slabname## _peek(struct slabname *s,			\
 					     const struct commit *c)	\
 {									\
 	return slabname##_at_peek(s, c, 0);				\
diff --git a/commit-slab.h b/commit-slab.h
index 204b928584..dc029acc66 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -46,6 +46,6 @@
 
 #define define_commit_slab(slabname, elemtype) \
 	declare_commit_slab(slabname, elemtype); \
-	implement_commit_slab(slabname, elemtype)
+	implement_static_commit_slab(slabname, elemtype)
 
 #endif /* COMMIT_SLAB_H */
-- 
2.17.0.705.g3525833791

