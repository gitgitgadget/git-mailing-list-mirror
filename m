Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44221FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 07:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760662AbdDSH4h (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 03:56:37 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:59884
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1760650AbdDSH4f (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Apr 2017 03:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1492588593;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=i3SzWYFclrrvkuk07/kXz32TqdY5kdmuTD6P9aYudys=;
        b=WpmBmeOw7WY/5Onx6B/prn4I6tfMQkCy6U8cYKrxMF9/4BZalbePJTctBrz2Pal8
        +eIiffHVcZF6PyAf9BJkn6iopDXc8NSF+K66LLC/FC7uWXzwSDa8JHy+ZJCN/XA9Y2M
        eBBpye5b/VHW4bhMru2Y4junwyrHmwBfzweUaTEQ=
From:   Sebastian Schuberth <sschuberth@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015b853681c6-2fb6f9ce-28dc-4ca8-82de-d5fbff10d3af-000000@eu-west-1.amazonses.com>
Subject: [PATCH] gitmodules: clarify what history depth a shallow clone has
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Apr 2017 07:56:33 +0000
X-SES-Outgoing: 2017.04.19-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/gitmodules.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 8f7c50f..6f39f24 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -84,8 +84,8 @@ submodule.<name>.ignore::
 
 submodule.<name>.shallow::
 	When set to true, a clone of this submodule will be performed as a
-	shallow clone unless the user explicitly asks for a non-shallow
-	clone.
+	shallow clone (with a history depth of 1) unless the user explicitly
+	asks for a non-shallow clone.
 
 
 EXAMPLES

--
https://github.com/git/git/pull/347
