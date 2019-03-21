Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED38420248
	for <e@80x24.org>; Thu, 21 Mar 2019 19:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfCUTgR (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 15:36:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42694 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfCUTgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 15:36:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id j89so5991463edb.9
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kDqKb0lvQPTOOfh+5XXy5idmVJeBPVYJuc/uaGGOhrc=;
        b=XJR9hrlHq+120708riQla9mmfqQazJulqybkAnorAhVGue6umqgXukJoe6Zv6+vja8
         eyfbYxOkZr5FaOPFslxVwVDCCF4hH/KaffBMKtsmWFa6AJuu60sEi/gt/wcjNUiN+745
         v3e0rZwKIsQYEIU2VCU1ID6czDr1CG4LsE7lFo5FwCUWBj20YhCvKyAYN2monr8aQgeX
         gZL9BDrFD1ZJ2041jNWCcXMPuRn8G8kmRfO422zONPniXdjarrJjEIKhJBICY+nAPJjM
         4imbmlQQ43qzusiR+k5Zz1A0scWEJgGQ9g7pXdpiPdE1i5gaApqzxiJ7x6LNt8Dp6rty
         AVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kDqKb0lvQPTOOfh+5XXy5idmVJeBPVYJuc/uaGGOhrc=;
        b=E6H9ZfeD1Jxh6lD3Mj/c3Rp+MwPGAYECZMyiNRQEzpTPFRbbI7zo22tELem7FegWGx
         8TtGon9rvQomfX4GZ/UmAWmtWd4LGBrROgwny1Z47evbOXn9z1BCjlCfcOjxOyES4zOL
         hlu3idP26+xnwWgRMHA7ymECkfzkdmOfCGNg35AxmVlyBHUWxDjPAiJCccxFY7OH0spi
         Epjpb98ZVg2U4xneMW8zD6sJ9YnHBpBLIk3/KzdAD4T0urNnw7MOaFygTDhsKgOwaEv5
         WFAsbyRnS8KsdItUP0ZbbllMjgpuMxH5NEZL8pyqoIralbtrxoYNZYpXAuy0MhMaX6Ux
         nUoQ==
X-Gm-Message-State: APjAAAW74iyTLLiNGIctMbgHiAFKkOmD5207I5jGa37SYnrQvAEzO6UQ
        ol5cjsZ00S1OZAybVv2mX7A1TWuN
X-Google-Smtp-Source: APXvYqycChpNUvzm94JKjEnECPe2PDna5FRY42QsrFw4Zn7ftzi0s6xsVVcP4ivRelW6r9pf2bEu1Q==
X-Received: by 2002:a17:906:4ac1:: with SMTP id u1mr3236655ejt.179.1553196974609;
        Thu, 21 Mar 2019 12:36:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k9sm1220342eja.33.2019.03.21.12.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 12:36:14 -0700 (PDT)
Date:   Thu, 21 Mar 2019 12:36:14 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Mar 2019 19:36:09 GMT
Message-Id: <8a60902d65c6b36c20b6e9fc99eace37602ca28b.1553196970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.166.v3.git.gitgitgadget@gmail.com>
References: <pull.166.v2.git.gitgitgadget@gmail.com>
        <pull.166.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 3/4] midx: add progress indicators in multi-pack-index
 verify
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add progress indicators to more parts of midx verify.
Use sparse progress indicator for object iteration.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 midx.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 24141a7c62..e3919387d9 100644
--- a/midx.c
+++ b/midx.c
@@ -962,6 +962,18 @@ static void midx_report(const char *fmt, ...)
 	va_end(ap);
 }
 
+/*
+ * Limit calls to display_progress() for performance reasons.
+ * The interval here was arbitrarily chosen.
+ */
+#define SPARSE_PROGRESS_INTERVAL (1 << 12)
+#define midx_display_sparse_progress(progress, n) \
+	do { \
+		uint64_t _n = (n); \
+		if ((_n & (SPARSE_PROGRESS_INTERVAL - 1)) == 0) \
+			display_progress(progress, _n); \
+	} while (0)
+
 int verify_midx_file(const char *object_dir)
 {
 	uint32_t i;
@@ -972,10 +984,15 @@ int verify_midx_file(const char *object_dir)
 	if (!m)
 		return 0;
 
+	progress = start_progress(_("Looking for referenced packfiles"),
+				  m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
 		if (prepare_midx_pack(m, i))
 			midx_report("failed to load pack in position %d", i);
+
+		display_progress(progress, i + 1);
 	}
+	stop_progress(&progress);
 
 	for (i = 0; i < 255; i++) {
 		uint32_t oid_fanout1 = ntohl(m->chunk_oid_fanout[i]);
@@ -986,6 +1003,8 @@ int verify_midx_file(const char *object_dir)
 				    i, oid_fanout1, oid_fanout2, i + 1);
 	}
 
+	progress = start_sparse_progress(_("Verifying OID order in MIDX"),
+					 m->num_objects - 1);
 	for (i = 0; i < m->num_objects - 1; i++) {
 		struct object_id oid1, oid2;
 
@@ -995,9 +1014,12 @@ int verify_midx_file(const char *object_dir)
 		if (oidcmp(&oid1, &oid2) >= 0)
 			midx_report(_("oid lookup out of order: oid[%d] = %s >= %s = oid[%d]"),
 				    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
+
+		midx_display_sparse_progress(progress, i + 1);
 	}
+	stop_progress(&progress);
 
-	progress = start_progress(_("Verifying object offsets"), m->num_objects);
+	progress = start_sparse_progress(_("Verifying object offsets"), m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
 		struct object_id oid;
 		struct pack_entry e;
@@ -1023,7 +1045,7 @@ int verify_midx_file(const char *object_dir)
 			midx_report(_("incorrect object offset for oid[%d] = %s: %"PRIx64" != %"PRIx64),
 				    i, oid_to_hex(&oid), m_offset, p_offset);
 
-		display_progress(progress, i + 1);
+		midx_display_sparse_progress(progress, i + 1);
 	}
 	stop_progress(&progress);
 
-- 
gitgitgadget

