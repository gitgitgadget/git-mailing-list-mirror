Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B32F81F461
	for <e@80x24.org>; Fri, 17 May 2019 18:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfEQSlv (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 14:41:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44923 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfEQSlu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 14:41:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id b8so11867451edm.11
        for <git@vger.kernel.org>; Fri, 17 May 2019 11:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9XRIr2i4RdGUwhOJrFCnq0jWsIJlTJ2429nIYb6DdVQ=;
        b=MyBsb7O+da9+43LSkpmJC6tLraVraf49QiXR9DXBrcC8dFhx/QJJd7uiK2bX2gojYR
         jt/mkSRnaR5iOXhjSYxyQwSsWD9ePlbjq+gtlp1xzzykUkyovEUz4h0TMY1cpeVl70TQ
         ExTMV1WE4UyJOsbdIc40N6XT1uNaMw9NwBFAdrsVaxuZ6svWDz6hYZYEp2v4zKZTSdvm
         A92XDztClf4RG2CP+xWwFP2Cx7b20/VVe4s5jPU62E6fciSlOGrnVhCvpPYmX9yCKY4a
         nw4FRO0Vonewr4Kdaa8nbrrZw2TBadNShKQ4NI6HVhOSUXE/J18Jw9x2X2ymheKMIgQ2
         ZBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9XRIr2i4RdGUwhOJrFCnq0jWsIJlTJ2429nIYb6DdVQ=;
        b=Ep7/O2tvJGWVo6rZPTnM3zdN9VEOCpkL4NSgSTdK9+sMYS+xiitehSDOjceGgo6UUz
         EXG2cgS70xVVz5pGeUGaQvUvvs1ElzoMxMjIbGARKiQXVd9qxhpMIvc4hvWTCB1bcT6h
         j0aWCDis1dLkv203EFNJ1NSkdNUykW0qT6u+4DlkcnlseZVD15Ru63oI92gewiTMbsRR
         u2a+EqFWvpvxvCNYmzsy/eO0bL27Mpmg9Qeg6huBz95W8HfQcqhiAFHOWRGQPb6QNgAD
         afoz/7MSrEX4SokuWVknHwYCRUkfI2anbou6wmgJveVktpF21Flg2N1RGCMxGI38pPuT
         vbeQ==
X-Gm-Message-State: APjAAAUwIYmj1hNNg8qgHVdJmSF2ILyL5etA8Oyj2pigUwbz+DOLrEIZ
        /VyiHtiQsvhaKN7u+EY3Lf5l18B8
X-Google-Smtp-Source: APXvYqwQEkALPTDsBfkHpuup7zP5drQiIYZHN6u17c2PsZs0e+vTfcDkYt2cEIgxtZul5aLl6C0zig==
X-Received: by 2002:a17:906:6410:: with SMTP id d16mr46145147ejm.75.1558118509168;
        Fri, 17 May 2019 11:41:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e35sm3006513eda.2.2019.05.17.11.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:41:48 -0700 (PDT)
Date:   Fri, 17 May 2019 11:41:48 -0700 (PDT)
X-Google-Original-Date: Fri, 17 May 2019 18:41:45 GMT
Message-Id: <e4811af2ecb72fbaf22e41c74d9fe0dc6fef246e.1558118506.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.208.git.gitgitgadget@gmail.com>
References: <pull.208.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] packfile: close commit-graph in close_all_packs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The close_all_packs() method is used to close all read handles to
pack-files and the multi-pack-index before running 'git gc --auto'.
This is particularly important on the Windows platform, where read
handles block any writes to those files. Replacing one of these
files with a rename() will fail in this situation.

The commit-graph also performs a rename, so is susceptable to this
problem. We are careful to close the commit-graph before writing,
but that doesn't work when a 'git fetch' (or similar) process runs
'git gc --auto' which may write a commit-graph.

Here, close the commit-graph as part of close_all_packs().

Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 packfile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/packfile.c b/packfile.c
index 16bcb75262..ce12bffe3e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -16,6 +16,7 @@
 #include "tree.h"
 #include "object-store.h"
 #include "midx.h"
+#include "commit-graph.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -350,6 +351,8 @@ void close_all_packs(struct raw_object_store *o)
 		close_midx(o->multi_pack_index);
 		o->multi_pack_index = NULL;
 	}
+
+	close_commit_graph(o);
 }
 
 /*
-- 
gitgitgadget

