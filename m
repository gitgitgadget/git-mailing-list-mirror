Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D37851F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 22:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390491AbeGKWt0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 18:49:26 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:41408 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388030AbeGKWtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 18:49:25 -0400
Received: by mail-yw0-f202.google.com with SMTP id c204-v6so20981621ywa.8
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 15:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=X2zjoEnicH2bXdli0EjfqgI0Exn7Qnju2fLVq5dLeAw=;
        b=PBiaQRClsyGkiLhtT1AnrofhHbCtSUWpQD8B2o9xNM7NQ9yg8aXUc5psbxopjJtkBA
         dKI0XfiGmgZTV8QghF9IxkE+LTwjIM6G0pGR06M52ToCxESNHymOLRH8rvYGtMYl0gQd
         gyHIXU1JijLvXRV2UMLlyBAS+cxnAlxeuE6QKIcJyMUxGD5rleQGHysm3dc3UM5UW5Lp
         jjB6hScv/4WTfnGpkpGx7JJulSLihXUjMoVY1vrnV2RKvJw+TdTiGAN1PRI5fN/DSo4S
         WLL8MH9w8s92RKPyrQOF+8hEbWrl1Z9PTZfvuSngrwgyLXDglri4zrpt2gk4cic/jnEB
         Rr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=X2zjoEnicH2bXdli0EjfqgI0Exn7Qnju2fLVq5dLeAw=;
        b=pD4SzVYd8fWS62sKnADlZPppIalsJKp7EiucTVLLpNrRi2DousHKZ+aquiL74Rvo28
         AoAKzqCAOtyJBCBynT31XzwVO/48mNr2LCaQXyRQYibVB8L8O4c+9mHNXZTCA3o26cCv
         EM0E/M3cyS6q9R5jsM8C6b8ZKzWuq9a/s9TEXkcR+Oxotb5002vr2ahU9lU+0ZiOWpHY
         qhY8HXGcFeXfRyhS/rXvAt21UeDM6f9srtCsrlcx2Go1gwmbCBi9pIvDGRdHADeu3dEo
         WcHgSalmC1Lo9VPwnK2OB1/oeotXqe3cGg3D/YlagygmSTMNSwcO9IwCYnkRfQjHUIVM
         btIA==
X-Gm-Message-State: AOUpUlFrPkcZGXpVxdy0RxwKCunqnnVU70fOpOcdEd6IU1VCPytWNcvr
        GbHhOwo+en5bdn35skc9YHJ/dGvffhNKc+GXQG9ZI4/xOrjoMXTPGUixzV3vrnUKIjr+5kMLp4X
        /Fn0NaDZ84Y4HqWtpW6LIslV+vFOHdtHFNAmM/5Z66DROwqB/R1oN++8bBa+4Oe3gud8jNkQPXF
        jz
X-Google-Smtp-Source: AAOMgpci7XFLVspWNyyYzyA9xcmNbUEXyHj6Buf5FrmkTgPZXUduPtY81IAJt8mJcGP3i6D+KP72p3m56k5b/U3DKXW+
MIME-Version: 1.0
X-Received: by 2002:a81:7cd5:: with SMTP id x204-v6mr215453ywc.94.1531348974970;
 Wed, 11 Jul 2018 15:42:54 -0700 (PDT)
Date:   Wed, 11 Jul 2018 15:42:39 -0700
In-Reply-To: <cover.1531348540.git.jonathantanmy@google.com>
Message-Id: <3f5988895ff97818e1b30ffd301ef2d1b940d05c.1531348540.git.jonathantanmy@google.com>
References: <cover.1529616356.git.jonathantanmy@google.com> <cover.1531348540.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v3 3/6] commit-graph: add missing forward declaration
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
 commit-graph.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/commit-graph.h b/commit-graph.h
index 506cb45fb1..674052bef4 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -5,6 +5,8 @@
 #include "repository.h"
 #include "string-list.h"
 
+struct commit;
+
 char *get_commit_graph_filename(const char *obj_dir);
 
 /*
-- 
2.18.0.203.gfac676dfb9-goog

