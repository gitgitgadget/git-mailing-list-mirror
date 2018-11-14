Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE9C1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 13:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbeKOACZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 19:02:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36433 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeKOACZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 19:02:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so1141063pfc.3
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 05:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V9RNKbQkXesRyT6BjU/xslRyh7KjIIRgdNaN93rpSV0=;
        b=aYbXrNOSjEJtGy9/pbLM6WrFCYN6zUCej2PT3OsIm3mV20susYIX2ndcKDylqHk8Rk
         tEVcRgWA1F/CxThaDbZd/0pFJt8kdJgZP6ZoQz8dZdAB2S+m2wxOEVkNGkMzM40BR8kR
         xv6ct3n0N+Ck4WfnqpvrSByg5z3O0/v5Vy5B0fTVFu6ln2gi/4V4K6o5eV8qqLIEHFKd
         Sdo17BN99/PWxBkVxcoNDaSLseVa4CCCnmKsOfzxqeQY+ZmOmWwv3HP+sn0tN5hFGL1A
         Ek1pebsUoUYg8oxGyCP4X7MnAUfFH/zLgGXLmunuCgO8HRi9BMqZyF8Jt4YTDZJPpsFS
         HErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V9RNKbQkXesRyT6BjU/xslRyh7KjIIRgdNaN93rpSV0=;
        b=rHuw7nn1Cbw8wjzvl9V/WbKydDuFBB3iaCgJ5HHLm0MphEaww/HgUw19vKOhEKdK2/
         u/ZX4fEnvjjTWPNiRqNh+fAvdPDckrv3zuUbiay4e6iieT+hs9m/XVLpbFr4ztdF3koi
         4ASfpTrvX44X71MnxGAXhjHTFGJjk3WzRTJ4PxSw7sHovnLOfEhFVORgzsHoN0GCVlkv
         Lj9yibRLmiajaR7Dsxg9p90XDJNLkvupP1c1Nsiys4BCKVFBta19d9Vw64dfEmvay2aC
         6obAcVWplvRxUntXatl5J1ScTsW/ozsFAhzmnCK9Jo7M67uxJZxJ5h7DAH01xcG75Q8J
         aksg==
X-Gm-Message-State: AGRZ1gLGOfHl4ak5OUGVW3AWuVgwbyOtPcGxKarO8BP92EkOzl73Vha5
        mQAuv7hrcaZbiThpBXGG1JFOpOuh
X-Google-Smtp-Source: AJdET5cK/eMgnoO+xOTRccq2r6+Ivrgn5RsUSAZ1hh5dkF8hNRMWDpH3FMZQoWUPwvq/19RW4TVnlw==
X-Received: by 2002:a63:6984:: with SMTP id e126mr1862276pgc.143.1542203942836;
        Wed, 14 Nov 2018 05:59:02 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id o70-v6sm69622120pfo.86.2018.11.14.05.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 05:59:02 -0800 (PST)
Date:   Wed, 14 Nov 2018 05:59:02 -0800 (PST)
X-Google-Original-Date: Wed, 14 Nov 2018 13:58:58 GMT
Message-Id: <0767f9837811c922c49c5aa148252f9e66320f18.1542203938.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.78.v2.git.gitgitgadget@gmail.com>
References: <pull.78.git.gitgitgadget@gmail.com>
        <pull.78.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] config: report a bug if git_dir exists without
 commondir
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

This did happen at some stage, and was fixed relatively quickly. Make
sure that we detect very quickly, too, should that happen again.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.c b/config.c
index 4051e38823..db6b0167c6 100644
--- a/config.c
+++ b/config.c
@@ -1676,6 +1676,8 @@ static int do_git_config_sequence(const struct config_options *opts,
 
 	if (opts->commondir)
 		repo_config = mkpathdup("%s/config", opts->commondir);
+	else if (opts->git_dir)
+		BUG("git_dir without commondir");
 	else
 		repo_config = NULL;
 
-- 
gitgitgadget
