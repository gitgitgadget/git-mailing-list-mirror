Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E0D41F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfA0X04 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:26:56 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:40361 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA0X0z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:26:55 -0500
Received: by mail-ed1-f46.google.com with SMTP id g22so11590881edr.7
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QDfwBZMkgyvZGlij6f9DAjFec83Ya7Y4uw5FE6ySdt4=;
        b=Ki+B5YWhw9Qd3UZBBZsAWVlg3EDsCR3zkemQdUD9ZCbb5JRsy6TDjiTHlcAyKxLjxc
         KQlPawDVh/QAksWYZf4SibRONsyMitkYyVZn4hS4U+BbUtu3bK4EB0iqS4SUE5JNs9Yp
         CvzNa9M3neQMGQpEncJL4/RRlapkYr7aZy8MvmJ/xeNIODy/XDJkSaFMfTlFdmYHjOEv
         g7hmuhp8NVz3Sl5iLIQq85BAIijV1k9ty6zNPhHFTydWz66KpJFlxnjaz+Y3nxqXhgCW
         B+096THn7bdnaUAqA6l6e0cDsxv46KgwjgTqWby7s4rYFDqnMBKdo4C+vdJ84s2/8mZg
         4Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QDfwBZMkgyvZGlij6f9DAjFec83Ya7Y4uw5FE6ySdt4=;
        b=npe2RBePdkmlZn3PNfHD05pQymEmwieyFAdYzC6APuPNHiZQOSsUqmlrAx2INN0k1I
         F8xFSMMpZGS86TT3nOxdfhLP8cL8xWEWLbxXcLpvyvk+QIwF5lm3Xw1ltsYxx9sPd9fQ
         gwDBS06x8rpieb775whWC9Boc8f2rhBrY6+O/jqns/cGhlFfP38fjqomAPRvEgza62wf
         IzX+wE+F4BPk+BqxWJhuO2R6enaJ2jtd1x96EndVsZ/4ltWC5JLGEP7kYdd198M7cT/3
         s44tC6wVoX53EI5wmXjMtI2vp2fs0FurvYMsnn++4exTGQALnhoIxBtv1cfcFEbZC5PM
         FZVw==
X-Gm-Message-State: AJcUukfMKpnQKTBC79x4kkg9aDNJs9fsUVRdO/bzhwDA7T1BQmNPCYHI
        5sXzWKCbTyQg4R8YLhcuHEJNgaPl
X-Google-Smtp-Source: ALg8bN68qaUc9wyQx7uRs5GpYBXCv2J3U7CF5nfH7thngh3lxotic6bgBs/Yh18W4eJlg8Ih9+kV2w==
X-Received: by 2002:a17:906:6b0f:: with SMTP id q15mr3015399ejr.139.1548631612906;
        Sun, 27 Jan 2019 15:26:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p21sm12894109edr.67.2019.01.27.15.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:26:52 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:26:52 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:30 GMT
Message-Id: <bf72fb10049283cb0d85ab3906f1ef535cb64ff8.1548631607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 04/21] ci: inherit --jobs via MAKEFLAGS in
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

