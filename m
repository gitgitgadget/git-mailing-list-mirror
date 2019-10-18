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
	by dcvr.yhbt.net (Postfix) with ESMTP id 728FA1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392260AbfJRWOd (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:14:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36381 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732431AbfJRWOc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:14:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23so4095318pgk.3
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ObasyHwZo6qRqX0/FuoNYgWtmKowrJy2UTYJxg8IPq0=;
        b=b4xXkeoqWbBQW1PYUWq1QNXSqyypE7Xjb4WGGnn8bHxuL7Vo5kM2UCMUVGbM19qKFJ
         74Kn3siLPIocBKTRwz5Mlg8tO4zWSkCncxe1eBvb/f9lwcFVJpRuHXofBq41Sg8K3YjE
         WDmi+rv+YHieeOBMg/5XmqWSu0P4TPUt0ioEseovUNtbUyBoiHS8FTY9OtXpeK7lJ1o0
         dXVf7p0MHeyUq36l5GDNaYNeezzacCOSbaF7oz+r1/t4GVH/8nEQ69w2XHfMLbVhuYyw
         gje1Hn1FTelWrYz+MmNfOt/mnNHEmPmQ8FrhQbE7CfW6u7dKDrF3/TCjUvIQjEV/ymmt
         hQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ObasyHwZo6qRqX0/FuoNYgWtmKowrJy2UTYJxg8IPq0=;
        b=XpBWUpFJMVAuXIWU/5J9VC1zz7F6qhbe5F1bfdmyTbojMU83orJ3dRuhqu7oz+SR4D
         K2P78jQNOe1UAuA8ssO57Rvz2huKylXakuyZBq38Fogd+RekN6yBzwJM5nLI3Ol0Cl/J
         ccqweqqum1ywAaFbbpjGwtXa8V1mDU3t2fUYKuolB+lRchZPABAHHzMIg0HsnAsif/5v
         08pR6PYJGTuL4w16w6oIph7EqQP9hEpVk4OoCCrPLRuOjQEtAf4wxzxLdef9lwvrK0Kt
         aka56MhKSofSfYdeHZl9xDcizFOtAM80OZXBlJx/kS9ABj7r9visvEL7PDziTinPxj9D
         YoYg==
X-Gm-Message-State: APjAAAUbiRpYic0PwASW3iJgJcxddrzN/V8MAghDgUYtdEVu/9msy5Op
        XWJRlwKZy6It/pBIP0J7aUxaIC8D
X-Google-Smtp-Source: APXvYqy5aFOASgKzlyz8Fm0Jp6xESqO6QTcHb7PyHVwOvOKoRbtgyOVFMvY2aNRWsb1WC9jr44In9Q==
X-Received: by 2002:a17:90a:9406:: with SMTP id r6mr14418156pjo.0.1571436871553;
        Fri, 18 Oct 2019 15:14:31 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id f21sm5563095pgh.85.2019.10.18.15.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:14:30 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:14:29 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/15] t5520: various test cleanup
Message-ID: <20191018221429.GA20245@generichostname>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571435195.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the double-send. public-inbox and MARC both showed that
only 3 messages got through the in the first send so I sent it again.
Seems to have gotten through find the second time around.

On Fri, Oct 18, 2019 at 03:04:03PM -0700, Denton Liu wrote:
> Like earlier patchsets, I want to implement a feature that involves
> modifications to the test suite. Since that feature will probably take a
> while to polish up, however, let's clean up the test suite in a separate
> patchset first so it's not blocked by the feature work.
> 
> 1/15 is a cleanup to an unrelated test that I found while addressing
> some of Eric's comments.
> 
> 2/15 is a general improvement to test_rev_cmp() that will be used later
> in the series.
> 
> Changes since v1:
> 
> * Incorporate Eric's feedback
> 
> Denton Liu (15):
>   t7408: replace `test_must_fail test_path_is_file`
>   t: teach test_cmp_rev to accept ! for not-equals
>   t5520: improve test style
>   t5520: use sq for test case names
>   t5520: let sed open its own input
>   t5520: replace test -f with test-lib functions
>   t5520: remove spaces after redirect operator
>   t5520: use test_line_count where possible
>   t5520: replace test -{n,z} with test-lib functions
>   t5520: use test_cmp_rev where possible
>   t5520: test single-line files by git with test_cmp
>   t5520: don't put git in upstream of pipe
>   t5520: replace subshell cat comparison with test_cmp
>   t5520: remove redundant lines in test cases
>   t5520: replace `! git` with `test_must_fail git`
> 
>  t/t2400-worktree-add.sh             |   4 +-
>  t/t3400-rebase.sh                   |   2 +-
>  t/t3421-rebase-topology-linear.sh   |   6 +-
>  t/t3430-rebase-merges.sh            |   2 +-
>  t/t3432-rebase-fast-forward.sh      |   2 +-
>  t/t3501-revert-cherry-pick.sh       |   2 +-
>  t/t3508-cherry-pick-many-commits.sh |   2 +-
>  t/t5520-pull.sh                     | 343 +++++++++++++++++-----------
>  t/t7408-submodule-reference.sh      |   2 +-
>  t/test-lib-functions.sh             |  13 +-
>  10 files changed, 227 insertions(+), 151 deletions(-)
> 
> Range-diff against v1:
>  -:  ---------- >  1:  987fee4652 t7408: replace `test_must_fail test_path_is_file`
>  -:  ---------- >  2:  417e808466 t: teach test_cmp_rev to accept ! for not-equals
>  1:  0bc54dd330 =  3:  0a56980857 t5520: improve test style
>  2:  a5dee82ecc =  4:  dfa89ba1cb t5520: use sq for test case names
>  3:  58cc2fcda3 =  5:  9fac3dff83 t5520: let sed open its own input
>  4:  d2946208d3 !  6:  c6ca45eb17 t5520: replace test -f with test_path_is_file
>     @@ Metadata
>      Author: Denton Liu <liu.denton@gmail.com>
>      
>       ## Commit message ##
>     -    t5520: replace test -f with test_path_is_file
>     +    t5520: replace test -f with test-lib functions
>      
>          Although `test -f` has the same functionality as test_path_is_file(), in
>          the case where test_path_is_file() fails, we get much better debugging
>     -    information. Replace `test -f` with test_path_is_file so that future
>     -    developers will have a better experience debugging these test cases.
>     +    information.
>     +
>     +    Replace `test -f` with test_path_is_file() so that future developers
>     +    will have a better experience debugging these test cases.
>     +
>     +    Also, in the case of `! test -f`, not only should that path not be a
>     +    file, it shouldn't exist at all so replace it with
>     +    test_path_is_missing().
>      
>          Signed-off-by: Denton Liu <liu.denton@gmail.com>
>      
>     @@ t/t5520-pull.sh: test_expect_success 'pulling into void must not create an octop
>       		cd cloned-octopus &&
>       		test_must_fail git pull .. master master &&
>      -		! test -f file
>     -+		test_must_fail test_path_is_file file
>     ++		test_path_is_missing file
>       	)
>       '
>       
>  5:  5b4c1dd291 =  7:  830a8212ae t5520: remove spaces after redirect operator
>  6:  26fea15950 =  8:  3d982230be t5520: use test_line_count where possible
>  7:  3fc0354c9c !  9:  2bca4f046d t5520: replace test -{n,z} with test-lib functions
>     @@ Metadata
>       ## Commit message ##
>          t5520: replace test -{n,z} with test-lib functions
>      
>     +    When wrapping a Git command in a subshell within another command, we
>     +    throw away the Git command's exit code. In case the Git command fails,
>     +    we would like to know about it rather than the failure being silent.
>     +    Extract Git commands so that their exit codes are not lost.
>     +
>          Instead of using `test -n` or `test -z`, replace them respectively with
>     -    invocations of test_file_not_empty() and test_must_be_empty().
>     +    invocations of test_file_not_empty() and test_must_be_empty() so that we
>     +    get better debugging information in the case of a failure.
>      
>          Signed-off-by: Denton Liu <liu.denton@gmail.com>
>      
>  8:  f4eb80c9ac ! 10:  1a54db1d5c t5520: use test_cmp_rev where possible
>     @@ Commit message
>      
>                  s/test "$(git rev-parse.* \([^)]*\))" = "$(git rev-parse \([^)]*\))"/test_cmp_rev \1 \2/
>                  s/test \([^ ]*\) = "$(git rev-parse.* \([^)]*\))"/test_cmp_rev \1 \2/
>     -            s/test "$(git rev-parse.* \([^)]*\))" != "$(git rev-parse.* \([^)]*\))"/test_must_fail test_cmp_rev \1 \2/
>     -            s/test \([^ ]*\) != "$(git rev-parse.* \([^)]*\))"/test_must_fail test_cmp_rev \1 \2/
>     +            s/test "$(git rev-parse.* \([^)]*\))" != "$(git rev-parse.* \([^)]*\))"/test_cmp_rev ! \1 \2/
>     +            s/test \([^ ]*\) != "$(git rev-parse.* \([^)]*\))"/test_cmp_rev ! \1 \2/
>      
>          Signed-off-by: Denton Liu <liu.denton@gmail.com>
>      
>     @@ t/t5520-pull.sh: test_expect_success 'branch.to-rebase.rebase should override pu
>       	test_config branch.to-rebase.rebase false &&
>       	git pull . copy &&
>      -	test "$(git rev-parse HEAD^)" != "$(git rev-parse copy)" &&
>     -+	test_must_fail test_cmp_rev HEAD^ copy &&
>     ++	test_cmp_rev ! HEAD^ copy &&
>       	test new = "$(git show HEAD:file2)"
>       '
>       
>     @@ t/t5520-pull.sh: test_expect_success 'pull --rebase dies early with dirty workin
>       	git checkout HEAD -- file &&
>       	git pull &&
>      -	test "$COPY" != "$(git rev-parse --verify me/copy)"
>     -+	test_must_fail test_cmp_rev "$COPY" me/copy
>     ++	test_cmp_rev ! "$COPY" me/copy
>       '
>       
>       test_expect_success 'pull --rebase works on branch yet to be born' '
>  9:  bd3ec4239c ! 11:  52cf4f0d0f t5520: test single-line files by git with test_cmp
>     @@ Commit message
>                  s/\(\s*\)test \([^ ]*\) = "$(\(git [^)]*\))"/\1echo \2 >expect \&\&\n\1\3 >actual \&\&\n\1test_cmp expect actual/
>                  s/\(\s*\)test "$(\(git [^)]*\))" = \([^ ]*\)/\1echo \3 >expect \&\&\n\1\2 >actual \&\&\n\1test_cmp expect actual/
>      
>     +    A future patch will clean up situations where we have multiple duplicate
>     +    statements within a test case. This is done to keep this patch purely
>     +    mechanical.
>     +
>          Signed-off-by: Denton Liu <liu.denton@gmail.com>
>      
>       ## t/t5520-pull.sh ##
>     @@ t/t5520-pull.sh: test_expect_success 'branch.to-rebase.rebase' '
>      @@ t/t5520-pull.sh: test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
>       	test_config branch.to-rebase.rebase false &&
>       	git pull . copy &&
>     - 	test_must_fail test_cmp_rev HEAD^ copy &&
>     + 	test_cmp_rev ! HEAD^ copy &&
>      -	test new = "$(git show HEAD:file2)"
>      +	echo new >expect &&
>      +	git show HEAD:file2 >actual &&
> 10:  61b4df0f7c = 12:  0cfabb201c t5520: don't put git in upstream of pipe
> 11:  f3429bbb57 ! 13:  b2d0ce21c8 t5520: replace subshell cat comparison with test_cmp
>     @@ Commit message
>                  s/\(\s*\)test \([^=]*\)= "$(cat \([^)]*\))"/\1echo \2>expect \&\&\n\1test_cmp expect \3/
>                  s/\(\s*\)test "$(cat \([^)]*\))" = \([^&]*\)\( &&\)\?$/\1echo \3 >expect \&\&\n\1test_cmp expect \2\4/
>      
>     +    A future patch will clean up situations where we have multiple duplicate
>     +    statements within a test case. This is done to keep this patch purely
>     +    mechanical.
>     +
>          Signed-off-by: Denton Liu <liu.denton@gmail.com>
>      
>       ## t/t5520-pull.sh ##
>  -:  ---------- > 14:  5aac40a029 t5520: remove redundant lines in test cases
> 12:  3e6c591b2b = 15:  2c0d3ac416 t5520: replace `! git` with `test_must_fail git`
> -- 
> 2.23.0.897.g0a19638b1e
> 
