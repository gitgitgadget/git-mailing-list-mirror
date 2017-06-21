Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC5720D0C
	for <e@80x24.org>; Wed, 21 Jun 2017 12:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdFUMb6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 08:31:58 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35170 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdFUMb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 08:31:58 -0400
Received: by mail-it0-f67.google.com with SMTP id f20so513650itb.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:disposition-notification-to
         :mime-version:content-transfer-encoding;
        bh=AAJzhkFtzN8zCfHvW5370Vzth9oD5degd0FKpC0p+sk=;
        b=kqCsDUh4x5Euzfg0WO1iqOOLx8WcCV5xDnuyXmdmM5KDlVqPi7xQzRIXy4J8/DgmwT
         ltStNh4avlJIrJHYDabGwWhd5vsjz+Ptp9NZWEF2i73fzDmLtIe30oHH7L0Qu5QtMu0U
         TLaC01osbEOVKyGLThLPI+25q46cPYAkP3ZskLQVwqfZGkzefJNGoMbhuZOng7e1hvyG
         VsZSbRQ1wV0g+j5/JNEmDqCBJxLzZvo9VUIm/g0uxG1/+ENl6aCvq/J2Ate9ZRABUM1m
         zdqADIJfSqPuGpR1wrqegl+IpGXgZBoG4/h5mgydvBpumjMa6mpCWUiz+BITChb37xGA
         aa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=AAJzhkFtzN8zCfHvW5370Vzth9oD5degd0FKpC0p+sk=;
        b=VupzSqBiERG4httXtjIChWOavfUYR6Uho+dLWWseC4dXzbfvOJIocu0j/rYHI0ic2j
         Ecxghr/QuuNwML3lbWMWzOW5QylIvhctVtU4fZpm0cDgBaP53yHNy9CO2CDputk6E5U3
         gmhbZUoyh5UlLjmbqGtBegR2l23hlVONPAVkVGGYfdIYU4RBOq4HgJu3e6ifucPD8Knz
         DK+KByCJBV9PT2JxMgmNP52iPOqKfqrvV9SEs7PmbEs4jhfo+zhX0bHJQVIWz31mJTFi
         gcczxTT4hAOJOnNEbRCavbk2ZnKPIHtITThf4/Gc7W3Rr8DcHyJpwxfafc0jq+SknVsU
         jkKg==
X-Gm-Message-State: AKS2vOysvlkH7lZcBCO6znEBpe0hRXODA2fxKENGaHY6gQsnTpHkUyym
        gV4+4eFcXgCGDQ==
X-Received: by 10.36.43.146 with SMTP id h140mr8184207ita.7.1498048317276;
        Wed, 21 Jun 2017 05:31:57 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id 11sm1160585iou.39.2017.06.21.05.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 05:31:56 -0700 (PDT)
Message-ID: <1498048305.1746.6.camel@gmail.com>
Subject: [PATCH] status tests: fix a minor indenting issue
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com
Date:   Wed, 21 Jun 2017 18:01:45 +0530
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the indentation from "\t " to "\t". This indenting issue was
introduced when the test was added in commit
1d2f393ac9 ("status/commit: show staged submodules regardless of
ignore config", 2014-04-05).

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7508-status.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 5edcc6edf..35ea0b707 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1494,7 +1494,7 @@ EOF
 test_expect_success 'git commit -m will commit a staged but ignored
submodule' '
 	git commit -uno -m message &&
 	git status -s --ignore-submodules=dirty >output &&
-	 test_i18ngrep ! "^M. sm" output &&
+	test_i18ngrep ! "^M. sm" output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
-- 
2.11.0
