Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1529B1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 03:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfJODbc (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 23:31:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53246 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbfJODbb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 23:31:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id r19so19114454wmh.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 20:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FqNp4juXy36DOc2Eajdera6WYFQ0jhTIiYn1rESRxY4=;
        b=VrkQoVjiim+B8qjZybBOe13lSlnpqwe2xsHGYY2EwLajfrfUr/ArtsKna7vAr6IVOZ
         paPXr/PABr3ALUTZU6XwAdewJxuUaz+bVzui6k8hVI1z/NUFFt7mArhVwUHJBuX27X93
         L7uRE+e3uL7WDT5MaPvBeo2PmoJOjH+H8CAt/SNxbw/V54iXmHvvwbfaV3PxnzZhRSo/
         4qUJCQi89qthCdBHFmhpGoLwhTXZgi7sYB4LH8iptJwjT+C1vmKk3YmJVbH+5pIK6UQR
         J7wodgignQ6YOQCsd6GOK//nRWqW4Uupm+t8fLxr+SXxeuzxL8wfSar+KHPIgVGrln5/
         7FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FqNp4juXy36DOc2Eajdera6WYFQ0jhTIiYn1rESRxY4=;
        b=HyHldTCMx4IBZSOaSAEflZzv/ppulnBqPjp2AlXzyUiMQA96ufzOEl5qPDvPQ3j5sf
         nSqJtTSRgcC+Cz0iorWjqZr3hEWGZeTyVRGbIhRp6GNGhhw6LVFkD4PX2h4XmfJq2sdk
         QXZhhz6I4paatvQun6Jlo9gXWaMAE4B2Gd2RwshJ9fQR3sXA6vTB/AhRnwQpZV96uCCC
         Sey0zZPxd8UCMOeYV7ytzBYVzTWrsZaRUK9sOwQpcvT9FANm3inQ/Ea8oOp2h3NqIMTk
         3oOjyb/LXPjDAF7Ii4nzF4Z6g+wpES/bEbunlJ+NvkXMJnizFoquIa5xDr8tisa8Hymg
         89iA==
X-Gm-Message-State: APjAAAW9Qrk7DnkFK6EBs0//OqQpysbDzmdel22jZu+rQwE+k0XWo6X5
        feMs8SMHN14a6YJruxMJstM42PVS
X-Google-Smtp-Source: APXvYqx9frFsUfjOMNaKe25HfSfP/O0GKCIVgRsfRYpDT3eZAO61Mmx1K5chF/VYok8US/LmtCQOig==
X-Received: by 2002:a05:600c:22ce:: with SMTP id 14mr16868272wmg.71.1571110289466;
        Mon, 14 Oct 2019 20:31:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 74sm12328142wrm.92.2019.10.14.20.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 20:31:29 -0700 (PDT)
Message-Id: <2823d4d360b2f53c1d63ba742808eaee80ede1e4.1571110286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.397.git.1571110286.gitgitgadget@gmail.com>
References: <pull.397.git.1571110286.gitgitgadget@gmail.com>
From:   "Norman Rasmussen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 03:31:26 +0000
Subject: [PATCH 1/1] diff-highlight: fix a whitespace nit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Norman Rasmussen <norman@rasmussen.co.za>,
        Junio C Hamano <gitster@pobox.com>,
        Norman Rasmussen <norman@rasmussen.co.za>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Norman Rasmussen <norman@rasmussen.co.za>

This changes the indent from
  "<tab><sp><sp><sp><sp><sp><sp><sp><sp>"
to
  "<tab><tab>"
so that the statement lines up with the rest of the block.

Signed-off-by: Norman Rasmussen <norman@rasmussen.co.za>
---
 contrib/diff-highlight/DiffHighlight.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
index 7440aa1c46..e2589922a6 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -72,7 +72,7 @@ sub handle_line {
 	      (?:$COLOR?\|$COLOR?[ ])* # zero or more trailing "|"
 	                         [ ]*  # trailing whitespace for merges
 	    /x) {
-	        my $graph_prefix = $&;
+		my $graph_prefix = $&;
 
 		# We must flush before setting graph indent, since the
 		# new commit may be indented differently from what we
-- 
gitgitgadget
