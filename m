Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026EBC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 14:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjBWOQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 09:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjBWOQX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 09:16:23 -0500
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6966A49893
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 06:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HB+dW
        uvscvjtkF0TmqtxSRbCMAwdZR2HoFjGWALWztU=; b=EFJK44Bvx/jB8VuMTiy6O
        xpc++UcMvVALLqk9ta20eNCrkEWM+12Yifm0IXZb/2GpM2b2Koho5a7zuwj5T4Ut
        rYzDeZ5BAyyrDuB5/zPVYa4Ga43MXDMpMCES4lWjV+4RNHlwz2v9A5oTbgKHkBs0
        URVwBYpqVbJbAoasjckfV0=
Received: from zy-X550VX.. (unknown [183.255.48.209])
        by smtp18 (Coremail) with SMTP id JNxpCgCHzqondfdjXsaGFA--.49594S7;
        Thu, 23 Feb 2023 22:16:17 +0800 (CST)
From:   Zhang Yi <18994118902@163.com>
To:     git@vger.kernel.org
Cc:     v.garg.work@gmail.com, Zhang Yi <18994118902@163.com>
Subject: [GSOC] [PATCH v2 3/3] t9700:delete whitespaces after redirect operators
Date:   Thu, 23 Feb 2023 22:15:20 +0800
Message-Id: <20230223141520.1967625-4-18994118902@163.com>
X-Mailer: git-send-email 2.29.0-rc0
In-Reply-To: <20230223141520.1967625-1-18994118902@163.com>
References: <20230223141520.1967625-1-18994118902@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: JNxpCgCHzqondfdjXsaGFA--.49594S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7XFW5Cw15AFyxWFy5urW8Crg_yoW8JrW7pr
        45Gr1ayrn0vr47GrnruF18CryxCa98Grn8XFsF9wn8GFn8CFsFkF13tr47WF18XrnIq3ZI
        ga1ktry8Gr4rW3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcyCAUUUUU=
X-Originating-IP: [183.255.48.209]
X-CM-SenderInfo: zprymmqurrmmmqsbiqqrwthudrp/1tbiZREf-l8ZXC+PwgAAst
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are whitespaces after redirect operators,which is a deprecated
style.

Delete whitespaces after redirect operators.

Signed-off-by: Zhang Yi <18994118902@163.com>
---
 t/t9700-perl-git.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 671875a3fc..ccc8212d73 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -14,20 +14,20 @@ skip_all_if_no_Test_More
 # set up test repository
 
 test_expect_success 'set up test repository' '
-	echo "test file 1" > file1 &&
-	echo "test file 2" > file2 &&
+	echo "test file 1" >file1 &&
+	echo "test file 2" >file2 &&
 	mkdir directory1 &&
-	echo "in directory1" >> directory1/file &&
+	echo "in directory1" >>directory1/file &&
 	mkdir directory2 &&
-	echo "in directory2" >> directory2/file &&
+	echo "in directory2" >>directory2/file &&
 	git add . &&
 	git commit -m "first commit" &&
 
-	echo "new file in subdir 2" > directory2/file2 &&
+	echo "new file in subdir 2" >directory2/file2 &&
 	git add . &&
 	git commit -m "commit in directory2" &&
 
-	echo "changed file 1" > file1 &&
+	echo "changed file 1" >file1 &&
 	git commit -a -m "second commit" &&
 
 	git config --add color.test.slot1 green &&
-- 
2.29.0-rc0

