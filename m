Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E7E21F731
	for <e@80x24.org>; Fri,  9 Aug 2019 15:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436522AbfHIPA7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 11:00:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33579 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407242AbfHIPA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 11:00:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id p77so6377332wme.0
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AMRj4RdGeKffECVj5c+t5qwJAsKJ92hhns5QybcLZDU=;
        b=FQW9fgXTjtmsv01m8EsqhjqMyxwp2hB2gWNkhtjeI3gKvIjXzJxT3AYDBTMkkf0Sbp
         eaL68Z+EzPhFh4lfYNqCbYHMaO4tn6cnv6IjNJhaAtHJ4NG6Y+ixDbod9U+vzn6zbUmq
         Wd/t7QGJ1jhic9goY7WebUa8QhFR8eZ4uFUu4XEa76Wgv9EbrJSv8eEH7hLXbalT3TnE
         8V8lB4l89OXWUW7/dtfPSBIb456BCiZJ/gEnhZR3zRPWQVD9672aBfI0YmcvU4s3Y1qk
         nqoFLIaNcVE3dxgN6Q8Op5W4y4nUePUGgmZqZ3NiMQtnZkZPtxeiAWHV5IgrHkTBZDTh
         r/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AMRj4RdGeKffECVj5c+t5qwJAsKJ92hhns5QybcLZDU=;
        b=D3JvaNHaOW9hr+/zDsoVvKXnXJ9/x7lU2fA9VxEv2NXJeT0VEacVBiaozzKt79r5yA
         B0oQIu/zBAGP3Cpfp8fKnUoPol03upBWIfpcUjNlkxcF7qkzDZ/wEkxoRBXUu5gfeUqs
         2NzxnJPeMG1tZue8vj4KAEjAWUD0ci1y+kDmX7152MzUHZqxu26lmyjZrbix6g5kqMwG
         G2wqJP3ONNIHmT4og8z8HP2Ef2Npai8wpiYYYXANDHztpZnh541M7kUUKSJVJJmS7dhf
         fBh0EcN5F7uxv5LhIEAo1WK8zxXe3lSGFC9D24j1XQuy5S02WsUgMeLSOEptll42WDY4
         c9RQ==
X-Gm-Message-State: APjAAAWjZJCLo2O1cRGGhJOEbq/Riyj5+9qkiF/7Y8Th5jCOiikeHh+/
        9XBbb44ekLeeBHcinPHxc+JzOWHj
X-Google-Smtp-Source: APXvYqyPEPLydNofExaqQZyC1HzZv4+QGENlk4ZbMXwZySVHWAG5W4Xs6DaV386a+yT527ygvGQK6g==
X-Received: by 2002:a1c:a446:: with SMTP id n67mr5662931wme.56.1565362855012;
        Fri, 09 Aug 2019 08:00:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4sm229697970wro.78.2019.08.09.08.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 08:00:54 -0700 (PDT)
Date:   Fri, 09 Aug 2019 08:00:54 -0700 (PDT)
X-Google-Original-Date: Fri, 09 Aug 2019 15:00:47 GMT
Message-Id: <09dff12a7dfe2219feab85b3fe611aa5c4196375.1565362851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.v3.git.gitgitgadget@gmail.com>
References: <pull.298.v2.git.gitgitgadget@gmail.com>
        <pull.298.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 3/7] trace2: remove dead code in maybe_add_string_va()
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

Remove an unnecessary "if" block in maybe_add_string_va().

Commit "ad006fe419e trace2: NULL is not allowed for va_list"
changed "if (fmt && *fmt && ap)" to just "if (fmt && *fmt)"
because it isn't safe to treat 'ap' as a pointer.  This made
the "if" block following it unnecessary.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_event.c  | 5 -----
 trace2/tr2_tgt_normal.c | 5 -----
 trace2/tr2_tgt_perf.c   | 5 -----
 3 files changed, 15 deletions(-)

diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index c2852d1bd2..9bcac20d1b 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -205,11 +205,6 @@ static void maybe_add_string_va(struct json_writer *jw, const char *field_name,
 		strbuf_release(&buf);
 		return;
 	}
-
-	if (fmt && *fmt) {
-		jw_object_string(jw, field_name, fmt);
-		return;
-	}
 }
 
 static void fn_error_va_fl(const char *file, int line, const char *fmt,
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 00b116d797..47a1882557 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -135,11 +135,6 @@ static void maybe_append_string_va(struct strbuf *buf, const char *fmt,
 		va_end(copy_ap);
 		return;
 	}
-
-	if (fmt && *fmt) {
-		strbuf_addstr(buf, fmt);
-		return;
-	}
 }
 
 static void fn_error_va_fl(const char *file, int line, const char *fmt,
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index fb845cb627..8e52395de2 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -239,11 +239,6 @@ static void maybe_append_string_va(struct strbuf *buf, const char *fmt,
 		va_end(copy_ap);
 		return;
 	}
-
-	if (fmt && *fmt) {
-		strbuf_addstr(buf, fmt);
-		return;
-	}
 }
 
 static void fn_error_va_fl(const char *file, int line, const char *fmt,
-- 
gitgitgadget

