Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253431F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfA0X0x (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:26:53 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38148 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA0X0x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:26:53 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so11588683ede.5
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=96M+SI3VKYDk3uCf1BpYpa5//cuUAVpfWWWcGr5kIog=;
        b=Fsxdfz4JXstOAoJ3gjFIvuqexGLx7A1U4ONjbqkPZdsdXxi9B4vL4iaRj/EYhJXivi
         FP7sXZWabDbNtAQhYuw//agLl+wxW9kjuPzO6Dr5YDxV9w2OlNK+yikcF89M1yTs9lNV
         61mWxkW9Nbw7L7hOrOLeorm7VSbFJPh2M5nFRc6QC/4rNtLNXovhU2jbVQN8JRr1iCHx
         XVCsN45u03bmg0f/gtUEBtpzFGogje65d27jQCGuZvyLYsX1Kc6kejuddZi1gVASSxBT
         rRyvsXYNQv2BGd6R6Ic6TeksAUiLR88XcxCP/4TK1Okl4gjCR50eUFq5+kz18Q+mMpNq
         TBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=96M+SI3VKYDk3uCf1BpYpa5//cuUAVpfWWWcGr5kIog=;
        b=GZRx4qknOHGHMylWtdWbVnRhC4K8z8chHYkHuPlEOp7fDFwAyZZlv932U9QNkxyTVE
         nQR6DWq1wqfVeG0f02a6/Lf6ZobweFes2y2olJd4xLBAk4cCYnc/DltG8Xja3hEI9W3W
         3BAkYvfEeI/LAORJpguQ7xzG38YraVQdZ79b2k/u3JEf9QTXSBLT9VT7Uen6IshYoCy0
         /v12/2PtG0stcJhMnVCisn0TfLHO8seVV+4lt4gsZUlOnR1BYx1YdV1J94Z0sVWVxIgU
         sYoPnESfNBXfr1Lp5ZXIK08vDsCENsYx6ZhtIe+YcvyawnGiCeG1YJravbTTmLsFozj3
         Pucw==
X-Gm-Message-State: AJcUukdrPKDbLpNCUeMnuD2GY7oulpr2O6OukvJkhi52DbbSor43xI3/
        gqg9qobJAbMUqzchauzOpTw5yscd
X-Google-Smtp-Source: ALg8bN51Fg53oCdriw5Jbw8qHvSXkxxDXXr/o23tv7Q1RYKh6dhTOgTXe/o9hGwZ4Cz7w+Z1puhZRg==
X-Received: by 2002:a17:906:288d:: with SMTP id o13-v6mr16727302ejd.53.1548631610939;
        Sun, 27 Jan 2019 15:26:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm14022650edc.28.2019.01.27.15.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:26:50 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:26:50 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:28 GMT
Message-Id: <f0852de8abe2a501fdb829b1c241f02fa1deeaf0.1548631607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 02/21] ci: rename the library of common functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The name is hard-coded to reflect that we use Travis CI for continuous
testing.

In the next commits, we will extend this to be able use Azure DevOps,
too.

So let's adjust the name to make it more generic.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/install-dependencies.sh     | 2 +-
 ci/{lib-travisci.sh => lib.sh} | 0
 ci/print-test-failures.sh      | 2 +-
 ci/run-build-and-tests.sh      | 2 +-
 ci/run-linux32-docker.sh       | 2 +-
 ci/run-static-analysis.sh      | 2 +-
 ci/run-windows-build.sh        | 2 +-
 ci/test-documentation.sh       | 2 +-
 8 files changed, 7 insertions(+), 7 deletions(-)
 rename ci/{lib-travisci.sh => lib.sh} (100%)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 06c3546e1e..fe65144152 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -3,7 +3,7 @@
 # Install dependencies required to build and test Git on Linux and macOS
 #
 
-. ${0%/*}/lib-travisci.sh
+. ${0%/*}/lib.sh
 
 P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
diff --git a/ci/lib-travisci.sh b/ci/lib.sh
similarity index 100%
rename from ci/lib-travisci.sh
rename to ci/lib.sh
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index d55460a212..7aef39a2fd 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -3,7 +3,7 @@
 # Print output of failing tests
 #
 
-. ${0%/*}/lib-travisci.sh
+. ${0%/*}/lib.sh
 
 # Tracing executed commands would produce too much noise in the loop below.
 set +x
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index cda170d5c2..db342bb6a8 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -3,7 +3,7 @@
 # Build and test Git
 #
 
-. ${0%/*}/lib-travisci.sh
+. ${0%/*}/lib.sh
 
 ln -s "$cache_dir/.prove" t/.prove
 
diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
index 21637903ce..751acfcf8a 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-linux32-docker.sh
@@ -3,7 +3,7 @@
 # Download and run Docker image to build and test 32-bit Git
 #
 
-. ${0%/*}/lib-travisci.sh
+. ${0%/*}/lib.sh
 
 docker pull daald/ubuntu32:xenial
 
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index 5688f261d0..dc189c7456 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -3,7 +3,7 @@
 # Perform various static code analysis checks
 #
 
-. ${0%/*}/lib-travisci.sh
+. ${0%/*}/lib.sh
 
 make --jobs=2 coccicheck
 
diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
index d99a180e52..a73a4eca0a 100755
--- a/ci/run-windows-build.sh
+++ b/ci/run-windows-build.sh
@@ -6,7 +6,7 @@
 # supported) and a commit hash.
 #
 
-. ${0%/*}/lib-travisci.sh
+. ${0%/*}/lib.sh
 
 test $# -ne 2 && echo "Unexpected number of parameters" && exit 1
 test -z "$GFW_CI_TOKEN" && echo "GFW_CI_TOKEN not defined" && exit
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index a20de9ca12..d3cdbac73f 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -3,7 +3,7 @@
 # Perform sanity checks on documentation and build it.
 #
 
-. ${0%/*}/lib-travisci.sh
+. ${0%/*}/lib.sh
 
 gem install asciidoctor
 
-- 
gitgitgadget

