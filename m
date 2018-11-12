Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7AFC1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 13:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbeKLXmA (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 18:42:00 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33392 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbeKLXmA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 18:42:00 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so1474593pgu.0
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 05:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gyvYND+Um5aelGgQxY5pWF9JfAP+j8GHDWQ3Jwc47xY=;
        b=ZRtQj//0V+lszyQGxhYpgOPJcm+Hsk4UczjFsbxsBmOAYWlw9HKKUTr0G6R84+P86+
         HaUz467+Lb/HLKKusr4HgrPBHpZDxPHWQoFD9PE6KyoL5NeCXyijxtTK1HMYwg3lmii4
         nSxLF5i+6ZI7wN9dRqxZ/h4glhYEidsPqr2CcuQpU/PLRm+/GmEm5X+jqSej1q9FvwHb
         vqRg49Ytmfi+297zOlVSm1btZ4r7TXAp9nxHfOe3zcBTHBTESeE5RIEX7w5aT+sAu4N/
         q2eyO0M1oCIBkm9K+YJGNCyt36KMWWlA/APC9g1b7bKcayBwBT6i9XFGwZPi11ZLv+a5
         ZLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gyvYND+Um5aelGgQxY5pWF9JfAP+j8GHDWQ3Jwc47xY=;
        b=d/rjfvnHfQLJ+tRUdHik7tkmLYIAANkC4+joflLJc3Pcn0xX8RLYu+DGzk5rS4nML8
         vRkn46VBr/qLoBVVg9eVG48eIkWwqQo1xsuL/Kq72jyF6yKUaJ0vEiQgW7qjxI2w+8XM
         ILHAcfgUGfq9Vv5u6ZeMjSZbytSycu+DS3nbDgwAu/9pYDcf2EWeedAQnhzkqZeqwmV/
         tVBTAdOrobNOowB76MXyuJnaMAloZNKs/Z4hD7GHntujp2IWoNe7ulBU1Js1bpZ+ik9Q
         cW24Pv3C19LtVE/6ZFe7M3yN34SuJdJH6TccypDO0ClwNJYfq8+6ltmyvf0Tb7j/4kME
         gF/A==
X-Gm-Message-State: AGRZ1gI9S98G82u+G9DS6ZA2tuZltUUlRdwxGbiN4pQNi8H0KQjRValM
        6GDmixkTzuZFVTYEu8SXFEV8EnHJ
X-Google-Smtp-Source: AJdET5d5trZZexOTH4+H1uM8XKi6InRMOUys50DuB4OuMmzM6q2zU8pDkBBNK3/NeRV5VM6BSKFO8A==
X-Received: by 2002:a63:6984:: with SMTP id e126mr894840pgc.143.1542030517798;
        Mon, 12 Nov 2018 05:48:37 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id o70-v6sm46802411pfo.86.2018.11.12.05.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 05:48:37 -0800 (PST)
Date:   Mon, 12 Nov 2018 05:48:37 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 13:48:28 GMT
Message-Id: <316e215e54b921330b91c763255eb25f475a64ae.1542030510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.73.git.gitgitgadget@gmail.com>
References: <pull.73.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/5] tests: do not require Git to be built when testing an
 installed Git
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

We really only need the test helpers in that case, but that is not what
we test for. So let's skip the test for now when we know that we want to
test an installed Git.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 832ede5099..1ea20dc2dc 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -51,7 +51,7 @@ export LSAN_OPTIONS
 
 ################################################################
 # It appears that people try to run tests without building...
-"$GIT_BUILD_DIR/git" >/dev/null
+test -n "$GIT_TEST_INSTALLED" || "$GIT_BUILD_DIR/git" >/dev/null ||
 if test $? != 1
 then
 	echo >&2 'error: you do not seem to have built git yet.'
-- 
gitgitgadget

