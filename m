Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E3231F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 15:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeJHW3S (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 18:29:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33720 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeJHW3S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 18:29:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so8539349pfn.0
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W22g94jweKpA+BlfEcvGX3Qr1Kzxrnj7ftYnF4HGPlM=;
        b=dje6rPJe5jNKK/P+g0pt+ydylTU+g3528ZCd2bM8ly6b4FXSMEfAB3t/0wEEtfPCaf
         xV5vZhgSsxfn1ZcE1bW1QmwyhpTc7N45t+wOiiDXb8+X3VjQKlQ81D2TGGnVBPB659AT
         Ab5pG5AEgNhe09JQidMzAlXvCVPIYAAfaHgnrfQ1DlZVLcPVFcbY+cfK/43EDvG/UcRJ
         ssnuHv5ZmqK/w/HEye+6xDkW74AQ9xiT9z9NKCfW7QRUtFF/W1kEPPWigeVHd2gfwndD
         QJ//ePhXnT6SVhuYo7sLTx+M6EhFi8kiqDl+blBHW4HvZvNiGO6jghU5wmMF/dWQQZzI
         qOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W22g94jweKpA+BlfEcvGX3Qr1Kzxrnj7ftYnF4HGPlM=;
        b=XSFsUwJdBPgwIwZjKTQu57MAUXWyvYnKzAoJZQr4suSL5l0Y4xqaUKvX5Th3nYcDNo
         Id66POl6psngmZKuKTlupiJ06mcdEqV1puycbH4wmu7VGjmpiXRgwOL8IGxomIzyNfLn
         18b7H8ZDUE1SuOGpeyN8nRl9Y8NP3BA9FoK25sSgIDO4RIIUBugJsm+LR+3uuzA+MB9c
         6qQtKKpW3o3aH9g12J8Mjz0WVNotq4Tic2rFuBYtH0fKvXAs4JlN/OFT6D/y/3N+3msf
         3LpSbmBNVP6/oVqn7KqDSy4O4u44D/y18pFS/AenkycIaPcnGQcbKyGYgqx/2Ybs6igv
         fNVA==
X-Gm-Message-State: ABuFfojqWks6eE5L530dUL5KxUWXNKzdjEiqOiFpCaLLoUvdHRb+4wL8
        m2UK0ipAK1WeYcf+s+zqdcfr18s+
X-Google-Smtp-Source: ACcGV63A2n3trH0PE2sP8MucIsHO0vF03q607R//7CmsTHEbWqfhpDfELgiV7vHD6aFCprz1B91n/A==
X-Received: by 2002:a63:f110:: with SMTP id f16-v6mr21684725pgi.236.1539011825875;
        Mon, 08 Oct 2018 08:17:05 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id x186-v6sm25410504pfx.152.2018.10.08.08.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 08:17:05 -0700 (PDT)
Date:   Mon, 08 Oct 2018 08:17:05 -0700 (PDT)
X-Google-Original-Date: Mon, 08 Oct 2018 15:16:58 GMT
Message-Id: <725ebadc92a91469eed089eb501b705c2dd2c627.1539011820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.27.git.gitgitgadget@gmail.com>
References: <pull.27.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] midx: close multi-pack-index on repack
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When repacking, we may remove pack-files. This invalidates the
multi-pack-index (if it exists). Previously, we removed the
multi-pack-index file before removing any pack-file. In some cases,
the repack command may load the multi-pack-index into memory. This
may lead to later in-memory references to the non-existent pack-
files.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/repack.c | 4 ++++
 midx.c           | 6 +++++-
 midx.h           | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index c6a7943d5c..7925bb976e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -432,6 +432,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 			if (!midx_cleared) {
 				/* if we move a packfile, it will invalidated the midx */
+				if (the_repository->objects) {
+					close_midx(the_repository->objects->multi_pack_index);
+					the_repository->objects->multi_pack_index = NULL;
+				}
 				clear_midx_file(get_object_directory());
 				midx_cleared = 1;
 			}
diff --git a/midx.c b/midx.c
index 999717b96f..fe8532a9d1 100644
--- a/midx.c
+++ b/midx.c
@@ -180,9 +180,13 @@ cleanup_fail:
 	return NULL;
 }
 
-static void close_midx(struct multi_pack_index *m)
+void close_midx(struct multi_pack_index *m)
 {
 	uint32_t i;
+
+	if (!m)
+		return;
+
 	munmap((unsigned char *)m->data, m->data_len);
 	close(m->fd);
 	m->fd = -1;
diff --git a/midx.h b/midx.h
index a210f1af2a..af6b5cb58f 100644
--- a/midx.h
+++ b/midx.h
@@ -44,4 +44,6 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 int write_midx_file(const char *object_dir);
 void clear_midx_file(const char *object_dir);
 
+void close_midx(struct multi_pack_index *m);
+
 #endif
-- 
gitgitgadget

