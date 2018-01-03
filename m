Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0831E1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 01:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750952AbeACBMl (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 20:12:41 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:44120 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeACBMh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 20:12:37 -0500
Received: by mail-io0-f193.google.com with SMTP id k18so547622ioc.11
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 17:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ZRZdPETG3ekF+KypkLsJRq/T/bpHyUZ39aRFkE3hI0=;
        b=jULxT8hxO5oVsb1jnC7dCADG0qFy0Pi1wOHhEP8uPeDAjnI6PfNGWq0NVrq/INZjRB
         lHhS4y3WRbLVJMDTNpG0sRFhnaR7/1AsJ9SQgMdEkxTAd3q7hnI2wN8/b2R60kmPyjHu
         zDn198eBhC8VwxPzeUk3swMWWjv399aKMOUzTvw1SDrYG8VHvvyctJjhYt18vuIxplOl
         Hs/GGPU+sR2VVL0jko0CfRQJMbLbbWB/vT7HQf86U18v0R1vFVR6YXc2Y9yNxuNi07G8
         xqDNhYcWN0hecJS7c5ADOy0YrtWq/iSj7V9FhFjojMOmCXgYx2TrpOZAi+0gqQRsNmif
         rhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ZRZdPETG3ekF+KypkLsJRq/T/bpHyUZ39aRFkE3hI0=;
        b=fz7/4oxVP37NBpeIyc5zPkK3+T37XbfYJGZCWxMMpJiRu9SU7eOvXvj4s4yUhFHy4T
         p5Vds0N1ywVLSSf7+FQbNpTU+oXbr4YXD4C3QRcwn1yA1OUKJ1/uyryCFKcbkzKHKI4P
         bmPUjxGl9j2H08WV7OmBytSYyGoqwQu44RhA1/1Y2XDQoj5Onfhi8tTcz7c96t5yuNtx
         w0+aFpBOklcW93Y6jI2ajh4xIFKmH6TqC6BTf3WEDMsXKGQ6K34UzgYqtGtOvkTIXOLh
         Ggv8X9ce7B5bKxMqw/OXPl6uArjftWIDq7oAEfu6Hh3dzeK6e8FxZCRrir17MN6UDBGl
         ny0w==
X-Gm-Message-State: AKGB3mLwlOk0MqHUyIanpHGSehSQfwZ7evZdG6gDy4zIM1fx/x//a4zm
        etHpUwCNnKKhLv6rtQsrjWKzkw==
X-Google-Smtp-Source: ACJfBovTxWJgtN1id6oq8ilgEN1DMGPDYaoFLvWG3FPlKYYLZgyihXoB4oeaSscSLV99WWiI/Pi4OQ==
X-Received: by 10.107.192.129 with SMTP id q123mr2810369iof.176.1514941956881;
        Tue, 02 Jan 2018 17:12:36 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i76sm56784itf.3.2018.01.02.17.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 17:12:36 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com
Subject: [PATCH 2/5] t/lib-submodule-update.sh: clarify test
Date:   Tue,  2 Jan 2018 17:12:23 -0800
Message-Id: <20180103011226.160185-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103011226.160185-1-sbeller@google.com>
References: <xmqqbmichws2.fsf@gitster.mtv.corp.google.com>
 <20180103011226.160185-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep the local branch name as the upstream branch name to avoid confusion.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 38dadd2c29..d7699046f6 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -664,8 +664,8 @@ test_submodule_recursing_with_args_common() {
 			cd submodule_update &&
 			git -C sub1 checkout -b keep_branch &&
 			git -C sub1 rev-parse HEAD >expect &&
-			git branch -t check-keep origin/modify_sub1 &&
-			$command check-keep &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			$command modify_sub1 &&
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/modify_sub1 &&
 			git -C sub1 rev-parse keep_branch >actual &&
-- 
2.15.1.620.gb9897f4670-goog

