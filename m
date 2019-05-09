Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 538401F45F
	for <e@80x24.org>; Thu,  9 May 2019 14:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfEIOWe (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 10:22:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33933 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfEIOWd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 10:22:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id p27so2227362eda.1
        for <git@vger.kernel.org>; Thu, 09 May 2019 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eSEy4lb7WYgAWpgS/k1w9gk9+9sz/RGuF/mmdJjwxO0=;
        b=IDXQVWdcZyB41s3LniC6DSSP3N4qYqHCVvPv15BbhzwlBWfOTBODvFmhPdtSdLajYQ
         MKUTyEGhMQpSkWZNsKx3yK45iWIu8ABqczUNU9at+kElwfByXDIinTAIDKq5xFF5Q+Oj
         2o/6v94JuIGYDi5UzHjNkbicvIKSKqzN+W9SZSVYvO3l3XMRFxMMqE3VFzMTgRdi8XQ4
         aezesOynYkJvyPHgqFX/BNE6P2vZFc0JL/iuyUrwadhunA3FnCmqWBJPtgTYJL28+TxP
         pIrFeflLvoyvDdNUc/0WLm5+T+bTioDrZrdXfRwnS3v+CQR1ivL9laC983Qrgr7jrnR6
         ym2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eSEy4lb7WYgAWpgS/k1w9gk9+9sz/RGuF/mmdJjwxO0=;
        b=Sb82Pob0ZLHoopJXE9aJ+gfKRmyYJRA9i0fS0e8v/7yAfFcxVMQQRjss8Ey67SwUsC
         FzSGFhAgxzwpepzVdwNje8LPlKEsfq/JC9DLQ1/33L08cE1aFf2/unC1Dzf2TOSHMLXP
         0+b3tC8FWqIzPCRFhdduUHyVdJ35W7uEFa1shlBXwc86FFCPqM/tvz+wB21acXngw3eN
         TNeXa1jd534lhnzBNQPaqrZHskAAoH35VZDJE4gcN448EbfYd9RS6G/0Qw2r0e+2mEcV
         8kaF7A8PWh+waraRbaIPHF2V7qXm6/6dAdNBCszCvGRjZrD/Gd740Mr8B0n1t+NACRyx
         bY0Q==
X-Gm-Message-State: APjAAAUKaVOvQLyc6arwgVe8TpMWU1ApCyffApbMlHybkgoTvxLE0k2u
        LD/nr4O324jqKCjqAnwWNr0+s83a
X-Google-Smtp-Source: APXvYqwp4Odvw3MyidlOXDc7cPXDJBn2M+VQEU5yPNS0MZhextLhsy3jT3qxxh9ojorTeeRj7chkcA==
X-Received: by 2002:a17:907:20ac:: with SMTP id pw12mr336312ejb.284.1557411751996;
        Thu, 09 May 2019 07:22:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm337597ejo.45.2019.05.09.07.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 07:22:31 -0700 (PDT)
Date:   Thu, 09 May 2019 07:22:31 -0700 (PDT)
X-Google-Original-Date: Thu, 09 May 2019 14:22:19 GMT
Message-Id: <0be7713a255d6f52c51ccb19299d0c9797e9a03f.1557411749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v4.git.gitgitgadget@gmail.com>
References: <pull.112.v3.git.gitgitgadget@gmail.com>
        <pull.112.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 01/11] commit-graph: fix the_repository reference
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The parse_commit_buffer() method takes a repository pointer, so it
should not refer to the_repository anymore.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index a5333c7ac6..e4d1233226 100644
--- a/commit.c
+++ b/commit.c
@@ -443,7 +443,7 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	item->date = parse_commit_date(bufptr, tail);
 
 	if (check_graph)
-		load_commit_graph_info(the_repository, item);
+		load_commit_graph_info(r, item);
 
 	return 0;
 }
-- 
gitgitgadget

