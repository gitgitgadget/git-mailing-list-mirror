Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EADCC433EF
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 16:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA51B610A4
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 16:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhJIQnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 12:43:23 -0400
Received: from defaultvalue.org ([45.33.119.55]:55978 "EHLO defaultvalue.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhJIQnW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 12:43:22 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Oct 2021 12:43:22 EDT
Received: from trouble.defaultvalue.org (localhost [127.0.0.1])
        (Authenticated sender: rlb@defaultvalue.org)
        by defaultvalue.org (Postfix) with ESMTPSA id 82B4E203B2
        for <git@vger.kernel.org>; Sat,  9 Oct 2021 11:33:39 -0500 (CDT)
Received: by trouble.defaultvalue.org (Postfix, from userid 1000)
        id EDF2814E081; Sat,  9 Oct 2021 11:33:38 -0500 (CDT)
From:   Rob Browning <rlb@defaultvalue.org>
To:     git@vger.kernel.org
Subject: [PATCH 1/1] signature-format.txt: add space to fix gpgsig continuation line
Date:   Sat,  9 Oct 2021 11:33:38 -0500
Message-Id: <20211009163338.2175170-1-rlb@defaultvalue.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a space to the blank line after the version header in the example
gpgsig commit header.

Signed-off-by: Rob Browning <rlb@defaultvalue.org>
---

 While investigating this (while parsing commit objects) I also
 noticed a commit in a repo that had a blank continuation line (" \n")
 after the "END PGP SIGNATURE" line.

 Presuming that's valid, I suppose we could consider detailing any
 additional specifications, i.e. what kind of trailing content a
 parser should expect/ignore, etc.

 Documentation/technical/signature-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
index 2c9406a56a..6acc0b1247 100644
--- a/Documentation/technical/signature-format.txt
+++ b/Documentation/technical/signature-format.txt
@@ -78,7 +78,7 @@ author A U Thor <author@example.com> 1465981137 +0000
 committer C O Mitter <committer@example.com> 1465981137 +0000
 gpgsig -----BEGIN PGP SIGNATURE-----
  Version: GnuPG v1
-
+ 
  iQEcBAABAgAGBQJXYRjRAAoJEGEJLoW3InGJ3IwIAIY4SA6GxY3BjL60YyvsJPh/
  HRCJwH+w7wt3Yc/9/bW2F+gF72kdHOOs2jfv+OZhq0q4OAN6fvVSczISY/82LpS7
  DVdMQj2/YcHDT4xrDNBnXnviDO9G7am/9OE77kEbXrp7QPxvhjkicHNwy2rEflAA
-- 
2.30.2

