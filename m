Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F4CC1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 15:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965998AbdCXP1y (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 11:27:54 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34354 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965959AbdCXP1r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 11:27:47 -0400
Received: by mail-qk0-f193.google.com with SMTP id v127so857196qkb.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 08:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/90P2luVD5hGLr+/lqrG6S+rqOIkh7hn4TQ2Eg6knfs=;
        b=FTcMnuDI9uxihdiNF0O3NjCM+s2lF/ph/ky5BsvPkmF+cVj+v58xd5XlxiZycUrR1F
         eB4+4Y8WBBWb4s4A42ehl61htggxj35iZXLGVM3J5mSNyNqQ5ysYnjlM8opp5TvBmKxz
         xB++aON0IrLJ9O8p3KuS/ALQeKmOWGeXVuxOcm1ImeV0FZ5G6LEajBGnH5Wox4bN/vqY
         wuQCGvdc21QmC4MxFnhKAyblZ8Ara6xg2BN/3eSchFC4P9caVPAApxF6ZeXkz1oJf6m3
         0PlUdYRwMo4aP7Pji+4j5ExsnjC1bvuLWj7brQul9vE7Aa9TZ4n/faMzLLz4U310jmxz
         Thdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/90P2luVD5hGLr+/lqrG6S+rqOIkh7hn4TQ2Eg6knfs=;
        b=Z0so4V/eE8WyN8XJiiHBz5PpixBSt7PZ+oHGkeGA5O1DagchtzByLBjJrgq/pa8l62
         L+6HaVuayfnv+lJ/CgJL6Y0BH3PZVJ4vlyWjftvhUYq7SN/5z3wdK7Ne5TrWa6LMZ3h3
         yUXsg8fVo3iGo1OlGWJFQ7Jvd1SJ5F3jh5AC/Tw0RG/PUNqUCiPuW1QC8uh/V3QM/7je
         4+6qbWplfmbn7+UYNpJ2P5XunKtGgPfxXUCL8s12SZIL/UNRI4wzKtzjIkyv+x6PacWC
         3t2ibs8FeRHPinAkC5b49yQsO0iqlmrYFndhtrKt11o4Bck2hqCVegDlFhw9ZK3ID9F5
         06Sg==
X-Gm-Message-State: AFeK/H2Vk5E0uWkJMPYVi+R4nIIWvwQiFrZoyigpledEIVHRmO1QRANV3rPujbFcz+62AA==
X-Received: by 10.55.195.68 with SMTP id a65mr9072268qkj.62.1490369261169;
        Fri, 24 Mar 2017 08:27:41 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d23sm1717589qta.32.2017.03.24.08.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 08:27:40 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, christian.couder@gmail.com,
        larsxschneider@gmail.com, David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] t7800: remove whitespace before redirect
Date:   Fri, 24 Mar 2017 11:27:22 -0400
Message-Id: <20170324152726.14632-3-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.gvfs.1.43.g876ba2a
In-Reply-To: <20170324152726.14632-1-benpeart@microsoft.com>
References: <20170324152726.14632-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Aguilar <davvid@gmail.com>

Signed-off-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
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
2.12.0.gvfs.1.43.g876ba2a

