Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185431F516
	for <e@80x24.org>; Tue,  3 Jul 2018 03:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeGCD6k (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 23:58:40 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:37813 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753788AbeGCD6i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 23:58:38 -0400
Received: by mail-yb0-f176.google.com with SMTP id r3-v6so207605ybo.4
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 20:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ePvToOFgkzUzPRD8oLwimBpnqV01pqqKoyKCNUbMdBA=;
        b=JVECcuP+zmn6Vb7jgoAJov8YujUL6WAXluFPizwofvtX8/+RFnqARJPHa2MTPsuLzh
         ROPOw4vG09QHEw4FZqbvIgyrPh+gDqKWAEy15P6BKukkqvI52bYwEdRnU5Usx/VyhEEQ
         +4mYvdyfsx3iurMP4eWkV+SgIHp6M0PHc9fpdL3L9pSMO9C36dVlZ2HqOTwRFozftInO
         lyQZ3OapNKOqXiQlYnSFZWyquJOIKyr6i4D32VoLcY+N3mQuE0h8KMI21SS9ScmEvoE3
         MlHxe5UXr6JwoB8sfdUHPYjU/rZtPru5BmTwH0Xg+83mRkZjZ6BQAhSI49mrsNJt36Lc
         v74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ePvToOFgkzUzPRD8oLwimBpnqV01pqqKoyKCNUbMdBA=;
        b=LfJMrzt1PefkxYmkn23Q7s2b1cM4msAKGkY8Wu2o0GY2hfmnBlz1YBwXIxVsYB75Sw
         zUJQA5bhcqWP6NYjrjZvtgfopKqn6Tae4w9Kj7n7hEAh+pkp3yp2e3dPuEMffiaINqSi
         T5/7XtXowj8L4m5O9hxfiIaVMu7i6MRI0cs45OzdCXwWolSOXKFrEqBnglrkFp6/XAf6
         Gb35It2LIzfuLYXn+/L/ognHtFAkGPZVSyo3INbvIeF8u5WnB2+n/vmJR30jxPPni9Dx
         5hQlxz0FPtKKg85XkJRYR56XZOaRG4745YbQkP0ABMbJ0bts1VGDQOKxzIkCFYc/C2E/
         37Mw==
X-Gm-Message-State: APt69E3zD7CJrpfMP/qcepZ53KC7neRDd/ypOIn/LAlqu97U5U/ZdgV6
        jEWwYOe9ZBqH3iJvkAqFIVFyjfJt
X-Google-Smtp-Source: ADUXVKLlIC/bte8NMqz6jssEJGVb7CbygTAwmtlQ5vcuHBnFedqXh6YTpthy71HAQofSoLGwcJDMuA==
X-Received: by 2002:a25:5a04:: with SMTP id o4-v6mr14291072ybb.196.1530590317352;
        Mon, 02 Jul 2018 20:58:37 -0700 (PDT)
Received: from localhost.localdomain ([70.63.112.210])
        by smtp.gmail.com with ESMTPSA id q131-v6sm97262ywq.8.2018.07.02.20.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 20:58:36 -0700 (PDT)
From:   Joshua Nelson <jyn514@gmail.com>
To:     git@vger.kernel.org
Cc:     Joshua Nelson <jyn514@gmail.com>
Subject: [PATCH 2/3] ls-tree: update usage info
Date:   Mon,  2 Jul 2018 23:58:01 -0400
Message-Id: <20180703035802.24060-2-jyn514@gmail.com>
X-Mailer: git-send-email 2.18.GIT
In-Reply-To: <20180703035802.24060-1-jyn514@gmail.com>
References: <20180703035802.24060-1-jyn514@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

show [tree-ish] and [--] as optional
---
 builtin/ls-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git builtin/ls-tree.c builtin/ls-tree.c
index 14102b052..c5649b09c 100644
--- builtin/ls-tree.c
+++ builtin/ls-tree.c
@@ -26,7 +26,7 @@ static int chomp_prefix;
 static const char *ls_tree_prefix;
 
 static const  char * const ls_tree_usage[] = {
-	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
+	N_("git ls-tree [<options>] [tree-ish] [--] [<path>...]"),
 	NULL
 };
 
-- 
2.18.GIT

