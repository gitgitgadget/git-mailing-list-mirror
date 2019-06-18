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
	by dcvr.yhbt.net (Postfix) with ESMTP id 527031F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfFRMYE (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:24:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37219 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfFRMX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:23:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so21474954eds.4
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KUoJ+UAAZHH8tlelUr0P8mSiA+QhsYQzdWUhkSBAxRE=;
        b=ZKOS7i2Kstd+zIXzey02JNCGKPwSXHzIfCgoJrniE9+V8BU0+vN0YY0TRtAF0zidLG
         1wo+nD2BRvcYsLc7eU/iCBwj7gOk37odt4kw5hKhiCAd28MnMgrAd6TC8YTNRw/H9QIb
         Gq/7uXNIgrhY/McWqusM62RUJtMTJ9LqRhAW+2Il3jrPqmYyqkt2I1tSioTKQr0yaqqK
         eJYAWDsPfEB5LKcC8KkZz0WZ/4OOdu7Pv2XxVStU7/HqpdnFq3YPedQNZOLNc48vWGHh
         6TnyS/S1A1KX4duwPF5xH4v5WBaDCBwSKua2KIHm0ZLbBJt5hB1zi8jNXYtshSVvYF6S
         AVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KUoJ+UAAZHH8tlelUr0P8mSiA+QhsYQzdWUhkSBAxRE=;
        b=ONjtUrziDyMgpUxnvHqKdPx1ORZ3AcBq29wBt3qg8sXUJdOhBla9OxrWiioUfmvNZx
         0l813wzCPCT4jXK5IFdFkC4t3FxY8RRU3kOtbXbnyt8rC9n6ETeEKyCUZKKrx7CJSSG4
         ViFDv/rDlcQHYmeziMaq3X1ENDfcv05xEQx6Ygoe4XYQKBxlmUdCYmdrTGesSyjuE9Dl
         3SuMJDYEuYynewgTtjUZPo4HnrVb7QyG0I4eA+TQUQPpe2OPh/I6JX5bL7EHuQVjcLn9
         Rj4X0NFgO5CfNktEeqbNKs18uOzKJeMGPGPEyNNLG6O+f++LgNP+XPH8zcpPGb1PYuK4
         T8Zw==
X-Gm-Message-State: APjAAAWUTLRajb3+L1I+Idx97nRwA//UsJOJx1AyEzBJP/IRpMFeQZWL
        BQR7it/Ee1XPd+zvjupbJZrUGDG0
X-Google-Smtp-Source: APXvYqzYgQeEznx7mP3R5Qyx9LTTMY0kU1NrJhc7DJg0PrBZ6fcEPQvpF5Si3YdY/Mbo/5/m3A32cw==
X-Received: by 2002:a50:87d0:: with SMTP id 16mr72143196edz.133.1560860638283;
        Tue, 18 Jun 2019 05:23:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j25sm4521526edq.68.2019.06.18.05.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:23:57 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:23:57 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:40 GMT
Message-Id: <486297ec8c146e0ed47cd1dd8fe8f6496c2b54c2.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 03/17] cache-tree.c: avoid reusing the DEBUG constant
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

In MSVC, the DEBUG constant is set automatically whenever compiling with
debug information.

This is clearly not what was intended in cache-tree.c, so let's use a less
ambiguous constant there.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache-tree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

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

