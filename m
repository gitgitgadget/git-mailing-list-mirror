Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFE30201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbdEQMGE (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:04 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:57187 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751300AbdEQMGA (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:00 -0400
X-AuditID: 12074414-071ff70000004f50-c8-591c3ca700b9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C1.CF.20304.7AC3C195; Wed, 17 May 2017 08:05:59 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pfr000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:05:57 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/23] refs.h: clarify docstring for the ref_transaction_update()-related fns
Date:   Wed, 17 May 2017 14:05:25 +0200
Message-Id: <f56871ab01d7a9b07631f143ae902605a1e247f4.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsUixO6iqLvcRibS4PJbUYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfG5UVrGQveclV8urGWtYHxB3sXIyeHhICJ
        xIEZHUxdjFwcQgI7mCTutW+Eck4wSczeP5EFpIpNQFdiUU8zE4gtIqAmMbHtEAtIEbPAYyaJ
        v8u6gRwODmGBWIm3N8pBalgEVCU+r5nACGLzCkRJdO75ALVNXmJX20VWEJtTwELi/vtH7CCt
        QgLmEtuvV05g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdCLzezRC81pXQTIyTQRHYw
        Hjkpd4hRgINRiYfXgkM6Uog1say4MvcQoyQHk5Io7/4HQCG+pPyUyozE4oz4otKc1OJDjBIc
        zEoivDdNZSKFeFMSK6tSi/JhUtIcLErivN8Wq/sJCaQnlqRmp6YWpBbBZGU4OJQkeKdYAzUK
        FqWmp1akZeaUIKSZODhBhvMADecCqeEtLkjMLc5Mh8ifYlSUEuc9AJIQAElklObB9cISwStG
        caBXhHnNQKp4gEkErvsV0GAmoMHNIB/xFpckIqSkGhhFlVw2FL82Pe6Se3ym1I+7KzK3VatK
        WGtrhC3hdzg061LLiRPZb7Re3Ki0SvBYy3tGJtp1nVGVTCFnBQ/nPhYh/3+1PInbvEM3zar9
        rHn1/IT81O607pwju8+HN/LMDj1zWXiFnvSrVsl3KwMXefI+OXivhPdBucbzxmlrdt8X6tqt
        FztNh02JpTgj0VCLuag4EQD6/GZP3wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In particular, make it clear that they make copies of the sha1
arguments.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/refs.h b/refs.h
index d18ef47128..a7d7b1afdf 100644
--- a/refs.h
+++ b/refs.h
@@ -427,6 +427,19 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  *
  *     refname -- the name of the reference to be affected.
  *
+ *     new_sha1 -- the SHA-1 that should be set to be the new value of
+ *         the reference. Some functions allow this parameter to be
+ *         NULL, meaning that the reference is not changed, or
+ *         null_sha1, meaning that the reference should be deleted. A
+ *         copy of this value is made in the transaction.
+ *
+ *     old_sha1 -- the SHA-1 value that the reference must have before
+ *         the update. Some functions allow this parameter to be NULL,
+ *         meaning that the old value of the reference is not checked,
+ *         or null_sha1, meaning that the reference must not exist
+ *         before the update. A copy of this value is made in the
+ *         transaction.
+ *
  *     flags -- flags affecting the update, passed to
  *         update_ref_lock(). Can be REF_NODEREF, which means that
  *         symbolic references should not be followed.
-- 
2.11.0

