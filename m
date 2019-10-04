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
	by dcvr.yhbt.net (Postfix) with ESMTP id 20A101F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 15:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389722AbfJDPJd (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 11:09:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42960 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388802AbfJDPJa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 11:09:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so7626424wrw.9
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 08:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cFC8wn4qClro7naip+RAGgtNl175phXEk4RtMxJ67aY=;
        b=iFRCU9duNEdAxeveeZu5PPASxCcpk7p5ucv8U1E1/nMI884K3LzUjfuzVTOAa3B6ik
         6yxyLmWXnHbGaZcS2XCusMjAlV57x6fXsOrohySyznTgk8FP6VL7F2Uiqn+BtoVpkIxH
         gKrt+IkMOfBuwkW57OyonbIip080iyQcPn1UbdUHxZyMGryOpHiOCcOpxEjv4ubCmXxu
         Z8mIsoPIQ62qA2gn48KKqtTyYnTMh79aYdK/gTIRtUE0aATNzyIAM7mUNLN+ZELxUsAL
         n/1hGYlRSBYomKWo1j/PVqvciwLh1a9iGQZAez2Wahyxugm4BCCh3ZVKU0Re20QMbYUh
         TD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cFC8wn4qClro7naip+RAGgtNl175phXEk4RtMxJ67aY=;
        b=JTB+upmRwikJJQ5tSt66K9h9u3z0C7jg5vRHyBomikNRCFhhqIny8uYSaT0a8ngGV2
         XpBuo/SIOkRtHVJBjMLYLuMpnHcSyu1RmuAFN44j30er/zpOLzzSJL+RQ8cQIh/WiOdE
         C6Kb19Nb/POGkk1ir1hTaVv6jeR4zcYnYJ/mIIHBg6ahrtvOxG81aZIv8L/2SGk4TGD8
         Bu6859oP2HfFlW0gjhnZFFeiLQ/JPXhzIMxBDq0pmKCuiKk2sz3+YmZyrBgb8j+BDOvw
         epn73B6QY3Y1ReVwBYS82dNjM6+RtV70dgpd7wvle2QLex4/Oc/lkz6WCA4wDDIKru0f
         vvSA==
X-Gm-Message-State: APjAAAUR5KhJumdqa0Vs74hcgKGiOC/QOsU6i0yLnPU32TMs/g5o4rhI
        d8C+gWa/QlBD1iUQs8IMomAt6kgW
X-Google-Smtp-Source: APXvYqwWIDI+50ln62fruqLkTzAz+uIQUxv07O3dAbdJlG3vUSkazOrLLMnCpfYMNE/xHD7sthoIjw==
X-Received: by 2002:a5d:49cb:: with SMTP id t11mr9963283wrs.366.1570201767446;
        Fri, 04 Oct 2019 08:09:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm6372860wrh.5.2019.10.04.08.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 08:09:26 -0700 (PDT)
Date:   Fri, 04 Oct 2019 08:09:26 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2019 15:09:11 GMT
Message-Id: <7fe2a85506d2489dc17a05bca5f95303892351a9.1570201763.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v3.git.gitgitgadget@gmail.com>
References: <pull.288.v2.git.gitgitgadget@gmail.com>
        <pull.288.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 02/13] msvc: avoid using minus operator on unsigned types
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
 cache.h       | 13 +++++++++++++
 read-cache.c  |  4 ++--
 sha1-lookup.c |  4 ++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 3167585cab..850e7b945a 100644
--- a/cache.h
+++ b/cache.h
@@ -725,6 +725,19 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
  */
 int index_name_pos(const struct index_state *, const char *name, int namelen);
 
+/*
+ * Some functions return the negative complement of an insert position when a
+ * precise match was not found but a position was found where the entry would
+ * need to be inserted. This helper protects that logic from any integer
+ * underflow.
+ */
+static inline int index_pos_to_insert_pos(uintmax_t pos)
+{
+	if (pos > INT_MAX)
+		die("overflow: -1 - %"PRIuMAX, pos);
+	return -1 - (int)pos;
+}
+
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
diff --git a/read-cache.c b/read-cache.c
index c701f7f8b8..ec13953a21 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1276,7 +1276,7 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	 */
 	if (istate->cache_nr > 0 &&
 		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
-		pos = -istate->cache_nr - 1;
+		pos = index_pos_to_insert_pos(istate->cache_nr);
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
index 796ab68da8..8590aac254 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -70,7 +70,7 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
 			if (miv < lov)
 				return -1;
 			if (hiv < miv)
-				return -1 - nr;
+				return index_pos_to_insert_pos(nr);
 			if (lov != hiv) {
 				/*
 				 * At this point miv could be equal
@@ -97,7 +97,7 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
 			lo = mi + 1;
 		mi = lo + (hi - lo) / 2;
 	} while (lo < hi);
-	return -lo-1;
+	return index_pos_to_insert_pos(lo);
 }
 
 int bsearch_hash(const unsigned char *sha1, const uint32_t *fanout_nbo,
-- 
gitgitgadget

