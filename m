Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 440AF1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 08:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfKGIKG (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 03:10:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34422 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfKGIKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 03:10:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id e6so1945633wrw.1
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 00:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=DRj6baJ5hWGW/fe3yGlZ49w3lXE6raGF4Y6+b49G500=;
        b=PM3FLyWfZpp70JMbVIwwqqqIHUftPQqstuazsdA8bNg7IBqxuqcb8K2cFtOR6ynO8W
         7Yjp5kcGYEKASH6K6jnHqKVsk6JinjidxJGu23MVseeIwx7mbb8ldlnW/5+35S6/Hxh1
         YrtCXhtGmOGGzcdPYW3btKq394GwgQQRweS+sNxy6FsejDixWlNgyFqN657PENhJzdJ2
         E2DkllhcmAqYqmXypKpm/clsSH/pWMxayR9xg3R9hjNVUVd+GIY4JSyzBjtauW+xF/pu
         8dj7lmTNcgQrF4imb1hXzVee3Wj3mjfsECsqEpAa7/Ebtdv2ANMrz9S0j8Bb4FjzyuMZ
         jiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DRj6baJ5hWGW/fe3yGlZ49w3lXE6raGF4Y6+b49G500=;
        b=D4DphTp+1JSEo8MF5zSZ91TJsiLPPNrpawaJrPBNQLWB7mr2F0e8AyoBq6QjQjmJy/
         aKrLqXUWv9bDEytflZ6+6Xnhb2ol2CgdradpwzvNrznSov7XFirPfQthoJjw8oyz2bQf
         dkD6gB1H8vWIahAyN/MXXeoROEhp/RYJB9Knfh/QHrkWdbA/vdKsjBwSj3nPaknyIUGq
         tPiWXe0Zw8renyF+0rwKfVWtxQ3TL3ba3LKPlj5XLBbhkKpBH2S9CxEsV5o54PCgIDbI
         dUtnbuR7uLzKJf+o6NMdXudJ9U35xeo98UeXzSItg0L4YJM+hwM4Zo22ACqCRMsF+LSB
         CsYA==
X-Gm-Message-State: APjAAAURJGGSsfGV7fbHckEJmvCpcVw1o9ktKvbni0gid0/st9S3AseY
        KJXwFpXG6ov99eMlbISb+GCholz5
X-Google-Smtp-Source: APXvYqy3cAPbTHcFancu1XKycykgFiNUgvn/tpaYEAM6VdOd5wnIDLK+hr7s9XskKrBoi1EVA1Tf9g==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr1615464wrm.213.1573114202069;
        Thu, 07 Nov 2019 00:10:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r5sm1355123wrl.86.2019.11.07.00.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 00:10:01 -0800 (PST)
Message-Id: <pull.449.git.1573114201.gitgitgadget@gmail.com>
From:   "George Espinoza via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 08:09:54 +0000
Subject: [PATCH 0/6] [Outreachy] check-ref-format: parse-options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     George Espinoza <gespinoz2019@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This command currently handles its own argv so by teaching it to use
parse-options instead we can standardize the way commands handle user input
across the project.

Because OPT_BOOL data structure is being used on --normalize --no-normalize
can now be utilized.

NO_PARSEOPT flag was also removed to update git.c with the conversion of the
structure in this command.

This is Micro-Project #3 that states: Teach a command which currently
handles its own argv how to use parse-options instead..

Helped by: emily shaffer emilyshaffer@google.com [emilyshaffer@google.com]
Helped by: johannes schindelin johannes.schindelin@gmx.de
[johannes.schindelin@gmx.de]

Signed-off-by: george espinoza gespinoz2019@gmail.com
[gespinoz2019@gmail.com]

george espinoza (6):
  [Outreachy] merge-ours: include parse-option.h
  [Outreachy] check-ref-format: parse-options
  This file wasn't supposed to change during my git push for
    check-ref-format :(
  [Outreachy] check-ref-format: parse options
  [Outreachy] check-ref-format: parse-options
  [Outreachy] check-ref-format: parse-options

 builtin/check-ref-format.c | 47 +++++++++++++++++++-------------------
 git.c                      |  2 +-
 2 files changed, 24 insertions(+), 25 deletions(-)


base-commit: efd54442381a2792186abc994060b8f7dd8b834b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-449%2FGeorgecanfly%2Fcheck-ref-format-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-449/Georgecanfly/check-ref-format-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/449
-- 
gitgitgadget
