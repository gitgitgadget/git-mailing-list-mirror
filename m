Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B1A11F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfA1Vrx (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:47:53 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:33412 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfA1Vrw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:47:52 -0500
Received: by mail-ed1-f50.google.com with SMTP id p6so14404578eds.0
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 13:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jOEJLrRKSNU5Ubvoy4Sb+1LnpkiwcYXZTV6mBbN+Jpc=;
        b=rk44tJCNkLQsSM8knKojXcxkHp2VAMg/JNc0bgH33geMLulOBBmAD95TSuABpzRS8H
         +A6tcIn4epu5hkK/WMNbWevZuUNFiWktQR1cJw2/DTuVyYFnglxinV6lpFLnL0Nu5X0G
         RTyhdVsfGo9d628v2RBuWOFeq+PYyYdaM62JYzRbnyPwTClWbWu+A5j03WAkvyP1wzIp
         1k2/CQfBO/LPRypWzmBdiIwITu+U7UiNRngRZvaUx/KQkMb516/V0rQ2D6wXSEUHP452
         CU9GPaCrEKD1+FSa080gCUtV3QWYb2KwOwoBQrAe/KgcmrOu0PMaVCysdNDCyp3/O48Z
         IJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jOEJLrRKSNU5Ubvoy4Sb+1LnpkiwcYXZTV6mBbN+Jpc=;
        b=SOKnLL6I+IwwwUdzJr3In7jlp3pShI7SVxsp4NYUoDkDaaQ8WB/wd/gsctyAh7ST4p
         ah9MPyOu4eop7OFjHcNvjygICwmPJVY6VOL+bFEnrwpHSYIh0ix50XKQsuSxfR95Hh5E
         UoFnjeXH/9pXd+/ilxWTOYyTEg3/ZCo+aoAXvkHrVREkG2cGX7H7vt4hdGIK+HwKY/n4
         ocfYFj/NZ97bNxZC/WdQ1QpR1aGjiP+QuVgr12sLj4i7+Z9ILrMXvYLO9t4yFD8P444n
         PFRIggwRXXRzpn9AvuDbahui9+6vqnlOKMH2MRcOiz1UJuKZgxJEcZPhbGVoSAeYeZsS
         OANg==
X-Gm-Message-State: AHQUAubvugt554GHTNVrQ9A2uulhq15ehy0OomFTTrVGgWvO/qUXbYn0
        FMVbC/INKVUNQXf/7NgKmUoeStL4
X-Google-Smtp-Source: AHgI3IZ1zLrqCPEbMFZNQm2BZEthfEhd1p/DvGAxGxc4DzSjGt9C6ahKmRATZitEAvXNqDEJ//ulGw==
X-Received: by 2002:a50:f141:: with SMTP id z1mr12577875edl.44.1548712070981;
        Mon, 28 Jan 2019 13:47:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm14702828edc.28.2019.01.28.13.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:47:50 -0800 (PST)
Date:   Mon, 28 Jan 2019 13:47:50 -0800 (PST)
X-Google-Original-Date: Mon, 28 Jan 2019 21:47:37 GMT
Message-Id: <9abbdf9ccda4526672523e1a4a2f6dcaa01758b8.1548712060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v2.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
        <pull.108.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 12/14] trace2:data: add subverb to reset command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/reset.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/reset.c b/builtin/reset.c
index 59898c972e..b65b4a66db 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -340,6 +340,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
+		trace2_cmd_subverb("patch-interactive");
 		return run_add_interactive(rev, "--patch=reset", &pathspec);
 	}
 
@@ -356,6 +357,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
 
+	if (pathspec.nr)
+		trace2_cmd_subverb("path");
+	else
+		trace2_cmd_subverb(reset_type_names[reset_type]);
+
 	if (reset_type != SOFT && (reset_type != MIXED || get_git_work_tree()))
 		setup_work_tree();
 
-- 
gitgitgadget

