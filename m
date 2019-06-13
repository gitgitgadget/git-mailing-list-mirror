Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D9D11F462
	for <e@80x24.org>; Thu, 13 Jun 2019 15:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfFMP0E (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 11:26:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34396 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbfFMLtt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 07:49:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id s49so1005378edb.1
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 04:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RjK5HPR90OQikUiyb0/LDBsGyBsszNskYXuUhuUaqTw=;
        b=fP1gjaheIJnQRfx8FRMUh4MwuBj66LPuAERMCCKMOslii0WFIEn8BGX9EU/Ec0GC0T
         9wpR2TYkYiJBDT75y+1Wld+NEirZ/NXVZ1+/+p5yfD9JlYfgKS/6kJdFmYomXR0s9aUR
         YWrxD4GuhfJZcjfvOVdW9O5X/WMPhc+EAn94fhyNG8YLhvHRtbNwUNApR2yWxJ9BwIY+
         mWr/f2NFs3MjNgvX/E+cL85vsYRw71E2ijDzzD23+B3/S/l8HX/2I8k2+BvY8pv8LIlV
         65vavlSoc4bWUenGUPdJv4RVRVtgb7IlldMhz7Bft0on2VZG7XxdowgHSiaFfpZpn8Ao
         NXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RjK5HPR90OQikUiyb0/LDBsGyBsszNskYXuUhuUaqTw=;
        b=UKYSNbpyJ9Q0pJf4qYclXRAm24WCBDs2onKmm4MYZQEtFsm8BIuroVKtGS+0ys14Y/
         xy3GjLkTbj41Uehd90w2lLj45rJy/2N2z0ZQPb4JXmkUDk9uJgw4EMSzniDvk26yL1Lf
         YbOE9XOkEInYbDx+nOItGkjOPkmKVQEa+nYPLLdfCt7+z533HBCnQYVYMDJtVTthbL38
         vWKJb73HlmchDA21Iz2ExIb7qu0gFUqK4lGL12Wk/stwdInpXkOgmyxzcJugrrFiaa9V
         K/+/nhPIFSMoV8LymUFTHq+s9yNBxzr1+Ywmzgq0A+bhggBTA9Oz99gGgX6SuuT/M67e
         fPgw==
X-Gm-Message-State: APjAAAVxs79DCSwfvRl0k21/THMtHfv+Ncp1Vynk3Z/BOBRj+YAWUhg4
        avAuWqU81qhQTWnVBp9MZvEPkNnN
X-Google-Smtp-Source: APXvYqzIeNGmrZkTGXj5YiXE6CmbStIi+nEUhtuwpqnu9qpA5W+hk7ipcVp0VzKGLB0i30YJL4n+rA==
X-Received: by 2002:a17:906:1e8a:: with SMTP id e10mr36957150ejj.261.1560426587685;
        Thu, 13 Jun 2019 04:49:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c49sm260560eda.74.2019.06.13.04.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 04:49:47 -0700 (PDT)
Date:   Thu, 13 Jun 2019 04:49:47 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Jun 2019 11:49:41 GMT
Message-Id: <9613c88849e53e00e1f7ade49c6c9056309ef0b9.1560426581.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.265.git.gitgitgadget@gmail.com>
References: <pull.265.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/4] config: avoid calling `labs()` on too-large data type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `labs()` function operates, as the initial `l` suggests, on `long`
parameters. However, in `config.c` we tried to use it on values of type
`intmax_t`.

This problem was found by GCC v9.x.

To fix it, let's just "unroll" the function (i.e. negate the value if it
is negative).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 296a6d9cc4..01c6e9df23 100644
--- a/config.c
+++ b/config.c
@@ -869,9 +869,9 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 			errno = EINVAL;
 			return 0;
 		}
-		uval = labs(val);
+		uval = val < 0 ? -val : val;
 		uval *= factor;
-		if (uval > max || labs(val) > uval) {
+		if (uval > max || (val < 0 ? -val : val) > uval) {
 			errno = ERANGE;
 			return 0;
 		}
-- 
gitgitgadget
