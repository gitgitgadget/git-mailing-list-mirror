Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFBED1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfA2OTZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:25 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40234 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfA2OTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:25 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so16082550edr.7
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=96M+SI3VKYDk3uCf1BpYpa5//cuUAVpfWWWcGr5kIog=;
        b=OGpWUiaZRKk+goM3dl6CfKY7yBUhOwIMNT0Ls+j/3EuozNzjHErwg+2tj+C0ZCK7i2
         DZz79hb7E+MBZC5mV5j5l38T2n34nrtQ5o5/PBH1dM3QxwdAYThLOprolt28e/tddo+U
         aaCUm/MN4H7v0/IfE29bENMDFeN0TP4ecq+bxFn92JI9WW6nn+IbvelMyBjGw/ix6XuQ
         99TuBC2ETb/yNiUrqHwJa6SIaSzOWWQqWeODE+8w0r3NNS22018ktNR8wBT5ALf/DSmm
         3iTJOviB5H47UuuqaMfXmt2jijNxfUeYsDEc3GLx5KH1CVuN9LOupDvx4YH7ei004WTO
         f6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=96M+SI3VKYDk3uCf1BpYpa5//cuUAVpfWWWcGr5kIog=;
        b=BIyW5OXBob3EYCjnZwWG3xHafPynu+kT4NGVzAhySo/2kVSmQdxzEVbB7WW1KUL2Au
         EUojgoDOBJotble5vi/WrWRW4C4yGHpjRabwP2rEzU/MmMkkcMvlwyNzmOe9tGmNSovU
         NdApqW1FpaTv4jcaC5JWZO3eETdr4ZLpLKRHGxNqO7q2RtQXxna05QAoucuHhmIe6yJI
         3opp0hdcQHMoi8xabUO3IMeXke+GJqmfrjujK0tr7NpV4mwpIe7XMUZxYYlvgjsPWL27
         gJQ7AG3H38is9NrMMXoawFhELH98P2e+EV6iDI09S/UsBRj7HVc9iBZQeuTuoFXsTusu
         zR1w==
X-Gm-Message-State: AJcUukdNuWvfkrwosqjaAaUmM70kdfqNJ8dYIKimoLq0teWI6i8c15nf
        9ebRL/XjTJFnmVZEL2Mu0430tO0P
X-Google-Smtp-Source: ALg8bN7B/6tqc4nkLH0BmmAcjNnHp2/DqXIUxK6k6slPngznvknGrBjWf8GqHqdIxHcUwRn8uAzvQA==
X-Received: by 2002:a50:d311:: with SMTP id g17mr25109800edh.187.1548771563987;
        Tue, 29 Jan 2019 06:19:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17sm1891777ejz.33.2019.01.29.06.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:23 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:23 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:01 GMT
Message-Id: <f0852de8abe2a501fdb829b1c241f02fa1deeaf0.1548771560.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 02/21] ci: rename the library of common functions
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

