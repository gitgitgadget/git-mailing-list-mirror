Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B8291F454
	for <e@80x24.org>; Wed,  6 Nov 2019 10:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfKFKE7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 05:04:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32966 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbfKFKE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 05:04:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id w30so2276511wra.0
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 02:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=UDEK+pc7ioMD64D4uZ8Gc5rjKyKEaFaG9k4uxscSWR4=;
        b=E84uToG40pf9WC/XcEH8x/MpTYXIFeddPhxJ1biCW/IJvMmrTP+2iE8zI8+uRnj/a7
         YZuBXJdbJay902uMc6QUfIbLt2CLiY9cYcALJhUWH8ihr7DFvVqdY18q5u/jIkLNZww2
         /PaRJRo4WMPX0Qe4x7QDcUgNWY7CHpVLKo0yDeSbiN93lKF+amNQCZo9HTZwMwV2MNLS
         OQly4erYbTzprAx0MexjALoQEc3O1XQditoSQ/LUYygR9Vky9FhqVCttHINm0xIgZVKQ
         IumQiDWm9EyR4ottbLaVhRjSryV97BqPK6WH73gmUb0rjPC1i9cK0zwQOb1ijU6rOgnB
         nuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=UDEK+pc7ioMD64D4uZ8Gc5rjKyKEaFaG9k4uxscSWR4=;
        b=hc0SnlebE6Hz/Bf5xrHYCJu6LWJRsaZ302xYHqs5FqSMB3x0mnV/jlotO6KfZsmoG3
         1iQMQqZuBOdQVjeV4lif3BcSEzKIMlQhpFJIwUB+bXmOzgs6BrwnAJ8XMzr6h3LcNHIY
         rkZH72b4OpCPBH37DZ1RMehdTuzUHVw0rcYKfUcBZSgPz6da1XIzx/fOp6S4tyFcwQws
         JztUnrEa5GwJVy27s6nvAEtOkI8A7ue1tI2spn7Bl7zU3e0ldisxAUbr4AADOaoXzxbr
         rFTYBxB7tjuEd9zKlhWMAbOnrMp5banmRM7puIE9n1XpMQFlJDZkL+3x7ZQv6JpCeDnb
         oKow==
X-Gm-Message-State: APjAAAVNW76aFyfXzAToAL0VnmZYkLUikreYR186bMWPKhhOdFGHRmOt
        bnkz/CETfFbubRwUkxNLTkvLgHCR
X-Google-Smtp-Source: APXvYqxZC0JtBuH2FvvlJU5IiDeo6W0MldRN0vAw4TDKBz7sYVBzp2fbqrll4wYJggOe7wl1PpJcUg==
X-Received: by 2002:adf:dbc3:: with SMTP id e3mr1877945wrj.185.1573034696913;
        Wed, 06 Nov 2019 02:04:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c144sm2324018wmd.1.2019.11.06.02.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 02:04:56 -0800 (PST)
Message-Id: <3168ba2c9eadcf0cd7e4f2533c9306b5d2c627d0.1573034695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.453.v2.git.1573034695.gitgitgadget@gmail.com>
References: <pull.453.git.1572991158.gitgitgadget@gmail.com>
        <pull.453.v2.git.1573034695.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 10:04:55 +0000
Subject: [PATCH v2 1/1] remote-curl: unbreak http.extraHeader with custom
 allocators
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 93b980e58f5 (http: use xmalloc with cURL, 2019-08-15), we started to
ask cURL to use `xmalloc()`, and if compiled with nedmalloc, that means
implicitly a different allocator than the system one.

Which means that all of cURL's allocations and releases now _need_ to
use that allocator.

However, the `http_options()` function used `slist_append()` to add any
configured extra HTTP header(s) _before_ asking cURL to use `xmalloc()`,
and `http_cleanup()` would release them _afterwards_, i.e. in the
presence of custom allocators, cURL would attempt to use the wrong
allocator to release the memory.

A naïve attempt at fixing this would move the call to
`curl_global_init()` _before_ the config is parsed (i.e. before that
call to `slist_append()`).

However, that does work, as we _also_ parse the config setting
`http.sslbackend` and if found, call `curl_global_sslset()` which *must*
be called before `curl_global_init()`, for details see:
https://curl.haxx.se/libcurl/c/curl_global_sslset.html

So let's instead make the config parsing entirely independent from
cURL's data structures. Incidentally, this deletes two more lines than
it introduces, which is nice.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/http.c b/http.c
index 27aa0a3192..82f493c7fd 100644
--- a/http.c
+++ b/http.c
@@ -150,7 +150,7 @@ static unsigned long empty_auth_useless =
 
 static struct curl_slist *pragma_header;
 static struct curl_slist *no_pragma_header;
-static struct curl_slist *extra_http_headers;
+static struct string_list extra_http_headers = STRING_LIST_INIT_DUP;
 
 static struct active_request_slot *active_queue_head;
 
@@ -414,11 +414,9 @@ static int http_options(const char *var, const char *value, void *cb)
 		if (!value) {
 			return config_error_nonbool(var);
 		} else if (!*value) {
-			curl_slist_free_all(extra_http_headers);
-			extra_http_headers = NULL;
+			string_list_clear(&extra_http_headers, 0);
 		} else {
-			extra_http_headers =
-				curl_slist_append(extra_http_headers, value);
+			string_list_append(&extra_http_headers, value);
 		}
 		return 0;
 	}
@@ -1199,8 +1197,7 @@ void http_cleanup(void)
 #endif
 	curl_global_cleanup();
 
-	curl_slist_free_all(extra_http_headers);
-	extra_http_headers = NULL;
+	string_list_clear(&extra_http_headers, 0);
 
 	curl_slist_free_all(pragma_header);
 	pragma_header = NULL;
@@ -1624,10 +1621,11 @@ int run_one_slot(struct active_request_slot *slot,
 
 struct curl_slist *http_copy_default_headers(void)
 {
-	struct curl_slist *headers = NULL, *h;
+	struct curl_slist *headers = NULL;
+	const struct string_list_item *item;
 
-	for (h = extra_http_headers; h; h = h->next)
-		headers = curl_slist_append(headers, h->data);
+	for_each_string_list_item(item, &extra_http_headers)
+		headers = curl_slist_append(headers, item->string);
 
 	return headers;
 }
-- 
gitgitgadget
