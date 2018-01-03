Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A78CA1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 03:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeACDFl (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 22:05:41 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36612 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeACDFk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 22:05:40 -0500
Received: by mail-pl0-f67.google.com with SMTP id b12so376073plm.3
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 19:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ecCwm8PKlwj8g/lBcebKhcGBehi2DL2PSHwdHEKM2o8=;
        b=J79ge9DelQ2GCdZo8FUm8tFR1b6RHcqjJxQmUOMPaCzrvsxdUJ0moqO5xacWIU0Y1a
         p0H74yXjRVeCefTIvRHeEiH8f11FLPvF6czrH4b622zs+WIbMA8QOMLjviebAvgN5WyY
         0rw0Q3yGNH8l2iFAy7xnyku4umE4StjypIKWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ecCwm8PKlwj8g/lBcebKhcGBehi2DL2PSHwdHEKM2o8=;
        b=QijaSNeum1wusXqURL/gbMQLsR9thSO/fxmkb6pmGU7nA0t28zH1PDI93y7+29zZ1s
         LeIDrkAfE/rrlnWtpyfAJg5xK5dspuYi6pqCuY7L84I6cUKPI5S+5QOT8QRfybZavwcx
         Dh36j55E0N9CMrfr5yGbsBYkSLiVlcS+ci9UtFqRh4ch9HoMvLGJNfPumGEjeb4UGHKz
         +2qvSrkEPOVm0lY0NlHXCcnTFZxiwHcXJzYh2tkhd01Pa5SOAT7aHmwfXBb8T6zH9Ekv
         uIZ2u57Ha9zhk5xrzYLA5zjorEUXxUCWeLRAQvbTb+59NIPE05QNk/ZXhcNVdUq2myAk
         gKZQ==
X-Gm-Message-State: AKGB3mKeD9gg5YKzPML1/TT4ZqHOICX3WeCOOugQh4yVc/Ty+T1SAPOz
        lhIFJS184Da0wy/n0M6BCnhb7GqKRpU=
X-Google-Smtp-Source: ACJfBosiFlN5+v9c+2zxbgOwe5uLI9oSRYSZzWX20RlSuNmcElSDPFULDBiKDDznlJpgRMy5cZTGFA==
X-Received: by 10.84.214.136 with SMTP id j8mr119114pli.408.1514948738185;
        Tue, 02 Jan 2018 19:05:38 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (V160-vrrp.corp.dropbox.com. [205.189.0.161])
        by smtp.gmail.com with ESMTPSA id 82sm107742pfm.136.2018.01.02.19.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 19:05:37 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH 5/6] fsmonitor: Remove debugging lines from t/t7519-status-fsmonitor.sh
Date:   Tue,  2 Jan 2018 19:04:55 -0800
Message-Id: <0ee51f4baaf07f388782e7a5904dcc6360e86f3d.1514948078.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.1.31.gddce0adfe
In-Reply-To: <20180103030456.8181-1-alexmv@dropbox.com>
References: <20180103030456.8181-1-alexmv@dropbox.com>
In-Reply-To: <023b0090bc7dc0ff9c3bee1efce8c85fdba27de3.1514948078.git.alexmv@dropbox.com>
References: <023b0090bc7dc0ff9c3bee1efce8c85fdba27de3.1514948078.git.alexmv@dropbox.com>
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
2.15.1.31.gddce0adfe

