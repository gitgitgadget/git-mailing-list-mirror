Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD52C61DA4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 04:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjBVEIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 23:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjBVEIe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 23:08:34 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B78433476
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 20:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=I2vhl
        xr6CAzuGFXn0bxXUKrXerBXJyIF+FC6VpXmmjE=; b=Qf76mW0CjQ+1r5B/ywUbI
        WW1H46FsM113AkBEz6eCzgDGSHcK7PiZoPyfcPqOzRwPvGYgmkoOhT8g7oFuK7qw
        rgdVSDFXuiWDzSjWwg/9yVL9dBzsu9cr3z8tG8o7hkZY2RjR3T18oJ79Nt5zoZzf
        Ze0B9xHJdhxi6bDUICfY9E=
Received: from zy-X550VX.. (unknown [183.255.48.209])
        by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id _____wCXTgchlfVjU8TpAg--.19558S6;
        Wed, 22 Feb 2023 12:08:18 +0800 (CST)
From:   Zhang Yi <18994118902@163.com>
To:     git@vger.kernel.org
Cc:     18994118902@163.com
Subject: [GSOC] [PATCH v1 2/2] Change indents  to TAB
Date:   Wed, 22 Feb 2023 12:07:45 +0800
Message-Id: <20230222040745.1511205-3-18994118902@163.com>
X-Mailer: git-send-email 2.29.0-rc0
In-Reply-To: <20230222040745.1511205-1-18994118902@163.com>
References: <20230222040745.1511205-1-18994118902@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXTgchlfVjU8TpAg--.19558S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww18WFWrAr18Kw1xXr1xuFg_yoW8Kw4UpF
        Wa9r1ayr1qqr13twsxurWxCrWUJa1kCr98XrZxC34fCrnYkr1xtF13Kr17XFyrXrnIva1a
        va4v9r15Ww4ag3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE-BMPUUUUU=
X-Originating-IP: [183.255.48.209]
X-CM-SenderInfo: zprymmqurrmmmqsbiqqrwthudrp/1tbiGB4e-lv2k5v62AAAsh
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

