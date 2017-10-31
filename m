Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 521661FAED
	for <e@80x24.org>; Tue, 31 Oct 2017 00:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753767AbdJaAeT (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 20:34:19 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:49106 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674AbdJaAeL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 20:34:11 -0400
Received: by mail-io0-f194.google.com with SMTP id j17so31310534iod.5
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 17:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e2Evyai3KlGaeTLcZ3uGPCXJdzkhiXh455QgONsR78g=;
        b=rAzHWyy/Upq0ffwZLQEJeJM0a1+I1l+FubFvQj+VoWE/4LbC3ye8yWuuDhqOX9R/ko
         G1iZ1n25KMLV1d3wx42FZPH1rR/m0P+F66WKI5ig7pPKIa461egmsWtCvGG1dl/u6+zy
         eQag6ybt3ZhLz0A+lV6UgBuE0qIGr4yDvD3KcB5EEHSzHCxv1nBHYF7bcV0SwN3dZtg9
         2asqT/VLcLWp/4CtzL2AeFGiqovJsEoiYeJME+bDnTUZubU5HRDKvAtcoAqo7I6AgSK1
         /s1vTFIvLU7hikW8jRGjlu9mMFgA1SM0DglzcSs15mWyHRNxLoe2AJM2EskHPATQpu3v
         e1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e2Evyai3KlGaeTLcZ3uGPCXJdzkhiXh455QgONsR78g=;
        b=JwWovU1Mc3lIWPIm/beu9uwB0MFzM/BQGYtdIwO61pzzcOgdRTRT6VzzTrqMVKDb9Z
         UlLVsoJIe6x0fHiNgJzLU069l4egloTw79tdxMshqDGIkHMo+TxcNSIHBs6yu0prgoT8
         mw4phrASZt5JOvTRupK78rI9Pw77bFCmZIm0nSe0eXUB6CVAGZC8gLVzSx8HuSYH9a+9
         azcfXDCXsJ+W2lioCzuaNjU+fvvTINBaF2agVLLWVF5JEc6M8YqPtu2H1rjH/z/hywF9
         8PbsfNrEaLsqt9HvGpNTwPjrBGcGXTaIfkugp/dIzZHuIE9Hd6q2tLkghc2Ix9cfSfqr
         k3sg==
X-Gm-Message-State: AMCzsaXQCrmEixz71mPT7Ti574DaG6aYH7j8gNYGLTQ7+hcJOwDCNYza
        Xbv2PS6Tv5KlrC4d3ASFKuP0Tw==
X-Google-Smtp-Source: ABhQp+RdT0qv8ovLNI/stqUqcWvySvsDafWrnbTRI/m4SYKBsIknBHm991GsAT+88GehbSGx1ta9sA==
X-Received: by 10.36.241.77 with SMTP id q13mr705239iti.123.1509410050777;
        Mon, 30 Oct 2017 17:34:10 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:58cb:1473:3cb:a95f])
        by smtp.gmail.com with ESMTPSA id q1sm263523itc.9.2017.10.30.17.34.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 17:34:10 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, me@ikke.info, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH 7/7] t6120: fix typo in test name
Date:   Mon, 30 Oct 2017 17:33:51 -0700
Message-Id: <20171031003351.22341-8-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171031003351.22341-1-sbeller@google.com>
References: <20171028004419.10139-1-sbeller@google.com>
 <20171031003351.22341-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t6120-describe.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 3be01316e8..fd329f173a 100755
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
2.15.0.rc2.443.gfcc3b81c0a

