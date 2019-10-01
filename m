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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD4C1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 11:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbfJALlJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 07:41:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38752 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387544AbfJALlI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 07:41:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id w12so15090001wro.5
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yrmxKw55W1ELZ/MbIn36tFw0bNuq4DdT86f47nkg518=;
        b=OBO19L94YPG2MIgk/zzNrFZFGuv9Fr4hoZj3FHTRzlIMKxQvJppXZIp69i3Bt1pAIu
         aztfm1CoIfCnnw7K6wmpXrtWgWuA0mfEMAU6cBdKqT1KNHBZ7RxVkSHe7+gbtXFAeyGI
         HkGirZXBm2si59qDmL1V12tBS51JB9gkaZNxizGjb6aIm0u5S4wlGJ/b19b1cAMT9IKo
         LuWOGaBuae/jGxgUZEIffbE3J6rKSfoEAsCDg+F/EsC1HHtQrYf21vyN9BTESNOABebJ
         7y100MA/+C3VjJ+B6cXrRYUEpS5hKecu9Ofz7ogYk4Cy2VI9Uz5PZfkD3Qvb/hEQsI5S
         6Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yrmxKw55W1ELZ/MbIn36tFw0bNuq4DdT86f47nkg518=;
        b=TRYjzV6xfn3MBUFjtI1k7xQ1grWSHFOO4JD/fS0992ZSjwjD1z5bwAWc/IoEvX6gvh
         AUu0Z3tETCK2sSO5W5/6vnKt2wQO2O71hbmMxxbd546vUBMOZyk7+sCaMbYreSiFzzVv
         NSIPkPba6DJYvjzJvKlXoDGo3RE6iQL3SVUJwNHbngxs+UWhH2iaa+frJSZSiJvuxW1M
         BfmcmQK8Ef1x9J6Gd4MrqyqH17QHzknqgfIazUE3ynU4I1sXCgUq7PlbhiVo6VaTzyvu
         5vDjLJPjdbUaz3kL//UWQ936InJGDjj3Yx0h87lGmEAoehRbM7iw0n2kK/wkQVHS7dUA
         PXJQ==
X-Gm-Message-State: APjAAAW8pIb3r5repkw9caqh9PGeOuoB4NikWpRCMwU453tdIL8Z8Iy2
        Ty4096oBpi7LmelcXAwknQ7/025j
X-Google-Smtp-Source: APXvYqzn3qcmYYd8iKv64X/jblrt6ZmSPFhIV7AqtLRD734es4KokF9pEGX9xPa/xcho9ORK35n0MA==
X-Received: by 2002:adf:ee10:: with SMTP id y16mr3329815wrn.47.1569930066382;
        Tue, 01 Oct 2019 04:41:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c18sm16465148wrv.10.2019.10.01.04.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 04:41:05 -0700 (PDT)
Date:   Tue, 01 Oct 2019 04:41:05 -0700 (PDT)
X-Google-Original-Date: Tue, 01 Oct 2019 11:41:03 GMT
Message-Id: <ab81cee29de17859b7e9e083c329d23429978ae7.1569930063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.356.git.gitgitgadget@gmail.com>
References: <pull.356.git.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] t0061: fix test for argv[0] with spaces (MINGW only)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

The test was originally designed for the case where user reported
that setting GIT_SSH to a .bat file with spaces in path fails on
Windows: https://github.com/git-for-windows/git/issues/692

The test has two different problems:

1. It succeeds with AND without fix eb7c7863 that addressed user's
   problem. This happens because the core problem was misunderstood,
   leading to conclusion that git is unable to start any programs with
   spaces in path on Win7. But in fact
     a) Bug only affected cmd.exe scripts, such as .bat scripts
     b) Bug only happened when cmd.exe received at least two quoted args
     c) Bug happened on any Windows (verified on Win10).
   Therefore, correct test must involve .bat script and two quoted args.
2. In Visual Studio build, it fails to run, because 'test-fake-ssh.exe'
   is copied away from its dependencies 'libiconv.dll' and 'zlib1.dll'.

Fix both problems by using .bat script instead of 'test-fake-ssh.exe'.
NOTE: With this change, the test now correctly fails without eb7c7863.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t0061-run-command.sh | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 015fac8b5d..42c2b6dafa 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -210,10 +210,23 @@ test_expect_success MINGW 'verify curlies are quoted properly' '
 	test_cmp expect actual
 '
 
-test_expect_success MINGW 'can spawn with argv[0] containing spaces' '
-	cp "$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" ./ &&
-	test_must_fail "$PWD/test-fake-ssh$X" 2>err &&
-	grep TRASH_DIRECTORY err
+test_expect_success MINGW 'can spawn .bat with argv[0] containing spaces' '
+	bat="$TRASH_DIRECTORY/bat with spaces in name.bat" &&
+	
+	# Every .bat invocation will log its arguments to file "out"
+	rm -f out &&
+	echo "echo %* >>out" >"$bat" &&
+	
+	# Ask git to invoke .bat; clone will fail due to fake SSH helper
+	test_must_fail env GIT_SSH="$bat" git clone myhost:src ssh-clone &&
+	
+	# Spawning .bat can fail if there are two quoted cmd.exe arguments.
+	# .bat itself is first (due to spaces in name), so just one more is
+	# needed to verify. GIT_SSH will invoke .bat multiple times:
+	# 1) -G myhost
+	# 2) myhost "git-upload-pack src"
+	# First invocation will always succeed. Test the second one.
+	grep "git-upload-pack" out
 '
 
 test_done
-- 
gitgitgadget
