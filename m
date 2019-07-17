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
	by dcvr.yhbt.net (Postfix) with ESMTP id B73651F461
	for <e@80x24.org>; Wed, 17 Jul 2019 02:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfGQCtg (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 22:49:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33683 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfGQCtg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 22:49:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so18043135wme.0
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 19:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1BmWC7VtREGfiAJsGt9Z+Md93qC7Dv3VhhHPulnP2kE=;
        b=cThxhfyvqQJmxVbgDHLJln/XGH6UORkpQ/0VnfyBNxYLtSh5FemCqnOMj+c6Y93Jb/
         M61D9qAyd5RzsSx83v3qEp1ryHcU8PoIUm75SwvW3WXs+/hisq0c/dkAvl7O00X7MBnF
         m4LzuDsuDHnf9asNyoPNtBI9pZBVDzzhYzSWD/KFGvyGfjgEpIvBv7GU2cJfCXPCvvbu
         pHP9HNCPmk6Fr2KWbkv7lStXcet/kwQcdGkrj5d9cAYrBkucSav2o7xgB6OlASQ/JgKo
         C8d+0GDe/GoQpms3ks67GTEaSsBuRENuUxUlB7sV7Ce3NlBzh32AOm/HZDd5IXuW1vD4
         sgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1BmWC7VtREGfiAJsGt9Z+Md93qC7Dv3VhhHPulnP2kE=;
        b=E8F0Iv83Vi9OOtdCf95vHTDMVFb6h/rPvXco6kzo6LcxRzL7ftZHoD7LzQMvn9p9Wm
         BIQj6i7wKb9pCi1tEmMB4qaZHdFKaIDh6qtXqvm/ra0UEGgKe2DBPlaaoUhAJk9DVbMY
         VlFOkHDNHKAjjfYZKp02J9n+zsDGEqug+PDzJ+ALE+GNEV+t5NULtMNvnbJFg2j/GRoE
         xbxS/RyyejmKywE2YDHDb1/XRvO9gr65lX7om65U1x8iUZQfqeAoi0FOoiD2HZF5kFPM
         L1xj2n/gAnWJcLpS1axJdOTB91qVOKgRQK/wUlJF+Ktungo6F/XI6VFW9vs6a+5J77n/
         M29A==
X-Gm-Message-State: APjAAAUibHoNvOzvOAx4YBlbZVRw2tchoEqYm2k8J7BfvxN5mkxpALJl
        dgQAMVav95jDi5tA27FVWM2uit1U
X-Google-Smtp-Source: APXvYqwApxne0cqXkZ3gnjoSZbIxZbrBrB3ofp7P2Gg/8qLzbRWwg0JISmGHk5ZirR3PoKFrMwSClg==
X-Received: by 2002:a1c:6641:: with SMTP id a62mr32021130wmc.175.1563331774100;
        Tue, 16 Jul 2019 19:49:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f192sm27843695wmg.30.2019.07.16.19.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 19:49:33 -0700 (PDT)
Date:   Tue, 16 Jul 2019 19:49:33 -0700 (PDT)
X-Google-Original-Date: Wed, 17 Jul 2019 02:49:31 GMT
Message-Id: <pull.264.git.gitgitgadget@gmail.com>
From:   "Thurston via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Adding git-ignore command, tests, and documentation.
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

git-ignore will allow users to quickly add entries to the gitignore files in
the repositories.

Many times, I'll have a config file or log file buried in a series of
sub-directories and find it frustrating to edit the right git ignore with
the right relative path to the file that i want to add. This script makes
adding items to a gitignore file easier.

Instead of managing paths and relative paths such as echo
"path/to/the/file.txt" >../../../../../../.gitignore git ignore
path/to/the/file.txt No matter what directory that is in, the correct
relative path will be added to the gitignore.

This script will also give the ability to add directories, extention globs,
and files to any gitignore in parent directories. Furthermore, it allows you
to easily open the gitignore file in your favorite editor from anywhere
using: git ignore --edit

I have been using this script for years and it has made things much easier
for me, so I figured I'd contribute.

Thurston Stone (1):
  Adding git ignore command

 .gitignore                   |   1 +
 Documentation/git-ignore.txt | 116 ++++++++++++++++++
 Makefile                     |   1 +
 git-ignore.sh                | 222 +++++++++++++++++++++++++++++++++++
 t/t7070-ignore.sh            | 180 ++++++++++++++++++++++++++++
 5 files changed, 520 insertions(+)
 create mode 100644 Documentation/git-ignore.txt
 create mode 100755 git-ignore.sh
 create mode 100755 t/t7070-ignore.sh


base-commit: 8dca754b1e874719a732bc9ab7b0e14b21b1bc10
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-264%2Ftstone2077%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-264/tstone2077/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/264
-- 
gitgitgadget
