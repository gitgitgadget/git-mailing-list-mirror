Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF291F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 17:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeJMBH4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 21:07:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43871 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJMBHy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 21:07:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id 30-v6so6236265plb.10
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8ggjSC0irLvzTbC/t3yoixFxsAPdmRt+s46lSMFd2V4=;
        b=LnPQTy6hRWW8SOZNI4bvD3ZeVtIwpPKrkgQWOXjAZOiwlPTtuB+lBLFnp6P5r+X1BY
         PPu9lxIMOHs1zG63pnuU5M3y/ZGHnfM1t9g3KAfs673l1K4tjDMdClp1dKYgp7Ba18GY
         dRPRAX7XsESkXgRmQyYzqdVzYZlYF2QcU2/2Akn00WDU7v+vit7wRIrvF3JE7BtkX8de
         FvIRVHXF3zREbTiolfJaAC7Y+zvDRSfzoKdoaqDEHCJuzh3vRBWgWTsJO30LRuNE1Az4
         7eTftXgI23mkbGFre7u0iTGkg8pEhctfMg9WcR/EuGhBDCc1iBikN1WbO+75SNilh3i4
         S1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8ggjSC0irLvzTbC/t3yoixFxsAPdmRt+s46lSMFd2V4=;
        b=QAbLye0aM4I+Y0LOmbqYcYS3LweJUMzoG6WIajKbi4jM3GEbHK3YJXwBGzEGXRcww5
         Aecr+pL6MifaSHAbi3wzWOZCfb+HUIvLZcBvUgTIW2IoX3iWQ2zm/RUlTnxmMpowNQ2E
         yLf5wR9LmzlMrcOwVaN6RJFSIRt4GXl0RR68jW2OCEfd1Gk/SqeoWClTrckqMDTc2ICp
         c3/TDmVhXXZCkY3qXIZszDrMGmWbZGFBSvcAoe+sCf4eXSNVzy88aUogJ/5kyKNh9jVa
         5tI+/iv2yymgr6WyEahyGLfUo5aD15cF2kNPqiXoY7Ebnd6CUgNC2h+Avo5pgp6/5sbs
         kW0Q==
X-Gm-Message-State: ABuFfojQhjDjBqWUzw/gF2t5qvH4E+rZv6YVem2UBDdzldA8CjJyJOWy
        vTXXNsn5yeiL+fX41RmY49kKcytS
X-Google-Smtp-Source: ACcGV60UhpnjZO7O58/EOUxdnYYmU3aQm0sFMrMp8qn7sLs8mJbGy9R8Cd9zedb96mXWiSpmepBpXg==
X-Received: by 2002:a17:902:7486:: with SMTP id h6-v6mr6544547pll.29.1539365660003;
        Fri, 12 Oct 2018 10:34:20 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id v190-v6sm4466613pgb.16.2018.10.12.10.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 10:34:19 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:34:19 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Oct 2018 17:34:13 GMT
Message-Id: <2d8f26679d4ba18d7a080a5e6be993198f9b1da2.1539365654.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.27.v2.git.gitgitgadget@gmail.com>
References: <pull.27.git.gitgitgadget@gmail.com>
        <pull.27.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/3] midx: close multi-pack-index on repack
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
 builtin/repack.c |  3 +--
 midx.c           | 15 ++++++++++++---
 midx.h           |  4 +++-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index c6a7943d5c..44965cbaa3 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -431,8 +431,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			char *fname, *fname_old;
 
 			if (!midx_cleared) {
-				/* if we move a packfile, it will invalidated the midx */
-				clear_midx_file(get_object_directory());
+				clear_midx_file(the_repository);
 				midx_cleared = 1;
 			}
 
diff --git a/midx.c b/midx.c
index bf1f511862..22247a30ab 100644
--- a/midx.c
+++ b/midx.c
@@ -176,9 +176,13 @@ cleanup_fail:
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
@@ -914,9 +918,14 @@ cleanup:
 	return 0;
 }
 
-void clear_midx_file(const char *object_dir)
+void clear_midx_file(struct repository *r)
 {
-	char *midx = get_midx_filename(object_dir);
+	char *midx = get_midx_filename(r->objects->objectdir);
+
+	if (r->objects && r->objects->multi_pack_index) {
+		close_midx(r->objects->multi_pack_index);
+		r->objects->multi_pack_index = NULL;
+	}
 
 	if (remove_path(midx)) {
 		UNLEAK(midx);
diff --git a/midx.h b/midx.h
index ce80b91c68..0f68bccdd5 100644
--- a/midx.h
+++ b/midx.h
@@ -42,7 +42,9 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_name);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
 
 int write_midx_file(const char *object_dir);
-void clear_midx_file(const char *object_dir);
+void clear_midx_file(struct repository *r);
 int verify_midx_file(const char *object_dir);
 
+void close_midx(struct multi_pack_index *m);
+
 #endif
-- 
gitgitgadget

