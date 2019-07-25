Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2BE41F462
	for <e@80x24.org>; Thu, 25 Jul 2019 10:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388644AbfGYKLW (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 06:11:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39582 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388446AbfGYKLV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 06:11:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so50075145wrt.6
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q3GR+HmC4hanNi6lsfFbMIJErTjBCcGre4Jjgg3o/LM=;
        b=EaP+uesEqU3uWG4fq7yw5mtCKmt+pnQaIxNPs+qoErXbdnc7yesVmciHs7YaPoS4jy
         EDxg6haji0PPQ0D+lweYOiHhu1nbnh+6b5fRZGsfIuGNwt8oeey9JOrdUX6Bf/2Z0xzg
         KtQik/p/2RAP8+tl7Xx0HU+8F/NbQfw2nqF5Jy2jAm2Wqe46uiCIwbQr5mEpvlBJDPmH
         MI7yqPI9gun9tuyVx44fzOinb949ppyRL9cnqnx3ZPLGeuDR7CTr0vEw1rT5udnqochL
         CBn1AkSaIv+ab4V+uPgIgTso68oe8fe35HhQmX/bB7kVVvaFWXBS/0B+HzmaeHyWO8d7
         7oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q3GR+HmC4hanNi6lsfFbMIJErTjBCcGre4Jjgg3o/LM=;
        b=nd9d/EVhxXOAAthGcDzCQMqzjB9h5yJch+RQqbAe2AgPP0YpdevSV8PNeyKnXKxeKI
         NQl75zoemFjIcnh5QK75JGJtsIGF/kOxlnOziIwMxiGbeny4rhDb751quyPQ6KqgvsPt
         fwJqytxHhmyQPwVJSx/FJYBw3aDbMsS41Ux+dtNgozj40RvcDhB/tKTfXqy8YJWUuhlt
         esmZh3q+Rbqp1bg3I4KzVRoHhYIuMaHRg2ScLvRtzS4GdNk5sLwpWaBnrsWxTcyN3tik
         dXTgSHBUbimrifxt3tmtseEoYB3Krhi+9+CXpK2AnBRaY/2wSExU6423ahZk7maLhiU1
         ewhg==
X-Gm-Message-State: APjAAAXkuHy9KkODRzLSMx34eQpPm5E7NRXo+wBmR+fuLyLo4mfK8NOG
        7U8X8uUZPRrEErf34Wew2YX7orDD
X-Google-Smtp-Source: APXvYqxz4utVHxw5EUj7v0+nNFjLkEUAb13Yy2JdMhR/FRfnlfcPaDKAU0AP/Q2DlsHdEGiU+KMnVA==
X-Received: by 2002:adf:fd08:: with SMTP id e8mr96899767wrr.147.1564049479901;
        Thu, 25 Jul 2019 03:11:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm60632252wmd.16.2019.07.25.03.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 03:11:19 -0700 (PDT)
Date:   Thu, 25 Jul 2019 03:11:19 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 10:11:07 GMT
Message-Id: <261825fe442a428ea0724ab6ae9d8d351bda8d3e.1564049473.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 06/12] t3427: accommodate for the `rebase --merge` backend
 having been replaced
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since 68aa495b590 (rebase: implement --merge via the interactive
machinery, 2018-12-11), the job of the old `--merge` backend is now
performed by the `--interactive` backend, too.

One consequence is that empty commits are no longer rebased by default.

Meaning that the test case that calls `git rebase -Xsubtree` (which used
to be handled by the `--merge` backend) now needs to ask explicitly for
the empty commit to be rebased.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3427-rebase-subtree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 8c4ddd3408..b490919c60 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -83,10 +83,10 @@ test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto comm
 '
 
 # FAILURE: fatal: Could not parse object
-test_expect_failure 'Rebase -Xsubtree --onto commit' '
+test_expect_failure 'Rebase -Xsubtree --keep-empty --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-onto to-rebase &&
-	git rebase -Xsubtree=files_subtree --onto files-master master &&
+	git rebase -Xsubtree=files_subtree --keep-empty --onto files-master master &&
 	verbose test "$(commit_message HEAD~2)" = "master4" &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
-- 
gitgitgadget

