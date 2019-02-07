Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6ED91F453
	for <e@80x24.org>; Thu,  7 Feb 2019 19:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfBGTYX (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 14:24:23 -0500
Received: from tasso.uni-konstanz.de ([134.34.240.59]:23024 "EHLO
        tasso.uni-konstanz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBGTYX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 14:24:23 -0500
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Feb 2019 14:24:21 EST
Received: from lyrae.kim.uni-konstanz.de (lyrae.kim.uni-konstanz.de [134.34.240.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by tasso.uni-konstanz.de (Postfix) with ESMTPS id 43wSjL3bfnz17S;
        Thu,  7 Feb 2019 20:16:38 +0100 (CET)
Received: from MBP11.fritz.box (a89-182-229-68.net-htp.de [89.182.229.68])
        by lyrae.kim.uni-konstanz.de (Postfix) with ESMTPSA id 1559D1434BECC;
        Thu,  7 Feb 2019 20:16:38 +0100 (CET)
From:   Katrin Leinweber <katrin.leinweber@uni-konstanz.de>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Openpgp: preference=signencrypt
Autocrypt: addr=katrin.leinweber@uni-konstanz.de; prefer-encrypt=mutual;
 keydata=
 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
 k7mVNqy4RYTItVXDuN5cM6qmLzI=
Subject: [PATCH] doc: prevent overflowing <code> tag in rendered HTML
Message-ID: <14b8a047-9e88-5ed9-300a-c8df1e953f07@uni-konstanz.de>
Date:   Thu, 7 Feb 2019 20:16:37 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an apparently missing back-tick to fix a multi-line <code> section
on https://git-scm.com/docs/git-log which seems to have been caused by
commit 18fb7ffc ("pretty: respect color settings [...]", 2017-07-13).

Signed-off-by: Katrin Leinweber <katrin.leinweber@uni-konstanz.de>
---
 Documentation/pretty-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt
b/Documentation/pretty-formats.txt
index 417b638cd..ee08d0906 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -181,7 +181,7 @@ endif::git-rev-list[]
   `color.diff`, `color.ui`, or `--color`, and respecting the `auto`
   settings of the former if we are going to a terminal). `%C(auto,...)`
   is accepted as a historical synonym for the default (e.g.,
-  `%C(auto,red)`). Specifying `%C(always,...) will show the colors
+  `%C(auto,red)`). Specifying `%C(always,...)` will show the colors
   even when color is not otherwise enabled (though consider
   just using `--color=always` to enable color for the whole output,
   including this format and anything else git might color).  `auto`
-- 
2.20.1



