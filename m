Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3706F1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 02:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752304AbeDOCpN (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 22:45:13 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:58179 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752122AbeDOCpM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 22:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1523760308;
        bh=nhN6HCS6zjlaJRs4tI5pESFVz+NOoZZbPd+9/AGFNk4=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=Wi50qv5GfPnB5bxh2UJ0A3O2+ljUsr47D9bYXJtnG3WOGv7CHRHgdHZB1MjbO/dly
         zHvl1cYKDPlbKlAwfPwujJDpcHzvQ8LEbHEFrx+cYtW++hFJYgAGmwz6petXX4THw4
         Tch8NisrUwio/bokFJl+eUS6Zf2YOk0YFP7R+vvU=
X-QQ-mid: esmtp23t1523760307t84n6foer
Received: from localhost.localdomain (unknown [218.82.51.190])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 15 Apr 2018 10:45:06 +0800 (CST)
X-QQ-SSF: B1000000000000F0F4100000000000Y
X-QQ-FEAT: nSUdqPGu3tshzs/xR53+gp2kmRNU+Out3pNz3nQM1WZ5f0iDV02OPndJ4sim6
        /OP2MZuvGaJtusfnk8mFJqaXZaRtSi2iDZH1Bf7rCssWsdspyGQsjFxpu6pA16n18LitU/f
        ZjnOI+dUGxrEYHGgw4QnAeBifUY8hcrXOfmEoQtx8HSIR0ke27uk/Uz/3wRQL6Ja5QwYhgg
        HZDR7kqbFzsKK5o9UrWnpLxMczCNFRwigHYSkSu5g2XTy6SI4iJI1zA2PdBBJDhNgvYnBlx
        z7YA==
X-QQ-GoodBg: 0
From:   qingyunha@foxmail.com
To:     git@vger.kernel.org
Cc:     Tao Qingyun <845767657@qq.com>
Subject: [PATCH] t1510-repo-setup.sh: rm useless mkdir
Date:   Sun, 15 Apr 2018 10:45:04 +0800
Message-Id: <20180415024504.2397-1-qingyunha@foxmail.com>
X-Mailer: git-send-email 2.16.2
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign3
X-QQ-Bgrelay: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Qingyun <845767657@qq.com>

Signed-off-by: Tao Qingyun <845767657@qq.com>
---
 t/t1510-repo-setup.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index e6854b828..972bd9c78 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -238,7 +238,6 @@ test_expect_success '#0: nonbare repo, no explicit configuration' '
 '
 
 test_expect_success '#1: GIT_WORK_TREE without explicit GIT_DIR is accepted' '
-	mkdir -p wt &&
 	try_repo 1 "$here" unset unset "" unset \
 		"$here/1/.git" "$here" "$here" 1/ \
 		"$here/1/.git" "$here" "$here" 1/sub/ 2>message &&
-- 
2.16.2



