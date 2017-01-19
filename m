Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F1761F89C
	for <e@80x24.org>; Thu, 19 Jan 2017 03:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbdASDTJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 22:19:09 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35454 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbdASDTF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 22:19:05 -0500
Received: by mail-pg0-f41.google.com with SMTP id 194so9914291pgd.2
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 19:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J9J0KcKBzjOHfU4HvjU62D0wzvHCmOc65l3vRMUOOd8=;
        b=wDJn9ZbnY6OxpkwVPw+xpFSBriiqysfiA9KNQVCQkn2rg6QKEQ6TVx93skIHXC0U8h
         3QHmtie1TASnZoROq1ryniGeVZoEeTb50TdsbFe3Li8TvFbPgjTuFvK03TxhNmffcOo3
         NbUNYzpXBzwudVrxsa5RJBkmwwlLKwCdkcqOWzVPfhbvitK6WVbAJDFUmKcEsXb4N9xf
         s05eifZLlgVqTq5fxE3TQhWRPRe2GHxF0xd38K7Sx0f9tC4lLGNzzfrv7WQuN7gs0mBq
         xrxfBKpWWLfqQ09CwAOo5wu4rBmACLr66jtzlCROol29VQkB9F1J08OgXf7Gz5FDciB5
         I9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J9J0KcKBzjOHfU4HvjU62D0wzvHCmOc65l3vRMUOOd8=;
        b=EuJKwcKhVAm4Do6UP76myuNDxbaePE6Khu3cBHIcHz4mID++0QzcqSdIqh9ZHIaO/4
         jGhXj1ldupjHut9XQsCg89it5GmKBCtvtr8ErddbdPEYZFxwqoYoKuukf5hKPcmGmRsZ
         2hpFK6uTxHpBtzuDlNcJJ6NatxKpfhcIAhui6VxpCmdJJ+tTV37w5KEFH72TQCuORDNk
         RQpjm5IMDhonzOT3s4KJ1qI1j8EcDrpBv1msVu6GeG4LH+JRapt5qT2zcMZh5d8tzMqp
         Z+9OW2ek7DC9HjbozFd0bGNw0VtdjBV7gFkWdSVeO+I+BquCMg2QRX2fOwuFK3cB7/gl
         ZvYA==
X-Gm-Message-State: AIkVDXLIZbv3Avati3d+cTRiDkisJw+rDvztwCHDX4RtD6MzERIFKYHHbMf3uRw4MSSYN8zf
X-Received: by 10.84.128.67 with SMTP id 61mr9911991pla.153.1484795944490;
        Wed, 18 Jan 2017 19:19:04 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:40e0:b9ca:546a:a0ec])
        by smtp.gmail.com with ESMTPSA id p26sm510890pgn.39.2017.01.18.19.19.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Jan 2017 19:19:03 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 4/4] documentation: retire unfinished documentation
Date:   Wed, 18 Jan 2017 19:18:54 -0800
Message-Id: <20170119031854.4570-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.299.g762782ba8a
In-Reply-To: <20170119031854.4570-1-sbeller@google.com>
References: <20170118232145.31606-2-sbeller@google.com>
 <20170119031854.4570-1-sbeller@google.com>
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

