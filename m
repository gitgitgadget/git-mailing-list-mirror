Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D8A61F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 13:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbeKLXl5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 18:41:57 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:36836 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbeKLXl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 18:41:57 -0500
Received: by mail-pg1-f172.google.com with SMTP id z17-v6so4111250pgv.3
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 05:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qICTNpKsUaEsN8WG9M+P2UYZDeBOF/WnA+KAw+W0iLs=;
        b=Xzt8BJripxvJTp8n7DWN2hp+JfxDpKV33rDBYd7PdEX7IYXXeoshTLkJqwAf+/87nI
         /h2gG23nbddd5/jnBmsxdy2HSbWx0+cklbTWQodIHvdruufmDcRycFQFUc1QU2B8fMQE
         /gu75/v5Jbypb4xM1zbc+y75ui1D7yAUQ8AjBUMWrS+gAmEsc0IoX4V1GRfbALzGLU6I
         EOdZ1cfDJ6S2BteSyQcULDxqL3YijBWSxaxzXQBqra7ckT9tfAOoP6mHQeDGhavMzKeq
         2I/haSNMUYmqppBX6J9KjUPjiZslwg/3uCS/EG8y1MYC1I2OFihyKvPL7S/Pc+e+mw77
         h52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qICTNpKsUaEsN8WG9M+P2UYZDeBOF/WnA+KAw+W0iLs=;
        b=tv/4Mw5s/99G2Zdv5ZuMlKItfefIcxtxOutm86cw49LtAjuxzRo8xSCXKys0YngwuI
         n2G2etH0FHn66/jjPgPQFlFA8Rl7SvrrcSCiK9gwRxPrbENt2OJh008FpXMJd0V8M6g8
         KnxlT6AfZWerISMvMVh75KxGYoKomK+SlZukFVbAZnS3U6NjN3ZC6YX8PzHUdyawf1gg
         jgtbIM5vcRIHcv9O1y4dDGok4i5eMDNE2cEGtZHUQGLHD3F930akROhI47GwRW6ZSa1o
         09Py7UnDNQN+ki3uoWolG38eTO6fugL4yHE6q4tZ/VmFap+NT/QHyQCbkX3/aKUv9LTf
         RQJw==
X-Gm-Message-State: AGRZ1gJ64Hu7JSqnDMcKwGC76noCsh+Fe4GnQMDyoPE9J5SQC0XGdJ5+
        zlHUHKnMT1veMqTQHE5TRY28F7H/
X-Google-Smtp-Source: AJdET5crdTTBS8grwVXKWe/Fr9MoTVV1bvijZ4bzgBzoT2mLKWqyh+Zu8iVTd2S7M8kHLZB/jBam3Q==
X-Received: by 2002:a62:6c89:: with SMTP id h131-v6mr1002534pfc.12.1542030515368;
        Mon, 12 Nov 2018 05:48:35 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id d197-v6sm21609923pga.1.2018.11.12.05.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 05:48:34 -0800 (PST)
Date:   Mon, 12 Nov 2018 05:48:34 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 13:48:26 GMT
Message-Id: <948b3dc146fe353fbab6057c1376fa0e787a444f.1542030510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.73.git.gitgitgadget@gmail.com>
References: <pull.73.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/5] tests: respect GIT_TEST_INSTALLED when initializing
 repositories
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

It really makes very, very little sense to use a different git
executable than the one the caller indicated via setting the environment
variable GIT_TEST_INSTALLED.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib-functions.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 78d8c3783b..801cc9b2ef 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -900,7 +900,8 @@ test_create_repo () {
 	mkdir -p "$repo"
 	(
 		cd "$repo" || error "Cannot setup test environment"
-		"$GIT_EXEC_PATH/git-init" "--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
+		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git" init \
+			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
 		error "cannot run git init -- have you built things yet?"
 		mv .git/hooks .git/hooks-disabled
 	) || exit
-- 
gitgitgadget

