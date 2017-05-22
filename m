Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 064892023D
	for <e@80x24.org>; Mon, 22 May 2017 19:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761106AbdEVTB0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 15:01:26 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35613 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751951AbdEVTBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 15:01:25 -0400
Received: by mail-pf0-f171.google.com with SMTP id n23so90675597pfb.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 12:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RSPn4UTMGqAWF8BgGsQTLAU6D4xInqOUC429NidkHxM=;
        b=ZUbiAj14iKd/glgxZqxKEwnTniwWhTvQmjxKcQ2zHVwhiMZipTWH/lKKSyBCInpsRi
         oHYYtltBjDTSjpaFpWDpd/sg7wpn+wyEeLCfB/g7Q/JDGqx7B+pg7HvWmhWcV6cubkqQ
         wkVoZQZlM8rtrA8Hnnqk21q5nSULaStA7H6jPFk6ukWf5U9K1EANLP9EzhaPcZfmnc39
         rsjBQVSBYpZENSY1JgSFErPKM4xZAndIXYmFRVH3J4nMKd/iiM5zgxA7pq+P8b6DqDxl
         VyfKgfigSDSU/d2JWb8K/T4MTJLSqbligc/uKV7Vl5aD1+D9fTAo2zu0kZ9CV/bo/1l7
         7AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RSPn4UTMGqAWF8BgGsQTLAU6D4xInqOUC429NidkHxM=;
        b=CKbRjxMHYv/hMU7rn4HtRkyB4oWhmKDNacoN4Of0cuGgQ1BBr4gM7G/vmXdosQhiyq
         Az/BvRjtcOePuoRfrA43xyexppeOaV4WB4hO2aqV5tgWUOo0mKlfvKJai586pw22h9Mv
         znE/1Am6P9s6/8eDev/ee0QvsILMMyBFhyIcbqPvtFjgVg8HvoufU6alOxplr8zS5tmF
         kKsOW3zeEgddDAWT8hR8t3sRm068GB5DyrBfHK7i2JrpfF7pkfQJ/yoggv7wIvR5SvCa
         FCEni9cQz0w/FAstGVe8vyYB9tkJXT4i0W/7Rufay7wDiAjZqrXU3rPTsSz5XPMuxQYB
         pENg==
X-Gm-Message-State: AODbwcB8/USg0YyJ2MBdwLZt8DhmR6FrFbW4T1YqZpz7++BpomdMZ326
        3l1dl6hK6U1pVizA
X-Received: by 10.99.119.137 with SMTP id s131mr27093191pgc.116.1495479683184;
        Mon, 22 May 2017 12:01:23 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id z21sm30665630pgc.15.2017.05.22.12.01.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 12:01:22 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] t5531: fix test description
Date:   Mon, 22 May 2017 12:01:14 -0700
Message-Id: <20170522190114.19832-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description of the test was not enclosed in single quotes, which
broke the coloring scheme that I am used to.  Upon closer inspection
the test is good, but the description is a bit vague. So extend the
description of the first test.

While at it align the description of the file to match what we actually
test in the file.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t5531-deep-submodule-push.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index f55137f76f..62160ab0ca 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='unpack-objects'
+test_description='test push with submodules'
 
 . ./test-lib.sh
 
@@ -27,7 +27,7 @@ test_expect_success setup '
 	)
 '
 
-test_expect_success push '
+test_expect_success 'push works with recorded gitlink' '
 	(
 		cd work &&
 		git push ../pub.git master
-- 
2.13.0.18.g7d86cc8ba0

