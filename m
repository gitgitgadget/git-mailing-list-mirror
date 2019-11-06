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
	by dcvr.yhbt.net (Postfix) with ESMTP id 514731F454
	for <e@80x24.org>; Wed,  6 Nov 2019 10:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbfKFKA0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 05:00:26 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:40384 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbfKFKAA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 05:00:00 -0500
Received: by mail-wm1-f49.google.com with SMTP id f3so2555361wmc.5
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 01:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BGFDMznWg+rixa5vEZllxFnPLKaJJ0SXa/3bQPF5IPY=;
        b=WOzhr0hGZavTqukW5aMf2KI+KJ+R12Of08HB+ryy1mNyXCSHSGVS8hAEwRIgWFaIDc
         BUr3t5yeadIOveQw1SZiIZ16fdbQRdRFW1XwYWh5Q3ewOIoKrG75mvJ4G0owGp+9srjC
         CEfgqgQROvRGipnq966H4647T9apxxP2g6NFSEcFZwxQ00YuOmnsM7SlQPf6eLoFb0q8
         MyPqS2ssN6QhDJEkHtx6vtqN4YDiwEIWWIQ7E4RaFtQIPHO7vypRZ7AxfofrbsLMZJAJ
         oLmEvvTAJVpnYnOaW0Dl0/k4wSmVMDHZza5WERAe4CpAsfAp00451zlGJKl91XmgJfdZ
         L+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BGFDMznWg+rixa5vEZllxFnPLKaJJ0SXa/3bQPF5IPY=;
        b=AjJJR+9AOH1cBNaW39t9iOdU3XS7P2Ssw2uRiuj/TwSiX+PQbTR23xd9GHinmrBIbf
         dZ4hgfMHuLHvUL34xfJyelw6IWlupE7eWj7ENJ+EaAILujbOZYTWQt/VlTsNQA7UYZcU
         sceBaazl70GOpER7Gw4/O9ekEmK2IvZsIExnIPjSBomSC1asTIAD8F+QnZgICXktNii7
         x+Ki1VhuutBYZ3HBZ4jIMcV/2LjT8Yd4s5gCNewSHhHUbBr3iKVFR557L2DSEn1Cwt4B
         7kl0lhwPnSGpOFzwx4H4osYZJm10iG05w9FQ+Wq7g9WBTMw5WhCEQLjQ48PSYBlCj+tg
         vXhA==
X-Gm-Message-State: APjAAAXeej3ihpd//P7PjdV/4Y2rAvy+jtgsx3MJ7WGNMnHwH1ge0mpr
        /OGBJ6OLncWzc2jS3u942ttqMlGQ
X-Google-Smtp-Source: APXvYqxIw/YLhXF+BKPt7ZsiCrQ4H1rjbWzSh47bHhhujpMv/8i6cgDhNEQ856UPbDNl6ReTsmpS7w==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr1580685wmi.16.1573034397414;
        Wed, 06 Nov 2019 01:59:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k4sm2291871wmk.26.2019.11.06.01.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:59:56 -0800 (PST)
Message-Id: <a280cf7f90f6769202840858ea3684e118b3dc26.1573034387.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
        <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 09:59:39 +0000
Subject: [PATCH v2 12/20] cache: move doc to cache.h
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
 .../technical/api-allocation-growing.txt      | 39 ------------------
 cache.h                                       | 41 +++++++++++++++++--
 2 files changed, 37 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/technical/api-allocation-growing.txt

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

