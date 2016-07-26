Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72390203E1
	for <e@80x24.org>; Tue, 26 Jul 2016 07:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572AbcGZHsj (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 03:48:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33033 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418AbcGZHsh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 03:48:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so343506wme.0
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 00:48:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8LL0R6hQ63BrTtl9lXTc8wZFgY+0eQGug7UsfAOE0tI=;
        b=uYt1sZqcIukjnn4CjkaY4BWJflKWPTrQp3RGLFhUmPCvYWm9JF8+L7oDaONDGgoJdw
         Hkld9vcZ1wh8NXDL6OegsJcYEkU4ksVUCU2eCG9Y+kcBtdIN5+HbEnRmrkBwyveuRe32
         QT2kkb5uyDv3uFf/afSbbPZSwlueXbmKyITJEIx8UMtBPg4tYRllv+ArN9/cCrJjiJRx
         4VvzTH6fMfO1AQKIlUaFcbDizeHNLj6dMb+Wexcyrn+pZDaRpOqO8whc2vf5tPQsgCgY
         8NccPan7YF16a59w14p2AfawMWeHQODAQVnQkWUyqGQtCqTvLGJhp8P4MGQg+ecaPf53
         /uBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8LL0R6hQ63BrTtl9lXTc8wZFgY+0eQGug7UsfAOE0tI=;
        b=DSSbceGPNs3aPqGeK48yDOCcWxrRwPsxPyo/kxdUt5R5UvfbHH2a4pdyTnwNqGILJ1
         Vbp18Va9MSbNtA8cJ1/cunCArSJB7wOtBRHYqR65IBAoyQKi9Q6BYS3cJWLIv37SRyVu
         YSMjy9VN3cYVgZQwJEWlDvxABDbw6MlEdNgAQZONfA4tVgxscNjEqv1gP/gjkxqfbOGT
         pQPT+/e92mbvlY+HDSiM9eNZ2kyHywZ4vzIFda/jglgZlQ00VyiGZqSdZMbAMQD9mUzA
         ZzXv2PZCGxvpTT/hpbvSZnB7HfFUl5c6PDby4zLW8hEJ9IL3A8f7kOD6wJLGhjKikQgf
         lToQ==
X-Gm-Message-State: AEkoouu/ghrPdz+KTeslJC3M/60VOkhsLcfMCDtETaKy0SpHSa75OLf0MmZBZ8J8paoFHQ==
X-Received: by 10.28.32.77 with SMTP id g74mr22657124wmg.45.1469519316224;
        Tue, 26 Jul 2016 00:48:36 -0700 (PDT)
Received: from localhost.localdomain ([95.86.71.62])
        by smtp.gmail.com with ESMTPSA id p83sm157762wma.18.2016.07.26.00.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jul 2016 00:48:33 -0700 (PDT)
From:	Orgad Shaneh <orgads@gmail.com>
X-Google-Original-From:	Orgad Shaneh <orgad.shaneh@audiocodes.com>
To:	git@vger.kernel.org
Cc:	Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] commit: Fix description of no-verify
Date:	Tue, 26 Jul 2016 10:48:25 +0300
Message-Id: <1469519305-11361-1-git-send-email-orgad.shaneh@audiocodes.com>
X-Mailer: git-send-email 2.8.1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

include also commit-msg hook.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 163dbca..2725712 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1616,7 +1616,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "interactive", &interactive, N_("interactively add files")),
 		OPT_BOOL('p', "patch", &patch_interactive, N_("interactively add changes")),
 		OPT_BOOL('o', "only", &only, N_("commit only specified files")),
-		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit hook")),
+		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit and commit-msg hooks")),
 		OPT_BOOL(0, "dry-run", &dry_run, N_("show what would be committed")),
 		OPT_SET_INT(0, "short", &status_format, N_("show status concisely"),
 			    STATUS_FORMAT_SHORT),
-- 
2.8.2

