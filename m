Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F7101F731
	for <e@80x24.org>; Sat, 10 Aug 2019 05:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfHJF7Q (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 01:59:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36940 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfHJF7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 01:59:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id b3so7664859wro.4
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 22:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vlmbEUUYHgKtESp3x4jGTvNo1+kPip0CmPIKILWskYA=;
        b=h7kYCS3N2imLXpVZWhelGP+dQMYmdMP1gjSTDWdCQjxgUHxkwUEQfRx5Mf0HyEVhU6
         YkO5nNCQBIVEI8f8Y50Dlk0hc75zPY8IcWO7ZtyFKW9NzcJTul2aV2SWvnAyVdQD2vxD
         zAlLHYHqYhrE8LMwXqur0QMgqw8g0iD1RTgzNHnIiSC+U47Ds1NiFI18NEWWXNj5wM5q
         +2cM5KjsqedZ5xtxCH7cEHaJrjPPwpxTi1eawtKg1vwKJ0Wib4LqZbz99ByF39dfrEGq
         AgopOkhVDFh7qaw7Trd8x+c4SiqFSrgcINQQ/WE4gYSM6lIT7/i8kvT4aJ8KD/Hkr94o
         08jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vlmbEUUYHgKtESp3x4jGTvNo1+kPip0CmPIKILWskYA=;
        b=bu4o9/f6YiN1JRRCPaavIQgNRoVtAYexTusYuw6HH5pmz5lNBWK4D3wsDlXwCZe0pf
         5ffJYhhyHalZFuZchGV+GeXUrhVHQlq0jTTm7hYcndOdde6sAu3UKZ0YCL8Ri3LRXEV9
         v6iI2B83HsV+MztxK6baJlgpqxMnN4xpq8XcrNHKW8p7YqcHxk4r4VkmQoVhLdCc2BkM
         bVRKmzHGh0BN27ROsoZX7656falzQU25gSU8A82UABAl7tvBYM88E2Dd0iHruczI4pUV
         RUkiyLXGFDnFfTnK2vaYH5K7IIEaTH9rwqx2O9fzDAf9qQE5Kx+tZ+1mk5AO1VjfvBXj
         jlzw==
X-Gm-Message-State: APjAAAVwlRTToXcDwukXTaN4l+I/h19wgJEzZShCsaUTxrtLmrIly1zi
        fEi8mChJ2GlViUx3u5GtRbKdp9P5
X-Google-Smtp-Source: APXvYqxAGA672l5sTjGDprgEIB+3MT9yZ4ApXY+Dp9w49TMEgSgB+syEN/OzR/M4ZrWAvV81G0DRqg==
X-Received: by 2002:adf:c508:: with SMTP id q8mr726029wrf.287.1565416754193;
        Fri, 09 Aug 2019 22:59:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm5789616wmi.38.2019.08.09.22.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 22:59:13 -0700 (PDT)
Date:   Fri, 09 Aug 2019 22:59:13 -0700 (PDT)
X-Google-Original-Date: Sat, 10 Aug 2019 05:59:11 GMT
Message-Id: <pull.309.git.gitgitgadget@gmail.com>
From:   "Mark Rushakoff via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] doc: fix repeated words
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Inspired by 21416f0a07 ("restore: fix typo in docs", 2019-08-03), I ran "git
grep -E '(\b[a-zA-Z]+) \1\b' -- Documentation/" to find other cases where
words were duplicated, e.g. "the the", and in most cases removed one of the
repeated words.

Mark Rushakoff (1):
  doc: fix repeated words

 Documentation/config/color.txt                       | 2 +-
 Documentation/config/stash.txt                       | 2 +-
 Documentation/git-fast-export.txt                    | 2 +-
 Documentation/git-fast-import.txt                    | 2 +-
 Documentation/git-pack-objects.txt                   | 2 +-
 Documentation/git-push.txt                           | 2 +-
 Documentation/git-repack.txt                         | 2 +-
 Documentation/technical/hash-function-transition.txt | 2 +-
 Documentation/technical/protocol-v2.txt              | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)


base-commit: 2e27de94d485a6da0c8e264c165e55100f1a13a8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-309%2Fmark-rushakoff%2Fdocs%2Ffix-repeated-words-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-309/mark-rushakoff/docs/fix-repeated-words-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/309
-- 
gitgitgadget
