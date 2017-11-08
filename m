Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D4371F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 13:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbdKHNVM (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 08:21:12 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54233 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbdKHNVL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 08:21:11 -0500
Received: by mail-wm0-f65.google.com with SMTP id r196so10758936wmf.2
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 05:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=n7NRH88kK3ImlBEQWSt0E9idrUOT1sHKSVriwK0MVpA=;
        b=I2OBTk2GWgAcdMgPTq48NjmU40E2Twsld0cdlR8MpPEw5CCJMd8M01VzxXgpGZRlcB
         GE1QC7qK9eYMTQl1JpeBmcZmucPH7Mweg6dqG8KyaZK4u/kTAQ3EUOoyUgprYO/uGhyN
         ETqWufXku6M1Qb63iXM2GuhTNv3w5L9gJ6wAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n7NRH88kK3ImlBEQWSt0E9idrUOT1sHKSVriwK0MVpA=;
        b=cymZSHcHjZSAKG3EfcyZwA0lcOBXdP9oO/VLNn/20Pof3CqhKPzVM+EnB2qCJK8c+U
         NNKqMEyE5NzbTdrlma8KN+EqNNpsjfvYEZD84Y/nZkExB3XA6CHhCiy209bBvu/wK969
         /ztk2lhGmkGDhVGQ9+dLTPNgsSq7DCKvNvVC4Wqni6NvA76NTTwodOtRZ/DticIzOQAP
         ecueGzW7vD5raSinov+ZZDBw+duTJKuxgCHkF4awzC8Igk5OAFe7MUXSN+099EHyLUJ9
         uIXmxgj8Um/X8fkkBwQqrFI1A6VFkoF9WSxjtP6FFH+ZVAKhqhASJ7TEfpjsQV5NJzfH
         Dtjw==
X-Gm-Message-State: AJaThX6WwugvJBPfFKKJoRUnV8vvLRfv4tIsnWaoJWnLW65oozS/LoxS
        vnpD/R5CP52dQIo6u09Fkx9UwYtxIbQ=
X-Google-Smtp-Source: ABhQp+SRbzndSdjxSNXKKoag6/fA4mWrM93i6WFyGHhlR6j++4yGG3Ju0/1WqyyGFOsKjOHpQJQqFw==
X-Received: by 10.28.125.206 with SMTP id y197mr450314wmc.85.1510147270123;
        Wed, 08 Nov 2017 05:21:10 -0800 (PST)
Received: from PC5175.ad.datcon.co.uk ([2620:104:4001:73:a407:552d:75e4:4516])
        by smtp.gmail.com with ESMTPSA id e131sm22461466wmg.1.2017.11.08.05.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Nov 2017 05:21:09 -0800 (PST)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCH] rebase -i: fix comment typo
Date:   Wed,  8 Nov 2017 13:20:20 +0000
Message-Id: <20171108132020.287540-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2563dc52d..437815669 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -722,7 +722,7 @@ collapse_todo_ids() {
 	git rebase--helper --shorten-ids
 }
 
-# Add commands after a pick or after a squash/fixup serie
+# Add commands after a pick or after a squash/fixup series
 # in the todo list.
 add_exec_commands () {
 	{
-- 
2.14.3

