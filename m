Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1468A1F461
	for <e@80x24.org>; Tue, 14 May 2019 11:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfENLWk (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 07:22:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44303 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfENLWe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 07:22:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id b8so22323969edm.11
        for <git@vger.kernel.org>; Tue, 14 May 2019 04:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gg8KfPiBx8a9+doXQfeNNHQeZGqR92Fu8BJkJTGi5yM=;
        b=aHHOiW4mtE3AGwilFO80vieuHsb8Azo0GV+n7C+7MKZl8sU8UiJDxZNBGXFNCvicg2
         ck8PZRyKMpyiN3I0DmdjtkXECf/5Tdl4oZuWrcFU2BfqJQufsZWjmYEDYwxRS1UJQP/L
         wfuZcfKQ1bXq6ZNd4hFhKtP2aluz+1yyUvwdWmnuMxBga8i4/NENMRoBzg5YimSm2Jms
         AcWuEryxMxduZdL/8RYK043RlvKHUsi2qrdYQmcy+nwZkUBYzzuJDMrMZtZOf4tMNRMk
         /4a/PpQy1xq9xYiCUD113/8qNp60eFfsb57umnHySE+47FwUEI1vEAlOaUX75Ih2hWbv
         uFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gg8KfPiBx8a9+doXQfeNNHQeZGqR92Fu8BJkJTGi5yM=;
        b=rmUTW6z8CHzwxKn+l2IPSvOYHvElax+akHcccpaBwUYEPSavo0ysga08BAMroufvBw
         PgdQ0QgVumYz4f1keprbOC6hjbpSHJtSDpYK9We3oo/IEhH4836S7xkCp2hvlPHhJ5lj
         NaIkAp/rrqyJnF41HBToUeisp1RYxBsJ/pWTsND8xqv2FFaQ4db/mjzl1dksZP5NHFz+
         +7ReRHOQrte4cW/O+gbvIs3aT/LuE1S6TfT6LftkVM0/2qDtxaXZor0qv6jZpThZBKBh
         aisZ6NfuoZIHQrqOXcBY6LoFFKaNJFOzWJu35cY6yd6lrfFrPdpyFNzqKRwnEoeU3Ory
         TMDg==
X-Gm-Message-State: APjAAAUe0GplesfHNXS6qif3Ls5E28SxypaaQEWCrK/CpZmWdkMXpL6q
        vMV03aJ+i0LJPIAQYnrcOUiTD+ST
X-Google-Smtp-Source: APXvYqwYAgTWDdY3X488MlYUzaP1sWYJEfG44ftnXLe8vyYUP2mAsUrQjfthuj87dqJ5SKro08P3bg==
X-Received: by 2002:a17:906:54d2:: with SMTP id c18mr26857648ejp.50.1557832953130;
        Tue, 14 May 2019 04:22:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i2sm1570697edg.81.2019.05.14.04.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 04:22:32 -0700 (PDT)
Date:   Tue, 14 May 2019 04:22:32 -0700 (PDT)
X-Google-Original-Date: Tue, 14 May 2019 11:22:27 GMT
Message-Id: <ab1fc1ad2ac88360b2edfe6d621d92adc7f9c03c.1557832949.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.194.git.gitgitgadget@gmail.com>
References: <pull.194.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/5] .gitignore: there is no longer a built-in
 `git-rebase--interactive`
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

This went away in 0609b741a4 (rebase -i: combine rebase--interactive.c
with rebase.c, 2019-04-17).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 875f3fc6e8..bcee4fda81 100644
--- a/.gitignore
+++ b/.gitignore
@@ -123,7 +123,6 @@
 /git-read-tree
 /git-rebase
 /git-rebase--common
-/git-rebase--interactive
 /git-rebase--preserve-merges
 /git-receive-pack
 /git-reflog
-- 
gitgitgadget

