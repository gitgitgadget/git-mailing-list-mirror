Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40431F406
	for <e@80x24.org>; Sun, 13 May 2018 05:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751089AbeEMFwT (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 01:52:19 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43906 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeEMFwR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 01:52:17 -0400
Received: by mail-lf0-f66.google.com with SMTP id n18-v6so6904711lfh.10
        for <git@vger.kernel.org>; Sat, 12 May 2018 22:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8mfOkkRY806dosGcjucH1RvAt1s0aKlZcVfXe6emALs=;
        b=cpnym5UbjC5ObZ5ojq95liA4uFP7dfoLkc5nDciZT09PrkCE/Kpy2KASuTkzxGYA2r
         GhL+B8BSRE9mx+OLI5n5d+aXJ65h9hQx71h8nhcyPEH8RN1HyMSqaIBfVUCXg34vYNT/
         gm+jQd0UzRpliSsNxJJtRecQ2FwBYmgE7UAl2xj338h3TDf9MJGxHkVrJskeiprIu3wW
         0SsICdCXQR33w3RLuhMIfQiE4PDWw+oTjnT318+kwq2K2hOHZWxGpEJvguSx1B9C22jb
         Yt+NPO1JGp/+eWSBhC0SXKVSOZa9O3aY7cDPoXujUsC5ABVCcAAZoF8jQ0Phmh4CpXCe
         rxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8mfOkkRY806dosGcjucH1RvAt1s0aKlZcVfXe6emALs=;
        b=p5nPboaOgjjJmOKpNDww6YHhf0EFQloI/1GCq/ECbv7iBYKL34+CQ+eX+Nk5weqSce
         mpccZPCwFeIyCf0ttCLyIpDLrNj6q/xcxD3buoM/66EFfmPZarT0g0rKgPezrUNwzwMq
         pHfTeEGN7u/WI3ZoqgOLEjhYnsowBmYyj5MnsL35TSN5miDw4uCt6Jc4Uw7D6HuTOleq
         Uk5xPD3Xj6vPmS9GTOg4ORJ5Q5VohRaRU9wxSjvgk892LUBYgwPkTi6Cm6QcvLsPgJcp
         LaQZisq/rmARwN8pvsbGbOC4uWJGrVhBhi5qy7/7qpFl1jYsazODh2SN6GdjT9th8ntp
         HL+Q==
X-Gm-Message-State: ALKqPwfKEZtS8P63cYLVu5ovWtU50BxjkPLprHEhtqYCwWKr3OqsuR+l
        lYGLrEWnuSsETBaRveb4N6YQmQ==
X-Google-Smtp-Source: AB8JxZpeUEZ8ryDXB9YgCoWk3LZmb+twqtJCHAoVYxxPxK29kiqaKs9sVE6uKDCmYU36zvuO0TQPEg==
X-Received: by 2002:a2e:8794:: with SMTP id n20-v6mr2072138lji.38.1526190735624;
        Sat, 12 May 2018 22:52:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y5-v6sm1257779ljd.12.2018.05.12.22.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 22:52:14 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 01/14] commit-slab.h: code split
Date:   Sun, 13 May 2018 07:51:55 +0200
Message-Id: <20180513055208.17952-2-pclouds@gmail.com>
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

The struct declaration and implementation macros are moved to
commit-slab-hdr.h and commit-slab-impl.h respectively. This right now
is not needed for current users but if we share a commit-slab for
multiple files, we need something better than the current structure.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 commit-slab-hdr.h  |  30 ++++++++++++
 commit-slab-impl.h |  91 +++++++++++++++++++++++++++++++++++
 commit-slab.h      | 115 +++------------------------------------------
 3 files changed, 127 insertions(+), 109 deletions(-)
 create mode 100644 commit-slab-hdr.h
 create mode 100644 commit-slab-impl.h

diff --git a/commit-slab-hdr.h b/commit-slab-hdr.h
new file mode 100644
index 0000000000..fb5220fb7d
--- /dev/null
+++ b/commit-slab-hdr.h
@@ -0,0 +1,30 @@
+#ifndef COMMIT_SLAB_HDR_H
+#define COMMIT_SLAB_HDR_H
+
+/* allocate ~512kB at once, allowing for malloc overhead */
+#ifndef COMMIT_SLAB_SIZE
+#define COMMIT_SLAB_SIZE (512*1024-32)
+#endif
+
+#define declare_commit_slab(slabname, elemtype) 			\
+									\
+struct slabname {							\
+	unsigned slab_size;						\
+	unsigned stride;						\
+	unsigned slab_count;						\
+	elemtype **slab;						\
+}
+
+/*
+ * Statically initialize a commit slab named "var". Note that this
+ * evaluates "stride" multiple times! Example:
+ *
+ *   struct indegree indegrees = COMMIT_SLAB_INIT(1, indegrees);
+ *
+ */
+#define COMMIT_SLAB_INIT(stride, var) { \
+	COMMIT_SLAB_SIZE / sizeof(**((var).slab)) / (stride), \
+	(stride), 0, NULL \
+}
+
+#endif /* COMMIT_SLAB_HDR_H */
diff --git a/commit-slab-impl.h b/commit-slab-impl.h
new file mode 100644
index 0000000000..234d9ee5f0
--- /dev/null
+++ b/commit-slab-impl.h
@@ -0,0 +1,91 @@
+#ifndef COMMIT_SLAB_IMPL_H
+#define COMMIT_SLAB_IMPL_H
+
+#define MAYBE_UNUSED __attribute__((__unused__))
+
+#define implement_commit_slab(slabname, elemtype) 			\
+									\
+static int stat_ ##slabname## realloc;					\
+									\
+static MAYBE_UNUSED void init_ ##slabname## _with_stride(struct slabname *s, \
+						   unsigned stride)	\
+{									\
+	unsigned int elem_size;						\
+	if (!stride)							\
+		stride = 1;						\
+	s->stride = stride;						\
+	elem_size = sizeof(elemtype) * stride;				\
+	s->slab_size = COMMIT_SLAB_SIZE / elem_size;			\
+	s->slab_count = 0;						\
+	s->slab = NULL;							\
+}									\
+									\
+static MAYBE_UNUSED void init_ ##slabname(struct slabname *s)		\
+{									\
+	init_ ##slabname## _with_stride(s, 1);				\
+}									\
+									\
+static MAYBE_UNUSED void clear_ ##slabname(struct slabname *s)		\
+{									\
+	unsigned int i;							\
+	for (i = 0; i < s->slab_count; i++)				\
+		free(s->slab[i]);					\
+	s->slab_count = 0;						\
+	FREE_AND_NULL(s->slab);						\
+}									\
+									\
+static MAYBE_UNUSED elemtype *slabname## _at_peek(struct slabname *s,	\
+						  const struct commit *c, \
+						  int add_if_missing)   \
+{									\
+	unsigned int nth_slab, nth_slot;				\
+									\
+	nth_slab = c->index / s->slab_size;				\
+	nth_slot = c->index % s->slab_size;				\
+									\
+	if (s->slab_count <= nth_slab) {				\
+		unsigned int i;						\
+		if (!add_if_missing)					\
+			return NULL;					\
+		REALLOC_ARRAY(s->slab, nth_slab + 1);			\
+		stat_ ##slabname## realloc++;				\
+		for (i = s->slab_count; i <= nth_slab; i++)		\
+			s->slab[i] = NULL;				\
+		s->slab_count = nth_slab + 1;				\
+	}								\
+	if (!s->slab[nth_slab]) {					\
+		if (!add_if_missing)					\
+			return NULL;					\
+		s->slab[nth_slab] = xcalloc(s->slab_size,		\
+					    sizeof(**s->slab) * s->stride);		\
+	}								\
+	return &s->slab[nth_slab][nth_slot * s->stride];		\
+}									\
+									\
+static MAYBE_UNUSED elemtype *slabname## _at(struct slabname *s,	\
+					     const struct commit *c)	\
+{									\
+	return slabname##_at_peek(s, c, 1);				\
+}									\
+									\
+static MAYBE_UNUSED elemtype *slabname## _peek(struct slabname *s,	\
+					     const struct commit *c)	\
+{									\
+	return slabname##_at_peek(s, c, 0);				\
+}									\
+									\
+struct slabname
+
+/*
+ * Note that this redundant forward declaration is required
+ * to allow a terminating semicolon, which makes instantiations look
+ * like function declarations.  I.e., the expansion of
+ *
+ *    implement_commit_slab(indegree, int);
+ *
+ * ends in 'struct indegree;'.  This would otherwise
+ * be a syntax error according (at least) to ISO C.  It's hard to
+ * catch because GCC silently parses it by default.
+ */
+
+#endif	/* COMMIT_SLAB_IMPL_H */
diff --git a/commit-slab.h b/commit-slab.h
index dcaab8ca04..204b928584 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -1,6 +1,9 @@
 #ifndef COMMIT_SLAB_H
 #define COMMIT_SLAB_H
 
+#include "commit-slab-hdr.h"
+#include "commit-slab-impl.h"
+
 /*
  * define_commit_slab(slabname, elemtype) creates boilerplate code to define
  * a new struct (struct slabname) that is used to associate a piece of data
@@ -41,114 +44,8 @@
  *   leaking memory.
  */
 
-/* allocate ~512kB at once, allowing for malloc overhead */
-#ifndef COMMIT_SLAB_SIZE
-#define COMMIT_SLAB_SIZE (512*1024-32)
-#endif
-
-#define MAYBE_UNUSED __attribute__((__unused__))
-
-#define define_commit_slab(slabname, elemtype) 				\
-									\
-struct slabname {							\
-	unsigned slab_size;						\
-	unsigned stride;						\
-	unsigned slab_count;						\
-	elemtype **slab;						\
-};									\
-static int stat_ ##slabname## realloc;					\
-									\
-static MAYBE_UNUSED void init_ ##slabname## _with_stride(struct slabname *s, \
-						   unsigned stride)	\
-{									\
-	unsigned int elem_size;						\
-	if (!stride)							\
-		stride = 1;						\
-	s->stride = stride;						\
-	elem_size = sizeof(elemtype) * stride;				\
-	s->slab_size = COMMIT_SLAB_SIZE / elem_size;			\
-	s->slab_count = 0;						\
-	s->slab = NULL;							\
-}									\
-									\
-static MAYBE_UNUSED void init_ ##slabname(struct slabname *s)		\
-{									\
-	init_ ##slabname## _with_stride(s, 1);				\
-}									\
-									\
-static MAYBE_UNUSED void clear_ ##slabname(struct slabname *s)		\
-{									\
-	unsigned int i;							\
-	for (i = 0; i < s->slab_count; i++)				\
-		free(s->slab[i]);					\
-	s->slab_count = 0;						\
-	FREE_AND_NULL(s->slab);						\
-}									\
-									\
-static MAYBE_UNUSED elemtype *slabname## _at_peek(struct slabname *s,	\
-						  const struct commit *c, \
-						  int add_if_missing)   \
-{									\
-	unsigned int nth_slab, nth_slot;				\
-									\
-	nth_slab = c->index / s->slab_size;				\
-	nth_slot = c->index % s->slab_size;				\
-									\
-	if (s->slab_count <= nth_slab) {				\
-		unsigned int i;						\
-		if (!add_if_missing)					\
-			return NULL;					\
-		REALLOC_ARRAY(s->slab, nth_slab + 1);			\
-		stat_ ##slabname## realloc++;				\
-		for (i = s->slab_count; i <= nth_slab; i++)		\
-			s->slab[i] = NULL;				\
-		s->slab_count = nth_slab + 1;				\
-	}								\
-	if (!s->slab[nth_slab]) {					\
-		if (!add_if_missing)					\
-			return NULL;					\
-		s->slab[nth_slab] = xcalloc(s->slab_size,		\
-					    sizeof(**s->slab) * s->stride);		\
-	}								\
-	return &s->slab[nth_slab][nth_slot * s->stride];		\
-}									\
-									\
-static MAYBE_UNUSED elemtype *slabname## _at(struct slabname *s,	\
-					     const struct commit *c)	\
-{									\
-	return slabname##_at_peek(s, c, 1);				\
-}									\
-									\
-static MAYBE_UNUSED elemtype *slabname## _peek(struct slabname *s,	\
-					     const struct commit *c)	\
-{									\
-	return slabname##_at_peek(s, c, 0);				\
-}									\
-									\
-struct slabname
-
-/*
- * Note that this redundant forward declaration is required
- * to allow a terminating semicolon, which makes instantiations look
- * like function declarations.  I.e., the expansion of
- *
- *    define_commit_slab(indegree, int);
- *
- * ends in 'struct indegree;'.  This would otherwise
- * be a syntax error according (at least) to ISO C.  It's hard to
- * catch because GCC silently parses it by default.
- */
-
-/*
- * Statically initialize a commit slab named "var". Note that this
- * evaluates "stride" multiple times! Example:
- *
- *   struct indegree indegrees = COMMIT_SLAB_INIT(1, indegrees);
- *
- */
-#define COMMIT_SLAB_INIT(stride, var) { \
-	COMMIT_SLAB_SIZE / sizeof(**((var).slab)) / (stride), \
-	(stride), 0, NULL \
-}
+#define define_commit_slab(slabname, elemtype) \
+	declare_commit_slab(slabname, elemtype); \
+	implement_commit_slab(slabname, elemtype)
 
 #endif /* COMMIT_SLAB_H */
-- 
2.17.0.705.g3525833791

