Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82E4A1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 14:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbeHWSL0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 14:11:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33002 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731973AbeHWSL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 14:11:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id t14-v6so2682010pgf.0
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 07:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SAEt4tbFEcepSQu4sTj8X6v0MZeisjjR775hE6cet50=;
        b=YFtX3N7Bv92LktoxxBG3F0ai1mejQnYifcdM9OxU+ppQFiodyZWm5At5FzGO+ws4nb
         UuUd18yFo3SXFcRcGSy+PjxBWzOOZFxV7BoCQaE+/OxwriCYQvQ0x7yJnk04WQKr4pUB
         2MDt8+A6DA/mEPerogQcM+eXO3nVUVKZ5spVHb4kvwrhsIHJ6dIPEXUPCqoqIMB5vHXv
         o4Xcrbe+/KPdeLhwwjq3wV4gykqmJ+QJkjQURE2e6K2HUFRp6Y3fvBwDNqH+Zlbl/8KB
         sH/mEbbnIpL+WLCNNPQFsAY+n1U1jihWSlLY6jY3v8aLLCtMEzRbGRjEYlTnmZb0ZuFP
         CG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SAEt4tbFEcepSQu4sTj8X6v0MZeisjjR775hE6cet50=;
        b=QQb3Fnbl3H8RqPp7i2yII40TR85xDsgG7eqiD1yhIXe5WvqnViJ6FZBulan96OZgW8
         0EF2kPDKiGbsTVSdVn7S6dIKqZ0mLoZ7dFuTyvtEOoHQBzC9psk3vgiBofuFGYzJrQ6n
         zakYtCXxcBDTXy8zI5NxT5PCEqS22Y6MHQ+dDpsDd+UJcvUbKzhNwCEaQp2JwHBe4t0T
         M6p59JpalI8rlkqrd/x3Dsw9UfiYb3k9hMkBxEI1rjGlHrxuGX2/6SQrox5OPZhMmEG6
         CXOsplfufBETc9ga6L6TFBVlOriH1xYS9+UEe9VUQ15BaCQ6qlHK4o31KyQqJ81qI7JM
         ZJDA==
X-Gm-Message-State: AOUpUlEgVo46VvFPM1NJb3w1LKrXFf7FXtUwS0XrTaEgIjq7OV9wjpsP
        Ousi/nRJ/C32O7F6iFjND/YHNQZq
X-Google-Smtp-Source: AA+uWPzTSyOsHDz0iuJAfvslQ6k2dN4L+1KJ9hgTqG/SgMLGZY7Zo7xQYusSbWa2+dkWV1mQ36lZNA==
X-Received: by 2002:a65:5286:: with SMTP id y6-v6mr55564645pgp.65.1535035286783;
        Thu, 23 Aug 2018 07:41:26 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id a90-v6sm11435823pfg.106.2018.08.23.07.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 07:41:25 -0700 (PDT)
Date:   Thu, 23 Aug 2018 07:41:25 -0700 (PDT)
X-Google-Original-Date: Thu, 23 Aug 2018 14:41:21 GMT
Message-Id: <8d46b31f5ad9925c8d1867c8db4fcbf86480d431.1535035282.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.20.v2.git.gitgitgadget@gmail.com>
References: <pull.20.git.gitgitgadget@gmail.com>
        <pull.20.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] t2024: mark a `checkout -p` test as requiring Perl
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     AEvar Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A recently-added test case tries to verify that the output of `checkout
-p` contains a certain piece of advice.

But if Git was built without Perl and therefore lacks support for `git
add -i`, the error output contains the hint that `-p` is not even
available instead.

Let's just skip that test case altogether if Git was built with NO_PERL.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t2024-checkout-dwim.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 26dc3f1fc0..29e1e25300 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -76,7 +76,8 @@ test_expect_success 'checkout of branch from multiple remotes fails #1' '
 	test_branch master
 '
 
-test_expect_success 'checkout of branch from multiple remotes fails with advice' '
+test_expect_success NO_PERL \
+	'checkout of branch from multiple remotes fails with advice' '
 	git checkout -B master &&
 	test_might_fail git branch -D foo &&
 	test_must_fail git checkout foo 2>stderr &&
-- 
gitgitgadget
