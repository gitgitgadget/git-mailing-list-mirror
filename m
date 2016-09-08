Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1408E1F859
	for <e@80x24.org>; Thu,  8 Sep 2016 04:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754308AbcIHEfB (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 00:35:01 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33253 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754012AbcIHEfA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 00:35:00 -0400
Received: by mail-it0-f66.google.com with SMTP id g185so3395013ith.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 21:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6ChtWMGQ9PueRIK/GAoBgNharqj1vPTy77rlW7OwktM=;
        b=STTvVuRBk4O3PXCgXmi0UcEJefFUV7GtIDHREMBOey2hfuDVxQ1XESbqts7iaGp7G1
         BP00ycBBNWQaEA6F5i45mDaVp0ZnW8wIZ4mnuXvrvz/5BZbQd7rbQFo03G4sEeZUIjXS
         t8i0rBFpHFn5nJGAaaqDaZiPui57pwf645Afh8p2a/KaC4CdJy8ZAFcwllxvoAxMsOwP
         lEEPU5ed2a8kgBc6MsH5LlF8FuTjhK8ezdmMnScSTEMiKndjEspZqBUtzjhmJlKAtMTx
         DJRlhWzMdMKhkP2iyYMLw/NnQVPTrWTY6qokl5pfkWZO67WQBjtbEyMu9s+L6jbO2JRL
         jWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6ChtWMGQ9PueRIK/GAoBgNharqj1vPTy77rlW7OwktM=;
        b=doC4MCXFlqyK2hTfdtoLd9KeyUN67mtXIXiIHl8sMoQu7HeCEv9gc1GkJWa5/KG/Oh
         X0TSOo3ffn6dWVz2FRogYE4cc8sdZylXSv1zxuYpyzC4FbdutdjorVqpWtUc7rE0thXW
         73aAm5zhFmCG+QbXRoqq6bTtCCcvEFHPQPV1dj9UMm8RDOsCP+vVyMfN8mfI1IIZLGwD
         JF5sU6IEx5Alc+vVdE21AvT00QRO/dBtEVEoRxoLwRsVTOoI+9Aqk9aWrxztC2ouSQv1
         FN5LtZvSnFoh4jaZCXV2l90UiQ76lrHiQ4mVuZ6SH4Iuxfc/rThCrpb/LHEXjmfTwdT0
         9EOw==
X-Gm-Message-State: AE9vXwMtmJQb9m5LorX1QFv9O2x5GALL41LFHecgRISLfNQ4rD+2XITK4+PGDO/KATx9kQ==
X-Received: by 10.36.87.212 with SMTP id u203mr12220492ita.7.1473309299720;
        Wed, 07 Sep 2016 21:34:59 -0700 (PDT)
Received: from wolverine.localdomain (c-67-182-247-84.hsd1.ut.comcast.net. [67.182.247.84])
        by smtp.gmail.com with ESMTPSA id o142sm5595480itg.1.2016.09.07.21.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2016 21:34:58 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     vascomalmeida@sapo.pt, Matthieu.Moy@imag.fr, gitster@pobox.com,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 5/5] unpack-trees: do not capitalize "working"
Date:   Wed,  7 Sep 2016 22:34:53 -0600
Message-Id: <20160908043453.6044-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In English, only proper nouns are capitalized.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 unpack-trees.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 11c37fb..c87a90a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -123,9 +123,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	msgs[ERROR_SPARSE_NOT_UPTODATE_FILE] =
 		_("Cannot update sparse checkout: the following entries are not up-to-date:\n%s");
 	msgs[ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN] =
-		_("The following Working tree files would be overwritten by sparse checkout update:\n%s");
+		_("The following working tree files would be overwritten by sparse checkout update:\n%s");
 	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
-		_("The following Working tree files would be removed by sparse checkout update:\n%s");
+		_("The following working tree files would be removed by sparse checkout update:\n%s");
 
 	opts->show_all_errors = 1;
 	/* rejected paths may not have a static buffer */
-- 
2.9.3

