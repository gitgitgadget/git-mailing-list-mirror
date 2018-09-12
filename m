Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3898D1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 14:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeILTfv (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 15:35:51 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:44542 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeILTfu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 15:35:50 -0400
Received: by mail-pf1-f180.google.com with SMTP id k21-v6so1095501pff.11
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 07:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sRLtrJ8mRnss+jYAqQW3NAHu+q60DLYtTh0NrV4ppRc=;
        b=kgMF4q9Pw9V/AdTsvews2o17HDoretZZmXizWj3DqspKCt+RsFfICXA5uIyPBuFrOs
         /aRl1g9Yy41215Grdm27+d0iEeaK+jU7UECPr731QWrPm/EcBrpCHrU1aEagZQbfI6l0
         5enScNPX6LRJK+A2QMmMW3MdlvxNA80W9aznvoejtgTgLR5vhxyX3VoyjiTX19rKp3Vc
         HBi+2Z8HhH/yXHzkmx94t2f6xk8IUQSvdSDjRG5r2wCs+Tdbsh2yjQw1ZIjx+JJGlnKc
         SmWBvdRUItUhX7KNWz8Eqz89R/cVaoTVsLnxbs997mts6We+ha6tFCnZ9ozIg8a1t9y3
         ITtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sRLtrJ8mRnss+jYAqQW3NAHu+q60DLYtTh0NrV4ppRc=;
        b=RjndxsuIxmcOVL0QvoXB4KIpqQzOmnkp4dAVj4yYHqMoseaRZl0wtCr9te2XYyJGzC
         vvlNhXrEGUdCxdh4pjul14pMCBK+TCJSbBGL5kvuhg/6WGs8Kh35Paz8ZEZp0Vya/AK7
         XDWmLPez0BTWoP6AgWDYO0Hd94ImchMpDRs/TgRGUgiB/1mQDRg6MUoTu4QqPVeixIm0
         cuUoJ6QAOUhx85tUSFrNIhjFGg7KeiLU794xDb7RprMrRZOm2AQrRNUqO6P59TUA+VQV
         pO5wiLuGqfMM7Cv+QhVIkzN+/4mR8msqJZp8jG6G+3/w/tT8bAOBrlkmFHFVq4g5dY14
         o6Mg==
X-Gm-Message-State: APzg51CFB/3n/QJx33siz/CjLz5fpDb0WTrKe3ZK03lIBo8Ux7TOVbcL
        Is9+wg6LvUvfeHfWbxLRarfdwr7k
X-Google-Smtp-Source: ANB0VdapBQgCWKXlK6Hmz/JlTIYkxf72EnujxQ3z1ROlebsK2Ul69V3V+V9oyzp6YXqHbrMArOd/cA==
X-Received: by 2002:a63:2150:: with SMTP id s16-v6mr2668094pgm.267.1536762664738;
        Wed, 12 Sep 2018 07:31:04 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id z22-v6sm4031371pgc.67.2018.09.12.07.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 07:31:03 -0700 (PDT)
Date:   Wed, 12 Sep 2018 07:31:03 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Sep 2018 14:31:00 GMT
Message-Id: <277a4d2bd8bcb20323f0a5a01ccdf431f3c08350.1536762661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.37.v2.git.gitgitgadget@gmail.com>
References: <pull.37.git.gitgitgadget@gmail.com>
        <pull.37.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] t3206-range-diff.sh: cover single-patch case
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The commit 40ce4160 "format-patch: allow --range-diff to apply to
a lone-patch" added the ability to see a range-diff as commentary
after the commit message of a single patch series (i.e. [PATCH]
instead of [PATCH X/N]). However, this functionality was not
covered by a test case.

Add a simple test case that checks that a range-diff is written as
commentary to the patch.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t3206-range-diff.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 3d7a2d8a4d..6babc0e276 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -154,4 +154,9 @@ do
 	'
 done
 
+test_expect_success 'format-patch --range-diff as commentary' '
+	git format-patch --stdout --range-diff=HEAD~1 HEAD~1 >actual &&
+	test_i18ngrep "^Range-diff:$" actual
+'
+
 test_done
-- 
gitgitgadget
