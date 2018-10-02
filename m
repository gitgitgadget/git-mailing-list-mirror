Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D78FA1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 14:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeJBVmh (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 17:42:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38816 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeJBVmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 17:42:36 -0400
Received: by mail-pl1-f196.google.com with SMTP id b5-v6so1824333plr.5
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rDJX4HTSVABF8MGpNvGjFcQY2O4XlSDRvIpNMXEFdhw=;
        b=q7d7BdWibBdUlJrXfWJFRFWXiV0sqdIMyNXsW0aERLXb2NbrBufNpKyDEXgPI1tq3q
         vQpjVrnV894G8gQE9UtxKl/YjXS/SzgyYC6dYA23pKXCjnUgf44AgbM7754lxtioWGyv
         naU3xbIQ276HGIDNKKyIR9oI0ZSVcN7lbYRWDs+sDCK9OZAHa8Df+poP/PEUM7uaHdxY
         ylOSVoPl2sjz5W/gu+O7UM9Q/U6K9FuOpD+5vnL3Fi1xlW1krhYZDs3/0Ixabg5nmcWr
         Rn6/vGIzTunuE6KVQZVV9UdUzeZ+bzVg9LNoqkxJT8v89DOxyKCscOyZWuxxXDMCgJKW
         ANwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rDJX4HTSVABF8MGpNvGjFcQY2O4XlSDRvIpNMXEFdhw=;
        b=nZRycoLZ7F2qIgxu+AH9eswUyE6z9smMr2NSCWeC1prDe85y/zW9Eak6mfFujOEsVO
         E5weLpP66l/uwLrECfzL0mIs/F4iJFcvcA9mXKsnOjwm/xvhhP+vHFcRBR/GdQq2Fa06
         /dFKschUmFAtmxxWC7jW6i96fzt5PwLnaciejFkJ9PGrOrSk5EtgcyX0fo1OV20mLI/V
         G4yPXPu0Fq+LX6XVGYAwJSKOOKik/CyCmaaWsiMmx6Qv7kg9inJtLihrM8n8rT20qF0N
         B3cJ4Ne8Rx7YLJnvZHUk1TJm2LSrQcWD3dh18rueJMlgsj+Tu4fiHjKZdYiz8NU4/3/4
         qGKQ==
X-Gm-Message-State: ABuFfojKYQVzn0VMnpXlvZBhrTgXFLXPGi2FPSPoTRj+CwcG1pS3r65o
        82El44nak3YuvDOW2Pg6CVcXmjgy
X-Google-Smtp-Source: ACcGV620r87VSW6/HN5S2eaGmCbQ3rZdeF37JOVrSr+0yhX68rVPKA8oct3LLklmmiwHy347RtjnaQ==
X-Received: by 2002:a17:902:29e3:: with SMTP id h90-v6mr17174015plb.215.1538492327531;
        Tue, 02 Oct 2018 07:58:47 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id w23-v6sm22060861pgi.18.2018.10.02.07.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 07:58:46 -0700 (PDT)
Date:   Tue, 02 Oct 2018 07:58:46 -0700 (PDT)
X-Google-Original-Date: Tue, 02 Oct 2018 14:58:41 GMT
Message-Id: <e29a0eaf032fa011e30a91d8f8c514eefe12d14c.1538492322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.42.git.gitgitgadget@gmail.com>
References: <pull.42.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] commit-graph: reduce initial oid allocation
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

While writing a commit-graph file, we store the full list of
commits in a flat list. We use this list for sorting and ensuring
we are closed under reachability.

The initial allocation assumed that (at most) one in four objects
is a commit. This is a dramatic over-count for many repos,
especially large ones. Since we grow the repo dynamically, reduce
this count by a factor of eight. We still set it to a minimum of
1024 before allocating.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 7226bd6b58..a24cceb55f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -721,7 +721,7 @@ void write_commit_graph(const char *obj_dir,
 	struct progress *progress = NULL;
 
 	oids.nr = 0;
-	oids.alloc = approximate_object_count() / 4;
+	oids.alloc = approximate_object_count() / 32;
 	oids.progress = NULL;
 	oids.progress_done = 0;
 
-- 
gitgitgadget
