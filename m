Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86662C636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 14:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjBWOQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 09:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjBWOQP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 09:16:15 -0500
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEDDC57D2C
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 06:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+LoK3
        ybq40+XIFETQ0rm60y+znVeMuLgvhN+8+cIWH4=; b=eIf6cRPtHGWIqTie7yVkf
        nfHEUlugmK4dmmuwZ2UDOytsAHxtqKHv+GNNCUI+zPkWFEuOKU4z97IfzbGzTwEE
        Ty+ONkrY1GdCEB7cxPpa9ZBJQzSttkJlNx0j8QaWIA85zEKtLnE2gDj7RklHnUZ8
        TDXTo6Ms1w1uZxlDkcJNkk=
Received: from zy-X550VX.. (unknown [183.255.48.209])
        by smtp18 (Coremail) with SMTP id JNxpCgCHzqondfdjXsaGFA--.49594S4;
        Thu, 23 Feb 2023 22:16:08 +0800 (CST)
From:   Zhang Yi <18994118902@163.com>
To:     git@vger.kernel.org
Cc:     v.garg.work@gmail.com, Zhang Yi <18994118902@163.com>
Subject: [GSOC] [PATCH 0/3] t9700:moderizen test scripts
Date:   Thu, 23 Feb 2023 22:15:17 +0800
Message-Id: <20230223141520.1967625-1-18994118902@163.com>
X-Mailer: git-send-email 2.29.0-rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: JNxpCgCHzqondfdjXsaGFA--.49594S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRu_MVDUUUU
X-Originating-IP: [183.255.48.209]
X-CM-SenderInfo: zprymmqurrmmmqsbiqqrwthudrp/1tbiZQkf-l8ZXC+PbAAAsb
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The style of t9700-perl-git.sh is old.There are 3 things need improve:
* A title is not on the same line with test_expect_success command.
* A test body is indented by whitespaces.
* There are whitespaces after redirect operators.

---
Thanks for all suggestions.

Zhang Yi (3):
  t9700:fix title style
  t9700:change indents to TAB
  t9700:delete whitespaces after redirect operators

 t/t9700-perl-git.sh | 61 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

-- 
2.29.0-rc0

