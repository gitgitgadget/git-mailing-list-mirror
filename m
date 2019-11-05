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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FA9F1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 23:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfKEXbg (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 18:31:36 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:38638 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbfKEXbg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 18:31:36 -0500
Received: by mail-wr1-f45.google.com with SMTP id j15so2875360wrw.5
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 15:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0UKBXwDnLT17c9U98NctBpC8Bi2vXm7vl61iWrTRIco=;
        b=Qy6hhahq1kdOc40Ptp0gd9AsW3FaO/x4CkPwoC6COR6OkoGaLl8XeQXbNZigUFINUS
         2u8U8UWhvjn8WplKqqUGzV7PUTv8lj1Q9ZB5rZw7h6QSqvMEVUn18MNuAfFQM4Km6Rl3
         L4AgDIt3gkkwKhC6fS6PXaU/JL+1TSi8y7F2jBeS6p8yzMXk4QatueWVV2jXGf3/kDrY
         16HsE2kr+BJEeG59bkN4R24OqhCNDyfip0Fb9XzPhozOUiaufd/p5PUbpfzmwuxfkyQ9
         KbzO1jwd/pZqg6DHt6CjBq/dpRVVrVOOYpVVAvviCYnVYqY1BBKbv/ADI0ro1ZDnYdtL
         qrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0UKBXwDnLT17c9U98NctBpC8Bi2vXm7vl61iWrTRIco=;
        b=Pex9q+jbd3riwpVeByv8U8zO2n7zWEFTYN694cpKcq6GGAOSwfoLOjVqShrBU9NpFV
         1PJhEEXPuFSDRHhCQOYunuGcwlB97glbKZYXT93gEPM1xQuhVYzksjyV7DBQaG7p12Do
         wejrKeN/Oodo2PgsegQ/ZsGk7zpOAYmCfmfVWOfEboMW+neE/WJ4O2JFXTZfBP1Or1NV
         Fg7m9p2GPXwI/uEBVc7z2bP0Q+Mjo87cjeRmbkjQZ5+bXelCdsFMFTgp6kX5WkXTSIsx
         8cUEe5DA4JcSajsAT9aIBv/OWhmV3C7iOlQSbLdmifP8OMvBjnxno7z8oykahZBxB0MK
         WA3g==
X-Gm-Message-State: APjAAAU671pZ9BVNCLa8rscqcZbvimBfhwnk4F4cDuaavdBzt0gHoScK
        htZzakMtfRkS2bAL23X65cPJsOpi
X-Google-Smtp-Source: APXvYqypatcp2+OME+djg0A4+z5eYkG70hUv3aa6XARXYN4TGl4WPDBxyyMdb7BeKeWVS7GfEQ7Y7A==
X-Received: by 2002:a5d:55c4:: with SMTP id i4mr29525521wrw.140.1572996693900;
        Tue, 05 Nov 2019 15:31:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o81sm880894wmb.38.2019.11.05.15.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:31:33 -0800 (PST)
Message-Id: <5bf1b5710f7f9bc6d217e5f7c1ee0d37a6f1617f.1572996692.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.454.git.1572996692.gitgitgadget@gmail.com>
References: <pull.454.git.1572996692.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 23:31:30 +0000
Subject: [PATCH 1/3] git-filter-branch.txt: correct argument name typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-filter-branch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 5876598852..1ba4667b12 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -649,7 +649,7 @@ create hoards of confusing empty commits
 commits from before the filtering operation are also pruned instead of
 just pruning commits that became empty due to filtering rules.
 
-* If --prune empty is specified, sometimes empty commits are missed
+* If --prune-empty is specified, sometimes empty commits are missed
 and left around anyway (a somewhat rare bug, but it happens...)
 
 * A minor issue, but users who have a goal to update all names and
-- 
gitgitgadget

