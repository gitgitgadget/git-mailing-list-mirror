Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD771FAAD
	for <e@80x24.org>; Sat, 28 Jan 2017 02:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbdA1CCl (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:02:41 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33191 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbdA1CCh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:37 -0500
Received: by mail-pg0-f45.google.com with SMTP id 204so85673079pge.0
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/sJRbbmVtGS2HRaOoFw7y0W5NKGXrZH7pVvwKVuqITw=;
        b=YmaEHTiRWgvGon/sj6jb5zn4HOqGTkjGA7jgnOVeT8EUL8PcOa9tgL63h09qfridCV
         Az34ewIE6GAwyIaf/FhNbo9snzDASYu+ZQd+IAcasgLzKkhcZT+f92j7cD2y4PwhILrI
         BjFU81dnkr3fJNlC6aCeAcqfqlk7hMiTP07q4dpTlorMq4/fa4wGpIIJmtohDysi2KW4
         Qff9zDJ4kGWVfG2KbQt19w1/se9ohF1C2/giYQVIUbr039iOrxV667PUR5gHY6xw6Dfs
         /pRm5k8HFis0zZelwmOy8eu3d2sX4e1mwI6STqV8zdV/1CbRcdmBKBJU5E2qL/X7Yb2o
         sTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/sJRbbmVtGS2HRaOoFw7y0W5NKGXrZH7pVvwKVuqITw=;
        b=G5MaJYd/6fFxhcbnpN+nj0HcVAGN+AFW6ESBWWtC/SMlTLCbO68CtHb1XpVdCklCdI
         d4Z2sfkCsUBfzngD6dzFmB8C/27G3fGhHZCzjWhMXUIEau+GxnI7UH9rUGVITFzpUiQ4
         CyNGlM2vKJQ/I/O0o1bPMo55qb2B+Rwrpc/D0MCVnI55vx6aXbJnhYnlTaO+CsJRU9x4
         reHjzLFQqVm0aK+03WuDwDFMlI2VXd3G7rzAevL+VYwOA6HHQtUNexAsKkSgyrf9hTr2
         oreHBIgHFGgESg2U+aVn6uDIBaLnqHlVT8+zEv03KIhFSx9kS1kU7WSPm5o26pqQ5s3T
         oGVw==
X-Gm-Message-State: AIkVDXIMzHBnJj9mqWK19dnw330olz27ujYxvvvm51o9KfIvJR/9zOEa7BVb5KGpYLe1cBJd
X-Received: by 10.84.168.3 with SMTP id e3mr16513770plb.144.1485568952061;
        Fri, 27 Jan 2017 18:02:32 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:30 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 03/27] attr.c: update a stale comment on "struct match_attr"
Date:   Fri, 27 Jan 2017 18:01:43 -0800
Message-Id: <20170128020207.179015-4-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

When 82dce998 (attr: more matching optimizations from .gitignore,
2012-10-15) changed a pointer to a string "*pattern" into an
embedded "struct pattern" in struct match_attr, it forgot to update
the comment that describes the structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 04d24334e..007f1a299 100644
--- a/attr.c
+++ b/attr.c
@@ -131,9 +131,8 @@ struct pattern {
  * If is_macro is true, then u.attr is a pointer to the git_attr being
  * defined.
  *
- * If is_macro is false, then u.pattern points at the filename pattern
- * to which the rule applies.  (The memory pointed to is part of the
- * memory block allocated for the match_attr instance.)
+ * If is_macro is false, then u.pat is the filename pattern to which the
+ * rule applies.
  *
  * In either case, num_attr is the number of attributes affected by
  * this rule, and state is an array listing them.  The attributes are
-- 
2.11.0.483.g087da7b7c-goog

