Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA0D7201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 02:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933176AbdKPCAy (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 21:00:54 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:36233 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758300AbdKPCAu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 21:00:50 -0500
Received: by mail-io0-f195.google.com with SMTP id n79so3669152ion.3
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 18:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hDNQNWR8RmhDg6mzqk72nv6EgfW3M9hrnYrAZnLblds=;
        b=qRoDJV5J/YF9RER5hj2OmshYnP0LuWYxo3Fs2WNJVFUeKeBl2QbS1H5cg3l6Kzydnm
         KWZ7/ErKFt6BZLgMBaNOUuTdiMNxYh6qmzo0PSBx/hXwAg1mNLqQQFdxe4LA6wkuL0KV
         VDbMVS1wJS3AlKqw0VQOGOInZZpYmejmHyRnwYDNC3qiS7ZEyvTJvIj/bBTscke8tkV1
         YB+o3Cl7fJtaN+cKE+p3uYv7+bwXPCkrA0Hkcqj6Orv0tHCejbbeW0GkasTMqbH/yJ59
         k3+xmlzLmJg7coH0n7nebLM7J+mqTI8ONuoseols7yoXxqZvUaAMgXR+xssyfdftJfgf
         urjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hDNQNWR8RmhDg6mzqk72nv6EgfW3M9hrnYrAZnLblds=;
        b=X9n1rfq7OcLfzvMHaWIbGKTo1QBPLRGw5TDfQUc9Kqh+xx0DpwLJkFXVc4N2SPoR5s
         TgP1gmzIhBxmv7yurBrUrHpvCYqOobiDKdjr8r4IeqinT0wPz05NfC1OBb7csPiA1O60
         6tWRlTwUadeDINlNYVIF7Vpet2CyCUbT0K7DoECXf3dHqv2HnEhIWzT+q/E8RXWQqQNu
         i2wazkKWGaSBNbUVaoDXEcOo0yM+JDhwCPfxNgDRz2548NycnNgTdlSuc2UDvckrjqFh
         tvHgEGb8UlMyjnEfgzjEh2b0szA3tgMsJ9He+RXBRBLSzqAPmzgCC8GyZJgBC7VKp2QS
         cBDg==
X-Gm-Message-State: AJaThX4ir8O48kdDqe/1N5BZgEmWQ+kVOE9w8qJeJdly7WXaV5j3IGiZ
        /DJPyVeB0Uz9+Vy7kZynm4SvxusVL8A=
X-Google-Smtp-Source: AGs4zMaTZ5VkLBhcPdDMRg6Xcz7NLRt0ZKAAE7t2rwj+E/TEC0QGC05m8Mf9oJ5LjpciJnrRsAhCgg==
X-Received: by 10.107.180.77 with SMTP id d74mr81991iof.118.1510797649089;
        Wed, 15 Nov 2017 18:00:49 -0800 (PST)
Received: from localhost ([2620:0:100e:422:34c9:3de6:9af7:a340])
        by smtp.gmail.com with ESMTPSA id g195sm259129itc.14.2017.11.15.18.00.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Nov 2017 18:00:48 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 1/7] t6120: fix typo in test name
Date:   Wed, 15 Nov 2017 18:00:33 -0800
Message-Id: <20171116020039.17810-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171116020039.17810-1-sbeller@google.com>
References: <20171116020039.17810-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6120-describe.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 1c0e8659d9..c8b7ed82d9 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -304,7 +304,7 @@ test_expect_success 'describe chokes on severely broken submodules' '
 	mv .git/modules/sub1/ .git/modules/sub_moved &&
 	test_must_fail git describe --dirty
 '
-test_expect_success 'describe ignoring a borken submodule' '
+test_expect_success 'describe ignoring a broken submodule' '
 	git describe --broken >out &&
 	test_when_finished "mv .git/modules/sub_moved .git/modules/sub1" &&
 	grep broken out
-- 
2.15.0.128.gcadd42da22

