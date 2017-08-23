Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1499820899
	for <e@80x24.org>; Wed, 23 Aug 2017 17:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932354AbdHWRuB (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 13:50:01 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34820 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbdHWRuB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 13:50:01 -0400
Received: by mail-wr0-f196.google.com with SMTP id n53so127794wrb.2
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t6ahbf/x4S3VhAokSXRAVdoQ16tbGO3ZM/R2lLAOLAg=;
        b=ByBOByaD+W0rA/qScvbzrbOSumwQW5ZbfCbt07Oz42OWUih4yDsUBqIgcGoVKG1Zs9
         HIHl74fr0xcSRCbgBlioEvGxXbYL6456oMJDXX+rLW5QOzcYXHs9ThONaHeMJga3T71H
         GNcFk6lONGVhGhcGiUeGOdwtQwsTshdwYdWOQAApJsI98oJOkxvZiUM9HfUuhI5vmCoR
         5GeRBxiBtVoSaYeFigtD6FvBC/YqKFoNKKI+yA24dgzIyX9cjm8QNOvxuyHqnaBnB881
         96/wdGh64oDxsvnRwc4isaXoCuVdkaWyRUNjWGowSJpMp8JiNZxJSkkjtafQiijwGIi4
         Vxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t6ahbf/x4S3VhAokSXRAVdoQ16tbGO3ZM/R2lLAOLAg=;
        b=VkKokdkTFPFEfvYImlfPBP2bpTtCud5a5DT0spD4YxepCjz7rSktsNTGJNkchan0n5
         jh1V7DHSPpXAl5/O5VBcCZ7uyE6es+/NMoFRmR+Ob5p9HjZOhH0opEvD9rVuyoM9lruu
         t+NmAS/cu4/VD1nrNQQT2xplk7XIZLrinfKVfkUuEJ+zJpgrKzFGJxt3UtW5MQeeDhLz
         nONtz78VgGlFjAxZ5MlYWyIJMRzb1vlH75yXHFFgmvA2NKmkrFsQV68x6lKp24b8EYmL
         EKz047tkh1tvlpH3Ih184lzD2vZp8n0lQY3mJD3hQMutRRjLwbRTEoKiVxwL7LgEyEPv
         cAdQ==
X-Gm-Message-State: AHYfb5gpamc8nZUL2/YuCWt1aNBrj1Anmx7Ke/RpmKl6RV1w2ubRD3vA
        /lC+JcEeDHbrL2RJ
X-Received: by 10.223.146.4 with SMTP id 4mr2086952wrj.296.1503510599591;
        Wed, 23 Aug 2017 10:49:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id y127sm2635429wmd.3.2017.08.23.10.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Aug 2017 10:49:58 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     STEVEN WHITE <stevencharleswhitevoices@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Documentation/user-manual: update outdated example output
Date:   Wed, 23 Aug 2017 19:49:34 +0200
Message-Id: <731cc618366d4835762d330e2398cf1a754ff11d.1503494617.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.g45c1275a3.dirty
In-Reply-To: <CAJXxHvVSXkQ4SYA5=ZtnWZCBbVk51oWY1OqM_XbGNoruyAGBrA@mail.gmail.com>
References: <CAJXxHvVSXkQ4SYA5=ZtnWZCBbVk51oWY1OqM_XbGNoruyAGBrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit f7673490 ("more terse push output", 2007-11-05), git push
has a completely different output format than the one shown in the user
manual for a non-fast-forward push.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
I'd say it's "not very many read this and immediately tried it out" and
not "nobody read this for the last ten years".

 Documentation/user-manual.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index bc2929867..d3c53b513 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2044,10 +2044,12 @@ If a push would not result in a <<fast-forwards,fast-forward>> of the
 remote branch, then it will fail with an error like:
 
 -------------------------------------------------
-error: remote 'refs/heads/master' is not an ancestor of
- local  'refs/heads/master'.
- Maybe you are not up-to-date and need to pull first?
-error: failed to push to 'ssh://yourserver.com/~you/proj.git'
+ ! [rejected]        master -> master (non-fast-forward)
+error: failed to push some refs to '...'
+hint: Updates were rejected because the tip of your current branch is behind
+hint: its remote counterpart. Integrate the remote changes (e.g.
+hint: 'git pull ...') before pushing again.
+hint: See the 'Note about fast-forwards' in 'git push --help' for details.
 -------------------------------------------------
 
 This can happen, for example, if you:
-- 
2.14.1.151.g45c1275a3.dirty

