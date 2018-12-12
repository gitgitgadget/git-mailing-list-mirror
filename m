Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B254220A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 00:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeLLA2N (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 19:28:13 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:33585 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeLLA2M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 19:28:12 -0500
Received: by mail-yb1-f202.google.com with SMTP id 71so1227962ybl.0
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 16:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cco+aX2k3xjHNJc2XrfLGcjMlpuGltb1Uy9Q+8bLsEg=;
        b=e2LCPBT0rPcAKuh3QRS3wI+ducqyjl17usRW4/1YwEFBdBcOUyo2+/2OQLGrNqLDa0
         JB4cBxh03Os3+1sqX37M+vDi9k0LHnQHPvNVgJDjTePNlRYyyMdbdHqK/IXbrt2mJ9Aa
         l18zTQKlfVrbOwKse7mBC1qcSxwfRds0S9CdR90fGNFQseDIHuLEPWwCNlL4SlDomZfB
         n1HGhXX2ErsR7L+G6OaOOsxmROBkmtigxJt17gdsmbGZopbweDOXBoYz+UYMX9vveJAf
         ahcvGhdPKDuFMRQdkVR+U+0tv0SBWoX9YmMbCOFXF5Goi6ta1mYwa69Jgx/CkwwRptK1
         8dBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cco+aX2k3xjHNJc2XrfLGcjMlpuGltb1Uy9Q+8bLsEg=;
        b=euuAVd1LrMTVGV7xuhTCKsQwM0wZHefSEWhGKRK19WJxIC7udhedQN0hxny65Y0W9e
         GqqLsHu3YGg6wRvvbL6pjjHpFAO7CaQS9qy9N0nTvqK2BSuGmYVatvlxveQ+tIpKE1Rt
         AyGqnXEXF8v7aSCt1fPGEcBlXaWSHiHjAc1TO24GkhsjSbE0yB0wtcD4iNr8CRITRxI2
         qt/dluMF2Chdj9XiWVriRBSJs9j/JLzWO9mmLEb2s4Du+aIvO0gNVq2SS5uuvg5IgXU6
         ehV/l/i3A0VQYjJKOmNNXcMBCiFVfncnqkx2vtgFFcQ7WXPTsbGkKwFKi390J36FjnJb
         BaRA==
X-Gm-Message-State: AA+aEWZ1LuK9qHTTOSiLv48R9GCztzE748CD8PepnQTsY3j/jOtldqyH
        toK3YrpdFnjL1zjXH9qKwHMpTvaxh7yr+bG+K78D6BjQW3a41AG8JPonF64VbYCy6JMqWUWbGwb
        chzrj9nDJ6a+sM+NYApK3ukneSgHw8IUOamW4K4fShDiDuZyeMNs0HzIJpI4VG1849vqoXXIJ2f
        tC
X-Google-Smtp-Source: AFSGD/VVLXxIwMcVMZYsZ+9s6IS2v3rECfi0Oh+p5l5YMrXGijIwoEiYQ2Mw/rRv63KCU/IP8WbMSq3v7y5K8/cN8/BW
X-Received: by 2002:a81:9195:: with SMTP id i143mr11112235ywg.6.1544574491641;
 Tue, 11 Dec 2018 16:28:11 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:27:58 -0800
In-Reply-To: <cover.1544573604.git.jonathantanmy@google.com>
Message-Id: <378905b2ce5790cb406b950a3be530859368b1fe.1544573604.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181211212135.21126-2-avarab@gmail.com> <cover.1544573604.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 3/3] also squash this into your patch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5500-fetch-pack.sh    | 13 +++++++------
 t/t5616-partial-clone.sh |  3 +--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 9c18875c9c..a5a8f348a2 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -41,8 +41,7 @@ pull_to_client () {
 	test_expect_success "$number pull" '
 		(
 			cd client &&
-			GIT_TEST_PROTOCOL_VERSION=0 \
-				git fetch-pack -k -v .. $heads &&
+			git fetch-pack -k -v .. $heads &&
 
 			case "$heads" in
 			    *A*)
@@ -441,7 +440,6 @@ test_expect_success 'setup tests for the --stdin parameter' '
 '
 
 test_expect_success 'fetch refs from cmdline' '
-	sane_unset GIT_TEST_PROTOCOL_VERSION &&
 	(
 		cd client &&
 		git fetch-pack --no-progress .. $(cat ../input)
@@ -630,7 +628,10 @@ test_expect_success 'fetch-pack cannot fetch a raw sha1 that is not advertised a
 	test_commit -C server 6 &&
 
 	git init client &&
-	test_must_fail git -C client fetch-pack ../server \
+
+	# Other protocol versions (e.g. 2) allow fetching an unadvertised
+	# object, so run this test with the default protocol version (0).
+	test_must_fail env --unset=GIT_TEST_PROTOCOL_VERSION git -C client fetch-pack ../server \
 		$(git -C server rev-parse refs/heads/master^) 2>err &&
 	test_i18ngrep "Server does not allow request for unadvertised object" err
 '
@@ -790,7 +791,7 @@ test_expect_success 'shallow clone exclude tag two' '
 '
 
 test_expect_success 'fetch exclude tag one' '
-	git -C shallow12 fetch --shallow-exclude one origin &&
+	env --unset=GIT_TEST_PROTOCOL_VERSION git -C shallow12 fetch --shallow-exclude one origin &&
 	git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
 	test_write_lines three two >expected &&
 	test_cmp expected actual
@@ -808,7 +809,7 @@ test_expect_success 'fetching deepen' '
 	git -C deepen log --pretty=tformat:%s master >actual &&
 	echo three >expected &&
 	test_cmp expected actual &&
-	git -C deepen fetch --deepen=1 &&
+	env --unset=GIT_TEST_PROTOCOL_VERSION git -C deepen fetch --deepen=1 &&
 	git -C deepen log --pretty=tformat:%s origin/master >actual &&
 	cat >expected <<-\EOF &&
 	four
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index feedf84ce1..336f02a41a 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -144,8 +144,7 @@ test_expect_success 'manual prefetch of missing objects' '
 	sort >observed.oids &&
 
 	test_line_count = 6 observed.oids &&
-	GIT_TEST_PROTOCOL_VERSION=0 \
-		git -C pc1 fetch-pack --stdin "file://$(pwd)/srv.bare" <observed.oids &&
+	git -C pc1 fetch-pack --stdin "file://$(pwd)/srv.bare" <observed.oids &&
 
 	git -C pc1 rev-list --quiet --objects --missing=print \
 		master..origin/master >revs &&
-- 
2.19.0.271.gfe8321ec05.dirty

