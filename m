Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0574C20248
	for <e@80x24.org>; Mon, 25 Mar 2019 21:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfCYVlk (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 17:41:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44976 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCYVlj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 17:41:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id x10so8888328edh.11
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 14:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LETu/4dglw1QDxR0NKFDq0Dcl34AK/ye1aFboqygRq8=;
        b=m9EWWTByB/YeFoceP1rExe9cM5WGXFAaYUAsKbrOVUSghEpAo0KG7tR3KCp5v73d6Z
         XHvdZKVpnWfShzpmaNCAHyq9rMSey0j99q9GmAqYH0CBRqMLcwytm3cjzCLm81wWKz+i
         dWmvK4Tcog2/z0vI+n6zfKeTLHRKg/DUzVNCi+tq1+FXKUqUWb7+KgHiwEtwVrl1Kv6d
         XbwZf5o02LopTCW1wqosDTO0DZtcZFmc4hdmLyV1nwk9vA3M+6pkF50yELcEefAGQW+S
         yIEHzUYA7N6e5EdBazYTxST/IF0RsyhfHMThqCTQ3W4uyeZiTLiD+4R6460qCQwPNqao
         dezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LETu/4dglw1QDxR0NKFDq0Dcl34AK/ye1aFboqygRq8=;
        b=ktelWO2iyW7oUNajH7bOipZIR/yGEQNyq/QJvOPViRwRFJ8U66XxD+lFKM93i7rBcE
         guPJISXX9eLOa/Izv75WVNe+rhRqX9Qa5B2Nis5GRWrKe5g/rToOpQa5uLi9ScKETzOo
         /g+pIsSphW+D3FFY8FdqedaXlAEoQX4Ar/YGKNiH/n2G41QPcXOeUKeQ3yKhl3uhXNEA
         zWEAENeE6NObS2aSyQacWtnvgUISFyfOXwe5HS/68YCTFqy7t5anxf6j00+lKQHvy2Zm
         TRjijne09T/o/Co/kuHG8qsy+wQ8CjZ/wL1EYRF8AmfltRv3ab9x8jtBWnU4GCizpveu
         DjUw==
X-Gm-Message-State: APjAAAWeQ6vLi67OTVb6ZiLyKIHbTsHSTIcmiHqTElzuOP2EK8c3vCS8
        olklGDS9JY8osuqhh7zkHn7qt0sc
X-Google-Smtp-Source: APXvYqxLME74h5vlKJ5G4yf67zsAWx3kxlN1lFNnWW9oNZiMSwj7LDZfbqd939tF5xZkE367p9tLAA==
X-Received: by 2002:a50:be05:: with SMTP id a5mr17515169edi.87.1553550097491;
        Mon, 25 Mar 2019 14:41:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l22sm5767731edc.68.2019.03.25.14.41.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:41:37 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:41:37 -0700 (PDT)
X-Google-Original-Date: Mon, 25 Mar 2019 21:41:31 GMT
Message-Id: <810d2c5a94b40544652c97ffa644b29e0db8af82.1553550094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.162.v2.git.gitgitgadget@gmail.com>
References: <pull.162.git.gitgitgadget@gmail.com>
        <pull.162.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/5] docs: do not document the `git remote-testgit` command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since 7ded055401 (build: do not install git-remote-testgit, 2013-06-07),
we do not install it. Therefore it makes no sense to document it,
either.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-remote-testgit.txt | 30 ----------------------------
 Documentation/gitremote-helpers.txt  |  2 --
 2 files changed, 32 deletions(-)
 delete mode 100644 Documentation/git-remote-testgit.txt

diff --git a/Documentation/git-remote-testgit.txt b/Documentation/git-remote-testgit.txt
deleted file mode 100644
index b45bfebba5..0000000000
--- a/Documentation/git-remote-testgit.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-git-remote-testgit(1)
-=====================
-
-NAME
-----
-git-remote-testgit - Example remote-helper
-
-
-SYNOPSIS
---------
-[verse]
-git clone testgit::<source-repo> [<destination>]
-
-DESCRIPTION
------------
-
-This command is a simple remote-helper, that is used both as a
-testcase for the remote-helper functionality, and as an example to
-show remote-helper authors one possible implementation.
-
-The best way to learn more is to read the comments and source code in
-'git-remote-testgit'.
-
-SEE ALSO
---------
-linkgit:gitremote-helpers[7]
-
-GIT
----
-Part of the linkgit:git[1] suite
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 34a3e60d08..2fc4007525 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -513,8 +513,6 @@ linkgit:git-remote-ext[1]
 
 linkgit:git-remote-fd[1]
 
-linkgit:git-remote-testgit[1]
-
 linkgit:git-fast-import[1]
 
 GIT
-- 
gitgitgadget

