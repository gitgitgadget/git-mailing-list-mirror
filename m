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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7300E1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 08:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfIZIaO (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 04:30:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46204 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfIZIaO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 04:30:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so1008929lfc.13
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 01:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4On/JqewR73Dd+z/jZvxquH/PHjeU5FAUfmDuzBbrkU=;
        b=NSW6f2MiP7z3egAw+PSIEJMTAI9rWFa5LVTka9XExy8V2VF9BvKkUR+s5iicjpU36+
         BooBNf98TOftWs3EMgGk9M09kJW+mlzdz95h+o4pkFxBzEbZRlfTRUx1dYll9GMs8xH3
         rtNFJLHi/4qJEGimvjYxmeikWff82Mj2ZyWUKruz2zTqcjb412ThocFdkZRtIgQayz6G
         ykDvpdruSGEOlOz0p0kvbkGTGVXUtWBGnBPgySrUJvkHOIXGFnga0AwrAMHvHs3VMOmk
         KYADINEo5XF5yofYlSGpnsmELcyBwWYh8WuawBrqECFLLcXZ5rn1MQ4zbh371y4yOENE
         Kc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4On/JqewR73Dd+z/jZvxquH/PHjeU5FAUfmDuzBbrkU=;
        b=BQjoE9u6nJFAes1GQU0AJ0fF6YpvzkLv1UxJz4Kqywxs8t/OJ7c2Gq/ITmIPM7BPEq
         ASYQuPEC9gzIGotRhoyl7zVLY8kE8z6mOka8uOhfp7RtAqYX7f/sDiG1GP76PP5jPAQ5
         4Yk8EJhZuyS95qneRSyE+lM/1xpYPnHQ6YhPx074VTGAuiyrMKzaANoVgIJkdZmJVyz/
         DEw03ZTNe4Vymna9njkR9WteiS9EHnDU/8rkJqcFjw7KteMnhI95EX20n9ldryGVN61Q
         7w8WABLEsf3HHZ6Nb0JGD9sDBbsIHx8w5P+1JuLrO5bqJR88OA1NlaoSJhSEio21NVv6
         a12w==
X-Gm-Message-State: APjAAAWgkb5a2wd2c57ufdtkTHusg8+SXL5fHpZ7AOye4YfvuolSUaqw
        E7U2kKBpTL6GWtA6FR5ZnTVYKAKA
X-Google-Smtp-Source: APXvYqwTtfCw1uP/278kWLRi+70gX21wIWvb3s1VZkyrL+tA4e/gLytIIBjGR8xSxC61MczVAA60xA==
X-Received: by 2002:ac2:4c2b:: with SMTP id u11mr1332072lfq.179.1569486611365;
        Thu, 26 Sep 2019 01:30:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b20sm339645ljo.106.2019.09.26.01.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 01:30:10 -0700 (PDT)
Date:   Thu, 26 Sep 2019 01:30:10 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 08:29:55 GMT
Message-Id: <2abe1e1fb0bf3025489c2e543b9a9c648a164827.1569486607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 02/13] msvc: avoid using minus operator on unsigned types
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 read-cache.c  | 4 ++--
 sha1-lookup.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c701f7f8b8..11f3357216 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1276,7 +1276,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	 */
 	if (istate->cache_nr > 0 &&
 		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
-		pos = -istate->cache_nr - 1;
+		pos = -1 - istate->cache_nr;
 	else
 		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
 
@@ -1894,7 +1894,7 @@ static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
 	/*
 	 * Account for potential alignment differences.
 	 */
-	per_entry += align_padding_size(sizeof(struct cache_entry), -sizeof(struct ondisk_cache_entry));
+	per_entry += align_padding_size(per_entry, 0);
 	return ondisk_size + entries * per_entry;
 }
 
diff --git a/sha1-lookup.c b/sha1-lookup.c
index 796ab68da8..c819687730 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -97,7 +97,7 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
 			lo = mi + 1;
 		mi = lo + (hi - lo) / 2;
 	} while (lo < hi);
-	return -lo-1;
+	return -1 - lo;
 }
 
 int bsearch_hash(const unsigned char *sha1, const uint32_t *fanout_nbo,
-- 
gitgitgadget

