Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF1FF1F453
	for <e@80x24.org>; Fri,  5 Oct 2018 09:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeJEQwC (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 12:52:02 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166]:49186 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbeJEQwB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 12:52:01 -0400
X-QQ-mid: Xesmtp4t1538733234trnsqjnrp
Received: from localhost.localdomain (unknown [180.155.237.212])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 05 Oct 2018 17:53:53 +0800 (CST)
X-QQ-SSF: B1000000000000F0F5100000000000Z
X-QQ-FEAT: JibMalLukFaVr190qeucrzwLbl4oNdNerjkOh3xe65f9bZ9scMLOMiPoYskXI
        sp6lDBmRT+YmwCWagTh+w3I+V1mXpwgFXWKwsrSh3K1Jlv1LZj6YRgLr1bKjYtCAP9nMzVt
        kyUAa40ldjhSeYFobwxGaLn/H1oxCNZZ/4Xn447XayIRj/hzsj5Di0sQ7NusHjZRyZRVsGa
        fj6A9Iz55hp6TnOhTza/Xt9TRjgjt9DVPkvfShZ1G2Q680xvIIPDYvu9NlausU0hMOVfwPb
        hBGP26uSrcpWkq
X-QQ-GoodBg: 0
From:   Tao Qingyun <taoqy@ls-a.me>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, Tao Qingyun <taoqy@ls-a.me>
Subject: [PATCH] branch: trivial style fix
Date:   Fri,  5 Oct 2018 17:52:14 +0800
Message-Id: <20181005095213.12509-1-taoqy@ls-a.me>
X-Mailer: git-send-email 2.19.0.272.g140c8e2b4e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:ls-a.me:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/branch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c396c41533..52aad0f602 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -222,10 +222,11 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		if (!head_rev)
 			die(_("Couldn't look up commit object for HEAD"));
 	}
-	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
+	for (i = 0; i < argc; i++) {
 		char *target = NULL;
 		int flags = 0;
 
+		strbuf_reset(&bname);
 		strbuf_branchname(&bname, argv[i], allowed_interpret);
 		free(name);
 		name = mkpathdup(fmt, bname.buf);
@@ -716,8 +717,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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



