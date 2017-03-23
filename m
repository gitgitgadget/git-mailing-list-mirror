Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA21F20958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932810AbdCWNGl (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:06:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33229 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbdCWNGj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:06:39 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11so16474969wma.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+ZohHEG7lcXTHh5LdACmdeoZ/Nyuyy/Mu3ku1p06kQ=;
        b=d1EIBucDw9rh7UUkblpFG+S8rFnyJvJ0bRpWPxl9ELShYZ8J3M+r6+AD/wVASEXgSC
         UGjh0krEQ0bj3/TAe3BbdtUs44kAeS+A8jmX8RvzDyqPx1YKg5USilgQTk/LCyXrET11
         KB2MUat4Qs3XAxixXAkHcxC5AwdbsMyG4BX0SnlYfAPd0aMv57mnzyWM9y4+RUXwfK7u
         5AJv/BeRPCOnKP0oR4k5zKmV3/jss8s2f1kV4fTuRCOW9Qm18pEAgJ1f6qlGDGlXFer0
         i+F5LMozesSv8s/MddrzlMWkL6DZvNxeUGCqpcRbYOvqu0fEMIH4Dxj2YvEQ5C9lN1QA
         81tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+ZohHEG7lcXTHh5LdACmdeoZ/Nyuyy/Mu3ku1p06kQ=;
        b=BHdzNdRzvtzhHEUMFIaTJhMMuW6AotHVXORX4fAIjbPBq1wKe1VN0prKe3KM+8tr49
         DjZJREJ4aT4T1qrbbL5HzTyscKtKpc7KqmHj6ffqKc72ebzrtMmtkJ6nKCsykaD79oKR
         jjmOArJcG5sI1omiB6MldCHFq1xMBgpLb+5y4Nyos06zwOcIj9gI3GgZsy6x87OWhFfL
         /dYkCzTz1HwXAGNYUiNeiM2GJDih4/Yq/ZiS1+6trtGfBbDjNz87FTeH8tHeVOoQWWus
         Slcrqg2L+Ft6fkSPbM4Ve/KXrR2K10AQ16x0gc5U1l0Fxm21vrd0IDjT6GxVdylpRlRc
         8fYA==
X-Gm-Message-State: AFeK/H38g7gWoqGZsI786lyyce4HvYMiBEmkoPyMcQts+wYSkhOKXs+dPUGFos2vlkUXtw==
X-Received: by 10.28.26.3 with SMTP id a3mr2665109wma.26.1490274392963;
        Thu, 23 Mar 2017 06:06:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h3sm5810071wrb.6.2017.03.23.06.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 06:06:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/16] tag tests: fix a typo in a test description
Date:   Thu, 23 Mar 2017 13:05:20 +0000
Message-Id: <20170323130529.11361-8-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170323130529.11361-1-avarab@gmail.com>
References: <20170323130529.11361-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "suceed" to "succeed" in a test description. The typo has been
here since the code was originally added in commit ef5a6fb597 ("Add
test-script for git-tag", 2007-06-28).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7004-tag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 830eff948e..63ee2cf727 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -136,7 +136,7 @@ test_expect_success \
 	'test $(git tag -l mytag) = mytag'
 
 test_expect_success \
-	'listing tags using a non-matching pattern should suceed' \
+	'listing tags using a non-matching pattern should succeed' \
 	'git tag -l xxx'
 
 test_expect_success \
-- 
2.11.0

