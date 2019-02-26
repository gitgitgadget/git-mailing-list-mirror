Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D8220248
	for <e@80x24.org>; Tue, 26 Feb 2019 14:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfBZO0M (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 09:26:12 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45372 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfBZO0M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 09:26:12 -0500
Received: by mail-ed1-f67.google.com with SMTP id f19so1486583eds.12
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 06:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SO2kt2iTNy918/QOIbkHOQSMI8+r8BcaFuHJeGcSeig=;
        b=MQgedj51ssfduB0qF4DN5VKBR2wfHHdTWlCeUF5nAO4z9R8hm/Yk1JivySKa9SHDzD
         fFb65VfdqutXfAcG3Q1DeGD7/HUF7/JgNDjlx/uGXtLeTABez41aOgzeIGT5OMIa7Wxf
         wNL4tOyq5QxHdCv00jYqDMgijdAChCgrWwVNhGWvWJTZomYK5vF1Wrpj8Q2bEYxOiBmN
         +4fjn7N6j8FHTC/jLMczNDSU9c0DGWEQFCsHFcorG+HpGXohJtnZrDUrAk32+id/YESq
         AKxn7Vs0MmXcivdP9LmvpJeQ/FgNBKmfP61fX1SheP+/RKUwBgcqyrh3HSpWbaRJHO+p
         mDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SO2kt2iTNy918/QOIbkHOQSMI8+r8BcaFuHJeGcSeig=;
        b=HSNTJHoxnVO4CODAmo2CWcQrETkK1zIyUnTXj4hlBE6fxElyh9+Na1Ciz5cy8fZ+Og
         jrrjwuN3vBaKzG9mD7IUNNJ5ug29YUZ28ZQ2vt7hp9c3+vjsgrJlOpfjJvUs4RXq2otb
         F4ZPLUBnmAls8m4H6piCvX2VM64IjOR9ivoIXXf6bJAmQYcCIGotsRHdbh5Zidd0kW2Y
         9nS0OiMzmEj0ZQ1s7gFg/er0jzqgR65yvOzwk2gdkovOQbqyzWcmPDZYN+pTdIToNbr1
         0pkFyDL6abtWvQyfQXUwuWbAYIGVHCJy1d2kqUA0TULyGVqyS9gt550j+8VXrSQG22UZ
         4W3A==
X-Gm-Message-State: AHQUAuYf6iBV7I/y3ssIZCvD6ja0rNAyRd1giFN2xjRyuBx4W0QpPrrd
        g6Qhn2YQENBGx+3IdNQ25ed/I87b
X-Google-Smtp-Source: AHgI3IYZTFejdCDhJih9UTQCId9bHyCZt1U8077g8dVo9f8V1pgvhP+1lEarv3R40+97zH/Eyv5HKg==
X-Received: by 2002:a50:c984:: with SMTP id w4mr19206844edh.272.1551191169748;
        Tue, 26 Feb 2019 06:26:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z42sm3513285edd.29.2019.02.26.06.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 06:26:09 -0800 (PST)
Date:   Tue, 26 Feb 2019 06:26:09 -0800 (PST)
X-Google-Original-Date: Tue, 26 Feb 2019 14:26:07 GMT
Message-Id: <pull.152.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.152.git.gitgitgadget@gmail.com>
References: <pull.152.git.gitgitgadget@gmail.com>
From:   "Rohit Ashiwal via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] [GSoC][PATCH] t3600: use test_path_is_dir and test_path_is_file
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

Previously we were using test -(d|f) to verify the presencee of a
directory/file, but we already have helper functions, viz, test_path_is_dir
and test_path_is_file with same functionality. This patch will replace test
-(d|f) calls in t3600-rm.sh.

Rohit Ashiwal (1):
  t3600: use test_path_is_dir and test_path_is_file

 t/t3600-rm.sh | 96 +++++++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-152%2Fr1walz%2Frefactor-tests-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-152/r1walz/refactor-tests-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/152

Range-diff vs v1:

 1:  bf5eb04579 ! 1:  fcafc87b38 tests: replace `test -(d|f)` with test_path_is_(dir|file)
     @@ -1,12 +1,16 @@
      Author: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
      
     -    tests: replace `test -(d|f)` with test_path_is_(dir|file)
     +    t3600: use test_path_is_dir and test_path_is_file
      
     -    t3600-rm.sh: Previously we were using `test -(d|f)`
     -    to verify the presencee of a directory/file, but we
     -    already have helper functions, viz, test_path_is_dir
     -    and test_path_is_file with same functionality. This
     -    patch will replace `test -(d|f)` calls in t3600-rm.sh.
     +    Previously we were using `test -(d|f)` to verify
     +    the presence of a directory/file, but we already
     +    have helper functions, viz, `test_path_is_dir`
     +    and `test_path_is_file` with better functionality.
     +    This patch will replace `test -(d|f)` calls in t3660.sh
     +
     +    These helper functions make code more readable
     +    and informative to someone new to code, also
     +    these functions have better error messages
      
          Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
      

-- 
gitgitgadget
