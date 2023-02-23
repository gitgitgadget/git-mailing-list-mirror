Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE89C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 14:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjBWOQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 09:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbjBWOQT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 09:16:19 -0500
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EB1A56519
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 06:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EtOcd
        mI1sd/hZfWmW6xKKc7llO/nJHcKdCqHA9cqIHQ=; b=E3tWxr1QWlDJIWhSpaLYW
        efHZ7TEnx9goZ5kHB4z4ZAbLzqUfkti41kXIissoMZiJapF58eITLYq4i++D2g1/
        LOGKZ3xWgeWHM6e/kukIKQZmMsrV7yGyUDxVJG3BgT6N8ms0MirlsK2+qsJ0HIyr
        IvH9/8utmCREyo9/Z+FVgw=
Received: from zy-X550VX.. (unknown [183.255.48.209])
        by smtp18 (Coremail) with SMTP id JNxpCgCHzqondfdjXsaGFA--.49594S6;
        Thu, 23 Feb 2023 22:16:14 +0800 (CST)
From:   Zhang Yi <18994118902@163.com>
To:     git@vger.kernel.org
Cc:     v.garg.work@gmail.com, Zhang Yi <18994118902@163.com>
Subject: [GSOC] [PATCH v2 2/3] t9700:change indents to TAB
Date:   Thu, 23 Feb 2023 22:15:19 +0800
Message-Id: <20230223141520.1967625-3-18994118902@163.com>
X-Mailer: git-send-email 2.29.0-rc0
In-Reply-To: <20230223141520.1967625-1-18994118902@163.com>
References: <20230223141520.1967625-1-18994118902@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: JNxpCgCHzqondfdjXsaGFA--.49594S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWrXw4kXryftr4rur4kJFb_yoW5GF45pF
        Wa9r1ayr1qqr13JwsxuFyxCrW7Ja1kCryDXrZxC3s3CrnYkr1xtF13Kr17XFyrXFnIqa1a
        ya4q9r15Ww4ag3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEDGYDUUUUU=
X-Originating-IP: [183.255.48.209]
X-CM-SenderInfo: zprymmqurrmmmqsbiqqrwthudrp/1tbiYw8f-laEN1MBmAAAsi
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The body of one test script in t9700-perl-git.sh is indented by spaces
while others are indented by TAB.And test bodies should be indented with
TAB, not spaces.

Replace all space indents by TAB.

Signed-off-by: Zhang Yi <18994118902@163.com>
---
 t/t9700-perl-git.sh | 58 ++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 3f6396ef63..671875a3fc 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -14,35 +14,35 @@ skip_all_if_no_Test_More
 # set up test repository
 
 test_expect_success 'set up test repository' '
-     echo "test file 1" > file1 &&
-     echo "test file 2" > file2 &&
-     mkdir directory1 &&
-     echo "in directory1" >> directory1/file &&
-     mkdir directory2 &&
-     echo "in directory2" >> directory2/file &&
-     git add . &&
-     git commit -m "first commit" &&
-
-     echo "new file in subdir 2" > directory2/file2 &&
-     git add . &&
-     git commit -m "commit in directory2" &&
-
-     echo "changed file 1" > file1 &&
-     git commit -a -m "second commit" &&
-
-     git config --add color.test.slot1 green &&
-     git config --add test.string value &&
-     git config --add test.dupstring value1 &&
-     git config --add test.dupstring value2 &&
-     git config --add test.booltrue true &&
-     git config --add test.boolfalse no &&
-     git config --add test.boolother other &&
-     git config --add test.int 2k &&
-     git config --add test.path "~/foo" &&
-     git config --add test.pathexpanded "$HOME/foo" &&
-     git config --add test.pathmulti foo &&
-     git config --add test.pathmulti bar
-     '
+	echo "test file 1" > file1 &&
+	echo "test file 2" > file2 &&
+	mkdir directory1 &&
+	echo "in directory1" >> directory1/file &&
+	mkdir directory2 &&
+	echo "in directory2" >> directory2/file &&
+	git add . &&
+	git commit -m "first commit" &&
+
+	echo "new file in subdir 2" > directory2/file2 &&
+	git add . &&
+	git commit -m "commit in directory2" &&
+
+	echo "changed file 1" > file1 &&
+	git commit -a -m "second commit" &&
+
+	git config --add color.test.slot1 green &&
+	git config --add test.string value &&
+	git config --add test.dupstring value1 &&
+	git config --add test.dupstring value2 &&
+	git config --add test.booltrue true &&
+	git config --add test.boolfalse no &&
+	git config --add test.boolother other &&
+	git config --add test.int 2k &&
+	git config --add test.path "~/foo" &&
+	git config --add test.pathexpanded "$HOME/foo" &&
+	git config --add test.pathmulti foo &&
+	git config --add test.pathmulti bar
+'
 
 test_expect_success 'set up bare repository' '
 	git init --bare bare.git
-- 
2.29.0-rc0

