Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23E6D1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbcLFVxb (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:31 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35611 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbcLFVxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:13 -0500
Received: by mail-pg0-f53.google.com with SMTP id p66so153557505pga.2
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hcwXeqPC/qkrTmNkCUGtoTK335IRbn5Kzd5xdRltJdw=;
        b=kYA+/VwCN/1kEKf7O09cXhm5nruso75oyVNgGAtR9da8O3ijkLUZ5aQVGA6zKuvJZe
         z0CPvx8aZSwm3Oee+Z3Z2hK/F3IwscGoo9jufZErwCqAqXKRmO5XcZisCETtEJrAM7IT
         kh81c9Bc7UmuHnbWTRCJ3hfpMC82NGQUYhDmhEMhOFz2yPVsO2bSf7fgIGeG8Ylu0K3R
         Wio3QIBvbvKhhcEalPZ8klHWfHw6QGSAas5Ih87PGhW5Ti5zMR4cTByZl1f7k4hmlxzY
         6r6rev4e2+mZhFrcJ56EnnSL3H8Ry+mqGb4BaFlb/rxZNGqFOYEBySghh7lQeyWBdIf1
         rIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hcwXeqPC/qkrTmNkCUGtoTK335IRbn5Kzd5xdRltJdw=;
        b=Y5iPEGVal9CFEn5K/5bnJt7dll/4qa5Kj1VaX3ZMNyo8pZKM+Xt0LlC0DgRDHcjJlB
         py2fz/8ptodJjIhRG0cHDreo9MBtUHpvj0rK6OGpxW+sZT3555XAc19gJGbzbXQnCMMI
         pG14PQjgTLL2tBuveEHq8L9sXoNqU87bZ9X89avrNC6FJKf8OOlgm1M8rC53k9ABD0xu
         wfMX9XxeigMAVwhFLHCJhCX5xHn5/IIghpvs4pyjlznKN1PMqIKvIimD/+m/USHVnKSA
         73J0rFpGCCAfuzPs/Syk0A58LgyTcQgcx8+cXqYszUjVI3T4zEQp/cDUPitlqO0HdGgD
         /7nw==
X-Gm-Message-State: AKaTC01czYaPmbYEyTbtj/v2+1dYbnA6iRvermc+es5rLfqvaUPOT7TQ/f4Ab1jORw6KDtHM
X-Received: by 10.98.35.5 with SMTP id j5mr64736745pfj.91.1481061159399;
        Tue, 06 Dec 2016 13:52:39 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:38 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 17/17] pathspec: remove outdated comment
Date:   Tue,  6 Dec 2016 13:51:46 -0800
Message-Id: <1481061106-117775-18-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove part of the function header comment to prefix_pathspec as it is
no longer relevant.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 8a07b02..66db257 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -298,15 +298,6 @@ static void strip_submodule_slash_expensive(struct pathspec_item *item)
 /*
  * Take an element of a pathspec and check for magic signatures.
  * Append the result to the prefix. Return the magic bitmap.
- *
- * For now, we only parse the syntax and throw out anything other than
- * "top" magic.
- *
- * NEEDSWORK: This needs to be rewritten when we start migrating
- * get_pathspec() users to use the "struct pathspec" interface.  For
- * example, a pathspec element may be marked as case-insensitive, but
- * the prefix part must always match literally, and a single stupid
- * string cannot express such a case.
  */
 static unsigned prefix_pathspec(struct pathspec_item *item,
 				unsigned flags,
-- 
2.8.0.rc3.226.g39d4020

