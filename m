Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E7D1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 20:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388884AbfFLU2R (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 16:28:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34462 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388338AbfFLU2R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 16:28:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id c26so27656237edt.1
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bcdJnmyITyiKoERP6NsdPAw9ZeTTXkFVrKDyPggaijw=;
        b=bj0Z6fiQMilAIeoLPWYBu2b9YZjc/cI9ChG+5weXWyZxONHdgzlCwszPyUfYDirhS+
         ta7xeG2ey8/o87BXisdMvmMq5OZKdrnZbbjXtGdByN5p1SfsfhS8qukgu3Lr7e2hZXh0
         t8tv1ypC8ETPVqPkK1mHkx2IWjAJ3pCfaK14+SWE52Pyf42Yr/ebfXqQeoSJHPBlHWZk
         rMhEZy3/CBW5+f8ePz+NC0K6MVbjHdQvMay4IfYssUf1UzTS/Oa5QU12Oz1hIntrLt9H
         t0yORwXwFpmJlbBS433zh3Li/f5EjEgW3QE19pZmWiPsVrVU++BGZOwWF7ac42xv2AGS
         4YAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bcdJnmyITyiKoERP6NsdPAw9ZeTTXkFVrKDyPggaijw=;
        b=StxfYiC359isi4oIqgaxFQf/8C0YbYVUSsidSd8Wu0F3dL2TS8TAJaxSe+DOfKqm75
         Oqdh69a9Lg36w7tb/FvqYemHdhc6Y0pJ2SzFQAz0EYw8nQi0ZafwYuAv1WjC49XRdUt5
         BoKOveDb3NoKd5k3Q2XkmAFbx1gkHPuyU/rzVevlTMWl6a2Y73H3Z4m6nfwNhqFHwD47
         PO/YHC3Neldtof7lpwEyowxskkMjfsL4+Bz1tXeqCzClHM2A+WRYokKfi7FkXm+aI520
         MWmsTzy6nmOQUBvGjAAMJNOSvBVwAR1FBPrn/a4CQu9r1FxmKkD8Vw7OQ+JSak8vfP0V
         hmUw==
X-Gm-Message-State: APjAAAU3Vm0UnKLvCRPzu0JS54QnGGkNHOsPB5CYQKqpDVB6RgYzeAnn
        kuAp4HYQAkOJiD548wYtp6ZzSQsd
X-Google-Smtp-Source: APXvYqwwY0QA/IKtPRmJyotU6aE7CexZlBSUtDtWysHYRJqcnuoeyrPxEkvYVrNOrFZdKuZGC9bOaA==
X-Received: by 2002:a17:906:58cf:: with SMTP id e15mr22499755ejs.240.1560371295183;
        Wed, 12 Jun 2019 13:28:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v32sm243620edm.92.2019.06.12.13.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 13:28:14 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:28:14 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 20:28:13 GMT
Message-Id: <c46e5bd1403b45d25192220ce689fcd55d897981.1560371293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.263.v2.git.gitgitgadget@gmail.com>
References: <pull.263.git.gitgitgadget@gmail.com>
        <pull.263.v2.git.gitgitgadget@gmail.com>
From:   "Morian Sonnet via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] submodule foreach: fix recursion of options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Morian Sonnet <MorianSonnet@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Morian Sonnet <MorianSonnet@googlemail.com>

Calling

    git submodule foreach --recursive git reset --hard

leads to an error stating that the option --hard is unknown to
submodule--helper.

Reasons:

. Above call is internally translated into

    git submodule--helper foreach --recursive -- git reset --hard

. After calling

    git reset --hard

  inside the first first level submodule,

    git --super-prefix <submodulepath> submodule--helper \
      foreach --recursive git reset --hard

  is called. Note the missing --.

. Due to the removal of PARSE_OPT_KEEP_UNKNOWN in commit a282f5a906 the
  option --hard is not passed to

    git reset

  anymore, but leads to git submodule--helper complaining about an
  unknown option.

Fix:

. Add -- before the command to execute, such that now correctly

    git --super-prefix <submodulepath> submodule--helper \
      foreach --recursive -- git reset --hard

  is called.

Signed-off-by: Morian Sonnet <moriansonnet@googlemail.com>
---
 builtin/submodule--helper.c  | 1 +
 t/t7407-submodule-foreach.sh | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0bf4aa088e..afaf0819c9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -540,6 +540,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		if (info->quiet)
 			argv_array_push(&cpr.args, "--quiet");
 
+		argv_array_push(&cpr.args, "--");
 		argv_array_pushv(&cpr.args, info->argv);
 
 		if (run_command(&cpr))
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 706ae762e0..c554589e6f 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -421,4 +421,11 @@ test_expect_success 'option-like arguments passed to foreach commands are not lo
 	test_cmp expected actual
 '
 
+test_expect_success 'option-like arguments passed to foreach recurse correctly' '
+  (
+    cd super &&
+    git submodule foreach --recursive git reset --hard
+  )
+'
+
 test_done
-- 
gitgitgadget
