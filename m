Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA8791F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390305AbeIUUyq (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 16:54:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39615 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeIUUyp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 16:54:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85-v6so3116011pge.6
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9o1A6gK2lpR75ydfqNNDKYzqCx33uR6V0jTqUevtWrk=;
        b=nR8uk2+TEm1itwc8qYUL1fOgnM6fRC0PDW0tDXv/7y6/ZPrSSm1UaE19X1O5QzMSdI
         sNUaC3sjivRXq/4CrfsPMd9PDeB0BERVpHXe9OZayMTKH79ZxSpRre2GV1IDaeWLRAK/
         439lvs3d5rUi0bQuLKcH1gFB9+KWyENiOdyitGslksv9zFXR7oS4PngKRQazAXx7bfRV
         kbXUHBNCGHMSSqKndF/05RX2AjSJQXsS2GFohGXaS1D0fy9kJ0dYo1cxnmGt0efwwXmj
         vYvByyNohyfwFQh9+K1zDJL/pSRmSflXa+Rz9KsdgFtf4UvPskwMz7MePfWIxAWWwgxR
         dK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9o1A6gK2lpR75ydfqNNDKYzqCx33uR6V0jTqUevtWrk=;
        b=rKZCfV5cIaHlHAMqaif7+kLFGiuyGtApeBOoLIN/vrU5TWT75CG31N/rFiVuh9YPa1
         dPUJnXlJsO5bgFj2OgZE43LnIC0Aj2sQbfWOe8PerR9jW096ssaVkhkosSEGujQbIhSD
         evx5THdU3dZRhbB12WkdyqvbB4hcG3Ah5gLfvhh1SrQF8QAGwSN6hhDa0uqojVSZd2TV
         CmCqsTkYSG7X1nkNBnR0syBAUyG0YEVc0iEz5fBgyPtXv9vFjl2pbU/F9HfVOXCPBI3d
         BHD9oo6xk2bLa5ndOfp2xYxHOGi48OK1Oqqm4VperN+uX0tzAMnHBWm7nKkFJK59n3nP
         ZvNQ==
X-Gm-Message-State: APzg51CSFuoQzcSetmccbktneRN54JifLbfHdfyjplNc2gZ2B020GRrl
        QHYQ7xGx/EfhEEg7hvXUCGo1rlmt
X-Google-Smtp-Source: ANB0VdYZbofx5RU8GLzuHj5Sl/rqbtQ/aeTjO0O9O38EUY5zuIfjid5cDjspIZsebr7Nec+HIWq4pQ==
X-Received: by 2002:a62:8d16:: with SMTP id z22-v6mr47540878pfd.181.1537542328550;
        Fri, 21 Sep 2018 08:05:28 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id b14-v6sm49181519pfc.178.2018.09.21.08.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:05:27 -0700 (PDT)
Date:   Fri, 21 Sep 2018 08:05:27 -0700 (PDT)
X-Google-Original-Date: Fri, 21 Sep 2018 15:05:22 GMT
Message-Id: <b2e0ee49788bfbf2182df7a93694333568552962.1537542323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.39.v3.git.gitgitgadget@gmail.com>
References: <pull.39.v2.git.gitgitgadget@gmail.com>
        <pull.39.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 2/2] commit-reach: fix memory and flag leaks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The can_all_from_reach_with_flag() method uses 'assign_flag' as a
value we can use to mark objects temporarily during our commit walk.
The intent is that these flags are removed from all objects before
returning. However, this is not the case.

The 'from' array could also contain objects that are not commits, and
we mark those objects with 'assign_flag'. Add a loop to the 'cleanup'
section that removes these markers.

Also, we forgot to free() the memory for 'list', so add that to the
'cleanup' section.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index e748414d04..5a845440a9 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -626,6 +626,11 @@ cleanup:
 		clear_commit_marks(list[i], RESULT);
 		clear_commit_marks(list[i], assign_flag);
 	}
+	free(list);
+
+	for (i = 0; i < from->nr; i++)
+		from->objects[i].item->flags &= ~assign_flag;
+
 	return result;
 }
 
-- 
gitgitgadget
