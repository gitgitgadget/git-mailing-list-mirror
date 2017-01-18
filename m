Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E79411F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 23:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751705AbdARXb3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 18:31:29 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34622 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbdARXb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 18:31:27 -0500
Received: by mail-pf0-f174.google.com with SMTP id e4so7858289pfg.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 15:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J9J0KcKBzjOHfU4HvjU62D0wzvHCmOc65l3vRMUOOd8=;
        b=c4ZL3M4sHp20AnwE+KnI5gGOmt9rT+2imfYZdpkjVTFBADpzvm5J1/0cILTACXV7QR
         txWcsIZbYhW/2/owwXTEyzd7KOctUR5l0a5VQEzuyqonpaFH4LnzMwAqGSm0+Kn5xQS4
         KCruko7SMkPG5L0/eDBkz2YxkZipXu5xVmmB/vTcsMHJmhF9XG1sY2mSjx4Fv4h4HrMc
         Xp8if2tIYmIm/08bdb43rf9PPpc9a2ZjMvXszpta3Yvl69/ncpu/IpUK08UWP2YLx45v
         kfK8/fyEnMj86Du6fyDqZ8VkfOXYPOz3d5la3tWdYMwPUSQw7smzhsaiFMH2sDkJqSVn
         Wb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J9J0KcKBzjOHfU4HvjU62D0wzvHCmOc65l3vRMUOOd8=;
        b=A2dcC5LAxGqhhnjOKvMIiuTtLCvjw6FJJJP5D4cyz4PY6BX2m/P5xjzbw6hEM+8dXM
         +4bUDSEHV6wL6RR2YtmiegTuU81PB4EV3fD+IkckiImYgey6e154AiDcST+7D3oG/eO1
         CKBEUu+ATDnY2E+ywjJyw9Bml4TpIGgrMzVNxfqqsRsZB35qWTKB3l07s2ysX8ZX53hB
         xUoQO2g/H7Wfq3sDNA5Wd28UYbNrhyV7WySQ9ApCGIoNJjJ+kKG9Fad/H8uBvdR8yTQA
         jnL7dHsZ9Rkj0Dgd5PKJK9yHIfeF2UWSTaPsrAjeINsSnQMrr9Z28UuwwotVSsqLoEDS
         o36Q==
X-Gm-Message-State: AIkVDXL8EEuwWMwmM8yC5dnyjg/itrG344sTwtya/FqKCj5JirkD/5HslOP41vyhoTOhM7mR
X-Received: by 10.99.47.199 with SMTP id v190mr6904244pgv.26.1484781725194;
        Wed, 18 Jan 2017 15:22:05 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:40e0:b9ca:546a:a0ec])
        by smtp.gmail.com with ESMTPSA id z77sm3191072pfk.47.2017.01.18.15.22.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Jan 2017 15:22:04 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 4/4] documentation: retire unfinished documentation
Date:   Wed, 18 Jan 2017 15:21:45 -0800
Message-Id: <20170118232145.31606-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.299.g762782ba8a
In-Reply-To: <20170118232145.31606-1-sbeller@google.com>
References: <20170117233503.27137-1-sbeller@google.com>
 <20170118232145.31606-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When looking for documentation for a specific function, you may be tempted
to run

  git -C Documentation grep index_name_pos

only to find the file technical/api-in-core-index.txt, which doesn't
help for understanding the given function. It would be better to not find
these functions in the documentation, such that people directly dive into
the code instead.

In the previous patches we have documented
* index_name_pos()
* remove_index_entry_at()
* add_[file_]to_index()
in cache.h

We already have documentation for:
* add_index_entry()
* read_index()

Which leaves us with a TODO for:
* cache -> the_index macros
* refresh_index()
* discard_index()
* ie_match_stat() and ie_modified(); how they are different and when to
  use which.
* write_index() that was renamed to write_locked_index
* cache_tree_invalidate_path()
* cache_tree_update()

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-in-core-index.txt | 21 ---------------------
 1 file changed, 21 deletions(-)
 delete mode 100644 Documentation/technical/api-in-core-index.txt

diff --git a/Documentation/technical/api-in-core-index.txt b/Documentation/technical/api-in-core-index.txt
deleted file mode 100644
index adbdbf5d75..0000000000
--- a/Documentation/technical/api-in-core-index.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-in-core index API
-=================
-
-Talk about <read-cache.c> and <cache-tree.c>, things like:
-
-* cache -> the_index macros
-* read_index()
-* write_index()
-* ie_match_stat() and ie_modified(); how they are different and when to
-  use which.
-* index_name_pos()
-* remove_index_entry_at()
-* remove_file_from_index()
-* add_file_to_index()
-* add_index_entry()
-* refresh_index()
-* discard_index()
-* cache_tree_invalidate_path()
-* cache_tree_update()
-
-(JC, Linus)
-- 
2.11.0.299.g762782ba8a

