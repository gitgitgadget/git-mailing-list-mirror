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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3779E1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfGaPSz (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:18:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50549 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbfGaPSv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so61268430wml.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 08:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CtvvfYhgHWuUdEUTYi70g5UR7x+H96DzbzyHvJ14ZZk=;
        b=HF3MGEtfwY7ammL4UattflVWSf+yMAaXXKXUqplszW790NKL2/wzQbLi/0Y8Tw+vH1
         elEnU4n0cirbL9znru7DOj5SdhX1goougFrXpgyoOPfi16ENLQbFbDd/uo3dn51ZVJS/
         4FJYcWaFAdtLq9KEp+OuIUg8PyZJTL5LYANHoYV6i8NiJCkyV9AlCQShF/TK3y2IAtal
         SyHbmgWaTR0xuhkvZx9h7g9+yHBl41amSriZY2evzwA8lZvNO3EEpZyF5yO4xp+8sjKh
         wcTW7MeZwz0UuuksTCaT2MVHLTO7LfwROUPNOBfOYGfQmW418cICcvIEIeVyas77l4Kb
         IUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CtvvfYhgHWuUdEUTYi70g5UR7x+H96DzbzyHvJ14ZZk=;
        b=tpmrCwkqnFz1c2y/S8pl4WuoUbvzIGN3v4FSjd9xEtDMGchbRbqwOkhgWbqSTBcc+h
         3IhDXFR/G9yZnabOo1TSUMEtzJDC2sYPqoKh4pEEpmTJvpHUAAKbBpaZpv2/rkRYRhs2
         QvAbWQDzOCy7o5iWuTkdUdgh/JXDCYoKe0/jWENZYW/SzwxezPnHzQhZ39RrqmAG4431
         pukZyMFHmFxNp5/1TrIQlEKSDF3esZ0J0bd/OTz+6nbmOD7quUdNIntc+Y1gXYdpE+Hb
         LQQziIFkkBmwIp2dsWjDhrjtF+m/rjyRgxVb65Zbt5lpscD0ASavRlpGGgwO8enVv/bM
         kKYQ==
X-Gm-Message-State: APjAAAXFkaiPfpJTu4z4PQL/iqwR+1SoxfQevainHPKKwoTyEZCUs6aZ
        xeGaw5sM8dUJZqvkaWUUHUrnqvAW
X-Google-Smtp-Source: APXvYqybvrmw+PZqygnMgB56QSFZ8NAYqumNAa4bt85nYpXVont7s+0LBkmZlvQohb/HaKpLrpq3yQ==
X-Received: by 2002:a1c:d10c:: with SMTP id i12mr111702559wmg.152.1564586329560;
        Wed, 31 Jul 2019 08:18:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j33sm145851066wre.42.2019.07.31.08.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:18:49 -0700 (PDT)
Date:   Wed, 31 Jul 2019 08:18:49 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 15:18:35 GMT
Message-Id: <0c938d02b303b995f75cd7dbaa77eac01a06dc4d.1564586316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.v2.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
        <pull.294.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 15/16] t3418: test `rebase -r` with merge strategies
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There is a test case in this script that verifies that `git rebase
--preserve-merges` works all right with non-default merge strategies or
non-default merge strategy options.

Now that `git rebase --rebase-merges` learned about merge strategies,
let's copy-edit this test case to verify that that works as intended,
too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3418-rebase-continue.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index bdaa511bb0..fbf9addfd1 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -120,6 +120,20 @@ test_expect_success REBASE_P 'rebase passes merge strategy options correctly' '
 	git rebase --continue
 '
 
+test_expect_success 'rebase -r passes merge strategy options correctly' '
+	rm -fr .git/rebase-* &&
+	git reset --hard commit-new-file-F3-on-topic-branch &&
+	test_commit merge-theirs &&
+	git reset --hard HEAD^ &&
+	test_commit some-other-commit &&
+	test_tick &&
+	git merge --no-ff merge-theirs &&
+	FAKE_LINES="1 3 edit 4 5 7 8 9" git rebase -i -f -r -m \
+		-s recursive --strategy-option=theirs HEAD~2 &&
+	test_commit force-change-ours &&
+	git rebase --continue
+'
+
 test_expect_success '--skip after failed fixup cleans commit message' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout -b with-conflicting-fixup &&
-- 
gitgitgadget

