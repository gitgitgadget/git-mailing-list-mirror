Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8291E1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 16:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfAHQwX (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 11:52:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34462 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbfAHQwX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 11:52:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so8893870wmd.1
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 08:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pKZgU9zKAHD+gwvg/GYnTiGPPDJl3vJxzOPS8jWBExM=;
        b=IacKC8CGDov5i/8GhhKPfqK0+JXUy2bgH0s0keeqkhUinBbi/i3QRLUomZ0CsLIqfD
         RlACXNOZf5vspYzZcBhQKe1YxlrxwLKvWiZd5/49f7kwZUmjK9dZzjd04TiHQub7ElPF
         VsOXGXVtS4zZBesPNmz+XCTWu8YiF9SinMhE3pHi28rjg/7bBg0I+HhxTbiUKh2Gk0pD
         dK4TA019VjEpjCkfVAAdJ9SVSTj1j7a/LWZDjHHDfeaa8UcEVtlVTTcfniyG5yQurjd3
         XR/afW1SAFUJ+hIV66GiwxZBngy24VXX7xNIsGJ9D5NkCTpKXOSCTsjVNoAK+7xJ8vrS
         uDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pKZgU9zKAHD+gwvg/GYnTiGPPDJl3vJxzOPS8jWBExM=;
        b=EzxgRveud6KNkTOe9vaeDuKvCLc9byED2Ra4nCJhdjNQpoRmwMPKEM4bS7SWpVnyNh
         e6POZctY2X4f1pIfh5bjNxM8lwioJ7mrL8OzNSP154FncjrUMv/d1a/OSvW44IWY8iQs
         8tTBt0gc4jhYnra9rNujf+KnZ5+FKDFKOplkcZy99obicu/4ydH3pueDKYIA3gJk9ewO
         tb3/Pm0+VlP6vG3CeZU9RIrCet1Q/pda5KZXjDcAVfSD+gmwxoaPPaiHoVTbEUG/5LfY
         uKJFIJGPYUu9ErYylkIZQuSdjRAM2hPfiYSarpFN2y2+uGnPT6CjlCw8TSYBEUGsZjr1
         pTQw==
X-Gm-Message-State: AJcUukeh3qZv9e0UmsOHzj2wrh+Ruo8W6AzQ0KBLzXtXZIWLLbTaVlaa
        6LnTTKhxbuIDCc+q1fN6OMzDAgad
X-Google-Smtp-Source: ALg8bN68ehBrXfx6yUekzIXUPU9UmBoWAYQFh7aGsDhrfbIEKTh7xGTNqwoM7m9jXczacUqxxSPxLA==
X-Received: by 2002:a1c:60c3:: with SMTP id u186mr2550299wmb.66.1546966341291;
        Tue, 08 Jan 2019 08:52:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18sm48037560wrr.43.2019.01.08.08.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:52:20 -0800 (PST)
Date:   Tue, 08 Jan 2019 08:52:20 -0800 (PST)
X-Google-Original-Date: Tue, 08 Jan 2019 16:52:19 GMT
Message-Id: <e628fefa41feec008fc4e19a5be5622108391bb3.1546966339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.105.git.gitgitgadget@gmail.com>
References: <pull.105.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] git-gc.txt: fix typo about gc.writeCommitGraph
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

Reported-by: Stefan Haller <stefan@haller-berlin.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-gc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index c20ee6c789..a7442499f6 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -137,7 +137,7 @@ The optional configuration variable `gc.packRefs` determines if
 it within all non-bare repos or it can be set to a boolean value.
 This defaults to true.
 
-The optional configuration variable `gc.commitGraph` determines if
+The optional configuration variable `gc.writeCommitGraph` determines if
 'git gc' should run 'git commit-graph write'. This can be set to a
 boolean value. This defaults to false.
 
-- 
gitgitgadget
