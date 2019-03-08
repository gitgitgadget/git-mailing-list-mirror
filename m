Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48EEA20248
	for <e@80x24.org>; Fri,  8 Mar 2019 13:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfCHNGN (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 08:06:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46824 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfCHNGM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 08:06:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id g6so14129493pfh.13
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 05:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=f7VMsalbpBE+gu7S3SYCp8z6fApu235RSTIxr1cs0yM=;
        b=ANwitaLrQPN+n7zx3zVDr4Pj8EbwNIw2bW2tPJF8wqALUS311tLzI4K35ihIBROfXQ
         6mUZ3ed4xU5Oe/ZJDhMiyVyHFdMILhhqPKdB2dJqz9BxR+uxuBZqOaUTrADcVsC/A4m5
         ANjjjuRHnevWQL6VNJGAWr8Vs3zS3MVE+iYQ7ccKaPlFuLm6ACj3ThVLoXLc1a0rnX4B
         cKZou1Ye6gDgXdVFlcp4+0vnAUQtR7NaL2fIzn54ukRyGkpgudGCsj1jEPhA19X+gEcD
         Ki5YxBeTx5KV5nblP1uo34vbZKoXvxzMfZI659JVSFddhkqvJdJJurjI/AfAqVZq+at4
         hhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=f7VMsalbpBE+gu7S3SYCp8z6fApu235RSTIxr1cs0yM=;
        b=cXPUd5bmCLZ2//Q6IGf8orpf1yvAW5ESt2mHWs3AavdshY7GOAtNolgcyFAjI0tye2
         8YJi4UtpTXB1F87tmTaVwj3KGCS85qEbmNLmafSYdIXmkg1OqHUL9BxuwP3unkQiPG8R
         XMY1aw8hfSApPtq9blp5u6e1ipEQn8PR8XQQS6y+ZdYANs0MvxVUy19zlx8Zf9hrYIRu
         h9oRUyqOa+U//Hh0G7itnC8qed+h7EEHRtdGso8onbUQzejp6s+i1iUNyt0NF8BpZerW
         bNFFKWyz9Gm4x9qatAa6fj5TJY81DBrmvO0EoDHSIHyXWMUSRvWkR0ym4cnfoI5Q6AII
         5V4w==
X-Gm-Message-State: APjAAAVzmKNfV66RGbF+gFg9eGu8F5tkq/opGVdl92625i20xzH4Ve4X
        2yJslKHupy5LOIzEV2qno1NR32Y8X9s=
X-Google-Smtp-Source: APXvYqziEa7T9xQno/2jySUlilA0FmeocT+xI3eezNZAdHcg8L6aSg153vxPanSssBlgyacJbeJyFQ==
X-Received: by 2002:a63:43:: with SMTP id 64mr16485576pga.64.1552050371558;
        Fri, 08 Mar 2019 05:06:11 -0800 (PST)
Received: from hacker-queen ([157.45.194.51])
        by smtp.gmail.com with ESMTPSA id t10sm21855113pfa.151.2019.03.08.05.06.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 05:06:11 -0800 (PST)
From:   sushmaunnibhavi <sushmaunnibhavi425@gmail.com>
X-Google-Original-From: sushmaunnibhavi <sushmaunnibhavi@gmail.com>
Date:   Fri, 8 Mar 2019 18:36:05 +0530
To:     git@vger.kernel.org
Subject: [PATCH 1/2] modified dir-iterator.c
Message-ID: <20190308130605.GA20220@hacker-queen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
Some places in git use raw API opendir/readdir/closedir to traverse a directory recursively, which usually involves function recursion. Now that we have struct dir_iterator,we have to convert these to use the dir-iterator to simplify the code. 

Signed-off-by: Sushma Unnibhavi <sushmaunnibhavi425@gmail.com>
 dir-iterator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index f2dcd82fde..a3b5b8929c 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -169,7 +169,7 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
 		struct dir_iterator_level *level =
 			&iter->levels[iter->levels_nr - 1];
 
-		if (level->dir && closedir(level->dir)) {
+		if (level->dir && (struct dir_iterator_int *)(level->dir)) {//changed closedir to (struct dir_iterator_int *)
 			strbuf_setlen(&iter->base.path, level->prefix_len);
 			warning("error closing directory %s: %s",
 				iter->base.path.buf, strerror(errno));
-- 
2.17.1

