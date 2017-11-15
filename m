Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F083202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 00:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755093AbdKOAbC (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 19:31:02 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:35335 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755260AbdKOAaw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 19:30:52 -0500
Received: by mail-it0-f67.google.com with SMTP id u132so15910893ita.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 16:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hDNQNWR8RmhDg6mzqk72nv6EgfW3M9hrnYrAZnLblds=;
        b=YUXEQZON7madwrQ03YCzkxpdbshYO1k7I6nvzsYHgsfGWR84vDSGnQA5q9P00f5TBv
         d3JPhSPiUdFszQC3iNvrscQEO2OsOayQ0abkoSiuqB/GDDsoPLUBI7gjlHqFdAriLEF5
         +FUz/dyBZQkf8Sw68HIz/54DQqM1cGklaWEWI2NVVzrFvZYH0XrM/Z268fJc1HwRn+ha
         Ce7d+GmhUaqKOTaHwTZ1Gnue/COvIWZXF6N45oMaSTREvyqmFwFa7qbs+6Hp1KOrVpU9
         Aj4TO8sn04k6lTF1YrkpNgyqhG5NJlK5srGf7dA3UAg9VELgIJFQF+l7heVEn+sfFs40
         GjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hDNQNWR8RmhDg6mzqk72nv6EgfW3M9hrnYrAZnLblds=;
        b=dKt0gFjJDXRztVyqoCPFAIeXTwAW/Go+guMDffpwTFcBNAIYK5c7Mvg9gsHBIMFDn5
         Gp1+byN488Z2a3M1Xv88qAZTO9lNKyFLcv2XfmFvTGWokwHuzzKCno9QXH6hDaDJ/AMT
         8Ldpn222hjWPCg9cFroLdiFsavzBLkbWcz8Kl8WLQWTzCRPC0F0pwm7KtCtch2NDo7DB
         ibh/zwiNOw0iS49HMciLqJk5vudBl2d37mllPuXzwuc20kRVfQMTLg4ZGEuNqXdlIxBX
         6DalqKgxgo88VeBUmQw7dM3lr88RBpJVeO5WgIF3+CTOAGGQjpSry4l/VmdjjYZesLy8
         4RWg==
X-Gm-Message-State: AJaThX5wvkQyELJr0EFZhEpOkiF/SeDmDikMzKsIMpWqumjiszsHMuOE
        K0J1PVywh4hetSS/6ZSsLaI8Z3+3Cfs=
X-Google-Smtp-Source: AGs4zMai6YqOkpX/mjGIfZaVJU91IN9csiFS7bAYafPostIKdFA19e+DATPJaZwH7AeC1sBQ47E5SQ==
X-Received: by 10.36.181.80 with SMTP id j16mr18553090iti.118.1510705851148;
        Tue, 14 Nov 2017 16:30:51 -0800 (PST)
Received: from localhost ([2620:0:100e:422:c9fb:9110:c737:8943])
        by smtp.gmail.com with ESMTPSA id 196sm9171116ioe.66.2017.11.14.16.30.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Nov 2017 16:30:50 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 1/7] t6120: fix typo in test name
Date:   Tue, 14 Nov 2017 16:30:37 -0800
Message-Id: <20171115003043.24080-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171115003043.24080-1-sbeller@google.com>
References: <20171115003043.24080-1-sbeller@google.com>
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

