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
	by dcvr.yhbt.net (Postfix) with ESMTP id 443B41F462
	for <e@80x24.org>; Thu, 25 Jul 2019 10:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbfGYKL1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 06:11:27 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:34844 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388781AbfGYKLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 06:11:25 -0400
Received: by mail-wr1-f45.google.com with SMTP id y4so50146770wrm.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 03:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CtvvfYhgHWuUdEUTYi70g5UR7x+H96DzbzyHvJ14ZZk=;
        b=RQwzVIyr8TlLkv6dnneascZEDFS6SAdeAHfkBMp5+7joISr7Vqykxhb2HeVm3HsnmA
         ARyUoJwvjBMqCvpxtyy3TfMlzoEuIeIG7cVxtOZm/82LeYI3qq3HV/8U5dQyWpMUARXr
         uv09+isT5GFXPqmPFGmjIOoUcSJKp1+OmODQxoGodMwe79c64UXKhw4esQ7zrK/Qfl55
         hClpP22Pn4ZZCFZH0KOBMfIXLVAD0I9qDN7OI3qhpfw+onONAdsJ8LbaVupcfA7yXEP8
         gclao2WnoOf412zRdhxW3NiOJ6ZVqB/n96IwWSKG9uC46SE+7MtbdqTVyAMbI0YRIGmX
         ySqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CtvvfYhgHWuUdEUTYi70g5UR7x+H96DzbzyHvJ14ZZk=;
        b=VPw+HshTBiPk+bFHX2PheV9mVulvleGGf8PuhAmacFujSHxu3mbDVwBR6Xxfh5nl+7
         mdy3+5uw2r/Q4IIL5VG0GAmb8BXuy38Q+8crorhstbqlQH48PpRBpzjObPv++8HLlPlU
         3IloqDv/4pj7fxiBL16+9Pn0xTjYcO4OkiyDR6kvm/Keo/LLA7Ez9oMIieiFsAU/wSXB
         HE0tYRXzRutM0NyRxM9NBg+yLAW3F74cR33XDb5W8RtKC/iVplK5lS7CCKZ2BOw0pjom
         kBDfqJ/eL5yA60t5Bevq05P3F2bc/ybHlv+WOW60bT9TjrSQK1r6YYbiv5FhDcIaRMjp
         wggA==
X-Gm-Message-State: APjAAAVlYCJqm+qC6k7c9we/dt+Qzj0DDPbf4AXD9Dy8v1/adeiiaK4Y
        QXvJRFuvcEJabJV6xGhX2CuLO6lZ
X-Google-Smtp-Source: APXvYqzglpDFVs4PwZYrq8UitvPq/84wOZWjWWbUpadJZhqllDsGRiyQ6fLgZeY1tcyNjo3jcUxFCA==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr91858447wrn.54.1564049483489;
        Thu, 25 Jul 2019 03:11:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f204sm71892533wme.18.2019.07.25.03.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 03:11:23 -0700 (PDT)
Date:   Thu, 25 Jul 2019 03:11:23 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 10:11:12 GMT
Message-Id: <a326be77aa05b88bfa9fc036b1551e7c2ae3ab2a.1564049474.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 11/12] t3418: test `rebase -r` with merge strategies
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

