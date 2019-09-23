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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6335F1F464
	for <e@80x24.org>; Mon, 23 Sep 2019 10:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407443AbfIWKEW (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 06:04:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51280 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405676AbfIWKEW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 06:04:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so9176627wme.1
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 03:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UWYATxod+fR2Iq69RvhaSC4xd0h1J5rpWK4rDs3GfAk=;
        b=eJ0sblTkQPNlCN/f36KaiWwyUNl2ck6Ny4Yez+rg1MKv1LJ8nckMMj/7fanbJ5+IBm
         b1HLWz1dtNPFj/yKW2yjrsimD82n7FaEmHuOc9EQ356WES4KT7WYtTZJOjWw2HZ70GkI
         HzQcWBD7MeuWN0vPCYpDGZrRBUH8TtVNrMFJ1MKPHvYM1YczMeGb0hlTuNsqZ39DS0xq
         bQHHIgCnFOQ1y5TTdVhIH4xaSX/UnkuVVRke9yhAPsaAnpbAZ3tdx5lutBRf1PWBXxMY
         VnwAQFA1ACIlYfbnjyC1lCZwtvokYa/jXDyPOdSckCx5y33YWY2J409hAX7TXQo+uANI
         ruAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UWYATxod+fR2Iq69RvhaSC4xd0h1J5rpWK4rDs3GfAk=;
        b=eKxf2cs+ctTvSXuH6Y/d9JrqmwbGwoZndQf4JWje2LNB40AVgSnebTHgYOqceMi73Z
         eP9Ms8WjF7ISdNLzCbpHWO47NVR+ZPrCp6KT3Rd8Z7Ntv9QYaaYUonxHIQ5ZyyvexSlV
         bG1d1hieNkTLgbdS1fXSNBZVZaR9ec57aP6RwOL+2x+eYuBE7TwvWzYZ6zK35OqvIo8y
         dqZHCvYto6A4BXDza4FL+3w481HBbH2TNoi0WMpkIOcTtMYfCOZsyHPpDsN0w9Q+6I9A
         fyrLJJI7tXwmvTmHWWz1i+EZH+iBa4TkUfaCVgMnKz4BSw0g8uhcZuC80cXqz+RHavw+
         IClQ==
X-Gm-Message-State: APjAAAVzVTcp7d5Ye9XTbf+9k9X8V7t1K+Kx/KcOKwJDEqVuX7e0VtIV
        cBE9+kAy17Ro5/NLj/98GlHe3MaZ
X-Google-Smtp-Source: APXvYqz+8xi78HOh0iQlSOPs0DSPZZ/ievSFdDHXBLIq1Tkx2CXLMdzmlfi917s+F8J+aIelsEL5xQ==
X-Received: by 2002:a05:600c:a:: with SMTP id g10mr12430539wmc.71.1569233059672;
        Mon, 23 Sep 2019 03:04:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10sm13797801wrh.20.2019.09.23.03.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 03:04:19 -0700 (PDT)
Date:   Mon, 23 Sep 2019 03:04:19 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Sep 2019 10:04:16 GMT
Message-Id: <d717a60932223443e95c000f4d17210b07d7b1a9.1569233057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.347.v2.git.gitgitgadget@gmail.com>
References: <pull.347.git.gitgitgadget@gmail.com>
        <pull.347.v2.git.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/2] t0028: fix test for UTF-16-LE-BOM
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

According to its name, the test is designed for UTF-16-LE-BOM.
However, possibly due to copy&paste oversight, it was using UTF-32 file.

While the test succeeds (probably interprets extra \x00\x00 as embedded
zero), I myself had an unrelated problem which caused the test to fail.
When analyzing the failure I was quite puzzled by the fact that the
test is obviously bugged. And it seems that I'm not alone:
https://public-inbox.org/git/CAH8yC8kSakS807d4jc_BtcUJOrcVT4No37AXSz=jePxhw-o9Dg@mail.gmail.com/T/#u

This fix changes the test to follow its original intention.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t0028-working-tree-encoding.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 1090e650ed..5493cf3ca9 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -40,7 +40,7 @@ test_expect_success 'setup test files' '
 	printf "$text" | write_utf16 >test.utf16.raw &&
 	printf "$text" | write_utf32 >test.utf32.raw &&
 	printf "\377\376"                         >test.utf16lebom.raw &&
-	printf "$text" | iconv -f UTF-8 -t UTF-32LE >>test.utf16lebom.raw &&
+	printf "$text" | iconv -f UTF-8 -t UTF-16LE >>test.utf16lebom.raw &&
 
 	# Line ending tests
 	printf "one\ntwo\nthree\n" >lf.utf8.raw &&
-- 
gitgitgadget

