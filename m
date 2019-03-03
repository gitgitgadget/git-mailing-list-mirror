Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DD6D20248
	for <e@80x24.org>; Sun,  3 Mar 2019 14:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCCOo5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 09:44:57 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46615 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCCOo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 09:44:57 -0500
Received: by mail-ed1-f68.google.com with SMTP id f2so2114451edy.13
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 06:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w9L1+0eO3mNHWKHJUuYqGgW/CvfCjwg6tb2PsCnRIFU=;
        b=H3JWMstNZY9CkjB/oyE6ejZ94VJp58Sgu7c/do+nGv990RSqcjHTzEcc8Wiogjx9Si
         on0J1t8uMfa17p8ZvMOuWb1+XC/e9Azn5Dx16FsgESGNXc9O5Vf/zGCRBMZ7/mri6LQu
         8sJyUvPzEMOzNCW9L826zXuYLONAzuOxdTE1yvOqAaItKZA4bi7ECsDNzZoEsgxNMBeL
         XG/HZ8AbKQm5rLYYicUeIZAI6iweIErcyD/mLM2FYQePVxex/6102MHW+/QL1FOrH4cM
         tjdL4wzLyDPQx42ZylKvw1/eewjlmqJD2m3nc8+U3/2ASjcpfOMTgagZNIKPAcl15FCa
         RUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w9L1+0eO3mNHWKHJUuYqGgW/CvfCjwg6tb2PsCnRIFU=;
        b=j+zMWNsC0oirOVBUqFBJEzTNrz3nrZF0zx4le8p7aZ74ynkROnqiuvL1IITxAQDmIb
         29F5mlDMIK0bTXOBeW0Kc2EgAMz9H+TfERLGvoEgKqkNvtwb3y4ibW4gnYm+FzohuTVa
         igQiYoXpgrJxYXHkP7VyNuZRj0NWxhVcCKdRoESOpzUDmauk/OfbSoAjYFAGLk9YYIRP
         NqgwLMkB5K11O783SaBj0aKIIbN0wchnGdSXaGe4Jnd3wn0xDj8kcvBj/+e/DqwF0RTf
         wYrOVotS5oCD81K9i8H+C99cH8R+IVQQ1uCYz/OinFtIKfdKSXqpo/NhareC/gEOLXaJ
         hh0g==
X-Gm-Message-State: APjAAAWevoUyKgJnn+Wf1pIIuhaVDsFg3V+dHXWv6nfl24kjM9KIW+tp
        hJ7bYrQ7rEN/mZ5nU/Hn8PoC1sm0
X-Google-Smtp-Source: APXvYqz0wdbP6FIbTdP8A2V2X1pcVYwDYEt4NNxpsQJSaSz67tIncKDs1tWCO+JfmSAYBBdv8JwC+Q==
X-Received: by 2002:a17:906:9150:: with SMTP id y16mr9722701ejw.123.1551624295380;
        Sun, 03 Mar 2019 06:44:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t25sm1276887eda.69.2019.03.03.06.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 06:44:54 -0800 (PST)
Date:   Sun, 03 Mar 2019 06:44:54 -0800 (PST)
X-Google-Original-Date: Sun, 03 Mar 2019 14:44:52 GMT
Message-Id: <fbe773c22a4ccea3e4eca8c1bd0206941d23f590.1551624293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.155.v2.git.gitgitgadget@gmail.com>
References: <pull.155.git.gitgitgadget@gmail.com>
        <pull.155.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/2] tests: let --stress-limit=<N> imply --stress
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It does not make much sense that running a test with
--stress-limit=<N> seemingly ignores that option because it does not
stress test at all.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/README      | 2 +-
 t/test-lib.sh | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 3aed321248..b61bc930c4 100644
--- a/t/README
+++ b/t/README
@@ -205,7 +205,7 @@ appropriately before running "make".
 --stress-limit=<N>::
 	When combined with --stress run the test script repeatedly
 	this many times in each of the parallel jobs or until one of
-	them fails, whichever comes first.
+	them fails, whichever comes first. Implies `--stress`.
 
 You can also set the GIT_TEST_INSTALLED environment variable to
 the bindir of an existing git installation to test that installation.
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4e7cb52b57..ab7f27ec6a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -153,6 +153,7 @@ do
 		esac
 		;;
 	--stress-limit=*)
+		stress=t;
 		stress_limit=${opt#--*=}
 		case "$stress_limit" in
 		*[!0-9]*|0*|"")
-- 
gitgitgadget

