Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDCCF1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 14:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeJPWKb (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 18:10:31 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:53180 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeJPWKb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 18:10:31 -0400
X-QQ-mid: Xesmtp6t1539699585tswwcrmuv
Received: from localhost.localdomain (unknown [218.82.50.250])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 16 Oct 2018 22:19:45 +0800 (CST)
X-QQ-SSF: B1000000000000F0F5100700000000Z
X-QQ-FEAT: 0ESs8nxzjD80PLw6m5eZ5xnqrS6Tc79s7RmACzffMo0+hP10QMHbYwhkN1p/z
        /AwA0lc+i/iJCOHoeCpcgAHH0jtAkg6RgKYOAHRdg1aFpxmeBNXHaFOR1lxYKzyjvcwwIqC
        M4idnQQ6P5ZGP9l4DNVR1DnwEeCnH9PM5aLu3RGPCR1eYYhAHOnkM8ZgVfHDzZNFva1NByF
        5CRV8q8LzOUjL2mz9Lqdjrdgq/LGVvsNuMKqDcgG5J8LeH8gJ0MkwYxglYnJwJWXjZowIVe
        7FD3SmHMIUcgpzLymT42HjfFMl6v7/jzkJOQ==
X-QQ-GoodBg: 0
From:   Tao Qingyun <taoqy@ls-a.me>
To:     peff@peff.net
Cc:     git@vger.kernel.org, gitster@pobox.com, Tao Qingyun <taoqy@ls-a.me>
Subject: [PATCH v2] branch: trivial style fix
Date:   Tue, 16 Oct 2018 22:19:20 +0800
Message-Id: <20181016141919.2268-1-taoqy@ls-a.me>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005095213.12509-1-taoqy@ls-a.me>
References: <20181005095213.12509-1-taoqy@ls-a.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:ls-a.me:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Tao Qingyun <taoqy@ls-a.me>
---
 builtin/branch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c396c41533..0aa3dac27b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -716,8 +716,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
 		return 0;
-	}
-	else if (edit_description) {
+	} else if (edit_description) {
 		const char *branch_name;
 		struct strbuf branch_ref = STRBUF_INIT;
 
-- 
2.19.0



