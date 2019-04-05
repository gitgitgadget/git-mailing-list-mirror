Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB76020248
	for <e@80x24.org>; Fri,  5 Apr 2019 17:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfDERJk (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 13:09:40 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:50475 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730587AbfDERJk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 13:09:40 -0400
Received: by mail-vk1-f201.google.com with SMTP id k78so2818138vkk.17
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 10:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bB5CJoTccP5ipZaDNn8+ntfmBTQy9oGTgOE2n2WWmT4=;
        b=jkV5CHskFPgMdhk6+S0hWV20p5MGoocQNa4j1FVlP1XUoGhOrCfWXc8Nz5dS3HvyOM
         HVg90cMw3qc9uSUlo8BqqiABqu5hV180GBjmwAUf1GpfzJENiQCPQAM/mEc/3uOrKvkP
         R9vitb+/QXMT8iQeO1dlLLuL83XjWZ4Fvs1JQ7NuImOkLvwPxXHk3X1inUGghCGZjxza
         6mEszrgQygGeQAw6a8JEcagUSg5chO8CUX587Aj13OazraNpmAckflqVmiz88p6AkoGL
         Hmp+MxTiqjdlj+XDv3wvmW6aGo0Qpj9j8vRBwNAKC0g2hXD+6Va+ld5wrmWgryn3vpsu
         4SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bB5CJoTccP5ipZaDNn8+ntfmBTQy9oGTgOE2n2WWmT4=;
        b=Pa47TWtS6ZOCRhKOSaVYY0qw3RCVpgtcczqDD4pP84HrxNjtJ2zhoKKfv0R3/7oEj4
         hH7hTolD0RWz/R3Q3jFXlZEPuQ1se7mEMdIFk3qZq0SZXX/mLAmBZbWSqcpLozgbly83
         WcKS+2DYySgD76Y9JPwD6mogva+g8jaYDRpNVyEcg7gwbwow2MHL0plSpkhPloi7MLHg
         lvPHPWXtjF2JLtEbctbea7LLT7HtLvHWvHhAavRUaI8hUOgL0XplHT7cRFzjpFUtd9PI
         tcMaIJS7lKSSvwr/N0UgaHvfdMYM9sBa2KxK1hgSf0sF7bBZjKed59RZhTpR00OY1sMF
         0bcw==
X-Gm-Message-State: APjAAAVe5CIbWi+G//BFnPVAcCmHebGHmQgw3qhEDlWAOJ9J4+JXoLVV
        xNUnfRohzx2t9MD/7a46zIdzNORR82kwXFa+zQBrXK7D6fDWKYwj0I0inpdajwp/ONivobnGNfl
        3OUxMUgx8x3olFBR5I18oXmj+TN9g2/xxJi3vDTcr9enWen83XzX+Cytsn+DiORV9dI0Qcq+aFG
        Af
X-Google-Smtp-Source: APXvYqzNnrAC/PQlbvSykAgufU9IIePjTL5lB0aUZMC6LMIcAcGQzRKZ4VFyyM86VFkoRldHacRBcU52ngA/ZbMEmezu
X-Received: by 2002:a1f:9010:: with SMTP id s16mr1615819vkd.12.1554484179262;
 Fri, 05 Apr 2019 10:09:39 -0700 (PDT)
Date:   Fri,  5 Apr 2019 10:09:34 -0700
In-Reply-To: <CACsJy8CgXLZxqab4vcP1jh3OMCGh1i=easb5BpCs1J8Uf_jsxw@mail.gmail.com>
Message-Id: <20190405170934.20441-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CACsJy8CgXLZxqab4vcP1jh3OMCGh1i=easb5BpCs1J8Uf_jsxw@mail.gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] fixup! diff: batch fetching of missing blobs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a fixup on the tip of jt/batch-fetch-blobs-in-diff (571debe1d9).

I don't know if Junio has already merged this branch to next (he marked
this as "Will merge to 'next'" in the "What's Cooking" email, but when I
fetched, it hasn't been merged yet). If he has, we can use this commit
message:

diff: propagate options->repo to add_if_missing

Avoid a usage of the_repository by propagating the configured repository
to add_if_missing(). Also, prefetch only if the repository being diffed
is the_repository (because we do not support lazy fetching for any other
repository anyway).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks, Duy, for noticing this.
---
 diff.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 1eccefb4ef..811afbdfb1 100644
--- a/diff.c
+++ b/diff.c
@@ -6367,18 +6367,19 @@ void diffcore_fix_diff_index(void)
 	QSORT(q->queue, q->nr, diffnamecmp);
 }
 
-static void add_if_missing(struct oid_array *to_fetch,
+static void add_if_missing(struct oid_array *to_fetch, struct repository *r,
 			   const struct diff_filespec *filespec)
 {
 	if (filespec && filespec->oid_valid &&
-	    oid_object_info_extended(the_repository, &filespec->oid, NULL,
+	    oid_object_info_extended(r, &filespec->oid, NULL,
 				     OBJECT_INFO_FOR_PREFETCH))
 		oid_array_append(to_fetch, &filespec->oid);
 }
 
 void diffcore_std(struct diff_options *options)
 {
-	if (repository_format_partial_clone) {
+	if (options->repo == the_repository &&
+	    repository_format_partial_clone) {
 		/*
 		 * Prefetch the diff pairs that are about to be flushed.
 		 */
@@ -6388,8 +6389,8 @@ void diffcore_std(struct diff_options *options)
 
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			add_if_missing(&to_fetch, p->one);
-			add_if_missing(&to_fetch, p->two);
+			add_if_missing(&to_fetch, options->repo, p->one);
+			add_if_missing(&to_fetch, options->repo, p->two);
 		}
 		if (to_fetch.nr)
 			/*
-- 
2.21.0.392.gf8f6787159e-goog

