Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3E11F424
	for <e@80x24.org>; Wed, 25 Apr 2018 16:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755684AbeDYQby (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 12:31:54 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42489 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755421AbeDYQbm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 12:31:42 -0400
Received: by mail-lf0-f66.google.com with SMTP id u21-v6so24771750lfu.9
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 09:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KV5+VDqXKxUO4+DI2Hvd9qCydvmlrxYDf9SaMiMPFtg=;
        b=lYIBQuK5HIcLMhYQqqsgIlP7s4h8QdUPaoG4+6rYeufX/6b0Z9410VTbapvuvhwdbv
         PrwoLNKKXZD9rQ83K95EFMlwzrV5HkbDYP/mMhNvlDp000S8R3ToQ0Qh3M553cv7YSqn
         6zrj5o8HEafLGwznd+bGdt3vSTvp6/bvWTsOZ5f81ECkK771/4+VSei4DaDY0AMKHcRe
         WOqkOBr+xi1YvorlnBGKCY/VaPlTCEqEwHtTZ7muRwZjkUCPnF7hOohtBDGL4WeZvt13
         r31Bjo/YzA2fyRX9hW6Njo+Mf/tRrp+nK2bpSOGgKO5xdNS9JTFaqYO9Fzck1YrijjTV
         5JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KV5+VDqXKxUO4+DI2Hvd9qCydvmlrxYDf9SaMiMPFtg=;
        b=JnWxlqXd5t2HJGDUwGviTXrRnUqrsD3BVQfhAKFDw8lsXzSE1ASbTJfrsvwOChdjYL
         05EsGGnpqoUEia653ulEgl+D8WqIoprSzfyoDFcUUwlyyUvv2VJkcI3OBRTfiB/1ThLH
         5pKEXH1tBwDktLkSkt9Vw1tn4SrsCXSg5PK87MsmKRwHy+DOFKkHeKqS+pf1+KTP+hFj
         w4p4LJWS0De/IZryILapdvqZ1f01Q9JsCKOLHfzwjATLAMEnZtgPIiev1P03ZH6UzO9U
         5hikQFnUXSzCPxt4iHAkS+ZQ+049rBAwO7xfTOJwjKdQGfS2aqRDBbW0XZIpx6KSMuQV
         yQ4w==
X-Gm-Message-State: ALQs6tCIharRHegcoHDwm6PljkA0skbQw2BZ3NaupdMhPSmQ1CSyY0Aj
        mSwdhZgf9T5Xw2REQhXudkQOCg==
X-Google-Smtp-Source: AB8JxZoroP6nIA0dWhTvcvFSlZfieERGrnGkWKmjyEZFR4xUPKNwAbv/CytN3CgMqOlMbOvMbIfSMQ==
X-Received: by 2002:a19:7113:: with SMTP id m19-v6mr15008247lfc.96.1524673900528;
        Wed, 25 Apr 2018 09:31:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t24sm518370ljg.65.2018.04.25.09.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 09:31:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v4/wip 11/12] command-list.txt: add new category "complete"
Date:   Wed, 25 Apr 2018 18:31:06 +0200
Message-Id: <20180425163107.10399-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.519.gb89679a4aa
In-Reply-To: <20180425163107.10399-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com>
 <20180425163107.10399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This category, combined with 'external' and 'mainporcelain', is
intended to replace the "porcelain command list" in git-completion.bash.
In other words, these are the commands that will show up by default
when you type "git <tab>".

Compared to the current list in git-completion.bash (which is
basically "git help -a" with a black list), the following commands no
longer show up:

- annotate          obsolete, discouraged to use
- difftool-helper   not an end user command
- filter-branch     not often used
- get-tar-commit-id not often used
- imap-send         not often used
- instaweb          does anybody still run this interactively?
- interpreter-trailers not an interactive command
- lost-found        obsolete
- mergetool         ???
- p4                too short to complete?
- peek-remote       not often used??
- svn               ???
- tar-tree          obsolete, use archive instead
- verify-commit     not often used

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 command-list.txt | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index a57bcb64a1..40b56c57f5 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -3,11 +3,11 @@
 git-add                                 mainporcelain           worktree
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
-git-apply                               plumbingmanipulators
+git-apply                               plumbingmanipulators            complete
 git-archimport                          foreignscminterface
 git-archive                             mainporcelain
 git-bisect                              mainporcelain           info
-git-blame                               ancillaryinterrogators
+git-blame                               ancillaryinterrogators          complete
 git-branch                              mainporcelain           history
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
@@ -17,7 +17,7 @@ git-check-mailmap                       purehelpers
 git-checkout                            mainporcelain           history
 git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
-git-cherry                              ancillaryinterrogators
+git-cherry                              ancillaryinterrogators          complete
 git-cherry-pick                         mainporcelain
 git-citool                              mainporcelain
 git-clean                               mainporcelain
@@ -25,7 +25,7 @@ git-clone                               mainporcelain           init
 git-column                              purehelpers
 git-commit                              mainporcelain           history
 git-commit-tree                         plumbingmanipulators
-git-config                              ancillarymanipulators
+git-config                              ancillarymanipulators           complete
 git-count-objects                       ancillaryinterrogators
 git-credential                          purehelpers
 git-credential-cache                    purehelpers
@@ -39,7 +39,7 @@ git-diff                                mainporcelain           history
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
-git-difftool                            ancillaryinterrogators
+git-difftool                            ancillaryinterrogators          complete
 git-fast-export                         ancillarymanipulators
 git-fast-import                         ancillarymanipulators
 git-fetch                               mainporcelain           remote
@@ -48,13 +48,13 @@ git-filter-branch                       ancillarymanipulators
 git-fmt-merge-msg                       purehelpers
 git-for-each-ref                        plumbinginterrogators
 git-format-patch                        mainporcelain
-git-fsck                                ancillaryinterrogators
+git-fsck                                ancillaryinterrogators          complete
 git-gc                                  mainporcelain
 git-get-tar-commit-id                   ancillaryinterrogators
 git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
-git-help                                ancillaryinterrogators
+git-help                                ancillaryinterrogators          complete
 git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
@@ -80,7 +80,7 @@ git-merge-tree                          ancillaryinterrogators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
 git-mv                                  mainporcelain           worktree
-git-name-rev                            plumbinginterrogators
+git-name-rev                            plumbinginterrogators           complete
 git-notes                               mainporcelain
 git-p4                                  foreignscminterface
 git-pack-objects                        plumbingmanipulators
@@ -96,28 +96,29 @@ git-quiltimport                         foreignscminterface
 git-read-tree                           plumbingmanipulators
 git-rebase                              mainporcelain           history
 git-receive-pack                        synchelpers
-git-reflog                              ancillarymanipulators
-git-remote                              ancillarymanipulators
-git-repack                              ancillarymanipulators
-git-replace                             ancillarymanipulators
-git-request-pull                        foreignscminterface
+git-reflog                              ancillarymanipulators           complete
+git-remote                              ancillarymanipulators           complete
+git-repack                              ancillarymanipulators           complete
+git-replace                             ancillarymanipulators           complete
+git-request-pull                        foreignscminterface             complete
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain           worktree
 git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           ancillaryinterrogators
 git-rm                                  mainporcelain           worktree
-git-send-email                          foreignscminterface
+git-send-email                          foreignscminterface             complete
 git-send-pack                           synchingrepositories
 git-shell                               synchelpers
 git-shortlog                            mainporcelain
 git-show                                mainporcelain           info
-git-show-branch                         ancillaryinterrogators
+git-show-branch                         ancillaryinterrogators          complete
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-i18n                             purehelpers
 git-sh-setup                            purehelpers
 git-stash                               mainporcelain
+git-stage                                                               complete
 git-status                              mainporcelain           info
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
@@ -136,7 +137,7 @@ git-verify-commit                       ancillaryinterrogators
 git-verify-pack                         plumbinginterrogators
 git-verify-tag                          ancillaryinterrogators
 gitweb                                  ancillaryinterrogators
-git-whatchanged                         ancillaryinterrogators
+git-whatchanged                         ancillaryinterrogators          complete
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
 gitattributes                           guide
-- 
2.17.0.519.gb89679a4aa

