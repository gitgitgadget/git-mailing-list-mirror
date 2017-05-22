Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AFF42023D
	for <e@80x24.org>; Mon, 22 May 2017 14:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934678AbdEVOSS (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:18:18 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64429 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934620AbdEVOSP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:15 -0400
X-AuditID: 1207440d-dcfff70000000e33-2c-5922f3263f31
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 2C.A8.03635.623F2295; Mon, 22 May 2017 10:18:14 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24C023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:12 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/25] ref_iterator_begin_fn(): fix docstring
Date:   Mon, 22 May 2017 16:17:33 +0200
Message-Id: <7df9b378009b633e72a98ba6e5f2250718f1ce19.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqKv2WSnSYN12ZYu1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXRlvvQpaCk9wV
        z/YsZGlgPMfZxcjJISFgInG88R9jFyMXh5DADiaJC4u/sUM4p5gknjzqYAWpYhPQlVjU08wE
        YosIqElMbDvEAlLELLCBWeLN9NVgCWEBB4nr04+B2SwCqhKNG++ygNi8AlESp+9vZIFYJy+x
        q+0i2FBOAQuJ37MOgNULCZhL9P5bzTKBkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0j
        vdzMEr3UlNJNjJBQ5N3B+H+dzCFGAQ5GJR5ejcdKkUKsiWXFlbmHGCU5mJREeY++AQrxJeWn
        VGYkFmfEF5XmpBYfYpTgYFYS4dW+C5TjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1I
        LYLJynBwKEnw6n0CahQsSk1PrUjLzClBSDNxcIIM5wEavuYDyPDigsTc4sx0iPwpRkUpcV4D
        kGYBkERGaR5cLyxVvGIUB3pFmNcEpIoHmGbgul8BDWYCGmz9TB5kcEkiQkqqgTGUe9rM3byO
        h6UKGPr8Wyb+FpTMFTZ/+dOCZeazT14BvwSWP+va8kpf8bD6sqMl/QECKq/0+TdJVEtP31vK
        XLXkTPj5kt+dR9dr7n1W2xffbxpRtuz1hYfC2353/pV1jJ5t77jj9aut353f+73VmjM97ctH
        f6414bva7jfoxedtP/z05aqi0hNKLMUZiYZazEXFiQDun69f8AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The iterator returned by this function only includes references whose
names start with the whole prefix, not all of those in
`find_containing_dir(prefix)` as the old docstring claimed. This
docstring was probably copy-pasted from old ref-cache code, which had
the old specification. But now, `cache_ref_iterator_begin()`
(from which the files reference iterator gets its values)
automatically wraps its output using `prefix_ref_iterator_begin()`
when necessary, so it has the stricter behavior.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/refs-internal.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index b6b291cf00..7020e51cb7 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -515,9 +515,10 @@ typedef int rename_ref_fn(struct ref_store *ref_store,
 			  const char *logmsg);
 
 /*
- * Iterate over the references in the specified ref_store that are
- * within find_containing_dir(prefix). If prefix is NULL or the empty
- * string, iterate over all references in the submodule.
+ * Iterate over the references in `ref_store` whose names start with
+ * `prefix`. `prefix` is matched as a literal string, without regard
+ * for path separators. If prefix is NULL or the empty string, iterate
+ * over all references in `ref_store`.
  */
 typedef struct ref_iterator *ref_iterator_begin_fn(
 		struct ref_store *ref_store,
-- 
2.11.0

