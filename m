Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BC5F202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 14:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932864AbdGKObH (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 10:31:07 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35292 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932729AbdGKObG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 10:31:06 -0400
Received: by mail-pf0-f195.google.com with SMTP id q85so153325pfq.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pK6VrqdSGNxfq5y+O+mEoJGMw66OZN1CVb5TkWSzDrA=;
        b=IWUtDZu4I2LKwXadgRSitkUlIlmNJwaguRavkhuTIFkQD8czo+yJfCfHxACokvsI3P
         aJT7yeybvhtHSWi+jn6lKqJ9Zg26sp7DUTO5jvfyj4qVKKztjj3GT+Dxuukn9U8cBpVy
         Cd4wDSDlbNE6jgN5zs9bdcRf6MeqQh6+v626nNQGm1CV5WK4G/m4+dP2/qGhcQq7etiZ
         hWdTFGOQCiZvecnrWi3ePtHf8yjQHjoQF2FO6WH89aXxkNHA+tR2BGMi9yVU0Kam9rWM
         CNtCng9/dxA1KHfV1tsKUvgE4q5Kbz4fp5FS24aLmI03a5Ol9jq6deaDZLmHOE5dnS/T
         S8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pK6VrqdSGNxfq5y+O+mEoJGMw66OZN1CVb5TkWSzDrA=;
        b=LHVWAaBQWE2GL/xNGvKjZpXi/AgKQcoe1hIkYaHbmVUSIqYV2AWwpvHWO6tklEFqf9
         NCCwzvmRpuu8/+ifeVoNKFPWYclD2MFis6yPngH8l2a8/qALeY6n97faGuC+u+ByybFJ
         kkYJMdRZIidSAeoODrCCYSpk0mG3sU84I9EEUJ+Yn2hSKPDkgiQtI0375wuTj+a2Od0t
         77SP9PQS2P69wTt2mP1uPvxketVxscQlayJpqWQaoM0QKisoFtodL/IWNtvBavvMYA+P
         f4HSGc1mFG7hKf4OSOtv1V5XLI2VsarAHE+Q+SFF/r0QkHAHAawkkCehCccxw7zUEDK4
         4fcg==
X-Gm-Message-State: AIVw113QzrvJ1v8LMt9giR+0FUfWfSw25EI9eCSzz7u8mzssscC3TaWL
        H8INgR9pRtEGvDuzvQx5NA==
X-Received: by 10.99.2.18 with SMTP id 18mr229518pgc.42.1499783465515;
        Tue, 11 Jul 2017 07:31:05 -0700 (PDT)
Received: from localhost.localdomain ([117.249.129.113])
        by smtp.gmail.com with ESMTPSA id y185sm244098pgb.9.2017.07.11.07.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jul 2017 07:31:05 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 4/4] hook: add a simple first example
Date:   Tue, 11 Jul 2017 20:00:54 +0530
Message-Id: <20170711143054.9255-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.957.g457671ade
In-Reply-To: <20170711141111.7538-4-kaarticsivaraam91196@gmail.com>
References: <20170711141111.7538-4-kaarticsivaraam91196@gmail.com>
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
 templates/hooks--prepare-commit-msg.sample | 9 ++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

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
index 87d770592..dc707e46e 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -9,20 +9,23 @@
 #
 # To enable this hook, rename this file to "prepare-commit-msg".
 
-# This hook includes two examples.
+# This hook includes three examples. The first one removes the
+# "# Please enter the commit message..." help message.
 #
-# The first includes the output of "git diff --name-status -r"
+# The second includes the output of "git diff --name-status -r"
 # into the message, just before the "git status" output.  It is
 # commented because it doesn't cope with --amend or with squashed
 # commits.
 #
-# The second example adds a Signed-off-by line to the message, that can
+# The third example adds a Signed-off-by line to the message, that can
 # still be edited.  This is rarely a good idea.
 
 COMMIT_MSG_FILE=$1
 COMMIT_SOURCE=$2
 SHA1=$3
 
+@PERL_PATH@ -i.bak -ne 'print unless(m/^. Please enter the commit message/..m/^#$/)' "$COMMIT_MSG_FILE"
+
 # case "$COMMIT_SOURCE,$SHA1" in
 #  ,|template,)
 #    @PERL_PATH@ -i.bak -pe '
-- 
2.13.2.957.g457671ade

