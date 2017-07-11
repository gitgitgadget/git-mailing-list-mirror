Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E17E8202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 14:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932765AbdGKOLf (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 10:11:35 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33495 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755627AbdGKOLe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 10:11:34 -0400
Received: by mail-pf0-f193.google.com with SMTP id e199so96038pfh.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 07:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zJk0SAkAD42dAixioWbrj4ngYhm99dXK9RfyHsZmgrY=;
        b=PuEW543eGKO9ReT5T2ZoaMHwLgFbEN/EQ9HuMX7WGbW7UcDzinqlHD1BarltNPxsA9
         ylWk0+ps3drqIGIiVV2NNeicTq/k7G0wxU0eWsuc4vh9tj1MAi1w9mUyyFgxVKC2YpGW
         JzBV3QkquJz7U5fEFSpC4EqZzUBdSjYu+nFMNa1c+sj/XXgUxIngYF59HpDzHfpCpHxF
         xHSSSk1t5yxbCvqTtKPzjcpTBrrlHj6EnvLlFWvP8wUnl1HyH42x+l8Q+kDlf+Ja3rXf
         056X2afnu9ioIlilz0EQtXhahcpJqHREp57ZErpNIM8ArPcxaQud0Dk05k1kJKCuM1OG
         vzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zJk0SAkAD42dAixioWbrj4ngYhm99dXK9RfyHsZmgrY=;
        b=Wqkfc1qfUxggL7cJ3OaUH+HdAVnkvIUM0c8NqrERrjTupzJQaeGuV0l5QXmUoIlaF8
         QLOigE2J5Vo5Mn5bliJAbTfDPa0koT1GMHyY4ZQiicPZuHgXPnE2XzlLcnBazWAQVZHn
         yRf44ksVdmacDdWvzra1qKoq5RA69a1yJwLBTXUWe1Lx/Fh7flGOYOCP437XHITNA0HP
         l/xOhWthCO4V9B3pityOIl34P7ETm6Nc+V54oQ6lxy2C9D3ZOv0C0rbiJHYWcPvq1UKD
         e232a0flnxOQNzqcnYOPyPNuxHh9enJQAuzyuVUwyUOIKWXnZvnGfd8+zpv15DXN+ig6
         r7Hg==
X-Gm-Message-State: AIVw112N5euXloftSzVHMDCVisO9dbJZBFPvOkbidbDmCueHBhCEG37T
        XIuSLwrVFhNd0XhI7b6hNQ==
X-Received: by 10.99.143.21 with SMTP id n21mr86312pgd.145.1499782293856;
        Tue, 11 Jul 2017 07:11:33 -0700 (PDT)
Received: from localhost.localdomain ([117.249.129.113])
        by smtp.gmail.com with ESMTPSA id i19sm98579pfj.78.2017.07.11.07.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jul 2017 07:11:33 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 4/4] hook: add a simple first example
Date:   Tue, 11 Jul 2017 19:41:11 +0530
Message-Id: <20170711141111.7538-4-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.957.g457671ade
In-Reply-To: <20170711141111.7538-1-kaarticsivaraam91196@gmail.com>
References: <xmqqfue45asd.fsf@gitster.mtv.corp.google.com>
 <20170711141111.7538-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a simple example that replaces an outdated example
that was removed. This ensures that there's at the least
a simple example that illustrates what could be done
using the hook just by enabling it.

Also, update the documentation.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Documentation/githooks.txt                 | 3 +++
 templates/hooks--prepare-commit-msg.sample | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index fdc01aa25..59f38efba 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -121,6 +121,9 @@ it is not suppressed by the `--no-verify` option.  A non-zero exit
 means a failure of the hook and aborts the commit.  It should not
 be used as replacement for pre-commit hook.
 
+The sample `prepare-commit-msg` hook that comes with Git removes the
+help message found in the commented portion of the commit template.
+
 commit-msg
 ~~~~~~~~~~
 
diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index 87d770592..f0228c1cb 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -9,7 +9,8 @@
 #
 # To enable this hook, rename this file to "prepare-commit-msg".
 
-# This hook includes two examples.
+# This hook includes three examples. The first one removes the
+# "# Please enter the commit message..." help message.
 #
 # The first includes the output of "git diff --name-status -r"
 # into the message, just before the "git status" output.  It is
@@ -23,6 +24,8 @@ COMMIT_MSG_FILE=$1
 COMMIT_SOURCE=$2
 SHA1=$3
 
+@PERL_PATH@ -i.bak -ne 'print unless(m/^. Please enter the commit message/..m/^#$/)' "$COMMIT_MSG_FILE"
+
 # case "$COMMIT_SOURCE,$SHA1" in
 #  ,|template,)
 #    @PERL_PATH@ -i.bak -pe '
-- 
2.13.2.957.g457671ade

