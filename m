Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6454A20248
	for <e@80x24.org>; Sat,  2 Mar 2019 21:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCBVTp (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 16:19:45 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:36173 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfCBVTp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 16:19:45 -0500
Received: by mail-ed1-f45.google.com with SMTP id g9so1191337eds.3
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 13:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=UMoYDuje7lyubOwdgTPzAF8XMA4SElPKmRK/hEcMksA=;
        b=T1lEQdZtx8V2Ykfa2m5D4/PuopGaHsTKKk0ULqeTh3rgDlj0mYxeuSLCiP94mSycfr
         nQAfYDxNJ7zPFs6yUQhN/UHcyBeWKQqhrS/nhj5Wi4qz9gOapbPYjk8sFFnXmrVtkAQ4
         AtC6cx/N+R5quDEwGl+veLA3PjSYP/ISp/vsProjs1gD0Q34+6/6vO/A5VLH/o9NBiU5
         yZmEniDSQh9UYDEKkAzQwE82ElRvcEClLPLXHQNnC1wvVw/6XOcoOIcAyI0vTO9VONmh
         60ynVxQoPz/qaxGsKLPghF9EQSFnunktKC54jxlxpWQ8AEZp5ql1RPVTMUYGeYnPtNaa
         9ZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UMoYDuje7lyubOwdgTPzAF8XMA4SElPKmRK/hEcMksA=;
        b=fCa4rx6RtINR8wUXjWNvndPAPCg5ywxg3K0X6tNXBuvrgmAMui7r/p1QFK4cbFnsGg
         uIlDz/+/8AObGIF24Dtf2NKloUtXYt+qpr5iiAQT4z9pHNMohp0Lye4kCCud9los1U/I
         EniZkSUgjdsrZ7r2jDuVOY7SyCYzuazRcjI55RVkXVNc8gpxwtQLz2LGvl3U9K8V3WGk
         wwvhxv0IdKb/TShBiyUqIz0ghvrTO6dQzIdYMr6eL1trbzdiLBDpCg4uNM/W5yfxHWf0
         spTl9Gg7XKrwhvTbUpFcUNM5zINX9gHV0Vy9uS1CwkTBjODxUidr/nC1mcLghUq4XV+G
         U97w==
X-Gm-Message-State: APjAAAVj3hm4P83dOu7ZFBxzxRnat9PGcA3uSVF1Dx1oq0K0rVVHRWWR
        vdJexLZgIL5IwpcsMWVaaykB3MDq
X-Google-Smtp-Source: APXvYqzdBZu1Y+MV8lHGyx5V5nERpAAk9frqBNxr9tLvEoQXoR98fxMaiiJEWUVxMkM+YBz8VOT1sw==
X-Received: by 2002:aa7:c3d3:: with SMTP id l19mr9333942edr.117.1551561583414;
        Sat, 02 Mar 2019 13:19:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15sm641506edl.40.2019.03.02.13.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 13:19:42 -0800 (PST)
Date:   Sat, 02 Mar 2019 13:19:42 -0800 (PST)
X-Google-Original-Date: Sat, 02 Mar 2019 21:19:40 GMT
Message-Id: <pull.155.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] tests: some touchups related to the --stress feature
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If my mistake using --stress= instead of --stress-limit= is any indication,
then the current options are very confusing.

This is my attempt at making them less confusing.

Johannes Schindelin (2):
  tests: let --stress-limit=<N> imply --stress
  tests: introduce --stress-jobs=<N>

 t/test-lib.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)


base-commit: 7d661e5ed16dca303d7898f5ab0cc2ffc69e0499
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-155%2Fdscho%2Fstress-test-extra-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-155/dscho/stress-test-extra-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/155
-- 
gitgitgadget
