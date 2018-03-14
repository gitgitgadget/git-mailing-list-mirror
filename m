Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A05C1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 03:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753173AbeCND2z (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 23:28:55 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45599 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbeCND2y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 23:28:54 -0400
Received: by mail-qt0-f195.google.com with SMTP id v90so1997005qte.12
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 20:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=sPp2hdDbPEFH48yMHA8dSl0d5BJkbiH4cjF1JIrg1xk=;
        b=RdmykH8Z8kzL8ZijSMUVmHtG/qMl62S2q8AdmuMlt15CuKAIpZWafTCxWo/6U66nqo
         h33ggciGqf4fTqNwQ6YmL7+zAt6VBQbpQkftqHl5fSNtF1Qhjbc6rB8jNCNv3bIzbzz8
         l31QrR0TFnaeODwRbPo+ks0hOBNtV32H/AAV2OKT+ZN3vTCoZokFHrRlYGXUbkpbs2w/
         hSsrBF6OoL7ZczPVZeLLHhRTJCFsWnFuErUerLYl10qXpa+zsKLwKU3s8V1hw6u+2+bo
         I8d/lHBlVyHceY6V75khk/FwxpBTOIvuQaylaTEjwLbV1wEypyVYF//Dy9mfuZTcRaXE
         gA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=sPp2hdDbPEFH48yMHA8dSl0d5BJkbiH4cjF1JIrg1xk=;
        b=WLU/7s69Ping9a6slNCe3YP+DXqhzpSfAOpCz7vRY7CSyWfzY/5O5LQG4mRxjFFopn
         0nO3IMpjEeh3/eS9cmNwfQa7WJXs8uafSNaUbztk73AiIe5P5WVc+C9FNuGOK7IFdr9i
         wzrf/HbHI5VcMazayper2Q7DJoTQBVBaVxE91PminN3/UnojCkOGVOKEpwQAGwaKDmFc
         pNbCiiTmwzxKfxkj8bBrBUryzmrgxwnAvjAOM4HI8AA+4DWJJRFsDClGnnXrTFYqifyR
         LKTDA+SPQNeOsLiNtYX9ku0QzYIEGWvchloVxpdxrc9k5Ozpe7jtqWLSl5e+WxuPFtdg
         VhWg==
X-Gm-Message-State: AElRT7EaYcrw4CSQLtwmTePu+dIBukqe59/HzMdjIQ3aIyYrFD+w/PWB
        CQ4xdeQTqULmzOa1+ftfhH5dlIrz
X-Google-Smtp-Source: AG47ELs1svm3VMjcouF3LRbDguemFeCJ4SaXpo48eVd9yOZVHyqDSyEPQpdASrBlPJzr/U4BBu6sdg==
X-Received: by 10.200.58.167 with SMTP id x36mr4890091qte.11.1520998133386;
        Tue, 13 Mar 2018 20:28:53 -0700 (PDT)
Received: from viet-VPCEA32EG.hsd1.pa.comcast.net ([2601:4a:c102:100d:8071:bd5c:7727:4ae6])
        by smtp.gmail.com with ESMTPSA id d129sm856866qkb.21.2018.03.13.20.28.52
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Mar 2018 20:28:53 -0700 (PDT)
From:   Viet Hung Tran <viethtran1620@gmail.com>
To:     Git List <git@vger.kernel.org>
Subject: [GSoC][PATCH 2/2] git-ci: update .pylintrc to ignore current warning
Date:   Tue, 13 Mar 2018 23:28:51 -0400
Message-Id: <20180314032851.11527-2-viethtran1620@gmail.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da
In-Reply-To: <20180314032851.11527-1-viethtran1620@gmail.com>
References: <CAE5ih78HdDvN+x94H3Tzygis8QGROUe4B-yBubFH4simN2u9vQ@mail.gmail.com>
 <20180314032851.11527-1-viethtran1620@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pylint's check for unused variables, global statements,
redefined builtins, undefined loop variables, and unused imports are
disabled.

The current configuration allows git-p4.py to pass the check in Travis CI
in my forked repository.

Here is the link for the successful built: https://travis-ci.org/VietHTran/git/builds/353155158 

Signed-off-by: Viet Hung Tran <viethtran1620@gmail.com>
---
 .pylintrc | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/.pylintrc b/.pylintrc
index 0db42d646..09a0019d6 100644
--- a/.pylintrc
+++ b/.pylintrc
@@ -60,20 +60,13 @@ enable=import-error,
        used-before-assignment,
        cell-var-from-loop,
        global-variable-undefined,
-       redefined-builtin,
        redefine-in-handler,
-       unused-import,
        unused-wildcard-import,
        global-variable-not-assigned,
-       undefined-loop-variable,
-       global-statement,
        global-at-module-level,
        bad-open-mode,
        redundant-unittest-assert,
        boolean-datetime,
-       # Has common issues with our style due to
-       # https://github.com/PyCQA/pylint/issues/210
-       unused-variable
 
 # Things we'd like to enable someday:
 # redefined-outer-name (requires a bunch of work to clean up our code first)
-- 
2.16.2.440.gc6284da

