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
	by dcvr.yhbt.net (Postfix) with ESMTP id AE09B1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 11:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbfJALQa (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 07:16:30 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:55680 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731397AbfJALQa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 07:16:30 -0400
Received: by mail-wm1-f48.google.com with SMTP id a6so2873334wma.5
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 04:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=35a6xnJ8EVrHgX1meIGwcTCt1t4vfwXTgjyp0Iplgh0=;
        b=SUukx4oLksFTYyFqOc/cRaJ/AyzkvparF6cWgl7sfVqM18WaP23VBRjh8+6DuCi0k/
         nzjp1zt7D3SfrIRXlcd9tPqTHtx+m0wGniSHyxcDF+zmTak/Uq/OeC81uUphbc8BlJLN
         pkWmj9qvStULq5Okg42jLvMxwq8guI6ZcH3WllR2pcmygsJa8mCn3ZI5seLR9gIy4Li0
         J5Roo1kcbVuIfDgmSHl87DKpOcBzy8k6L8OSTcyRAljmp9JwdbgFMfpenMcbE4+W9UWe
         uu1t3oLhYaizN5w3pSXtyGpur1OPvYI8JHcd75yDHD0iaORVIwl+wQUr1zdoAtnT1UbE
         oVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=35a6xnJ8EVrHgX1meIGwcTCt1t4vfwXTgjyp0Iplgh0=;
        b=ag5dNXgYZAThou9QPM0NLLSycZ8TYVc707+APxeLpXo9Emg+1142qNrdKIfuoQ/Zxq
         c20kfg0ZYUSNnalac2/7MenMR/8iQd9J+frMDjgpkHjPaxaFLbNAJ82melTlZtQVmOzQ
         yvPLlU87cJeKFCXc6bj9eEL69JJ4d2kq+la0UBRf3bmG3xw921RvD7MpGYZp3RjDY2Zw
         usC2a2+tG1gfnzklk4OTVDJBD6ZsKF8gvR/AgViWMumEmRjsmgDEIIAbLzGIIsAKx0tY
         iaV6sKaI6264i473QCcnaFSx7PK7+H2+ApVsDjz+Ax+HREyWRBOeSRcY2qgf/UHXv0fE
         gIAw==
X-Gm-Message-State: APjAAAXHw7adtAHgoC6pI+zbYya5s6/XelUz9igZf7nRdhUPSCPDmq6M
        1wQOjl1M62m1dlbMVrk6a019vnNN
X-Google-Smtp-Source: APXvYqz1hcOEoKj0TDB6qohdifXz/91lJ9nDhPFnnGp1Ti32G1yIHFTnUzPFHsIrn/Kg53J+hdmggw==
X-Received: by 2002:a05:600c:2052:: with SMTP id p18mr3196280wmg.13.1569928586933;
        Tue, 01 Oct 2019 04:16:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y13sm24668976wrg.8.2019.10.01.04.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 04:16:26 -0700 (PDT)
Date:   Tue, 01 Oct 2019 04:16:26 -0700 (PDT)
X-Google-Original-Date: Tue, 01 Oct 2019 11:16:24 GMT
Message-Id: <4b3b58ca6ddff476acff6735129049588c0a1f13.1569928584.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.368.git.gitgitgadget@gmail.com>
References: <pull.368.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] ci: run `hdr-check` as part of the `Static Analysis` job
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 azure-pipelines.yml        | 2 +-
 ci/install-dependencies.sh | 3 ++-
 ci/run-static-analysis.sh  | 3 +++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index c329b7218b..15831f6006 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -354,7 +354,7 @@ jobs:
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
 
        sudo apt-get update &&
-       sudo apt-get install -y coccinelle &&
+       sudo apt-get install -y coccinelle  coccinelle libcurl4-openssl-dev libssl-dev libexpat-dev gettext &&
 
        export jobname=StaticAnalysis &&
 
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 8cc72503cb..8ce9ce276e 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -49,7 +49,8 @@ osx-clang|osx-gcc)
 	;;
 StaticAnalysis)
 	sudo apt-get -q update
-	sudo apt-get -q -y install coccinelle
+	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
+		libexpat-dev gettext
 	;;
 Documentation)
 	sudo apt-get -q update
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index a19aa7ebbc..65bcebda41 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -26,4 +26,7 @@ then
 	exit 1
 fi
 
+make hdr-check ||
+exit 1
+
 save_good_tree
-- 
gitgitgadget
