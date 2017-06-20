Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E6341FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 03:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbdFTDDP (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 23:03:15 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36158 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbdFTDDO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 23:03:14 -0400
Received: by mail-pg0-f68.google.com with SMTP id e187so10360598pgc.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 20:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lXXHgpBngkBLW1jqig3/BlBY7vfUTrfuwGwBJtSSmHg=;
        b=aoVzlrCRjZCjoNfmFcH8lqu8/vGK73nVQSS4MM19b58qjIvbBNXG0LcHZdjVs6i1Nz
         Hn2TTATSLxttxZdKCwPTMx+CJcUHA7dj1Ipx98sOnJGO7e293UH6OhF+Be+i4He08+Od
         mVmypX/nY7b6y/XRaW1ihrflDzIS+Gw9tZa/e0unUT2Mh5DDvetcFOH7SfC7X1BtEwvF
         gnKVL/mxzbKztD4vqR5wW9UdjQJDzSU7v9/QzTUCtvIbiAMbfxuo//q6UGdmU2TKNUSd
         pEYAIMLNDeF6P1EwsV6WcqQd32FkaOnhTdVjmogBjyV1k4SEdFiGfyyj7qp8s34HDePJ
         PXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lXXHgpBngkBLW1jqig3/BlBY7vfUTrfuwGwBJtSSmHg=;
        b=kSodYQBvnM8+IQ7Qzo4I83UpA4t3Ei2FIPZ6gRDHGca6QGHEl3lwOzzHaPldDNk+IM
         dvLdYZhvPdg8J0sAg3Ejxu4IgL+6+Io3N7idmE/E8TvyYHPcXRoAzaXciFLAnJbm/Y+P
         Muq1VqDSFsSQbP6/5Ba2JFav9v4fbJT4VzfKr8DSWcR42ObTdzdbs0jfojQcrpOvbo+W
         Y679uqn3i5QHO9RQ1AxUuAw4s5PIrjiehkoK29mMv9+22CW4P3JSRjM1Bc65syfrBDgd
         jciSlc11XvGq/mcgoGLV4nUKQkVpxwXctDcIpMt1wW0cgjsvkSsPAy1IjV9VLzAWwWpm
         WM9Q==
X-Gm-Message-State: AKS2vOxUzkEsnQyPxvYEkpxMQxtn47TKyOq5uOy8H+rx7xJnDwn0TZFI
        RCyVretmoCaekA==
X-Received: by 10.98.81.129 with SMTP id f123mr13416089pfb.195.1497927794097;
        Mon, 19 Jun 2017 20:03:14 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7088:3652:1086:ad92:af48:f1cf])
        by smtp.gmail.com with ESMTPSA id 186sm22585415pfv.15.2017.06.19.20.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 20:03:13 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     peff@peff.net, git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [PATCH 2/3] Update test(s) that used old status message
Date:   Tue, 20 Jun 2017 08:32:19 +0530
Message-Id: <20170620030220.7323-2-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170620030220.7323-1-kaarticsivaraam91196@gmail.com>
References: <xmqqshiwt1w6.fsf@gitster.mtv.corp.google.com>
 <20170620030220.7323-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests that checked for old status message have been
updated to check for the new status message

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 t/t7501-commit.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 0b6da7ae1..fa61b1a4e 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -18,7 +18,7 @@ test_expect_success 'initial status' '
 	echo bongo bongo >file &&
 	git add file &&
 	git status >actual &&
-	test_i18ngrep "Initial commit" actual
+	test_i18ngrep "No commits yet" actual
 '
 
 test_expect_success 'fail initial amend' '
-- 
2.11.0

