Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4382D1F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 21:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfJEVMT (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 17:12:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36310 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbfJEVMT (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 5 Oct 2019 17:12:19 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 15EB661C61;
        Sat,  5 Oct 2019 21:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1570309938;
        bh=Wm52b8iIB9lXyIl7tICfuaKE4juYijcTOcHsmgsONd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=j3NsgU35mqpCrJEJxnvbcGAWyrA4yYjLhcUyPW4ooTVdTJ5ZdfX6X0jVqUbenNVOH
         c6qUtgSwYqCpolv33tg67oZp6iiIXfeYexOOMgLIhS17dexFsL9w3WX023/k2jVoWZ
         R6rcWu/cHqymUSeOgn0kMl2hF56pEU3X4kxLbZs/ru+2mXFRpilOE2QVwugA6uLMqp
         /+HepqiJsngFFUuFg9pgikFrNTfjSuTeuJCDVFp72Z+tEZnWPG3YACBkQyGaC6j8N2
         3U/mfJo/eYHlpPhgSwDEF+qVuhMvbD3nFcD6n3mtquWpxDhJqJw4y0Q8EdQ8k45pSC
         whkede6Tz/sNScTlmVcki+9ud21Hm6NMDGEH9Bdv7kIkVWIztjZk76Sj6CjlAQRgwR
         qntWugskr9aFb6VS00trc0KOWX6Rq9KRZMeZ+9G6yYRrSRR3ybWrJvsfF8d6JGbNRd
         +b2OhHtflaLlSpQdqoyuBhZ57ALCwqdodFJsuyWwxOnsSrjow09
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 05/15] t3429: remove SHA1 annotation
Date:   Sat,  5 Oct 2019 21:11:59 +0000
Message-Id: <20191005211209.18237-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb
In-Reply-To: <20191005211209.18237-1-sandals@crustytoothpaste.net>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test passes successfully with SHA-256, so remove the annotation
which limits it to SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3429-rebase-edit-todo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index 76f6d306ea..63edf17114 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -11,7 +11,7 @@ test_expect_success 'rebase exec modifies rebase-todo' '
 	test -e F
 '
 
-test_expect_success SHA1 'loose object cache vs re-reading todo list' '
+test_expect_success 'loose object cache vs re-reading todo list' '
 	GIT_REBASE_TODO=.git/rebase-merge/git-rebase-todo &&
 	export GIT_REBASE_TODO &&
 	write_script append-todo.sh <<-\EOS &&
