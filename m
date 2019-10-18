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
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D8D1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 00:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438762AbfJRAHN (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 20:07:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51238 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438748AbfJRAHE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 20:07:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so4300486wme.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 17:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=uk5qh6iivKTfJrInY2eg4g1kvXZJ5mOJSStOqG5RhQM=;
        b=lWeG6HJTA7DQrNQynxOSn5+4IrDersjQfgj8L3vZLjn8L//ZzuxQP8Up6+Ga1bFYoq
         /fQqQAXdPCr0Kosl8t17BZsfn0efY1bkpLhYUNEKk1g07vVuLsRTRb6FucZy+SORtV5A
         NLSU/p98oU32Wi4gzsf0qUYn2aW1rqA0UhRVDb53Jbjv8HPhc+CMwbyxGnH/Qbc2oHWl
         uNWpznVdUE1NC8vk6BL9ft6pHeNbuSQwLfn75NSRWGFuM6093o4JZwBqTczf9V5EM7bd
         tOtKWUeKS/wU9KjzQL+6x8Iy62/gLyTWLOvxrYoZBsWwVrY5YUZcyxqDI4o8RnKqN4cz
         Nv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uk5qh6iivKTfJrInY2eg4g1kvXZJ5mOJSStOqG5RhQM=;
        b=UFPQptVZgeeAdRStgYQPv4m0mBEiaOBkjfQiFp7KXMeqM6OwTmgoP/F9/HAznBp75S
         Lpzm3xUUWPmqGIqJSxzIeJX4dfakA5+4E+4j4DtOZXRc6NTZyViv5yjPoIrhaMZCgURD
         lS4D0v9rGzNSDlUyhysev70LojCg7IZ/CbHrwDKyAXAFClkCCxwJBy2L9fOZesPFWriH
         ZRSJLoeVs4p4+cKR7QvMsp3VkLfjEJ0fRyESpwK4BpKf4GEJaereevt0M5wYvwAUVyZx
         WaFy8mdCUiT67awAgJMKI5zuCXYj4VmpLdxqQCNAQr6OGbMFqTZ3s78s6ZexXX4sMIu8
         wilQ==
X-Gm-Message-State: APjAAAVcKzHCduy+yhQNI9g62ZhBnLM8pT8qz/az7znjVBJnjjvqDEsW
        XIDVKqCOoNKNfVUS4EhfseiLMreJ
X-Google-Smtp-Source: APXvYqx7d72X0Zoxc/dYPKnGsqeI7ZZI/zQfzTDYiwSsjQUc2tthShxOl/qeq1E8ycTUEAnVQPsj7w==
X-Received: by 2002:a7b:c5c9:: with SMTP id n9mr5319637wmk.28.1571357220868;
        Thu, 17 Oct 2019 17:07:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p85sm3736622wme.23.2019.10.17.17.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 17:07:00 -0700 (PDT)
Message-Id: <pull.405.git.1571357219.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Oct 2019 00:06:58 +0000
Subject: [PATCH 0/1] config: add documentation to config.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit is copying and summarizing the documentation from
documentation/technical/api-config.txt to comments in config.h

Signed-off-by: Heba Waly heba.waly@gmail.com [heba.waly@gmail.com]

Thanks for taking the time to contribute to Git! Please be advised that the
Git community does not use github.com for their contributions. Instead, we
use a mailing list (git@vger.kernel.org) for code submissions, code reviews,
and bug reports. Nevertheless, you can use GitGitGadget (
https://gitgitgadget.github.io/) to conveniently send your Pull Requests
commits to our mailing list.

Please read the "guidelines for contributing" linked above!

Heba Waly (1):
  config: add documentation to config.h

 config.h | 327 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 327 insertions(+)


base-commit: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-405%2FHebaWaly%2Fconfig_documentation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-405/HebaWaly/config_documentation-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/405
-- 
gitgitgadget
