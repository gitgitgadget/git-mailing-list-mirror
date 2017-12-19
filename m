Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F10DC1F424
	for <e@80x24.org>; Tue, 19 Dec 2017 00:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966062AbdLSA3x (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 19:29:53 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33653 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965488AbdLSA3k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 19:29:40 -0500
Received: by mail-pg0-f66.google.com with SMTP id g7so9865164pgs.0
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 16:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=oTpjry4vkM7XZiegpcrBm0msXjn+r/CIYSoesocomiI=;
        b=QIH/wtIehPNKl4b3gqHvntH8QHipStR1Y8FcbWOsDJjishYXFELR1bLs7UPgw/nN+G
         r6oXY7nuU+efG3WwZ8WbyxXfJITUPB7ymCxF626dxbrfh0++f4NNMoTVnEKD/LB3ccHY
         eqdC00b/NL7lgA+WE8XOX/M56EK6tuYmlDVLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=oTpjry4vkM7XZiegpcrBm0msXjn+r/CIYSoesocomiI=;
        b=fw/k4Nzc0uzlJ0mVVslXAcIoK7f/s5cPX2dsIH/1df80rapvdyierzP7rTiaHNWLJn
         IntBbnXctl+okhicRuFjUbMd83cqKvl8jDNWSUneAqGsfPgm6synTs/dmoQb0qyoM9fW
         8C/+iKxCOS+zxvqPTYeWFtcbJCl2jhGkThVpKorMbeBldBToN4lacF/svg50ZDIAbJKX
         kO5o2RReQKKk1DLjeK6eJX672EgM+SV0HH5ty3KGpfeVC+NRlmryNXEu6Lyj5eSF/LuY
         kFAbVaHsYmvElsEHoW7C+sYO/r/PyUfwruQ5JnjgkPhEKEzFgQT1DxRYa4+ibvis7iVe
         2rPQ==
X-Gm-Message-State: AKGB3mIG3T0pdUkhGgMVABRMXdSWj+4Uw1SKyZkXjWkyLkdR/0VqamZu
        QnYO56f1tPsyKlSfvu8BvzZbVT5L40c=
X-Google-Smtp-Source: ACJfBouCGEhtYduTp0KnHWv/2m6IyQbyCgixzz2lZQU18kgZdU0EZA8+FpchtF3InkJjLxUjTfwk/w==
X-Received: by 10.98.86.193 with SMTP id h62mr1382629pfj.109.1513643379558;
        Mon, 18 Dec 2017 16:29:39 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id b10sm26056581pfj.20.2017.12.18.16.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Dec 2017 16:29:39 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH 5/6] fsmonitor: Remove debugging lines from t/t7519-status-fsmonitor.sh
Date:   Mon, 18 Dec 2017 16:28:57 -0800
Message-Id: <0e1b58795c3cfe2a6a64ae8ab0f87f46e5716da4.1513642743.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.1.626.gc4617b774
In-Reply-To: <20171219002858.22214-1-alexmv@dropbox.com>
References: <20171219002858.22214-1-alexmv@dropbox.com>
In-Reply-To: <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com>
References: <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These were mistakenly left in when the test was introduced, in
1487372d3 ("fsmonitor: store fsmonitor bitmap before splitting index",
2017-11-09)

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 t/t7519-status-fsmonitor.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index eb2d13bbc..19b2a0a0f 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -307,9 +307,7 @@ test_expect_success 'splitting the index results in the same state' '
 	dirty_repo &&
 	git update-index --fsmonitor  &&
 	git ls-files -f >expect &&
-	test-dump-fsmonitor >&2 && echo &&
 	git update-index --fsmonitor --split-index &&
-	test-dump-fsmonitor >&2 && echo &&
 	git ls-files -f >actual &&
 	test_cmp expect actual
 '
-- 
2.15.1.626.gc4617b774

