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
	by dcvr.yhbt.net (Postfix) with ESMTP id 79E311F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfI3Jzg (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:55:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34942 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfI3Jzf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:55:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so10528652wrt.2
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 02:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rXwokdNk6lwmPypVuQrwU+yirXvG0r98uWyB6BIZAbc=;
        b=FrUsVV7f6TO7t+/u79qULGGEqC1jw23Y9RitigWBh516Da3J7GxksmsFs6zpMkwSSu
         ym2lrBziFgYmu4Gtkl0rVqWnVg+fobmyzHGbGBq3fxtHHnSctq0/ndBEolNKpWk1Fi39
         Q0Sa8AX3Lw9zEOT1YydMkoBcClftLhvJ+U17Jq/J3V8M15wefXHsBOdesTctjL7bkwT7
         qhw3HF2Bp8Lh7gtlVKZ0U3Jf11Ykrop+V87yjRB1IUkhGMCeMYciycoC5jPIQkpL3yBf
         c2g6rBtxV1EuNXQ1IlMovbtvQg3HoJGKhSrit4PY9u4CI/xliIQBLJoQeMG37fpC6fDO
         ENeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rXwokdNk6lwmPypVuQrwU+yirXvG0r98uWyB6BIZAbc=;
        b=PaUuuUqQrNTTBcoKfdfOh5Kgz25483FVVKSZLDpX+YoZic+vaqJxwca3RTx9W2tVX/
         fr0Q7HAIJTeGK1eefOP5LizrCcwMLD/jBKl0mNmF4wXY4jBeeKjRgi8ufpzARKq3oIh3
         Xs3YVqjrGIlirU39xQgZgubqJVNqbNZGQ0AdCphUfamKmzXaBCwGPEChNNW59rJVKQNw
         DSHY7cZcqAKEZuUwBZ+kZF9Fbgl5KQoA/XlnWivnKRj0PWlnWfyIqiFD0KLrckZe+k21
         dh9y4r0C0xaT6U9nE4W5/uWJ/In9oO9gTFG6nCenSxO9igqQ9vQvx0sb25fM+q63lRRa
         VbRA==
X-Gm-Message-State: APjAAAU8fN/7kTY0hRJF34VFy35AiGwJ+sz518K1JBEnlBT8T9WInyZh
        gSwLlCOxFK0ZbUMotVqWUO0aWfB8
X-Google-Smtp-Source: APXvYqwxFczH33my3F5VpoEXCr6gvXyjja24RsCET6tYIqeMg5s/YV42U2v8/xfKE5t8YjFAjkef2g==
X-Received: by 2002:a5d:6411:: with SMTP id z17mr851570wru.274.1569837332315;
        Mon, 30 Sep 2019 02:55:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm16107681wrm.3.2019.09.30.02.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:55:31 -0700 (PDT)
Date:   Mon, 30 Sep 2019 02:55:31 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 09:55:18 GMT
Message-Id: <8800320590e4d7218a80f80abca23a7f44b8747d.1569837329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v2.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
        <pull.288.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 02/13] msvc: avoid using minus operator on unsigned types
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

MSVC complains about this with `-Wall`, which can be taken as a sign
that this is indeed a real bug. The symptom is:

	C4146: unary minus operator applied to unsigned type, result
	still unsigned

Let's avoid this warning in the minimal way, e.g. writing `-1 -
<unsigned value>` instead of `-<unsigned value> - 1`.

Note that the change in the `estimate_cache_size()` function is
needed because MSVC considers the "return type" of the `sizeof()`
operator to be `size_t`, i.e. unsigned, and therefore it cannot be
negated using the unary minus operator.

Even worse, that arithmetic is doing extra work, in vain. We want to
calculate the entry extra cache size as the difference between the
size of the `cache_entry` structure minus the size of the
`ondisk_cache_entry` structure, padded to the appropriate alignment
boundary.

To that end, we start by assigning that difference to the `per_entry`
variable, and then abuse the `len` parameter of the
`align_padding_size()` macro to take the negative size of the ondisk
entry size. Essentially, we try to avoid passing the already calculated
difference to that macro by passing the operands of that difference
instead, when the macro expects operands of an addition:

	#define align_padding_size(size, len) \
		((size + (len) + 8) & ~7) - (size + len)

Currently, we pass A and -B to that macro instead of passing A - B and
0, where A - B is already stored in the `per_entry` variable, ready to
be used.

This is neither necessary, nor intuitive. Let's fix this, and have code
that is both easier to read and that also does not trigger MSVC's
warning.

While at it, we take care of reporting overflows (which are unlikely,
but hey, defensive programming is good!).

We _also_ take pains of casting the unsigned value to signed: otherwise,
the signed operand (i.e. the `-1`) would be cast to unsigned before
doing the arithmetic.

Helped-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 read-cache.c  |  9 ++++++---
 sha1-lookup.c | 12 +++++++++---
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c701f7f8b8..97745c2a31 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1275,8 +1275,11 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	 * we can avoid searching for it.
 	 */
 	if (istate->cache_nr > 0 &&
-		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
-		pos = -istate->cache_nr - 1;
+		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0) {
+		if (istate->cache_nr > INT_MAX)
+			die("overflow: -1 - %u", istate->cache_nr);
+		pos = -1 - (int)istate->cache_nr;
+	}
 	else
 		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
 
@@ -1894,7 +1897,7 @@ static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
 	/*
 	 * Account for potential alignment differences.
 	 */
-	per_entry += align_padding_size(sizeof(struct cache_entry), -sizeof(struct ondisk_cache_entry));
+	per_entry += align_padding_size(per_entry, 0);
 	return ondisk_size + entries * per_entry;
 }
 
diff --git a/sha1-lookup.c b/sha1-lookup.c
index 796ab68da8..bb786b5420 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -69,8 +69,12 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
 			miv = take2(sha1 + ofs);
 			if (miv < lov)
 				return -1;
-			if (hiv < miv)
-				return -1 - nr;
+			if (hiv < miv) {
+				if (nr > INT_MAX)
+					die("overflow: -1 - %"PRIuMAX,
+					    (uintmax_t)nr);
+				return -1 - (int)nr;
+			}
 			if (lov != hiv) {
 				/*
 				 * At this point miv could be equal
@@ -97,7 +101,9 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
 			lo = mi + 1;
 		mi = lo + (hi - lo) / 2;
 	} while (lo < hi);
-	return -lo-1;
+	if (nr > INT_MAX)
+		die("overflow: -1 - %"PRIuMAX, (uintmax_t)lo);
+	return -1 - (int)lo;
 }
 
 int bsearch_hash(const unsigned char *sha1, const uint32_t *fanout_nbo,
-- 
gitgitgadget

