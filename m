Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9859BC64ED6
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 01:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjBXBhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 20:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBXBhC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 20:37:02 -0500
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2741A48E35
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 17:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GUznP
        5zL1umj9C1EysQAh/DchVShK+lEXckkdRBbQM4=; b=oGqfvwhTsBPW9jVYAh2Ei
        KcXCf90fBDfJsz0oQFb7HBjHx0QqDH3k4zOBqC6wt4IRpr0U40nUWXLFCzfhxCru
        /c6kcsCEJW2ZfQvh1KXmf5tp/3cf5qbby8Lmoc7CYz/I7p34a21lngyPVCTm2a1p
        a56WpEQg13nuUggeHQsMS8=
Received: from zy-X550VX.. (unknown [183.255.48.209])
        by smtp19 (Coremail) with SMTP id R9xpCgB3LvuyFPhj_w4HFQ--.50957S5;
        Fri, 24 Feb 2023 09:36:58 +0800 (CST)
From:   Zhang Yi <18994118902@163.com>
To:     git@vger.kernel.org
Cc:     v.garg.work@gmail.com, Zhang Yi <18994118902@163.com>
Subject: [GSOC] [PATCH v2 1/3] t9700:fix title style
Date:   Fri, 24 Feb 2023 09:34:11 +0800
Message-Id: <20230224013413.1969003-2-18994118902@163.com>
X-Mailer: git-send-email 2.29.0-rc0
In-Reply-To: <20230224013413.1969003-1-18994118902@163.com>
References: <CADupsJPpZnjA=Pu_RZZZXy7Titj3UD7ppww48KvcHHHbrGx=rw@mail.gmail.com>
 <20230224013413.1969003-1-18994118902@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: R9xpCgB3LvuyFPhj_w4HFQ--.50957S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr47tF4ftF45JryxJFy5Arb_yoW3KFbEga
        4kWF1DG347ZFn2qr1xAFsavFnrA347Gw1YkFnYgw1DAa47JrnYvF95GF1rAan8Ca93Cas3
        Kws8Xr4rG3WIyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUj1rW5UUUUU==
X-Originating-IP: [183.255.48.209]
X-CM-SenderInfo: zprymmqurrmmmqsbiqqrwthudrp/1tbiZRog-l8ZXDaxuAAAsE
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One title in t9700-perl-git.sh is in old style where the
test_expect_success command and test title are written on
separate lines.

Combine the test_expect_success command and the title in one line.

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

