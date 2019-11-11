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
	by dcvr.yhbt.net (Postfix) with ESMTP id DFB8F1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 21:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfKKV2S (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 16:28:18 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:42501 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfKKV2S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 16:28:18 -0500
Received: by mail-wr1-f49.google.com with SMTP id a15so16220224wrf.9
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 13:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kAlgZI/rqjNeIybAIDl1BOSUvsJpzxiqkQ2PkT7FQps=;
        b=uf0hT6WAeLQiDzi1Jn8As8UJfy2JRbGzmlQUl2Uwu6wt4qJg5IHKkQiOv6ZxjPvIQA
         E/xmJDW+G//HALUl1EGqDPTANDhKk8VkqnAlIvq3aK6vJlh7a20u15gMyrReYdRHDQD1
         j4GTQGtMg0oOM4USla17AZ6vUhfw1ViiZANy54vDr25mydCCDQGAxQ7VVaV9cdqxmFdt
         0nYX9xlPSEGlfdxME18+E1pQ7kMOZ1JPOo7u7a93bOjLAtNgyRddbYipYenNyi0bmbWU
         04VTko7ZUjY1dcsTgakI1S85uny+SUwvszhXJMQ4+G3er/L7DezZu6+J38yb94nTQYEO
         i2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kAlgZI/rqjNeIybAIDl1BOSUvsJpzxiqkQ2PkT7FQps=;
        b=VxzQ9F3AxysCjqXC3QQsop3+3HNLa3iIYsxYjNZmbPvhExYHOXP8Popwy3W22yJanT
         xR8ZZF+slMr/ntIwCW+EihremnnMXEZzTnGqrHUtADTw46JRlJ9idpbUQBsuLth6ckRO
         Rh2lIvXtLvE/mMx10zqcxU4OdbTp10QQnecgmp/gTRQx6/pLgnkOySpOomKSBGfHPWMA
         NVb3WIcboIF9aI/k0lj+wpQOzU4bg4zAmv8SlrJUfrTbN6WoblugXcIuT3QJYGoG4S71
         9O8h/rH+zJNeAtnshiKnloYycYhbrcY3puV7LPHBVo/FcZkwNXjhRjf9GhK6KyCOcSe0
         +ffQ==
X-Gm-Message-State: APjAAAVHMjPhfCH5JIpwOLrt5RDfVV0suQn6twy5tZRbNL+441e8Plj8
        W6ptp+9DDUlaNZSGpsZB1ZMGf1BS
X-Google-Smtp-Source: APXvYqz3q7UaNO6v3f3pRGmGUlLTquhQCG1jh9GFSoVCCmrM/9+6ti528rIE8PDlOGJ62rXOpcZZng==
X-Received: by 2002:a05:6000:1181:: with SMTP id g1mr23619151wrx.131.1573507695936;
        Mon, 11 Nov 2019 13:28:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm35965018wrc.73.2019.11.11.13.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 13:28:15 -0800 (PST)
Message-Id: <1eca7099efeb6f57be646351d19baaf636a31b2b.1573507684.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
        <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Nov 2019 21:27:55 +0000
Subject: [PATCH v3 12/21] cache: move doc to cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Move the documentation from Documentation/technical/api-allocation-growing.txt
to cache.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Also documentation/technical/api-allocation-growing.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/MyFirstObjectWalk.txt           |  5 +--
 .../technical/api-allocation-growing.txt      | 39 ------------------
 cache.h                                       | 41 +++++++++++++++++--
 3 files changed, 39 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/technical/api-allocation-growing.txt

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index 321c0ba6a4..6629122703 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -119,9 +119,8 @@ parameters provided by the user over the CLI.
 
 `nr` represents the number of `rev_cmdline_entry` present in the array.
 
-`alloc` is used by the `ALLOC_GROW` macro. Check
-`Documentation/technical/api-allocation-growing.txt` - this variable is used to
-track the allocated size of the list.
+`alloc` is used by the `ALLOC_GROW` macro. Check `cache.h` - this variable is 
+used to track the allocated size of the list.
 
 Per entry, we find:
 
diff --git a/Documentation/technical/api-allocation-growing.txt b/Documentation/technical/api-allocation-growing.txt
deleted file mode 100644
index 5a59b54844..0000000000
--- a/Documentation/technical/api-allocation-growing.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-allocation growing API
-======================
-
-Dynamically growing an array using realloc() is error prone and boring.
-
-Define your array with:
-
-* a pointer (`item`) that points at the array, initialized to `NULL`
-  (although please name the variable based on its contents, not on its
-  type);
-
-* an integer variable (`alloc`) that keeps track of how big the current
-  allocation is, initialized to `0`;
-
-* another integer variable (`nr`) to keep track of how many elements the
-  array currently has, initialized to `0`.
-
-Then before adding `n`th element to the item, call `ALLOC_GROW(item, n,
-alloc)`.  This ensures that the array can hold at least `n` elements by
-calling `realloc(3)` and adjusting `alloc` variable.
-
-------------
-sometype *item;
-size_t nr;
-size_t alloc
-
-for (i = 0; i < nr; i++)
-	if (we like item[i] already)
-		return;
-
-/* we did not like any existing one, so add one */
-ALLOC_GROW(item, nr + 1, alloc);
-item[nr++] = value you like;
-------------
-
-You are responsible for updating the `nr` variable.
-
-If you need to specify the number of elements to allocate explicitly
-then use the macro `REALLOC_ARRAY(item, alloc)` instead of `ALLOC_GROW`.
diff --git a/cache.h b/cache.h
index 04cabaac11..8fbbdf971a 100644
--- a/cache.h
+++ b/cache.h
@@ -632,10 +632,43 @@ int daemonize(void);
 
 #define alloc_nr(x) (((x)+16)*3/2)
 
-/*
- * Realloc the buffer pointed at by variable 'x' so that it can hold
- * at least 'nr' entries; the number of entries currently allocated
- * is 'alloc', using the standard growing factor alloc_nr() macro.
+/**
+ * Dynamically growing an array using realloc() is error prone and boring.
+ *
+ * Define your array with:
+ *
+ * - a pointer (`item`) that points at the array, initialized to `NULL`
+ *   (although please name the variable based on its contents, not on its
+ *   type);
+ *
+ * - an integer variable (`alloc`) that keeps track of how big the current
+ *   allocation is, initialized to `0`;
+ *
+ * - another integer variable (`nr`) to keep track of how many elements the
+ *   array currently has, initialized to `0`.
+ *
+ * Then before adding `n`th element to the item, call `ALLOC_GROW(item, n,
+ * alloc)`.  This ensures that the array can hold at least `n` elements by
+ * calling `realloc(3)` and adjusting `alloc` variable.
+ *
+ * ------------
+ * sometype *item;
+ * size_t nr;
+ * size_t alloc
+ *
+ * for (i = 0; i < nr; i++)
+ * 	if (we like item[i] already)
+ * 		return;
+ *
+ * // we did not like any existing one, so add one
+ * ALLOC_GROW(item, nr + 1, alloc);
+ * item[nr++] = value you like;
+ * ------------
+ *
+ * You are responsible for updating the `nr` variable.
+ *
+ * If you need to specify the number of elements to allocate explicitly
+ * then use the macro `REALLOC_ARRAY(item, alloc)` instead of `ALLOC_GROW`.
  *
  * Consider using ALLOC_GROW_BY instead of ALLOC_GROW as it has some
  * added niceties.
-- 
gitgitgadget

