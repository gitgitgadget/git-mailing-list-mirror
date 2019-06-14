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
	by dcvr.yhbt.net (Postfix) with ESMTP id 13F0A1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 12:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfFNMQL (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 08:16:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34134 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfFNMQK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 08:16:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so3247402edb.1
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qNCUwFDIQWpSa3qulD6X1fo+5QifvdCMOm50foZOXaU=;
        b=oGcuzE8ORUAiKefXCAyL/3sqoZUV6H183r+BJ4HjMshLkrqTPIxYcZOlKGISziCIEC
         uiYPJplbNLK1g7GxxjHyI4JiV4PQVXVYkOD80GJKov9DrGNN4ZJ0sbfknmO3JVV6auwN
         zgSE2AqEsfP2Qm120Kd3DEeK9nv+jXSNK/IkmyXtBCksMeGUc/BzpuRpPXdqQs6HpPPk
         hC+UBYVg/EYXZT8njtql6EvFZj+sH6jga6v9VjiEBJjmNnhXXFlZMUudaKjDEObw/NT4
         fdCjtzF0qAdv550ljMBR1/0jJy1uRXda9lxpPPPYy4gbJaKBGUAQoOVo/fWWDWVoAfb7
         a45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qNCUwFDIQWpSa3qulD6X1fo+5QifvdCMOm50foZOXaU=;
        b=lwcYbLLC5oQ+ZfDTdqG2OwcISgQ+/ylq8HVk+uBtfq3b+DQLUMISKbu1meAEHLt4Sc
         GXpGZ1Eb0i7S5/UqTjL15g7VK1gERj1ZexcwfNL49I1hlh9Q0T2sYpGINU4gCtyyw7c4
         1kk9j2GmydYQurgtX0RohcAZ5bk8mytJusjLOMHIIS/fsH2mwBVf8MBERvNYXjjk6mM5
         uDf+LxmN3tyCwIidLU2xQn98hYxKbbMzFXFidKBSs1SAj5hzTf46f6ilUaqOsAi1f5Yy
         xfZKvX4ba1+t+YTUcpOCALszzgAcCEI27nCy7xPC5aTFbqrV9skmYp71yjU6tvphRAmw
         OHkg==
X-Gm-Message-State: APjAAAVUpHnD14SMvcQojJ5tKm0Y7KUqAbH9L7CiCHzKMWJkBgURMziB
        1CMiCYpGZiC0IXOgVDwzMZTPBLwWyjk=
X-Google-Smtp-Source: APXvYqy4DReqyXBEIZ5+2s0cHWp4sYvics+iJmhcpibOdzaLygKpjFrg9k1ooxTrYciUIiZC0C1Q9A==
X-Received: by 2002:a50:ec03:: with SMTP id g3mr38965281edr.233.1560514568597;
        Fri, 14 Jun 2019 05:16:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i5sm839597edc.20.2019.06.14.05.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 05:16:08 -0700 (PDT)
Date:   Fri, 14 Jun 2019 05:16:08 -0700 (PDT)
X-Google-Original-Date: Fri, 14 Jun 2019 12:16:06 GMT
Message-Id: <e924b6a464b3532cd05f8d3c2df1ddea3e861873.1560514566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.267.git.gitgitgadget@gmail.com>
References: <pull.267.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] t3404: fix a typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This one slipped through the review of a9279c678588 (sequencer: do not
squash 'reword' commits when we hit conflicts, 2018-06-19).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 1723e1a858..46d971b4ef 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1031,7 +1031,7 @@ test_expect_success 'rebase -i --root reword root commit' '
 	test -z "$(git show -s --format=%p HEAD^)"
 '
 
-test_expect_success 'rebase -i --root when root has untracked file confilct' '
+test_expect_success 'rebase -i --root when root has untracked file conflict' '
 	test_when_finished "reset_rebase" &&
 	git checkout -b failing-root-pick A &&
 	echo x >file2 &&
-- 
gitgitgadget
