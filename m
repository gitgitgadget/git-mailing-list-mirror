Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A95861F461
	for <e@80x24.org>; Mon, 15 Jul 2019 12:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfGOMlP (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jul 2019 08:41:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41824 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbfGOMlP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jul 2019 08:41:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so16762702ota.8
        for <git@vger.kernel.org>; Mon, 15 Jul 2019 05:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=txvecSw9jqUzzh7fTMrwuQR6LGkiq6U0h8j626J3XHQ=;
        b=qEbsgBWc5JxAKXHqLHKSLfFwBQbYEooLPcObeFoWwPXAp+WGi5uu/llbFeAqQpn71U
         1p2rpBTf3A1aiM01tfYsAUajvfoadXRR0yHpq+Dhu/jXPymyGVdbJSfHF82KtkMSmxhK
         D86xRDQsn3Y+3YRlD8mauPCLJcIcj8FiiTh5sDO8FboCtAG9RLkUW0XZKqoSyM3jJlBO
         KA+f01kMX8KnolTk2u7INtIq4Ld2EZudnUTupTaAqdgyF2j1Ht6E4Ew6xOC6tt1N6E8c
         kTMS5VRJ8lOQSpwe19LLPikMMnbQBrXO5h6LSXFy4grJKwZriK3MEb7523v5v19U3NXW
         LQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=txvecSw9jqUzzh7fTMrwuQR6LGkiq6U0h8j626J3XHQ=;
        b=b5duJPhF2xzeNbPMlVKFiqJL1798tBE2SLlFGY7Y7RLtcF38oQEZTP50PQDaF/07Bj
         /ScfN0JZPXS0ZJmCVluh/2AxAW21XtUT58p4AxKSoEOeVumiv5haaSvqv6pbEzzE93H0
         AkfAuSI/KlR9eDjt6PVPFXFJKgBC8wfEcBg0LzvXRgQjgIesEJw9RxmfJ74jloCPXmPT
         szhhu0AQIufzxB7z69vRKsVUY3oiY8qXsJbrDDf6WNfKCGiQQrF6h9ToHo1+lOcjypE3
         3tYf+1arVyRVOQaw13FVcjGEudgnPi/V9nb+r+wsQnBW7BMC2P5xHZqSVLvDi/FCUw1P
         2AOQ==
X-Gm-Message-State: APjAAAVXSldCCmGYPqNKxPQblqOEQyoY9qSGBB4puwZrBbzd18q/NRmx
        6pzLwJcNiRiDNdYarqiI2idRAdDT
X-Google-Smtp-Source: APXvYqzGYsg9onHLOyvkQnMC1y3wEg65TP96xUkaTMkr0veUshz7oBa70WCAHwCL1V44VWppZYAnSw==
X-Received: by 2002:a9d:6ad7:: with SMTP id m23mr19623800otq.306.1563194474099;
        Mon, 15 Jul 2019 05:41:14 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:5c00:b322:c4d8:3df5])
        by smtp.gmail.com with ESMTPSA id q17sm6085893otf.54.2019.07.15.05.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 05:41:13 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v3 2/3] documentation: mention --no-use-mailmap and log.mailmap false setting
Date:   Mon, 15 Jul 2019 07:41:05 -0500
Message-Id: <20190715124106.12642-3-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124106.12642-1-ariadne@dereferenced.org>
References: <20190715124106.12642-1-ariadne@dereferenced.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The log.mailmap setting may be explicitly set to false, which disables
the mailmap feature implicity. In practice, doing so is equivalent to
always using the previously undocumented --no-use-mailmap option on the
command line.

Accordingly, we document both the existence of --no-use-mailmap as
well as briefly discuss the equivalence of it to log.mailmap=False.

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 Documentation/config/log.txt | 3 ++-
 Documentation/git-log.txt    | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 78d9e4453a..7798e10cb0 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -40,4 +40,5 @@ log.showSignature::
 
 log.mailmap::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-	linkgit:git-whatchanged[1] assume `--use-mailmap`.
+	linkgit:git-whatchanged[1] assume `--use-mailmap`, otherwise
+	assume `--no-use-mailmap`. False by default.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index b02e922dc3..b406bc4c48 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -49,7 +49,7 @@ OPTIONS
 	Print out the ref name given on the command line by which each
 	commit was reached.
 
---use-mailmap::
+--[no-]use-mailmap::
 	Use mailmap file to map author and committer names and email
 	addresses to canonical real names and email addresses. See
 	linkgit:git-shortlog[1].
-- 
2.17.1

