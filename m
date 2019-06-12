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
	by dcvr.yhbt.net (Postfix) with ESMTP id 15E051F462
	for <e@80x24.org>; Wed, 12 Jun 2019 18:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfFLSKN (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 14:10:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35835 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfFLSKL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 14:10:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so23035162edr.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 11:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vb2NcnlPfKa58SoklfefNdMlesTIR2Xi2ohW2s8/bV8=;
        b=EO9yAMQvRS0q+lbr0CgTPfKh25LCI1W2WRBVIKZJFiNavJwpOLtu5MZQ2tjiZT/wZx
         t1cTCKk1z5JkUyu8KOslG8oHaZnT4jse+UTiUZmU/Ob9WekGSut8Hl5Mpv0dmZbFP2Uz
         ZTodKgqudBoFemtNaJ/61Htsis/pJzBBxc500q3e9YkTgwBLAoqNuSsyg8wRkMTxYxV8
         4MYX4J+E8hiMI0wjDD0qH7aVTd04aKX8O4ILW+BG5gLNZA9U5efz1Q1x6F8R1VRCtjel
         ApeGsyZPGCXS5WMsyjwr3msZbdJdzYLVSfRlcvVsvSHIMZuXDLNSISxVGDZVdGpMU/Ff
         muyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vb2NcnlPfKa58SoklfefNdMlesTIR2Xi2ohW2s8/bV8=;
        b=KMNK9VVqWQhO+C6JVOoi2mNtvxv+Y6OT2bC90lVUxhAA/7WdSACnTBb/SeVfmXYSAZ
         /NNyebTfbXKPMYyO+Ylffy6wzYsPRE/CVHTNXWxVp9HgSmJDrI7rpOEu9R3jsLC3tSvk
         VQJJfM9Kdj7z+/d/LMGVJklRkxqJfphPO8z3MvQP+0VHog3mP9+LluHn4/SNO4DJdC/h
         fM7onvMRB1DJE2J0kMEa76lN8FoMqJ97DY+0nN1u7X2R3M7F/HoRsUaKBsyl8A6IC11r
         2/tyBwLMt0btL+MjBmwRRKy9ZkaAdPVgw/Z2ai79UglxJgPi32jObshhrsk8UjfYC26h
         tEQQ==
X-Gm-Message-State: APjAAAXdpwTkoDg6j58hxHOErMTD/CQsEmhKuCH32hytKJAwym+R98vK
        HjfPxOhc6M+UbXy6GgBfdDMA/uVA
X-Google-Smtp-Source: APXvYqy5PMa63/Fha2mnf9rvtxkFdS9AztPXYh+ZiyOsh1t2YZdHs2SKBCBXluCu9eT7dENOyRXBOw==
X-Received: by 2002:a50:ac46:: with SMTP id w6mr56367507edc.238.1560363010044;
        Wed, 12 Jun 2019 11:10:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm157866eds.23.2019.06.12.11.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 11:10:09 -0700 (PDT)
Date:   Wed, 12 Jun 2019 11:10:09 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 18:10:08 GMT
Message-Id: <e766e5177722dc20837adbd902d596186b1e4997.1560363008.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.263.git.gitgitgadget@gmail.com>
References: <pull.263.git.gitgitgadget@gmail.com>
From:   "Morian Sonnet via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] submodule foreach: fix recursion of options
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
 t/t7407-submodule-foreach.sh | 5 +++++
 2 files changed, 6 insertions(+)

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
index 706ae762e0..6110742a7c 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -421,4 +421,9 @@ test_expect_success 'option-like arguments passed to foreach commands are not lo
 	test_cmp expected actual
 '
 
+test_expect_success 'option-like arguments passed to foreach recurse correctly' '
+  cd super &&
+  git submodule foreach --recursive git reset --hard
+'
+
 test_done
-- 
gitgitgadget
