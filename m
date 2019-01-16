Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B869C1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393203AbfAPNgO (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:14 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41798 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390490AbfAPNgO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:14 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so5404174edc.8
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HXiejwwfCeMnioxjbQbemqGN0nu3EIP7X0SejTQQ79I=;
        b=otUVaGVHFowMgfVgcGUlOwGB8S8J8rVUcatzMdyrLsWAcI+08WyG7c7nxtttoABtS+
         aa7lj7J4/6CPCGHn5ip0D+1hiPTjVTqwU3d4mvqwjg1eo+Wspd9PvQQ+saQuyUDnc59M
         ICBAfNhKCHm+AjpkKA9dmZ9uHu+l4GB9TAgB0qZuqklPphiIcuwnChRyMRzA4gIVwbHR
         2/imuHvkQw5XVU5wwo0rXss9rxyv/CNOggi8TdAA2M/dVeG5C8mg/OqPgnWQyOp6wUcL
         vsRlTTsRmIJz0umPGEElCJESRMhD9/OhE0pSaLMW+op0t60/1sAupKos+fgjmBOdLRhL
         jDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HXiejwwfCeMnioxjbQbemqGN0nu3EIP7X0SejTQQ79I=;
        b=eNQ5zSI1w1BLBVzOi/w7AISGG6C4eBTId7Igxcv1/lfof83jfmuoOFihbfUOTGHDq+
         9qpE/vnIyUwHyhZV+vMoHLvX8rahBx3cTq3ffhLc94YUYKPp9UVfqEzil2hm4COCql1o
         s+4l9qSunWi/UcVHNoE1vLaeAq6CTsZfJDWEdbwHc7EXmMPZM4iRRssg7zMxBlPxiONx
         hnFbdzvQDsck5hDzA3/7Dzu88UQUp3xl8BICPQ92wLXfBzTJfBccx/ACzSC3tKUYcOoy
         DCsxZM7woLicXiuZ1yYaNrGM2kc/vGjeKJJ+ellFFaSpMGyRiAPCrhLjDQ7u6s/ErdaL
         QmyA==
X-Gm-Message-State: AJcUukegeytXmdzq3Ppnb2p9IeoGywUtuAXLyKNu/7m3r9y+FYBQ3S1F
        PgwBK+xvtEepnpHAohQV+N5gcnli
X-Google-Smtp-Source: ALg8bN4f7xWWbrf1vVtLTLxOqKzzIVGTcB+IJwGUJeU2Ql2Nn5Y4PcvPL/4x08klZgGn4iw75dHvKQ==
X-Received: by 2002:a50:a517:: with SMTP id y23mr7621955edb.219.1547645772458;
        Wed, 16 Jan 2019 05:36:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p36sm5690199edc.78.2019.01.16.05.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:11 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:11 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:35:49 GMT
Message-Id: <75ec97b3921f3ed346e9ab119ebff2546f03fade.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 01/21] travis: fix skipping tagged releases
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

When building a PR, TRAVIS_BRANCH refers to the *target branch*.
Therefore, if a PR targets `master`, and `master` happened to be tagged,
we skipped the build by mistake.

Fix this by using TRAVIS_PULL_REQUEST_BRANCH (i.e. the *source branch*)
when available, falling back to TRAVIS_BRANCH (i.e. for CI builds, also
known as "push builds").

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib-travisci.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 69dff4d1ec..d9d4f1a9d7 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -1,5 +1,9 @@
 # Library of functions shared by all CI scripts
 
+# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
+# want here. We want the source branch instead.
+TRAVIS_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
+
 skip_branch_tip_with_tag () {
 	# Sometimes, a branch is pushed at the same time the tag that points
 	# at the same commit as the tip of the branch is pushed, and building
-- 
gitgitgadget

