Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCBF320323
	for <e@80x24.org>; Wed, 15 Mar 2017 06:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbdCOGyM (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 02:54:12 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35214 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdCOGyM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 02:54:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id x63so1081098pfx.2
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 23:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GLpomIZAf9q/KGs7R2YRbV5rgmmAMHSAKwPJyHjHRoE=;
        b=fahgQQXg0FWV3Pn1E8FzJItlLAlCl9DfA6WzUS13SfK3EXXN2dT/9uXN7L1RlkLrz/
         5uMdbwnDMYjfVRx8/9lupy6O6ATPYgb4bxRvYISx/LMqkVB+oQ6AhvZLlSdv31JcMrzg
         xM5gfkCLuFftBVEGIoVtzMgubYxQzHAq74kwCwWmMHSAJzrIV9M9/sRA6FbxzItcywnr
         qXXoUdtLkBWdwWK+Ay8fwbN0p6rSZl0NsYgpqkvfNFJpb+9dopwOLcHtpYbWCzEskZsk
         PFFImiLKgPG326d2iNPLV26EXMzOIuIr0vaXkxo4CNV9KT6dn1ONCnq0aS+jQWu3/7PZ
         +MTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GLpomIZAf9q/KGs7R2YRbV5rgmmAMHSAKwPJyHjHRoE=;
        b=nG4ntduyTqHnY4DQyITPQCgU6MEN2uc95UaxlH+KeQIdV6POVr43oPoocNAfV1zMqw
         LiXd1bwd0u33fllPwk3GrrR2xYJM7GaJkeB5rE33Ce/By0PlQ+/QSJ271Phz6lKVa9OU
         XxZT+381Ar410IOkOZwwewiG30Y8BtH8YoGsKvigbe3Eqj62vDfT187wGmOHU60Yur54
         dVDD+oteb8USlu7rqdwYORvlqJu/Os8IFqxyvqgU7NheEKRVBxasazb7TH67nL5ZsQ7X
         /Pe90AWhEhz9ov1/2uf/hA5QB32FfT3gfh7j5w0E7jKRu2Gn6sQFVV1Vt2jjVt+8gowi
         YX4g==
X-Gm-Message-State: AFeK/H3G6nafR8RJm/ODkVe1ZiGM9ECT5ooRcINt9+2rWcTojZf0itXVvv7YJzI0AULQhQ==
X-Received: by 10.98.112.134 with SMTP id l128mr1955979pfc.81.1489560850883;
        Tue, 14 Mar 2017 23:54:10 -0700 (PDT)
Received: from localhost.localdomain (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id v9sm1851026pfg.133.2017.03.14.23.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Mar 2017 23:54:09 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Christophe Macabiau <christophemacabiau@gmail.com>
Subject: [PATCH 1/3] t7800: remove whitespace before redirect
Date:   Tue, 14 Mar 2017 23:54:04 -0700
Message-Id: <20170315065406.6739-1-davvid@gmail.com>
X-Mailer: git-send-email 2.12.0.309.gffef9e61c2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Cleanup before the fix.

 t/t7800-difftool.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 25241f4096..e1ec292718 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -428,7 +428,7 @@ run_dir_diff_test 'difftool --dir-diff branch from subdirectory' '
 		git difftool --dir-diff $symlinks --extcmd ls branch >output &&
 		# "sub" must only exist in "right"
 		# "file" and "file2" must be listed in both "left" and "right"
-		grep sub output > sub-output &&
+		grep sub output >sub-output &&
 		test_line_count = 1 sub-output &&
 		grep file"$" output >file-output &&
 		test_line_count = 2 file-output &&
-- 
2.12.0.309.gffef9e61c2

