Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DCA91F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfA2OTj (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:39 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45650 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbfA2OTi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:38 -0500
Received: by mail-ed1-f65.google.com with SMTP id d39so16060261edb.12
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yoxWa1U90pjzjU/QbGOiqw837KuauzuzDTNtqYZbGj0=;
        b=cOIQulFNIbHf6ry6JQ5Zsuvqh8JGGXnY1IDhRD9c7zFhoelOMqp1WHc0igM1GW0b4y
         p+RYi6MOcES0IaQC6O/DwT7Sjh9jAe+AVdUmDfKCUbkWwhrpd6lJp4AewyHXCT6JI26X
         aLo4s0OJRsHxCrO04CLRu2nPNH7IcQnbZZXQvKdUQUYftzk+dTuI4OMuqz7ZPGFXx3UM
         BnF4Zc51I4TSoAsHGo3wgULhg09CQpLTjtcXGoQoMDG/BrNpXRc/5M1u0AHCjkO3wGOs
         /2gzFOWJSVHJGAGGB0Iy9ttk50w12jte5EtkpgbKRxbGW1otqMqVHGHR5YcIMV/kDQQi
         +eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yoxWa1U90pjzjU/QbGOiqw837KuauzuzDTNtqYZbGj0=;
        b=VnqCQhYBptYw3+0PjYxa5He0edcxqu4HSIxx7TYvsDpcIVh7YK5ubYpRaRN5hqp8CS
         o2MOtK75+2Gp9hfVlqCguCJfJDH3l8UOCHybLXdVOFfI/S0yInbe2DfS/gI1A/p2COF3
         BvLU+8D99+j2+gmkP9PtzPIWPmGvIrW2KmnxUlkQ34074AXQ1i+hzv1c7SmFMDy0k2q+
         8owYoiAvoB8htLazLWutdTqRDaibNasHWj76lqFCSzrPJTSRtRx7pFduq9GzfgG6aDUs
         Vq6rmdSadUnUinyfDMvaLD5k8eziTUI1Yeba5Rzbkg05DVpo6wpjQo8XIo2seai/Tbjm
         mrNA==
X-Gm-Message-State: AJcUukcikkvVoeW78TEYSJa1Yi9YQFnvyjtTCC9WVQsAK19i9iTssgTP
        sLhsu0xDXC6hEagJfeOSwf1U58q1
X-Google-Smtp-Source: ALg8bN5+UfNcaUEHBAWK0c1ltkKj7H9wdPlsmbGlNQkuatjwTOFcNh5agCnf+b8p1eH21gOgs2Jdzw==
X-Received: by 2002:a05:6402:758:: with SMTP id p24mr26269198edy.92.1548771576835;
        Tue, 29 Jan 2019 06:19:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm15867350ede.53.2019.01.29.06.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:36 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:36 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:17 GMT
Message-Id: <4ec6cc83ef03a68cb0efacc530e8413fded83b95.1548771561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 18/21] t0061: workaround issues with --with-dashes and
 RUNTIME_PREFIX
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

When building Git with RUNTIME_PREFIX and starting a test helper from
t/helper/, it fails to detect a system prefix. The reason is that the
RUNTIME_PREFIX feature wants to use the location of the Git executable
to determine where the support files can be found, e.g. system-wide Git
config or the translations. This does not make any sense for the test
helpers, though, as they are distinctly not in a directory structure
resembling the final installation location of Git.

That is the reason why the test helpers rely on environment variables to
indicate the location of the needed support files, e.g.
GIT_TEXTDOMAINDIR. If this information is missing, the output will
contain warnings like this one:

	RUNTIME_PREFIX requested, but prefix computation failed. [...]

In t0061, we did not expect that to happen, and it actually does not
happen in the regular case, because bin-wrappers/test-tool specifically
sets GIT_TEXTDOMAINDIR (and as a consequence, nothing in test-tool needs
to know anything about any runtime prefix).

However, with --with-dashes, bin-wrappers/test-tool is no longer called,
but t/helper/test-tool is called directly instead.

So let's just ignore the RUNTIME_PREFIX warning.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0061-run-command.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 99a614bc7c..5a2d087bf0 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -166,7 +166,8 @@ test_trace () {
 	expect="$1"
 	shift
 	GIT_TRACE=1 test-tool run-command "$@" run-command true 2>&1 >/dev/null | \
-		sed -e 's/.* run_command: //' -e '/trace: .*/d' >actual &&
+		sed -e 's/.* run_command: //' -e '/trace: .*/d' \
+			-e '/RUNTIME_PREFIX requested/d' >actual &&
 	echo "$expect true" >expect &&
 	test_cmp expect actual
 }
-- 
gitgitgadget

