Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9C5820451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbcLMXQm (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:16:42 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35537 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbcLMXQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:16:31 -0500
Received: by mail-pg0-f47.google.com with SMTP id p66so768883pga.2
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 15:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v1YS/J83Eu5nrPHDPpheoNGguZg0ZukbHxQjRUh1nnc=;
        b=Ldt4M2uPAlHaJP2kNoy6h54HswO6//N05AX2gtoL803pQhI5MvP9gimbQkWhYndBvA
         oQ396Idjct7J0f+WUxZ8OnCNR/MeIIKXZgLQc5Lh9iJbvb8yQl7nEL4hj1jQaq73MH0V
         WU5u5IOA+jUrxL/gLCvveyCym+hcd9/fgsUGy1Rf/2EiolhUlIr0zKKnLV7FYHcLKVwO
         lU8cQNmZQRmTbQvaVvWQstWi30EtSwx0ZbnDLPq6n2KlKVQTQIdDMaU7Py4rcbDWyYVl
         JZPtOb8CT/OQgLG59TdxzwUAWzvAaITS7hxjEsA5ux5wTPiUIR/Kn0p7erUyQVxqj+QA
         7uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v1YS/J83Eu5nrPHDPpheoNGguZg0ZukbHxQjRUh1nnc=;
        b=I0rrsxxFAnhsdzY4o0CWUd1+iEOxEN0/alxFqmBSZcR4I3lT/scAc7iFJJVcRkSPKJ
         hKhlpK7tT1dooBQ3wC5gTipFirVzU3eW1+A0IyxYukadm0hO4lBOcX5m89Qrr+2y/lf0
         PMhCO4Eiz5pNToQ0UHqiedABz4NlJ5U0xVulf6jYN6w+U6OX1XFum2UVsGFHSC5cztyw
         eJ54/CJ1jx0DnNVqZD491kKmHH+scjgF3Io1I7YvwhdmS+o3QXOOjr9gnWMvvVZ159q9
         cl9Pu7dGXBoYpz+xqk9ERBNIZXzVRrFFKqDqzjqFhBweRJbxG7qM8doaz5lEHlB3Qbbw
         kl/g==
X-Gm-Message-State: AKaTC009Zul5hIyqOY69flWM4zLghcP1bMmoDNbJL+xmvQwpZLOco69w61YmsGoBdAfAHARf
X-Received: by 10.99.111.78 with SMTP id k75mr181362042pgc.114.1481670890590;
        Tue, 13 Dec 2016 15:14:50 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id c15sm82308567pfd.36.2016.12.13.15.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 15:14:49 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v3 07/16] pathspec: remove unused variable from unsupported_magic
Date:   Tue, 13 Dec 2016 15:14:21 -0800
Message-Id: <1481670870-66754-8-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481670870-66754-1-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Removed unused variable 'n' from the 'unsupported_magic()' function.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 8f367f0..ec0d590 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -333,8 +333,8 @@ static void NORETURN unsupported_magic(const char *pattern,
 				       unsigned short_magic)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int i, n;
-	for (n = i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+	int i;
+	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 		const struct pathspec_magic *m = pathspec_magic + i;
 		if (!(magic & m->bit))
 			continue;
@@ -344,7 +344,6 @@ static void NORETURN unsupported_magic(const char *pattern,
 			strbuf_addf(&sb, "'%c'", m->mnemonic);
 		else
 			strbuf_addf(&sb, "'%s'", m->name);
-		n++;
 	}
 	/*
 	 * We may want to substitute "this command" with a command
-- 
2.8.0.rc3.226.g39d4020

