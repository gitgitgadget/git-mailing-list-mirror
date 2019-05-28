Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71EEB1F462
	for <e@80x24.org>; Tue, 28 May 2019 15:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfE1PTK (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 11:19:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33880 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfE1PTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 11:19:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id p27so32376335eda.1
        for <git@vger.kernel.org>; Tue, 28 May 2019 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GvPuNGFecoM81GAH9Nujinb+/fIOr27aWstSX5af8Nc=;
        b=FQ6AhYVppkw6lSqs3oXV0YjkjiGZPOdo0MhYcinnwV93u0mPZ9z/sEnfsLc2Sss7Lc
         NPa4TYwr7U99Y+tUPo8hIfqxKVmdEnKtyYSicLLVDRO9Kyhpu6NjJSzrc64Cpny1k/ET
         Pv+Qp+DDHcU/X8U56gSxhryB7txVI6cF/tUF+sk51SZDXbArZ83iuF9cxhNg6KiwAJ0q
         rbEYYYIxay14f2+OJ1h+NcA/qnu7V3oORqjGJICZFM3Bokhv60TveUxmmbmr/QFk1h2Y
         6joS2TmAaoEszUysY012tV0BHlk6hDXw6SraCkF+7q9aSWo4qlitwnx8DCIAsITv+/M6
         1NEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GvPuNGFecoM81GAH9Nujinb+/fIOr27aWstSX5af8Nc=;
        b=DCMCjIdKuXy2n02QU6IBzVJ3tWWBZZqMRps+k2Sr/ss2q6oF2bd0ntFmNaFjpXdCyS
         LHvGxzJqUiB+QhLY3K+nqdKGYxSw2wFPDmrsn/rwyRwh9yMUhhyF1rBrvLMipNmokNr1
         b20kDqcntmJ9mFVdmsJrgs90fLHSAfrZJ0S6CX3TRS3H5e+iUHs3+jQPWV3/Yx+Yp7hT
         gV34EUESOQIaSTOclXDKb+wnLXwOUm1B1AW1aizhPgOKfguzMQT3oWsw0KHfsEMyjcgM
         1FF52tk0GrU+UhSAQYFZADcaYaVp8hHgu7BlUp/m2IY8cieEJsCBerZR6AQy/IpA0Bzf
         yNfw==
X-Gm-Message-State: APjAAAU4/k8WaoHUr0l38ur0jmzRo51jXX8qiSwfo/hJSfNTLKjWqwWe
        8eYB41ky9ICcbJzjf0NIXww7YmSVbXY=
X-Google-Smtp-Source: APXvYqzlOQkyMTk/xMWd92LlMACJCJ4adgYC2CXi+2Z/03apjLhoLb+BFmUyKUm6bR4zxok5YIRc6A==
X-Received: by 2002:a17:906:52c9:: with SMTP id w9mr4510888ejn.118.1559056748062;
        Tue, 28 May 2019 08:19:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm2286801eja.58.2019.05.28.08.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 08:19:07 -0700 (PDT)
Date:   Tue, 28 May 2019 08:19:07 -0700 (PDT)
X-Google-Original-Date: Tue, 28 May 2019 15:19:05 GMT
Message-Id: <2737e62966cae2f00d75a93446bad76e5816d07e.1559056745.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.228.git.gitgitgadget@gmail.com>
References: <pull.228.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] sha1-file: split OBJECT_INFO_FOR_PREFETCH
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The OBJECT_INFO_FOR_PREFETCH bitflag was added to sha1-file.c in 0f4a4fb1
(sha1-file: support OBJECT_INFO_FOR_PREFETCH, 2019-03-29) and is used to
prevent the fetch_objects() method when enabled.

However, there is a problem with the current use. The definition of
OBJECT_INFO_FOR_PREFETCH is given by adding 32 to OBJECT_INFO_QUICK. This is
clearly stated above the definition (in a comment) that this is so
OBJECT_INFO_FOR_PREFETCH implies OBJECT_INFO_QUICK. The problem is that using
"flag & OBJECT_INFO_FOR_PREFETCH" means that OBJECT_INFO_QUICK also implies
OBJECT_INFO_FOR_PREFETCH.

Split out the single bit from OBJECT_INFO_FOR_PREFETCH into a new
OBJECT_INFO_SKIP_FETCH_OBJECT as the single bit and keep
OBJECT_INFO_FOR_PREFETCH as the union of two flags. This allows a clearer use
of flag checking while also keeping the implication of OBJECT_INFO_QUICK.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 object-store.h | 10 +++++++---
 sha1-file.c    |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index dd3f9b75f0..c90628d839 100644
--- a/object-store.h
+++ b/object-store.h
@@ -282,10 +282,14 @@ struct object_info {
 #define OBJECT_INFO_IGNORE_LOOSE 16
 /*
  * Do not attempt to fetch the object if missing (even if fetch_is_missing is
- * nonzero). This is meant for bulk prefetching of missing blobs in a partial
- * clone. Implies OBJECT_INFO_QUICK.
+ * nonzero).
  */
-#define OBJECT_INFO_FOR_PREFETCH (32 + OBJECT_INFO_QUICK)
+#define OBJECT_INFO_SKIP_FETCH_OBJECT 32
+/*
+ * This is meant for bulk prefetching of missing blobs in a partial
+ * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
+ */
+#define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
 
 int oid_object_info_extended(struct repository *r,
 			     const struct object_id *,
diff --git a/sha1-file.c b/sha1-file.c
index ad02649124..0299fdd516 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1371,7 +1371,7 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 		/* Check if it is a missing object */
 		if (fetch_if_missing && repository_format_partial_clone &&
 		    !already_retried && r == the_repository &&
-		    !(flags & OBJECT_INFO_FOR_PREFETCH)) {
+		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
 			/*
 			 * TODO Investigate having fetch_object() return
 			 * TODO error/success and stopping the music here.
-- 
gitgitgadget
