Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D6451FBB0
	for <e@80x24.org>; Sun,  4 Dec 2016 13:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750971AbcLDNha (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 08:37:30 -0500
Received: from mail-wj0-f176.google.com ([209.85.210.176]:34133 "EHLO
        mail-wj0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbcLDNh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 08:37:29 -0500
Received: by mail-wj0-f176.google.com with SMTP id tg4so13678023wjb.1
        for <git@vger.kernel.org>; Sun, 04 Dec 2016 05:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=w/kCwjEJj3WJLeuej+HNr/LE0of1scwcR5sp6Gl1foc=;
        b=qp4mx2nf3gRe2ON8d1hss2/WPxwmDlJfUsN4cVzipLNjr9zCGVfJ4esxSS1z3qNY5C
         rO2v9RPYGzctBWgcZ8VLy2V4OS1tVHtSDFEHO8ZSRmmsvgjco1/aVu+63MfmYywh78x9
         GDGjeQxC7/QKOpslfvjJN9O9BIM8tqhoJmBu1yw02h+Vrf5SUTarawobW1jaqijJHMgf
         0G06Kpj9MaZsNZA+rExzXBjJTjSbQgVcAfHtCT/G9Mg8HZyJV4YvvxaYLDJ5KovD26c0
         ssnUR3hyCf+SZoiuQAml+uyFW7dDzOgucuvA1u1fIkqMnaPJ3iReozqHTeUQc/FyCSzm
         5HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w/kCwjEJj3WJLeuej+HNr/LE0of1scwcR5sp6Gl1foc=;
        b=OAHuAvytm/tRAALbGrSjJCoroI303N8SDC+ZHyyd9bzvzieFutpi3Ha47ztaVXxxwF
         Wnt3Hhr2v7xU51ktS4+vV7Zzrax9CZqAhbXJ7uwYBb9T4jSvrgGsLEWRbaT40M2bsnaZ
         9NMdp150E8+LqSO6DBExb3RBHPd/Va1HZviWN+l8q8tqkkLsvoGi47UDqmFy/tyUMFeI
         MaDKopbx2MpOtYM7r9THcRbSwoJafcXRNnCwfVmu8nuAMHvG9AyeFIXa1IXbxa6YWNTt
         Vw+e+DfgNOt/sSgUq9bsKGYmEYVFxTJLprZ/b6vmuvRSvGiAiP3+sbVdJtLGbAeifcj5
         khwQ==
X-Gm-Message-State: AKaTC01qzOHf2zTqDky95zduZHaNtKBk1ceCuPrVo/q9Kf8Ad/7Io5DNkkiraw2Sq/V15g==
X-Received: by 10.194.87.230 with SMTP id bb6mr52734012wjb.163.1480858648316;
        Sun, 04 Dec 2016 05:37:28 -0800 (PST)
Received: from slxBook4.fritz.box.fritz.box (p508BA0CE.dip0.t-ipconnect.de. [80.139.160.206])
        by smtp.gmail.com with ESMTPSA id u18sm13115318wmd.1.2016.12.04.05.37.27
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 04 Dec 2016 05:37:27 -0800 (PST)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] t0021: minor filter process test cleanup
Date:   Sun,  4 Dec 2016 14:37:31 +0100
Message-Id: <20161204133731.24852-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Remove superfluous .gitignore pattern and invalid '.' in `git commit`
calls.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Notes:
    Base Commit: 454cb6b (v2.11.0)
    Diff on Web: https://git.io/test_ls_filter-process_cleanup-test-v1.diff
    Checkout:    git fetch https://github.com/larsxschneider/git filter-process/cleanup-test-v1 && git checkout c052a3d

 t/t0021-conversion.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 4ea534e9fa..34891c4b1a 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -350,10 +350,9 @@ test_expect_success PERL 'required process filter should filter data' '
 		cd repo &&
 		git init &&
 
-		echo "git-stderr.log" >.gitignore &&
 		echo "*.r filter=protocol" >.gitattributes &&
 		git add . &&
-		git commit . -m "test commit 1" &&
+		git commit -m "test commit 1" &&
 		git branch empty-branch &&
 
 		cp "$TEST_ROOT/test.o" test.r &&
@@ -378,7 +377,7 @@ test_expect_success PERL 'required process filter should filter data' '
 		EOF
 		test_cmp_count expected.log rot13-filter.log &&
 
-		filter_git commit . -m "test commit 2" &&
+		filter_git commit -m "test commit 2" &&
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-- 
2.11.0

