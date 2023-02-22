Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429A4C636D6
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 04:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjBVEI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 23:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjBVEIX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 23:08:23 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77AC221A1F
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 20:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=S1U0s
        uweyv2fk9NE1gS2IJ3sKo97oVL2IO4tWG4OtAI=; b=JHm789CC+fzLx+/IQKd2f
        oNZB8earMZ2BFZWfcVV7If0bWKmQBtnI6Avm6NCbUQfB9MB/8mIfdSgxgEI1UgwM
        4vyC7yt1YwSNFhzgSzTCudDaq0w/GImIiZtE7nNlInKkr0uNWt5Fsn5hSj2Wm2u2
        vdouCV1vuKCDOrJkyH71yk=
Received: from zy-X550VX.. (unknown [183.255.48.209])
        by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id _____wCXTgchlfVjU8TpAg--.19558S5;
        Wed, 22 Feb 2023 12:08:11 +0800 (CST)
From:   Zhang Yi <18994118902@163.com>
To:     git@vger.kernel.org
Cc:     18994118902@163.com
Subject: [GSOC] [PATCH v1 1/2] Fix title style
Date:   Wed, 22 Feb 2023 12:07:44 +0800
Message-Id: <20230222040745.1511205-2-18994118902@163.com>
X-Mailer: git-send-email 2.29.0-rc0
In-Reply-To: <20230222040745.1511205-1-18994118902@163.com>
References: <20230222040745.1511205-1-18994118902@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXTgchlfVjU8TpAg--.19558S5
X-Coremail-Antispam: 1Uf129KBjvdXoWrJF1kWw18ZF1DAry7urW7urg_yoWxXFg_KF
        y8WF4DGw13JF10yr1xAFsFqFs7C348J34Yk3Z3Kw1UA3W7Arn0vF95GFn5AFs8Ka9akas3
        Kw4Dur4rGa1SyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_fHU3UUUUU==
X-Originating-IP: [183.255.48.209]
X-CM-SenderInfo: zprymmqurrmmmqsbiqqrwthudrp/1tbiGBQe-lv2k5v6OQAAsK
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Zhang Yi <18994118902@163.com>
---
 t/t9700-perl-git.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index b105d6d9d5..3f6396ef63 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -13,9 +13,8 @@ skip_all_if_no_Test_More
 
 # set up test repository
 
-test_expect_success \
-    'set up test repository' \
-    'echo "test file 1" > file1 &&
+test_expect_success 'set up test repository' '
+     echo "test file 1" > file1 &&
      echo "test file 2" > file2 &&
      mkdir directory1 &&
      echo "in directory1" >> directory1/file &&
-- 
2.29.0-rc0

