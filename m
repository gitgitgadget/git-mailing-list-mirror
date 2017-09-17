Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC7F20281
	for <e@80x24.org>; Sun, 17 Sep 2017 10:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbdIQKSR (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 06:18:17 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:35320
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750824AbdIQKSQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 17 Sep 2017 06:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1505643495;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=DL3XB0RgJJJ6U3ujyPX/AyqZR9/tz9ZIBSZEMzYD7L4=;
        b=D0uGr8QXanNPryXGnDwEPi2kII3LUYayWpyfGJj1kPDx8yBfXSKloyUA+AIjahJc
        +dSApneyrUbYlPjvvS7RTzgkOqA6ngahZPb676Uzl9Z6Hnv/vjEvlzyB2MdyncJwkDr
        htoBY7W0t1M5cK7L0yCt+d9YU3v4tw/jNBosVru0=
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015e8f587e1a-6101d61b-8db8-4f22-8101-68f582c6df8f-000000@eu-west-1.amazonses.com>
Subject: [PATCH] t/README: fix typo and grammatically improve a sentence
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 17 Sep 2017 10:18:15 +0000
X-SES-Outgoing: 2017.09.17-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 t/README | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/README b/t/README
index 2f95860369751..4b079e4494d93 100644
--- a/t/README
+++ b/t/README
@@ -265,12 +265,12 @@ or:
 
     $ sh ./t9200-git-cvsexport-commit.sh --run='-3 21'
 
-As noted above, the test set is built going though items left to
-right, so this:
+As noted above, the test set is built by going through the items
+from left to right, so this:
 
     $ sh ./t9200-git-cvsexport-commit.sh --run='1-4 !3'
 
-will run tests 1, 2, and 4.  Items that comes later have higher
+will run tests 1, 2, and 4.  Items that come later have higher
 precedence.  It means that this:
 
     $ sh ./t9200-git-cvsexport-commit.sh --run='!3 1-4'

--
https://github.com/git/git/pull/404
