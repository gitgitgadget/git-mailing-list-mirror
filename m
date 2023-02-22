Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE47C636D6
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 04:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjBVEIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 23:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjBVEII (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 23:08:08 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5459193F8
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 20:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=k9+2z
        Qmn2qI8Mb+QbRgK16BqWUEiPZZvBO9rqwcbX8E=; b=fb2En+QYAnOQvphzU41Zk
        b6zP2VsWU+wV12Nf2P5gp4q/2QX9fJSxa2SQkrk8HU99RDYhjr5XUH4lCjMlp2SS
        1R2m7TBNP5JcE5jrD7jIAT7kJwdc6Sy+7s8bny4MHIefkD7R59DRh9g7IxpKPE0D
        P3CoTZ5PagmD7Dc+A4gLtI=
Received: from zy-X550VX.. (unknown [183.255.48.209])
        by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id _____wCXTgchlfVjU8TpAg--.19558S4;
        Wed, 22 Feb 2023 12:08:02 +0800 (CST)
From:   Zhang Yi <18994118902@163.com>
To:     git@vger.kernel.org
Cc:     18994118902@163.com
Subject: [GSOC] [PATCH v1 0/2] Modernize t9700 test script
Date:   Wed, 22 Feb 2023 12:07:43 +0800
Message-Id: <20230222040745.1511205-1-18994118902@163.com>
X-Mailer: git-send-email 2.29.0-rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXTgchlfVjU8TpAg--.19558S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRuiifUUUUU
X-Originating-IP: [183.255.48.209]
X-CM-SenderInfo: zprymmqurrmmmqsbiqqrwthudrp/1tbiZQMe-l8ZXBdrHAAAs8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A title in the test script is in old style an a body is indented by spaces.I fix the title style and change indents to TAB.

Zhang Yi (2):
  Fix title style
  Change indents  to TAB

 t/t9700-perl-git.sh | 61 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

-- 
2.29.0-rc0

