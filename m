Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 026C71F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfFSVGG (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:06:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40006 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730487AbfFSVGB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:06:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so1275457eds.7
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3BindVbIcEpTBEEDDp7VbSsrPex7xUuc+AbIS6NQwM8=;
        b=GacZQmSBYqiZ+3MM13AgMHtPmKCtEU+xcxJoDG4gd7IJqDbkNn8BDfjWgjM2sBIQqK
         a14yuo8Zg7HD86IXZPb3/BXCiaOweCTSb+lXHJvHHz/JHpKGyC2Sn0RDLFiOcRrTgbn8
         /tbx8eaqdoM52FqePWuEO+OiXdYosHBMEay5hiDwpw/kkNQPMHgwFppngjMcf9o2JRzT
         vL1MPIe31TlgIEo3xt3ZBbESUlafWYvIQfjg+KJdPxeUqlyLktMU0JiSPXM1fZ9uaYxf
         yjDNkjFW04rgoVdIvRMYkzrfju9s/4JJqXeRDjTXlQfeNilXQYdBMML/beb6XeDnDFAG
         94RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3BindVbIcEpTBEEDDp7VbSsrPex7xUuc+AbIS6NQwM8=;
        b=pHbapX1ckqGLhXF104cGqmjK0nlPinAafaTEK19S8UIZ4hQe67Lc+w15WWCgO6jW+V
         BXUBGSyz6LsZAKbutLukac8D9TbOMOUcpXoU+PdOZP6/ZXNBWenKT8GIGEMfnzw/xH75
         vhnUd4KFcWdv43yamD5vQL0uCgv7sNYMFWBhZgsfu5ebR1CEY6hqs7r/kEMHlmwt2nvn
         Oa7Uxezu/Cghgeqaox0Yg672KKwFDc6NCaiqDif3+o6dYEnHuX5w0OybQMSfP4pWStKe
         C474ivJOKPe/sw8VW9ejHypbwc3HtIfGStoYHo14jizkHr/2ZhP66re4lVBPxl8gv78N
         RWCQ==
X-Gm-Message-State: APjAAAXCtfrOPTEgyI39rG9xFrRDuEZWbJheyZFXf99kXTgePIo8elV5
        ElT0Yf1DfvMHd5dt22VnQq0Rsu5u
X-Google-Smtp-Source: APXvYqzM/TEehzjmWnTgMZIAz6DDmP0OYJZdESjofbsWnuTmo9s0fLSpHeDzCXIaQnJRTtApazR8dg==
X-Received: by 2002:a50:ad1a:: with SMTP id y26mr92090398edc.86.1560978358882;
        Wed, 19 Jun 2019 14:05:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dc1sm3406508ejb.39.2019.06.19.14.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:05:58 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:05:58 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:38 GMT
Message-Id: <90ac088d22359de9c86e7e5ee54cfb59071b1cff.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 04/20] cache-tree/blame: avoid reusing the DEBUG constant
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

In MS Visual C, the `DEBUG` constant is set automatically whenever
compiling with debug information.

This is clearly not what was intended in `cache-tree.c` nor in
`builtin/blame.c`, so let's use a less ambiguous name there.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/blame.c |  6 +++---
 cache-tree.c    | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 21cde57e71..50e3d4a265 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -59,8 +59,8 @@ static size_t blame_date_width;
 
 static struct string_list mailmap = STRING_LIST_INIT_NODUP;
 
-#ifndef DEBUG
-#define DEBUG 0
+#ifndef DEBUG_BLAME
+#define DEBUG_BLAME 0
 #endif
 
 static unsigned blame_move_score;
@@ -1062,7 +1062,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	if (blame_copy_score)
 		sb.copy_score = blame_copy_score;
 
-	sb.debug = DEBUG;
+	sb.debug = DEBUG_BLAME;
 	sb.on_sanity_fail = &sanity_check_on_fail;
 
 	sb.show_root = show_root;
diff --git a/cache-tree.c b/cache-tree.c
index b13bfaf71e..706ffcf188 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -6,8 +6,8 @@
 #include "object-store.h"
 #include "replace-object.h"
 
-#ifndef DEBUG
-#define DEBUG 0
+#ifndef DEBUG_CACHE_TREE
+#define DEBUG_CACHE_TREE 0
 #endif
 
 struct cache_tree *cache_tree(void)
@@ -111,7 +111,7 @@ static int do_invalidate_path(struct cache_tree *it, const char *path)
 	int namelen;
 	struct cache_tree_sub *down;
 
-#if DEBUG
+#if DEBUG_CACHE_TREE
 	fprintf(stderr, "cache-tree invalidate <%s>\n", path);
 #endif
 
@@ -398,7 +398,7 @@ static int update_one(struct cache_tree *it,
 		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0');
 		strbuf_add(&buffer, oid->hash, the_hash_algo->rawsz);
 
-#if DEBUG
+#if DEBUG_CACHE_TREE
 		fprintf(stderr, "cache-tree update-one %o %.*s\n",
 			mode, entlen, path + baselen);
 #endif
@@ -421,7 +421,7 @@ static int update_one(struct cache_tree *it,
 
 	strbuf_release(&buffer);
 	it->entry_count = to_invalidate ? -1 : i - *skip_count;
-#if DEBUG
+#if DEBUG_CACHE_TREE
 	fprintf(stderr, "cache-tree update-one (%d ent, %d subtree) %s\n",
 		it->entry_count, it->subtree_nr,
 		oid_to_hex(&it->oid));
@@ -462,7 +462,7 @@ static void write_one(struct strbuf *buffer, struct cache_tree *it,
 	strbuf_add(buffer, path, pathlen);
 	strbuf_addf(buffer, "%c%d %d\n", 0, it->entry_count, it->subtree_nr);
 
-#if DEBUG
+#if DEBUG_CACHE_TREE
 	if (0 <= it->entry_count)
 		fprintf(stderr, "cache-tree <%.*s> (%d ent, %d subtree) %s\n",
 			pathlen, path, it->entry_count, it->subtree_nr,
@@ -536,7 +536,7 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 		size -= rawsz;
 	}
 
-#if DEBUG
+#if DEBUG_CACHE_TREE
 	if (0 <= it->entry_count)
 		fprintf(stderr, "cache-tree <%s> (%d ent, %d subtree) %s\n",
 			*buffer, it->entry_count, subtree_nr,
-- 
gitgitgadget

