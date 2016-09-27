Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF91020986
	for <e@80x24.org>; Tue, 27 Sep 2016 20:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755084AbcI0UoN (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:44:13 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:59679
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752993AbcI0UoM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Sep 2016 16:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1475009049;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=dJ/ie5zT1QnSBz/LpPZrZPugOozY/zkksMzx874I89E=;
        b=a6oZgfL+qkrUMEaO/DXPRFm2nQ+PdmrHdk2aPbx2g4qxOlfrMNTGOeziYhIqoe47
        gQ9crOrFH5IsqcIIFDs2qi0wp7PNUjghZt+uZ6cEn3j3d8lQ32d4oPv5eMoT0ndjU6z
        68NLOadXhM+FosQ9+wpZ5ujLLLnLS/+X71GEcEbA=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201576d63f422-abe45938-0da1-4fc0-b0e7-3e552b59d10a-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201576bfb6c7d-0b68228f-9503-4dd1-9721-713477fa2596-000000@eu-west-1.amazonses.com>
References: <010201576bfb6c7d-0b68228f-9503-4dd1-9721-713477fa2596-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2] rev-list-options: clarify the usage of --reverse
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Sep 2016 20:44:09 +0000
X-SES-Outgoing: 2016.09.27-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Specify even more clearly that --reverse works only with the commits
which are chosen to be shown so as to eliminate the confusion as to
whether the first n or the last n commits with be shown when used
with `-n --reverse`.

Reported-by: Ruediger Meier <sweet_f_a@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 Documentation/rev-list-options.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 7e462d3..5da7cf5 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -657,8 +657,9 @@ avoid showing the commits from two parallel development track mixed
 together.
 
 --reverse::
-	Output the commits in reverse order.
-	Cannot be combined with `--walk-reflogs`.
+	Output the commits chosen to be shown (see Commit Limiting
+	section above) in reverse order. Cannot be combined with
+	`--walk-reflogs`.
 
 Object Traversal
 ~~~~~~~~~~~~~~~~

--
https://github.com/git/git/pull/296
