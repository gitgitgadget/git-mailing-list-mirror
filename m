Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B84B920357
	for <e@80x24.org>; Mon, 10 Jul 2017 14:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932402AbdGJOSD (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 10:18:03 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34264 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932390AbdGJOSB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 10:18:01 -0400
Received: by mail-pg0-f68.google.com with SMTP id j186so12910874pge.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 07:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DBK9uHnbUiwXLM/VDskUZzcIrTG38mq97HP0wxqIHdc=;
        b=AX613qsFZ3ROXzi7pO63zbV80TkNOvVZtsTB8Ey3Q3cU4+CmFSGQocj7KS93Bb71VA
         7JSD5tZZu2uEeb2o+Ky8dON4CSsjhDUA+Du4NdpaRztbtmNtUmZ3r/hm/mLkdE9YkpXD
         AuH5gJLCGjl2HRsipF5IbMWci0xKMBpbyFl8lDR8w+wElBg6tDWtyXd3rr8leABvxk64
         BpPCkWLRHtOvlAN7jdIacetEfyzKdc4/CCNCZXisOk3toO9qnAtqtV8WWytLr8U8UfRz
         /YHqDnyCy9ekieC8mvD42km7eG3Mgh7i++8Dr8XdvRGqr/dz2w7Dfs1VSTZ5aI4X8+Q2
         NeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DBK9uHnbUiwXLM/VDskUZzcIrTG38mq97HP0wxqIHdc=;
        b=YfS/YTM4IOSxZQZKPNcyWg5DEi8cIaw/jaButOvbI9KIbAjxiPVsJPGrZnsSyv23dd
         iTGbsodInQ6nyy5nwq8TCWr2aR2f3BviReYw1xJfhmWwBWoKtO6rKcM8rcCtftxedeqZ
         cQrEDIJd8lf8mlnjSTl7bmfIZSeMBkA9FKSHM0spa+jmF065+eW+qhsurfz5DQQqrfDd
         dSSJxOSodmFgr5j6wBFqLy/q44YqXNlol8ADhNDZcQqpgS+1zu33gtnWe5RGEZ+xq8Yv
         8t5d2pv7g8+RUh67Jvqo0qFl17u7QlpL7qOix2EMPPPR3WE57Owg9tvdfMEQrI5I2Qkh
         YgyQ==
X-Gm-Message-State: AIVw110CF26ZoMw6ZXWMuNqwj9P1kF7WAdzuKD1wLGbpQEgg0QLJd6nn
        9oxzMlAn3hcIJQ==
X-Received: by 10.84.133.73 with SMTP id 67mr18765640plf.125.1499696280649;
        Mon, 10 Jul 2017 07:18:00 -0700 (PDT)
Received: from localhost.localdomain ([117.209.158.50])
        by smtp.gmail.com with ESMTPSA id t78sm25469923pfa.48.2017.07.10.07.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jul 2017 07:18:00 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 4/4] hook: add a simple first example
Date:   Mon, 10 Jul 2017 19:47:44 +0530
Message-Id: <20170710141744.8541-4-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.957.g457671ade
In-Reply-To: <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
References: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
 <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
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
 I made an attempt to make the second example work with amending 
 with the aim of making it suitable for usage out of the box. It
 seems that it's not easy to make it work as the status of a file
 cannot be determined correctly when the index while amending
 introduces changes to a file that has a change in the commit being
 amended.

 Is there any way in which the second example could be made to work with
 amending without much effort? I'm asking this assuming something might
 have happened, since the script was added, that could ease the task.

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
index a15d6d634..a84c3e5a8 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -9,7 +9,8 @@
 #
 # To enable this hook, rename this file to "prepare-commit-msg".
 
-# This hook includes three examples.
+# This hook includes three examples.  The first one removes the
+# "# Please enter the commit message..." help message.
 #
 # The second includes the output of "git diff --name-status -r"
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

