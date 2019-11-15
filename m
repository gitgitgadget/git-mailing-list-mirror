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
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B7C1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 09:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfKOJyC (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 04:54:02 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:37871 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfKOJyA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 04:54:00 -0500
Received: by mail-wm1-f45.google.com with SMTP id b17so9656332wmj.2
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 01:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VWNl6wK9EB6mZDC5GVSJ8qEMjlos9LR3gykaHGpGsuM=;
        b=JQrF4lVubicqR/FgorAHQfd3MsAd5uvoM1c3l+5duMQ9SRio8aC6TZov9nFXsYS16O
         rwINi3J4rfCdyaDqz9foEXVzTOv+nKRBRjsrJrfW4lSJzyxpq5+0qeAXnBeRwxaV5IME
         k15EBQV+tv2wV1i6yq+BNg+0T6yC5OnPNukrv6S5RrP0OhGBwqEIRKb7Ul+13c4cqJBC
         /H3+bsqAfG22+zj/89Az4OGgUz2x7JB4dERsOniOwE/XbC9965g8H6TK9eoDJWS0zFky
         ulH4/JuZOHOyqDl4ZHhC7rROCXAqP9qILgve4W+vkb/9xplmuXGLwaDrokRBnaP9DC55
         3FZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VWNl6wK9EB6mZDC5GVSJ8qEMjlos9LR3gykaHGpGsuM=;
        b=ehur5zwe3fN/y8Az0He8Fc/qlbKfHNAQb2M+Ab3cO3JW3H/AwHUKQr0HLlhHO2mJdL
         zvtUd2nLVbsp3N3/uExqOhPGDdJU4izoQk/90MprKuLiKbNtPTzg/r8JUmUQNFrklmQY
         WYkpcT414nHLTW7FNH7HZUxEpSTHs+r1e+Xd4p4oPuDsRJSTyxavsxn39r0nYasiARQN
         5GSbHw24+1mi27mAHWHt/Ru1Hm2mtK6VpjJ6zBunuQe0imCiV0BMntTNdqoxK22g9UND
         BoM18nNpoAI+guUFrt8cswhmGG9vUeirLjIhrNKFymq8rJ+EtYVwxwmQfZ6z5ctbz554
         F/DA==
X-Gm-Message-State: APjAAAXr+XcTlQTdUIIdKpelZLfPO3REnRYoLuBnHEpAiMq7732+J+Ez
        Yoi8Tph2kW26ayrhD6LyAsC3SgAT
X-Google-Smtp-Source: APXvYqymgwmZquNmPCmhjbUo0YIQPnTMhFKm2mNAgwCOG8DeezTFCWWXk73bw7b7lfjGtj1zCLDW8w==
X-Received: by 2002:a7b:ce90:: with SMTP id q16mr13345735wmj.172.1573811637883;
        Fri, 15 Nov 2019 01:53:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm10467231wrt.39.2019.11.15.01.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:53:57 -0800 (PST)
Message-Id: <3e0d3f24158baa42464cef24ef7ea6ab0328801a.1573811627.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
References: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
        <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 09:53:37 +0000
Subject: [PATCH v4 12/21] cache: move doc to cache.h
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
index 321c0ba6a4..aa828dfdc4 100644
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

