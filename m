Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B72CB1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393207AbfAPNgR (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:17 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41800 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390472AbfAPNgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:16 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so5404229edc.8
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=96M+SI3VKYDk3uCf1BpYpa5//cuUAVpfWWWcGr5kIog=;
        b=OPgAP1ewTojsAdaG2LqLaQABYazEhjnrBWNjSKpQX9DfNviSFKb3LAmrsJ8fos7mdj
         88Vv+lf7WK5Dl/Rmw4ILMpZkYFSkG3Ew2NNeY6gNqQ9xPfGeFM13R1M4rMEFmSK8n+1y
         OfZxP2ta55U1jP8xrDNNp2UiYQOR24qRuxy1M0aY07bsgpKqLhjWsfDebphiaCllFunx
         3xiqh+jXwSIscuAWrEo0MWxkmD0PqtNotLQe1hrspP4ymglwwFRZNuQ6RUcsYoofUsLI
         jBl+g7FZpNCU9Zx7u1zv3qCSClISeJRrI/Bey8rY12F30FKi53NJnXEE/4TKasADfbMM
         9Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=96M+SI3VKYDk3uCf1BpYpa5//cuUAVpfWWWcGr5kIog=;
        b=q8LvAAFua9unyuxOusAU3e2vWDxy5tXfYOMKyZJHE19VTNxh/hWOtJN3O4CgaMDhHA
         w/kRvKeXpNDOOB1G1xNxZ/pcIjunoTe+ETVASZMwUFZWI2ntYG6EhOZcgRgHxn0QatOX
         PjmJ6+eUQRG9SRMHNcS3I7iLtOtCFQe/bNJX7WE0VUrBeIfBof1MyvKcPcuW+f/zk8G1
         LdhN5nsjN77LCi3c/WZRwIaL+J4a5QoM+wIXPjFRsofeiESAQwC0y58vTkgCiaKY5Jvl
         ewuuXVpIw7orBr0NaYhMgYUdKGk5A3cSvGhEilDduU+ZmwCRuZF6Wr6kBGP0QZblKYj/
         mTXg==
X-Gm-Message-State: AJcUukcffuthouVPkmmLOBLvvYvVimSELUj46T60ZOnTESbm5w4JS82o
        /srrlqSXAmlzVUAyhMkKZq2cQitl
X-Google-Smtp-Source: ALg8bN7zit2FmWxj/NfgwwV4OSSMVXV1ef9SoRKG/mU6xRIB0g4nZ9lPypP45l3xT/cdVEYyzWXTDw==
X-Received: by 2002:a17:906:1489:: with SMTP id x9-v6mr6670465ejc.222.1547645773387;
        Wed, 16 Jan 2019 05:36:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11sm5458667edy.49.2019.01.16.05.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:12 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:12 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:35:50 GMT
Message-Id: <d520f451080c8e43e3159665ca62a7ab9b8ca445.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 02/21] ci: rename the library of common functions
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

