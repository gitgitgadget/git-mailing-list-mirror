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
	by dcvr.yhbt.net (Postfix) with ESMTP id 07CF11F463
	for <e@80x24.org>; Tue, 24 Sep 2019 10:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409532AbfIXKkc (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 06:40:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37501 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409464AbfIXKkc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 06:40:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so1471329wmc.2
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aN6kAgH9D3R3JKViLSzZQlCXQh+X1eFgsCjVcj2DLzc=;
        b=ds/fc4TJUrft3gr9nt857js21wLM0oLCE2CcxMP9bblQhKndMR3ghcgwEiyiQWRWAX
         IVV6DzFDeZ8xhlhej7kBArPxOXr9r36b3dOskwvHdPH5K1VPH7m6Au2F22dwTHpMtzph
         iCK7K96GRxxFSi48ECsbZ8C2Y/orB3u8izINQcKh8yM+ZwaeSxAh82hHU6XnJoeFbsiq
         bLWpUonpXPt+lyRLXlIYnopuOadqW03u+ZUgIYPnuka3V1D+gPKZz7ygMbd9ogCu7q5c
         E5uETlNsPig3b/X/p+J8GKffxaV8lon6dnwuQmJb2LlIM7Y85T1iL5f+D573qgJCiG9W
         Nnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aN6kAgH9D3R3JKViLSzZQlCXQh+X1eFgsCjVcj2DLzc=;
        b=amWlbaKln3n8QX2ctTni5rNE1lY8uce6cynvwqzFRyAxJTfMiV0yHrh+N+8LRWUTax
         AqJehOvwQjNu/neGuna7VbGgjgiPdepvlEN3DN2bacj425BImOX9CO2HZdtlz7Bq/laN
         oxQY+FXfnD6yGNyU0ZC0GvlFaKoaDs1fgO4xFLvkAKkt+3Q3lf719QDbqYGD8Y3Q3vND
         FJwWmEy6If3W7VWu4pXiH/Qy8pR80lx4c0fJYgOqmNtxYeWN8pk8LsLejeUi4qDJ/XO0
         O6JKev0ihNcjxymy+paZy2Ee9UTP7on13+rXj4gMaeJRD7S+wO2yOep6q9yd7ZgtYDCN
         xlhg==
X-Gm-Message-State: APjAAAXJc4yZRq06LOu+i62qNzFpKV53Ufm6KBQaQcepO6cWBF7GmEtB
        TEeJ1xH1QC2Z4sMnUn9IDmCspuLe
X-Google-Smtp-Source: APXvYqySgcKbP6x2bK4Xv/QcBOjJi7daxP4u3VqaP6GzgHOQBazvCF1CGOlTUTACodOZz1Eizky1YA==
X-Received: by 2002:a05:600c:210b:: with SMTP id u11mr2113688wml.29.1569321629285;
        Tue, 24 Sep 2019 03:40:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9sm968678wme.45.2019.09.24.03.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 03:40:28 -0700 (PDT)
Date:   Tue, 24 Sep 2019 03:40:28 -0700 (PDT)
X-Google-Original-Date: Tue, 24 Sep 2019 10:40:26 GMT
Message-Id: <pull.347.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.347.v2.git.gitgitgadget@gmail.com>
References: <pull.347.v2.git.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/2] Update: fixed typos in commit message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 1/2: t0028: fix test for UTF-16-LE-BOM Commit 2/2: t0028: add more
tests Please refer to individual commit messages for more information.

Alexandr Miloslavskiy (2):
  t0028: fix test for UTF-16-LE-BOM
  t0028: add more tests

 t/t0028-working-tree-encoding.sh | 41 +++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)


base-commit: 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-347%2FSyntevoAlex%2F%230189_t0028_fixes-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-347/SyntevoAlex/#0189_t0028_fixes-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/347

Range-diff vs v2:

 1:  d717a60932 ! 1:  438ac961a5 t0028: fix test for UTF-16-LE-BOM
     @@ -3,15 +3,15 @@
          t0028: fix test for UTF-16-LE-BOM
      
          According to its name, the test is designed for UTF-16-LE-BOM.
     -    However, possibly due to copy&paste oversight, it was using UTF-32 file.
     +    However, possibly due to copy&paste oversight, it was using UTF-32.
      
     -    While the test succeeds (probably interprets extra \x00\x00 as embedded
     -    zero), I myself had an unrelated problem which caused the test to fail.
     +    While the test succeeds (extra \000\000 are interpreted as NUL),
     +    I myself had an unrelated problem which caused the test to fail.
          When analyzing the failure I was quite puzzled by the fact that the
          test is obviously bugged. And it seems that I'm not alone:
          https://public-inbox.org/git/CAH8yC8kSakS807d4jc_BtcUJOrcVT4No37AXSz=jePxhw-o9Dg@mail.gmail.com/T/#u
      
     -    This fix changes the test to follow its original intention.
     +    Fix the test to follow its original intention.
      
          Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
      
 2:  40e54cf5ce ! 2:  e4410274e6 t0028: add more tests
     @@ -2,9 +2,9 @@
      
          t0028: add more tests
      
     -    After I discovered that UTF-16-LE-BOM test was bugged and still
     -    succeeded, I decided that better tests are required. Possibly the best
     -    option here is to compare git results against hardcoded ground truth.
     +    After I discovered that UTF-16-LE-BOM test was bugged, I decided that
     +    better tests are required. Possibly the best option here is to compare
     +    git results against hardcoded ground truth.
      
          The new tests also cover more interesting chars where (ANSI != UTF-8).
      
     @@ -25,26 +25,26 @@
      +	orig_string="$2"
      +	expect_bytes="$3"
      +	
     -+	test_expect_success "Commit utf-8, checkout ${encoding}" '
     ++	test_expect_success "Commit UTF-8, checkout $encoding" '
      +		test_when_finished "git checkout HEAD -- .gitattributes" &&
      +		
     -+		test_ext="commit_utf8_checkout_${encoding}" &&
     -+		test_file="test.${test_ext}" &&
     ++		test_ext="commit_utf8_checkout_$encoding" &&
     ++		test_file="test.$test_ext" &&
      +		
     -+		# Commit as utf-8
     -+		echo "*.${test_ext} text working-tree-encoding=utf-8" >.gitattributes &&
     -+		printf "${orig_string}" >"${test_file}" &&
     -+		git add "${test_file}" &&
     ++		# Commit as UTF-8
     ++		echo "*.$test_ext text working-tree-encoding=UTF-8" >.gitattributes &&
     ++		printf "$orig_string" >$test_file &&
     ++		git add $test_file &&
      +		git commit -m "Test data" &&
      +
      +		# Checkout in tested encoding
     -+		rm "${test_file}" &&
     -+		echo "*.${test_ext} text working-tree-encoding=${encoding}" >.gitattributes &&
     -+		git checkout HEAD -- "${test_file}" &&
     ++		rm $test_file &&
     ++		echo "*.$test_ext text working-tree-encoding=$encoding" >.gitattributes &&
     ++		git checkout HEAD -- $test_file &&
      +		
      +		# Test
     -+		printf "${expect_bytes}" > "${test_file}.raw" &&
     -+		test_cmp_bin "${test_file}.raw" "${test_file}"
     ++		printf $expect_bytes >$test_file.raw &&
     ++		test_cmp_bin $test_file.raw $test_file
      +	'
      +}
      +

-- 
gitgitgadget
