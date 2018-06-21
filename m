Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2B01F516
	for <e@80x24.org>; Thu, 21 Jun 2018 21:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933831AbeFUV3e (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 17:29:34 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:53502 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933745AbeFUV3c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:32 -0400
Received: by mail-qt0-f202.google.com with SMTP id x16-v6so3618390qto.20
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 14:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ip55qi/SOCTpuZNxGafax/y0EMOarFUp7v7hGlmCnzA=;
        b=E/bbY91Xuobb8jMBwETB52xn6Le7xK9/15Ie4H1TG9tzy99rx4iZ1Et7smagU5ztZ8
         hUgwelQyzIUtBS2WtojU8P4kuuxliRjaSir9hRo+75QQTxb26VYiq5FBmt3i/FTe8TT1
         yURVIiAqlVn7n3CaCr4oE4jRt8SyDgEVt8uMfMdDBP9tZsJqhS12VoCYkig9U8uPCTBZ
         8vX2NndH0B0uKL4qB+HUpFPpcrerAgiqrQ6c1DdzqpYzX98lTk+7p8+zp3MUZJjk7S7q
         jvttpScfV6krgOqLF1No7eIGe7y1H3KPi8pWkJIhXSEIPnkjIKUB/c4SJ33OBMKcoV2b
         q3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ip55qi/SOCTpuZNxGafax/y0EMOarFUp7v7hGlmCnzA=;
        b=gY4aIHRFLq4Bicn+r/WTOAppDUEiNEfUFy4+ogX3EH/lde6DuXMep/0tblLs22lMoe
         hWcCbr5GJj2qcnZ8nF3hUsCbjJot1pAMewroHW2SEUUGKVHRxI58KxQ/PzouuR1HZFxl
         D3E8oR/OyS96xP8d/w6TfpmnvfuCZKXaqwbzlNE1ChPucubb6YuYsxJOw9mFBAKMp+EG
         AOBISROruivUwiFH+gaWIMRfa0/ybsnYOOwZDAnsxUrLxrQuDo02mdwfjFyayywHNxzZ
         PXqpgqmnex78y/kNBikP+aAW2eI6ExVuucr6JfwbsKYS6N4TJaI1M04BDPuLRpmWv7hd
         s6cw==
X-Gm-Message-State: APt69E399JTOoc/N/QtpVwxULqa2E6+FpMLuwck8+F7YwHPeSADXloXP
        7LXOpQr8UEUXiPH2bgUQvLQYmbmzA1sKkjIb60PlLfOpV/W/uxd0StdpRVYqwkgUIM/pCrC8+tw
        b1JTxTH6PmkZFTITqfliG4vHVfVKNfHFFgTJmsMwV6un98LgL6Tdl+gxD9dSop0rBttOev0EOp0
        G0
X-Google-Smtp-Source: ADUXVKItGuITAqkN4ud9cRLVhB7lG9EoAh7wpWgi3w0e6synUT/CiBKDZdVzIdEw9Dx8LLGgJfUqGvlEGSzV4Ph+NqWG
MIME-Version: 1.0
X-Received: by 2002:a37:61d8:: with SMTP id v207-v6mr5064406qkb.59.1529616571179;
 Thu, 21 Jun 2018 14:29:31 -0700 (PDT)
Date:   Thu, 21 Jun 2018 14:29:21 -0700
In-Reply-To: <cover.1529616356.git.jonathantanmy@google.com>
Message-Id: <d8daccadb7eeb90f024b027a8a0c5ea86a7c179b.1529616356.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: [PATCH 1/5] object-store: add missing include
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-store.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/object-store.h b/object-store.h
index d683112fd7..f0b77146e4 100644
--- a/object-store.h
+++ b/object-store.h
@@ -2,6 +2,9 @@
 #define OBJECT_STORE_H
 
 #include "oidmap.h"
+#include "list.h"
+#include "sha1-array.h"
+#include "strbuf.h"
 
 struct alternate_object_database {
 	struct alternate_object_database *next;
-- 
2.18.0.rc2.347.g0da03f3a46.dirty

