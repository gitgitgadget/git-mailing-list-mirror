Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 342CC1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 12:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbeHUQND (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 12:13:03 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:37782 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbeHUQNC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 12:13:02 -0400
Received: by mail-pl0-f41.google.com with SMTP id c6-v6so3926338pls.4
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=G8uqTfFI54b2uQW7SXTgNd2v36697mYu0ZixySvIE3o=;
        b=YXl0CY3ldUvTnQBMKxDD8gsW84tAzj0y3lDZHkTkzo1TXShk0rMGWmQJUQg0bmiaKJ
         3VMsgpK/48g2xeYQ9odAFXWMTuolg+tjfRj52E7TbBuCnQyqDwbTJwAJ9yfZxLv9CvHT
         9XFORr89lcITP/nPWh0w6QwdYXWoEx9HMkzEPuW3bhLFBzYlMGa4jWjw+zsUjanZgNzw
         LVenGCoRrYqou235C618xNu6aS698Ysc0Y5NgqQ4l0PXGvUOljXjRg8NudQsP03ws2vE
         nonzIBDobS2LuGrHrBH0uGvjbfHGyDe9DpgwM+RD5WOiHsylW6IHg5lokuY3D4rtDIxz
         WnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G8uqTfFI54b2uQW7SXTgNd2v36697mYu0ZixySvIE3o=;
        b=gEou1oDdgcWD5ZO84Y5yDwOl0D9vB2Y4JHg7ScB/L8TBPEpFdMVmRImiGiyuYnfGdK
         UduQ1Kc3kZukjRE1IS6RWOnKaYKjfTuEwnpnSJRH5L143c1o9ZN5hnNCMcQs9NnbzH/R
         0WGnA8tDO6exP1EhhLe0Il4hxE7ds4AQa9qzqEDXbP5qCc1SM03Wb0qyamm89HxO69GT
         gxpqog2EtAQdtnLmEbC2cTGUVkH/5kMCRMMuV7gIXqn77AcoZszyuqaLpGobvjrskE6P
         hYQl1D8tcWFSK1snsmQXmnbfaxpSJFHbmzar0/LSo4GsGbsoI4dAllppqbgsd55fhhgH
         UL3w==
X-Gm-Message-State: AOUpUlFiBNf1hVY/WVCTqvAqvL/oi1c+DR0nDPdOgmsrH5RTU+ltVAG8
        ZWhkvLJcGaGQ4Ml7TSFIy1cfZ4r5vaA=
X-Google-Smtp-Source: AA+uWPzV+e9XrPHphfcYhIy64z+4jcTh4jhP4ILj6eIk49N8o18DqsMYI0l5IQPQhLB9upAU+wDk7Q==
X-Received: by 2002:a17:902:7803:: with SMTP id p3-v6mr49281103pll.119.1534855980838;
        Tue, 21 Aug 2018 05:53:00 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id v20-v6sm22474404pfk.12.2018.08.21.05.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 05:53:00 -0700 (PDT)
Date:   Tue, 21 Aug 2018 05:53:00 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Aug 2018 12:52:57 GMT
Message-Id: <pull.22.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Docs: Add commit-graph tech docs to Makefile
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

Similar to [1], add the commit-graph and commit-graph-format technical docs
to Documentation/Makefile so they are automatically converted to HTML when
needed.

I compiled the docs and inspected the HTML manually in the browser. Nothing
looked strange, so I don't think the docs themselves need any editing for
format.

[1] 
https://public-inbox.org/git/20180814222846.GG142615@aiede.svl.corp.google.com/
[PATCH] partial-clone: render design doc using asciidoc

Derrick Stolee (1):
  Docs: Add commit-graph tech docs to Makefile

 Documentation/Makefile | 2 ++
 1 file changed, 2 insertions(+)


base-commit: 53f9a3e157dbbc901a02ac2c73346d375e24978c
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-22%2Fderrickstolee%2Fmake-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-22/derrickstolee/make-docs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/22
-- 
gitgitgadget
