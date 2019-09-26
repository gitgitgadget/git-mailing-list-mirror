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
	by dcvr.yhbt.net (Postfix) with ESMTP id D9A011F463
	for <e@80x24.org>; Thu, 26 Sep 2019 08:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfIZIa3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 04:30:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44802 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfIZIa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 04:30:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id q11so1012388lfc.11
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 01:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1WrFUOjNOCYQ9G5fl078OoTy2uTYYjpRxw5Us+PnBoc=;
        b=jhfmC04sdSLtrH+/tKVbSV193wXCVARU2RzZmUUTL7AwMFHCF7/FuoDDEQEJcGlXYK
         1/mkPPwzKWhjxcRkZKUcu1vlE2A5s7nCaG5ggsn5FweoZnxlsMpqk17WvIQWrxHMGi5k
         S2tZ2RZM583VIAcR2b/nvLgwz37ptexCKyFmTpWJS9pVVrOvxr6L1nec9tq6159kd0z2
         Se5W8iFi0KmZHNF+ooW16z6ySUJ/KOw6rQ82YUOTfWMPa2z13sDqFnmKuHYqsvg/jRd1
         Bn68GMSXScN3lmj9965+whND1f5XbmSNir/OBpPTmDhVlWw0KNi1e3JhOtoD7Oc7U/E+
         IvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1WrFUOjNOCYQ9G5fl078OoTy2uTYYjpRxw5Us+PnBoc=;
        b=YdrCo0112veTH4OntcWjbUFNb6+p2JFjW1zKH11SYXlh7ijvqlrbgvtPOCaeQl6jth
         tpYwAbQi3/JgXwnewrmZvhSIivF/UPVhDDa7sCYcgeBI1brr3MVFeLivazrDRiLkWZIQ
         etGAb7crLsyCiAx2L9hnVOv53dnH3g7gYh9ZKIzdZGR+dV/73F9XEqaanYRwOJ95fxbg
         U6VIhPBEVNh3nRz+G7FRzXxDYGPK3MLtajHzklHTJzML3dCozG5ozI8v8cd9e1Ziu2qv
         jU2PD0X75WZ1R6UBrfKjzcRCFy4TIV+wOW8MjvVxLvP0cApJu29rtYdvADob8mDq6SO1
         MKdA==
X-Gm-Message-State: APjAAAUNn62+KvvDNeBN3A5Ktr8xpbrw8niF0mcyBw8auAsmx4HzSx4Y
        kHHfyOX9sdDOSk7V+QvL1cPlaob/
X-Google-Smtp-Source: APXvYqwQZtpIHmD6iYkcCBWpr49Bx4lwclv8VAkdb0T5zWcUFyHoA0rWtsOtAxPYwv7Tv1h2T4yvKw==
X-Received: by 2002:a05:6512:25b:: with SMTP id b27mr1471920lfo.60.1569486624048;
        Thu, 26 Sep 2019 01:30:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6sm411270ljj.3.2019.09.26.01.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 01:30:23 -0700 (PDT)
Date:   Thu, 26 Sep 2019 01:30:23 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 08:30:05 GMT
Message-Id: <29dceaae5ece947e7748330c3fdee4f9667f0fab.1569486607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 12/13] ci: really use shallow clones on Azure Pipelines
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

This was a left-over from the previous YAML schema, and it no longer
works. The problem was noticed while editing `azure-pipelines.yml` in VS
Code with the very helpful "Azure Pipelines" extension (syntax
highlighting and intellisense for `azure-pipelines.yml`...).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 azure-pipelines.yml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index c329b7218b..55ee23ad0f 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -1,6 +1,5 @@
-resources:
-- repo: self
-  fetchDepth: 1
+variables:
+  Agent.Source.Git.ShallowFetchDepth: 1
 
 jobs:
 - job: windows_build
-- 
gitgitgadget

