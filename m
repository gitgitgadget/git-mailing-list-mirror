Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BF201F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfA0X1J (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:27:09 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35015 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfA0X1F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:27:05 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so11634276edx.2
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6wZF5XyFnvK4tOVLEGObR7qCxdrcyoiAaAwrz8JEDdo=;
        b=tUKZQODyN+d2cJfU/8r7HN0MCDNYJkXdKmZZ/BFP65FNbeF7MgHXXytyOanZ7tbEgd
         nl9T6FHSTOA/B59eeyDdJjXxmLWxp0M7CAT+yhW0WPaCtnVPWDQEqUHZD387y6PMbX4z
         hQpIEOh4piSf/EO3275/rk5OTLr8kRS4Ci5icDr4OLGfKp4qo10rF8YuBjoriQWlxcEy
         7OLkw1ayq0x0/ea73PvljTjidOaG9+AGKsys8kDojRoJianM3T5tM3XY8KazUqOStK25
         98p3kXK7e2CY/YGtogtaF2L2nJoD174T7xj20WtSXge5T1OulCDYatvebX6B2l0Cd5zQ
         ZXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6wZF5XyFnvK4tOVLEGObR7qCxdrcyoiAaAwrz8JEDdo=;
        b=hSD5opHVQyo39LQqj5VK57vwD8sAoyhPs1/v9yyt9v1NSXzlTd30TxQ77oYqzaW3Zd
         R+T9S8ayFlj9/pKFkOE4dG2veUcm3XSx9fvqr/LNuH1lis7sj8iuvkLFCmMjQZ/9KEgA
         71efUMpT/qpDQtWF/2hJz/2xz/gDa2rN5vUUtcC32Mm3aTAkI3Ro1ixDqbYD0sIvSFr2
         M66Cl/xY2Wujtn8LBs993dg2gzmeGybN6/XHEFPt8ST/lUbyqU67S6IGfj+lZ8/WyV63
         53c6u4etA28ZKbqGe3O5UUvTVDdGpYcsHQpcqFXTkk69pnt1/T8znn87qbcVrasg4b4S
         pr3g==
X-Gm-Message-State: AJcUukfURv2Q3IW7dBlJJITtwpQKc9lWlPpUcRXoAMpl/GCSi9isWYUE
        rcQA4sEmAZky74J8ko1pS7korXin
X-Google-Smtp-Source: ALg8bN59dEn4Dms1jK1ttCBmajWsZdYmLAVrCSLW1uR5hwCNBLBnWhXFniYcDLj5mteHj3EFloX5hw==
X-Received: by 2002:a17:906:1c86:: with SMTP id g6-v6mr17478580ejh.195.1548631623513;
        Sun, 27 Jan 2019 15:27:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id gf12sm755708ejb.26.2019.01.27.15.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:27:03 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:27:03 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:43 GMT
Message-Id: <a8101ae3e18dfad3bbdb6ae5dce798ba934a053e.1548631608.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 17/21] tests: add t/helper/ to the PATH with --with-dashes
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

We really need to be able to find the test helpers... Really. This
change was forgotten when we moved the test helpers into t/helper/

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9c0ca5effb..c790e98fd2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1227,7 +1227,7 @@ else # normal case, use ../bin-wrappers only unless $with_dashes:
 	GIT_EXEC_PATH=$GIT_BUILD_DIR
 	if test -n "$with_dashes"
 	then
-		PATH="$GIT_BUILD_DIR:$PATH"
+		PATH="$GIT_BUILD_DIR:$GIT_BUILD_DIR/t/helper:$PATH"
 	fi
 fi
 GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
-- 
gitgitgadget

