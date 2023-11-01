Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EE81C69F
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rUDeV4Ee"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEB3FC
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 16:31:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afe220cadeso5123387b3.3
        for <git@vger.kernel.org>; Wed, 01 Nov 2023 16:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698881487; x=1699486287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JOtA1IYqOpX4c93LlYPUaRF3p6VzSgj2O9uC5Pjovg4=;
        b=rUDeV4EeXKeEcixV5vcHXtsiFOMjAX9f9iCKdIbwRvYBopaDuxU7jZA0wQsdv7u14B
         xcBvRUDFw5ddY/A5K+PFdPcZ/AsBEHxWKeVzQmIboIndizXCSxerruNlidufikb8iNB6
         BBNSMuk460rTt+rsZ36nO8gWGeyXit/FGfIp0DOPLcEr11LgkqKNkZ5m9nry+CX/hYDW
         ayBf3MWymTQsF/Gd7z78lxS3Qe9/jaLCoWh/47gW6A791F1PKRX5fcQugo9pRsxaqN7U
         HROfkhF1omwFYvrGQzGRp5y/+GzXFINCtyzECo/jye/DQ0jnPv6MDUzLyc45QAx3S+CK
         GCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698881487; x=1699486287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOtA1IYqOpX4c93LlYPUaRF3p6VzSgj2O9uC5Pjovg4=;
        b=V3RKjf47zTSIDVbYqiPC7JPD0bTUDSnqswxwFIaUCw7rBAbP2S3sjxXxqJekfkA8mI
         WVt+tdlINWQgHg1LTai5nk/PP1HXeFIyRn8kmE+E16Lzh7E/nE0274xwFgkKN68KKsqf
         bp0cf+SkYrTs9R00KC6uxqkiZktTWxAxbZ1JIx2o1ShA2IL9+RXGuNjy/ginJ2vYJAWm
         4d7Dmwwu7YBcqchdQnMy0bU/flZyV0k5w/6d09Kr9sAg24S3RpH45tpr85a0o9KF+9tL
         kD7KeUDu9ag1d214GmnJCRi7qtuEwDXo9K5Zm9/uN005MKBgXI4XS+Nnxrxdz5lQpmfR
         QdwA==
X-Gm-Message-State: AOJu0Yze1mYnwG79Uw0PNNRKlQidEuDATljKHMJJLI7Fc/oRad+Id31M
	1xq2Zru+Bo4j+vGMM7SyzQfBFJVJJ+CIBPVH4mzTTEckDQmGt5V1TJ5vyq/eXRnEBBHoJ1UcLgc
	jgM/Kmzf9ipcmw3VhZBBuYX5bJWeSidCmsROCFE46Y+T/5dKkkHk/oRkIOgtkHTQ=
X-Google-Smtp-Source: AGHT+IFT2n9QeUd+10s/aJ6vHKujdK8FG4msPACV+sbSCp9+AtjMPX1P/BBcC1KZw3ioSZh5mv18zsRKITNQew==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:fc30:220:f2fb:969])
 (user=steadmon job=sendgmr) by 2002:a81:6e54:0:b0:59b:ebe0:9fce with SMTP id
 j81-20020a816e54000000b0059bebe09fcemr396151ywc.5.1698881487415; Wed, 01 Nov
 2023 16:31:27 -0700 (PDT)
Date: Wed,  1 Nov 2023 16:31:17 -0700
In-Reply-To: <cover.1698881249.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1698881249.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <08d27bb5f9b9c9b92f2ab75a4caf37fe49ac89f9.1698881249.git.steadmon@google.com>
Subject: [PATCH v9 3/3] ci: run unit tests in CI
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, phillip.wood123@gmail.com, rsbecker@nexbridge.com, 
	oswald.buddenhagen@gmx.de, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

Run unit tests in both Cirrus and GitHub CI. For sharded CI instances
(currently just Windows on GitHub), run only on the first shard. This is
OK while we have only a single unit test executable, but we may wish to
distribute tests more evenly when we add new unit tests in the future.

We may also want to add more status output in our unit test framework,
so that we can do similar post-processing as in
ci/lib.sh:handle_failed_tests().

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .cirrus.yml               | 2 +-
 ci/run-build-and-tests.sh | 2 ++
 ci/run-test-slice.sh      | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 4860bebd32..b6280692d2 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -19,4 +19,4 @@ freebsd_12_task:
   build_script:
     - su git -c gmake
   test_script:
-    - su git -c 'gmake test'
+    - su git -c 'gmake DEFAULT_UNIT_TEST_TARGET=unit-tests-prove test unit-tests'
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 2528f25e31..7a1466b868 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -50,6 +50,8 @@ if test -n "$run_tests"
 then
 	group "Run tests" make test ||
 	handle_failed_tests
+	group "Run unit tests" \
+		make DEFAULT_UNIT_TEST_TARGET=unit-tests-prove unit-tests
 fi
 check_unignored_build_artifacts
 
diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index a3c67956a8..ae8094382f 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -15,4 +15,9 @@ group "Run tests" make --quiet -C t T="$(cd t &&
 	tr '\n' ' ')" ||
 handle_failed_tests
 
+# We only have one unit test at the moment, so run it in the first slice
+if [ "$1" == "0" ] ; then
+	group "Run unit tests" make --quiet -C t unit-tests-prove
+fi
+
 check_unignored_build_artifacts
-- 
2.42.0.869.gea05f2083d-goog

