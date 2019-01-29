Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFBF61F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfA2OT3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:29 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:37264 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfA2OT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:27 -0500
Received: by mail-ed1-f45.google.com with SMTP id h15so16094565edb.4
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QDfwBZMkgyvZGlij6f9DAjFec83Ya7Y4uw5FE6ySdt4=;
        b=StsIvhPXgaV3gHSgBla9LLqw43a773qICh4l8eZnZcWIB2dGN0HREi1d67OJPr0tM3
         8Gvhh0+vQV/mgOqhCKSMAtPYB54fNpBxcedyIK3Sb1Pv9K2VI5HZopkYWpmVvVmNcd9Q
         mpeA/AnBm8mHP/mL+HqQlp5Q6P0CzHD3tnIZ/koxWy2zhK1Z+HN4mjAvMw/4UIMKgyQi
         wd171/JaVVhI5kVdT3K0Yuvxrcuqta9Iy6skuo9BYSIifwqKtC43t1qM5o1N+GhczkPk
         hnI6m/fSsLrc96XxItrcdr4tbtDMyd4bMMOSASyUI2xtt0qVFGT4merpd5BZ1fdBGYFG
         cbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QDfwBZMkgyvZGlij6f9DAjFec83Ya7Y4uw5FE6ySdt4=;
        b=GA1zv44VH35SCzb5gJVyCRGvLbriqb8nvmIJLmFrVp6ndoCmxecETh2dL+4jJJLMeD
         JbTZMid0hc+RNHJGaSk6Nhj4orRhGBzAbcK89zGh1mp3vs/Zq43pGH1OStBzY9+m7RPV
         1Er112Xo1zVbd0tfyTK4yWnWfFDRmIUKJUHtDsruppKIT53KyHVmVm+XUbIF1KBQYyNZ
         Mr8czjxOUpT+leq0KBuVzf0cxKRekGMQroBnmUPU5vq09nvPFj0H5d/CoEc/e3gfJlgx
         KS8dOcyWch+YREDYYGGnMwmwGC4UAEqLiMFz82l1kCuvapjCG9AH7mAwqbxR/cVBb3vb
         VH4g==
X-Gm-Message-State: AJcUukeib7QAd2IQfyjaCE/hPIiqXzAYlKaXZFGyZ39CGJ3nz9QYpMm4
        t99NtSwPg5sP19BYjARmnS07XEfw
X-Google-Smtp-Source: ALg8bN7jj5VG8dWK1nZc4giVC2ijhzf6kpoWg9FeTmnli4YwVyb91RBELYTyOdVmOhI506dns4e7vg==
X-Received: by 2002:aa7:ca4a:: with SMTP id j10mr24770504edt.213.1548771565891;
        Tue, 29 Jan 2019 06:19:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay20sm1958983ejb.32.2019.01.29.06.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:25 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:25 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:03 GMT
Message-Id: <bf72fb10049283cb0d85ab3906f1ef535cb64ff8.1548771560.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 04/21] ci: inherit --jobs via MAKEFLAGS in
 run-build-and-tests
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

Let's not decide in the generic ci/ part how many jobs to run in
parallel; different CI configurations would favor a different number of
parallel jobs, and it is easy enough to hand that information down via
the `MAKEFLAGS` variable.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh                 | 1 +
 ci/run-build-and-tests.sh | 2 +-
 ci/run-linux32-build.sh   | 2 +-
 ci/run-static-analysis.sh | 2 +-
 ci/test-documentation.sh  | 4 ++--
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 3f286d86a6..32a28fd209 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -101,6 +101,7 @@ then
 	BREW_INSTALL_PACKAGES="git-lfs gettext"
 	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --immediate"
+	export MAKEFLAGS="--jobs=2"
 else
 	echo "Could not identify CI type" >&2
 	exit 1
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index db342bb6a8..80d72d120f 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -7,7 +7,7 @@
 
 ln -s "$cache_dir/.prove" t/.prove
 
-make --jobs=2
+make
 make --quiet test
 if test "$jobname" = "linux-gcc"
 then
diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index 2c60d2e70a..09e9276e12 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -55,6 +55,6 @@ linux32 --32bit i386 su -m -l $CI_USER -c '
 	set -ex
 	cd /usr/src/git
 	test -n "$cache_dir" && ln -s "$cache_dir/.prove" t/.prove
-	make --jobs=2
+	make
 	make --quiet test
 '
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index dc189c7456..a19aa7ebbc 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -5,7 +5,7 @@
 
 . ${0%/*}/lib.sh
 
-make --jobs=2 coccicheck
+make coccicheck
 
 set +x
 
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 7d0beb2832..be3b7d376a 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -12,7 +12,7 @@ make check-builtins
 make check-docs
 
 # Build docs with AsciiDoc
-make --jobs=2 doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
+make doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
 ! test -s stderr.log
 test -s Documentation/git.html
 test -s Documentation/git.xml
@@ -24,7 +24,7 @@ check_unignored_build_artifacts
 
 # Build docs with AsciiDoctor
 make clean
-make --jobs=2 USE_ASCIIDOCTOR=1 doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
+make USE_ASCIIDOCTOR=1 doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
 sed '/^GIT_VERSION = / d' stderr.log
 ! test -s stderr.log
 test -s Documentation/git.html
-- 
gitgitgadget

