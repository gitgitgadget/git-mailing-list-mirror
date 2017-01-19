Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7C2C1F89C
	for <e@80x24.org>; Thu, 19 Jan 2017 03:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbdASDTD (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 22:19:03 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33764 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbdASDTB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 22:19:01 -0500
Received: by mail-pf0-f175.google.com with SMTP id y143so9457637pfb.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 19:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KeL/LTirrhifah/ZeQWH47rmxycYi+rD2jj0D6hW+vE=;
        b=BfK2gWaWIMcqv+T3q7Fe4x2yKqlgEV0ujV8VUb1bGzB1+cOpTSdp+Dm4H5fWPBDiyf
         Kz4yr7EcNzWf88WG45s2+X4yjYP157lUbekfBGxKpYjRm7YZXnDvG/J0NLSmWKyyWQY5
         IxekFAoU/z5bhoSkJFE60kPekn1MQ7xAbYDypRen1OmzYyFrbM2gHyXnvfXPU3+comd7
         KdgLzIsSEWXYPXtfbXWlJ/hiH8ZrN9sc2XRs1FdvGB6tr1fAXUl3aTpAq36Fn6RIZ0w+
         wZKSvtipkuAEdIm6S7a2TlupwviOUKQz+yVJ3UKcqG/5l/osyIR2VvrYvXOToBT6JLCa
         5dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KeL/LTirrhifah/ZeQWH47rmxycYi+rD2jj0D6hW+vE=;
        b=dDB4fOr+FI1dEt+A2lyYJwT2wFPKgbIh01EImX5LUdin2jLq0SIw5DVeW6DVmEtCdb
         3GaPnQs4wGSVBW30GQoEt5Jvcmar4oPnVD4SWyPBBTpxSrp1TNITinHsZxTUIIJLuMjw
         H/upBynYHZcfy/JvoHFWDZkHse75c5PU1J/HgVGmIbY2o+VC5lhxw0ZbsnsCDYIKu2In
         4lj037kdjTk8Ks0DgfCAL+bTzLkLFQg3MUhClA7tl+SM2xox4ihWdviJf79JcKvKsieo
         4UD5Gg6micqOmpcc+bxweJaNm+yW9I1XUORKzOe8oYCDBKb6Rdsm0JhUjOlVnfXdnw1p
         Gnaw==
X-Gm-Message-State: AIkVDXJ6t50qR5fkoH1vRJeurp+es+73H5v7qFlWTxroPlXLFzz+nf1mre1Ei4vn6H4fxcxF
X-Received: by 10.99.95.151 with SMTP id t145mr7729180pgb.75.1484795941108;
        Wed, 18 Jan 2017 19:19:01 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:40e0:b9ca:546a:a0ec])
        by smtp.gmail.com with ESMTPSA id j78sm3872270pfk.39.2017.01.18.19.19.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Jan 2017 19:19:00 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 1/4] cache.h: document index_name_pos
Date:   Wed, 18 Jan 2017 19:18:51 -0800
Message-Id: <20170119031854.4570-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.299.g762782ba8a
In-Reply-To: <20170119031854.4570-1-sbeller@google.com>
References: <20170118232145.31606-2-sbeller@google.com>
 <20170119031854.4570-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/cache.h b/cache.h
index 1b67f078dd..1469ddeafe 100644
--- a/cache.h
+++ b/cache.h
@@ -575,7 +575,26 @@ extern int verify_path(const char *path);
 extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
 extern void adjust_dirname_case(struct index_state *istate, char *name);
 extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
+
+/*
+ * Searches for an entry defined by name and namelen in the given index.
+ * If the return value is positive (including 0) it is the position of an
+ * exact match. If the return value is negative, the negated value minus 1
+ * is the position where the entry would be inserted.
+ * Example: The current index consists of these files and its stages:
+ *
+ *   b#0, d#0, f#1, f#3
+ *
+ * index_name_pos(&index, "a", 1) -> -1
+ * index_name_pos(&index, "b", 1) ->  0
+ * index_name_pos(&index, "c", 1) -> -2
+ * index_name_pos(&index, "d", 1) ->  1
+ * index_name_pos(&index, "e", 1) -> -3
+ * index_name_pos(&index, "f", 1) -> -3
+ * index_name_pos(&index, "g", 1) -> -5
+ */
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
+
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
-- 
2.11.0.299.g762782ba8a

