Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F8CC3F6B0
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 10:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiHNKA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 06:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHNKA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 06:00:26 -0400
X-Greylist: delayed 361 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 Aug 2022 03:00:23 PDT
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65A0BCA0
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 03:00:22 -0700 (PDT)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1660470858; bh=V0q7F0czR4SdfYrxRN9Yli1S3M6Z1FxGeaadYBKXzm8=;
        h=From:To:Cc:Subject:Date:From;
        b=USvz8I27YU5HJZhjQhKv4Csh9w6lLEWv0Eu1tKI9000h1SwY2xyF/PRoXhyInLtN2
         Bc/rK458teWef64ioHYT/+Ru4qjdsH0uRk/9ObdDlTdIBenEsEKDvxUfDnbZSV/hfd
         MoHImm4hW3MOz/ACpqouiEDaWeNJ/xEA/mJnm9Ak=
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH] Documentation: mention the magic pathspec ":/"
Date:   Sun, 14 Aug 2022 11:52:53 +0200
Message-Id: <20220814095253.3422612-1-thomas@t-8ch.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 Documentation/gitcli.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 1819a5a185..a421855bdb 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -78,6 +78,8 @@ you will.
    using a '.' as a repository name in Git (a dot-repository) is a relative
    path and means your current repository.
 
+ * The magic pathspec `:/` refers to the root of the working tree.
+
 Here are the rules regarding the "flags" that you should follow when you are
 scripting Git:
 

base-commit: afa70145a25e81faa685dc0b465e52b45d2444bd
-- 
2.37.2

