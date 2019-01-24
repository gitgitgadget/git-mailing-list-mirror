Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21E551F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfAXVwI (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:52:08 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39017 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbfAXVwD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:52:03 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so5822376edt.6
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 13:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nFDmTJ7EIYAEQqIc3KjFWf1HILA8Ab7U2MDpeTRtibg=;
        b=kND3cLbBGgUg4zm8RVTth0X+4X0fYryk8nSoHp6Z7r/DoFKRsNMdYkHYuopDGfYenD
         lbED+huOCyoaTpbYqMA/cLLAbt8x4EX3FfOLKhO5zOZiXu2jfTTHU5/ByW8d5ERH6Og+
         2zlKh8o7fODgqOLYRE3Qb1TZkXBa8FPc/BEeaPlQcKJ5QUAwLy7t2YYjOhq6jRMVCqcK
         2opRsluayzRScqtT8zyl4XaJyvHJz7e7lYSHI3zzinhwG9evxE7Nr8vkQvwh3QTwzgIR
         OfDC0S1FtE3A6Htmvhw83/I+hkGA4ogxtDODV/RsEgrpCEFbZLKGEugomk6//Eevzg5n
         v4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nFDmTJ7EIYAEQqIc3KjFWf1HILA8Ab7U2MDpeTRtibg=;
        b=WtDoVVedzsuVPVy8KnEgtTg1KO5Z9eGTfrNr40xdztKJmBaFCU2aH/hUefuZwlVpMc
         X5nnkEIg2VamZojC4IRVJS0YupdUdkhmNDy38UEHDSgruCkYbTwoqLsWmPQ4sAxGlzML
         V1z0yzteam8Zwav0UE+za7aXsF8PHm9YWHXpoIHHGwQdtGGIwdT6+T8uKJyjIVIs0VmH
         HZL56juirdOE9f0BVG6vNzHUb4O7rlIrE6lSdd6p+9IATXac9D+tudbwmkg94e5bkWaj
         GllaJHSALNAY1/5r6KPwvnTJF/CiFq+urTIU4zJohRrNJ4O3HODjlT49DkAIykLPU2SJ
         uHpA==
X-Gm-Message-State: AJcUukfQGNI6IRxkClwdqWJ9TAicv2vY8z/XZWqpSntu63v1ffQMMVLv
        OGRq6xPd8GBsV5JwS4xPD5UsLQB9
X-Google-Smtp-Source: ALg8bN6jsyzDQc49ed1wvEqaMYIeEjCtZn16ZHSf537YULsLHVPHY3xNiWZppIQ/RwFOXpyV1UJL7Q==
X-Received: by 2002:a17:906:1d01:: with SMTP id n1-v6mr7430877ejh.61.1548366721976;
        Thu, 24 Jan 2019 13:52:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5-v6sm6169638ejq.21.2019.01.24.13.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 13:52:01 -0800 (PST)
Date:   Thu, 24 Jan 2019 13:52:01 -0800 (PST)
X-Google-Original-Date: Thu, 24 Jan 2019 21:51:52 GMT
Message-Id: <b1c6892417d60b0052535f9332a001868447fa9b.1548366713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v4.git.gitgitgadget@gmail.com>
References: <pull.92.v3.git.gitgitgadget@gmail.com>
        <pull.92.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 09/10] multi-pack-index: test expire while adding packs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

During development of the multi-pack-index expire subcommand, a
version went out that improperly computed the pack order if a new
pack was introduced while other packs were being removed. Part of
the subtlety of the bug involved the new pack being placed before
other packs that already existed in the multi-pack-index.

Add a test to t5319-multi-pack-index.sh that catches this issue.
The test adds new packs that cause another pack to be expired, and
creates new packs that are lexicographically sorted before and
after the existing packs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index d6c1353514..19b769eea0 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -463,4 +463,36 @@ test_expect_success 'expire removes repacked packs' '
 	)
 '
 
+test_expect_success 'expire works when adding new packs' '
+	(
+		cd dup &&
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/A
+		^refs/heads/B
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/B
+		^refs/heads/C
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/C
+		^refs/heads/D
+		EOF
+		git multi-pack-index write &&
+		git pack-objects --revs .git/objects/pack/a-pack <<-EOF &&
+		refs/heads/D
+		^refs/heads/E
+		EOF
+		git multi-pack-index write &&
+		git pack-objects --revs .git/objects/pack/z-pack <<-EOF &&
+		refs/heads/E
+		EOF
+		git multi-pack-index expire &&
+		ls .git/objects/pack/ | grep idx >expect &&
+		test-tool read-midx .git/objects | grep idx >actual &&
+		test_cmp expect actual &&
+		git multi-pack-index verify
+	)
+'
+
 test_done
-- 
gitgitgadget

