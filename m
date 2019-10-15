Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1EB51F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 13:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbfJON4Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 09:56:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51594 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732308AbfJON4X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so21019343wme.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 06:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rHoy5XLBWfbjNZXziz0bjrE5Oji7sBiSNTBdxx6SchQ=;
        b=AiCupem7kCgvp9yAqDIgUjX8D2kURiF3XgOkd8c8/rqltUA6mldYvEPYU7OlHcLDMj
         tU6teoQBxJJV1YLjKqZ60fJNFZb4cHmmilamZbnAHb0zimFetRENYFGofheKoD/3IKe1
         GJZAa49nevI9BSYNWbnc7RRCBnxhrFWNgzdTeEO9d2/dT6w2KDplO2/+g8hBo8dzn67d
         B5c5p0WbmOn8LN9xMsXFayLc+mYeuZB6vSxPnxeEPVyTSnyT/6bZl+W0B2Do1oQ/In3I
         V7HjRlOt8ErLo/uFk97GhbT681M0mvfnTMme29v+lB57rAk0BxY+vdynoxIPAYoByTds
         tpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rHoy5XLBWfbjNZXziz0bjrE5Oji7sBiSNTBdxx6SchQ=;
        b=okkCQpbA9Mj04fs5mEe3eGz/fQgk07m/x8MoqnmvhvHA6f7LPkaViDOZ8dFTSLsRKp
         txTMuRqdeoy11AHt/rVWhVOE8ti9IoqHfp1CY2g8WI1SWZToe4oZmFZmYc3dLBg2xeMK
         v16zrb8Fu0bVdXIa7Z39RTym2c2+kYpEHCTxH6p8s5tBcoFNexw0kEdOnFZ2V6gNunsq
         8RwMTsVrNAxUYSM/3Op+/iFWvWVPelPa8cRmPtpP7LqTi+5GeBV5htlSmF1PAANJoxcY
         s9RdhSp9Tsa+9eTIzSRilsWSF3OcMawroQdi0sVWwYEYYct5ihz7WSnGljwyr9O6emIk
         XAIA==
X-Gm-Message-State: APjAAAVu8b/EAge0TswWhEOkCgx/B1lbcY37m9rHIfRdIfNT4THjmIwh
        d0NiQRX8fQ7CMrzSscP8xjxsJ3TV
X-Google-Smtp-Source: APXvYqwAToFjjByPBi98xc8RbFIzo8HGI15j38XUA1u5CGvlCVATdy6Lyas5PTsPC4u1ci+Nh+GOMA==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr18300748wma.74.1571147781651;
        Tue, 15 Oct 2019 06:56:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 33sm39113631wra.41.2019.10.15.06.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:56:21 -0700 (PDT)
Message-Id: <ed1f148763437925248684b37a0c8b70f837d40b.1571147765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
        <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 13:56:04 +0000
Subject: [PATCH v4 17/17] sparse-checkout: cone mode should not interact with
 .gitignore
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

During the development of the sparse-checkout "cone mode" feature,
an incorrect placement of the initializer for "use_cone_patterns = 1"
caused warnings to show up when a .gitignore file was present with
non-cone-mode patterns. This was fixed in the original commit
introducing the cone mode, but now we should add a test to avoid
hitting this problem again in the future.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1091-sparse-checkout-builtin.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 48493e1012..14141b8f54 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -269,4 +269,11 @@ test_expect_success 'fail when lock is taken' '
 	test_i18ngrep "File exists" err
 '
 
+test_expect_success '.gitignore should not warn about cone mode' '
+	git -C repo config --worktree core.sparseCheckoutCone true &&
+	echo "**/bin/*" >repo/.gitignore &&
+	git -C repo reset --hard 2>err &&
+	test_i18ngrep ! "disabling cone patterns" err
+'
+
 test_done
-- 
gitgitgadget
