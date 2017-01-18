Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63EA11F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 23:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbdARXbT (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 18:31:19 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33713 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbdARXbS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 18:31:18 -0500
Received: by mail-pf0-f172.google.com with SMTP id y143so7900699pfb.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 15:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WZRHKO+RJf06FJGESmiDzcof54lSTs1UzHAGgQmQ+CE=;
        b=eJ4HVx/4kC1Q/qmwualadAhg3pLdUs7bEANfCrJBGzKr4lVh1ZUTA7zLr/WfEJNKUD
         ih4rFQ6BP8kRE3/MxciNybFLDyAmcZVIw++zTUX0gWbPfN4kHEu2dSfA9pBKicJigPBW
         /6tE2sU19aLcF8g7VF7DJL6ytV+m8E3PrJWDOX+c4jVwHZcltA5dFHxtzb8aMMrXbksB
         3aEMCRpz9chYNrppmN/XlfTZUG5UxYzOnd5+DwO4MkZKctpZAD1rhsNiZ12vHYJWSIR9
         7VCcfCTwFD6njzh4jDdk/YZ+3ncSaaJC2Mx8aMKG8CbIz1TboZaulsv6Ne71MkW3TpOM
         dMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WZRHKO+RJf06FJGESmiDzcof54lSTs1UzHAGgQmQ+CE=;
        b=S3FN2G6jCCDDM2TNTBJi47R1e6EX5S1PnzaoAwMYezMcAPrf4ybJQBtdE24Xz4Klpq
         rPUXJO8UlW3QbGhYXmUNwA4P4Gm8RfmgEDqOtqb7rNNzIrr4mLJaQw/M5DDggZN/5uGh
         DEwieO2V5ZJ4SCieo3gaUWwyUfPVAZwfge7d/CPNRg+Fh6Jg91WfEJNJM27c4D+sBtvW
         O9CNcDcKu3X8osx+7e30Lo+oZw/SKCjQr3V2z+Uub9NzI0eJzl1CpPEshEGsfLTNiLpk
         bJCs0rgrlx/d/grMpXyURLhTREQbbx3ak6rqCK2WkLHYuojqyu3SMoklsrwgJqk/gmCW
         dkJQ==
X-Gm-Message-State: AIkVDXLVIHAb6//Qc165tnglkMi1xoE+pVvUhiber9BL9lrYmYmaX7Ts8UdQoZIthten7hoM
X-Received: by 10.99.62.73 with SMTP id l70mr6569074pga.97.1484781722002;
        Wed, 18 Jan 2017 15:22:02 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:40e0:b9ca:546a:a0ec])
        by smtp.gmail.com with ESMTPSA id n70sm3212273pfg.34.2017.01.18.15.22.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Jan 2017 15:22:01 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/4] cache.h: document index_name_pos
Date:   Wed, 18 Jan 2017 15:21:42 -0800
Message-Id: <20170118232145.31606-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.299.g762782ba8a
In-Reply-To: <20170118232145.31606-1-sbeller@google.com>
References: <20170117233503.27137-1-sbeller@google.com>
 <20170118232145.31606-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/cache.h b/cache.h
index 1b67f078dd..3dbba69aec 100644
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
+ * index_name_pos(&index, "f", 1) ->  2
+ * index_name_pos(&index, "g", 1) -> -5
+ */
 extern int index_name_pos(const struct index_state *, const char *name, int namelen);
+
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
-- 
2.11.0.299.g762782ba8a

