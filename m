Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 297041F981
	for <e@80x24.org>; Tue, 21 Aug 2018 19:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeHUWuj (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:50:39 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:43708 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeHUWui (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:50:38 -0400
Received: by mail-pg1-f178.google.com with SMTP id v66-v6so7569374pgb.10
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1nvQQ97o7PoBc9QR0pNoQ8MokiB9shbSRcqkCliBisE=;
        b=Q+mnMdAUf0eKi4cjObHgK1VKC8qwARc5Df0WN/bjKyXxLk7MxmqMUQy/iyoBDwPrzK
         zu4DeN7zlyalafskMKjJR5VR8vluWO4zHgtwDpWVrLXaLDGZE59vuRpFa0KjfsbSvVes
         WuToGjbaALWacYuiPu0x0hHMPPSsvDaNcdW6Ll6GoEQqI6RCOSZtC3of6QlkBd6PscyQ
         H1I19NfMYWc6DjB9qgLNxZMBfwywSpHZDlB6AtUlnXbtTfmiNVHKQE0lLSayFZz9DHkP
         PMpIvk467KoeCKxPCQHcuW6wsI9eFqYZt0922QW6xWuExSLz5ED27jsEv7IVmNFj+vL1
         49eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1nvQQ97o7PoBc9QR0pNoQ8MokiB9shbSRcqkCliBisE=;
        b=LMoyRXqIxAgX6EH/kYG/yIfXdBBXTnF7PsPIg9xeswiQwSQQ/zFhX/EE3bTYgm54N5
         LPXhej7Sw+nINdfj/nT5/bpFk/HnNbKxCM88UyXgiuaA9nXF/PEVOnURF5x2phYbtlye
         H9rYBvW8p95EUHRFpr7bxp1DVfkl8R3Md/LH0yGtC/vGVp86yGwfqZgozaa3CPebDF5r
         BzceO73cveQTIkYTACeg8QHZKH1JBXIiUrBHgguPtm/SwPwehHj2rKPebWTCkEOMCL8S
         Z+h07j3pb5jFn/WbJyTyKuOP797f83SC3JqPbyom4aHCSA6plD41n77VWANaoEwDF60s
         pBKg==
X-Gm-Message-State: AOUpUlHWZkjztcSg0k4GkKEAh6+4/G7t+en+/04e62Retqeds1L/cQNB
        CMBK1bH1gK36gK0LTtDiHmsKCx/H
X-Google-Smtp-Source: AA+uWPyiqBBLwFBroNyIR8OHPcCd0Zu9lKIov7nN4b1NhOIIExaxcoS3wEpw3DOxjZY79e0ko1BwUw==
X-Received: by 2002:a63:41c1:: with SMTP id o184-v6mr16666928pga.297.1534879751622;
        Tue, 21 Aug 2018 12:29:11 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id c1-v6sm27708765pfg.25.2018.08.21.12.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 12:29:10 -0700 (PDT)
Date:   Tue, 21 Aug 2018 12:29:10 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Aug 2018 19:29:05 GMT
Message-Id: <pull.22.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.22.git.gitgitgadget@gmail.com>
References: <pull.22.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/2] Docs: Add commit-graph tech docs to Makefile
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

I compiled the docs and inspected the HTML manually in the browser. As
suggested, I modified the documents to format a bit better. See the commit
messages for details. Since the files had been modified since 'maint', this
version is based on 'master'.

[1] 
https://public-inbox.org/git/20180814222846.GG142615@aiede.svl.corp.google.com/
[PATCH] partial-clone: render design doc using asciidoc

Derrick Stolee (2):
  Docs: Add commit-graph tech docs to Makefile
  commit-graph.txt: improve formatting for asciidoc

 Documentation/Makefile                   |  2 ++
 Documentation/technical/commit-graph.txt | 43 +++++++++++-------------
 2 files changed, 22 insertions(+), 23 deletions(-)


base-commit: fa03cdc39b951d1cfbfd690fe6f3ac6c57ab6a44
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-22%2Fderrickstolee%2Fmake-docs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-22/derrickstolee/make-docs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/22

Range-diff vs v1:

 1:  ef5af2ccc = 1:  4c66af626 Docs: Add commit-graph tech docs to Makefile
 -:  --------- > 2:  6cf253c2a commit-graph.txt: improve formatting for asciidoc

-- 
gitgitgadget
