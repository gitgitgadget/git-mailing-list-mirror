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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B34F1F461
	for <e@80x24.org>; Fri,  6 Sep 2019 02:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfIFCE7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 22:04:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38887 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfIFCE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 22:04:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id w11so2326521plp.5
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 19:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n2DKt68s6xYIb4ctKk6rX/QAv0T/Y9yBtpKawLicmus=;
        b=VqcvNIm2W2cVIIQRtxhydmGc8LQmfKxgtXHNdo18VRyfVgRlGwBng4g5hNT7Hl20oT
         CgsXOGOA2Zu1qwgiFDGF0oj/8B+FLA20IgRniUkBnKIaBYqwcz2uVG9LqlnfLYHxY+jp
         RxWxwL4kcErPtp7gONlkC4o+cbxD2IJHoQoEDibNwZuYh/MMsKq6+TpSSDgY9CIYz92f
         y09utUUs84rhmSwKnq13cKfB/QJYLFGg3xplQk4tPO8xaZoUIUQDdBZikeN89KCjdn1H
         vHgC37rn6DQqwp8Q+ohdxCij9mJIdBLMYkGOm5Y4T3jahiLGX1bMOCxVt1bEA8cfHJSg
         iRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n2DKt68s6xYIb4ctKk6rX/QAv0T/Y9yBtpKawLicmus=;
        b=VPodO6oCq4xPcKjEghxxWPttQ5sRsCjsVuOkSpSZzDsAco0TP8P/XcqskwRobu3s0h
         0jnDePZHaXmPklh2mejQBQQ9tfmdqbLlRkGRjfxxAiuJwBzKxbFk4VFXDHdPYKQ8t1cH
         X9FTFNVNJMYAZFqj79yUF+Hlw5ABllPXOUNip7p6S9GjQ3a0yAerNkBdWPYElXRGREwb
         +GKzRgo02U/J+ziaBvhX2jg08SldFJ0dpmuQY9IGzQQRC4SIsikbBBMT917NQxEqAtrr
         phEjRFBvZya70elm0U+TPvXYP/kJ+uS4uUbsStQB43Nv9QEufX4BRY5EJ/qHvH04+S2t
         eieg==
X-Gm-Message-State: APjAAAWSiGKCAp/enzjqNMAJ8fc5BH+0Q6DUUvGOUkdJZKgRZTbf7OxS
        49m0Hq+pALezaLrHU60927YKSbiU1QI=
X-Google-Smtp-Source: APXvYqyUXxZB3kTU2JxWODuY/V1GuashNi9R7TNk698Hp6Ern1MZI6KUuYGL88aLd6SQJV1vlXAJQw==
X-Received: by 2002:a17:902:4303:: with SMTP id i3mr7120832pld.30.1567735496937;
        Thu, 05 Sep 2019 19:04:56 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id i19sm9542290pjx.1.2019.09.05.19.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 19:04:56 -0700 (PDT)
Date:   Thu, 5 Sep 2019 19:04:54 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] t: use common $SQ variable
Message-ID: <20190906020454.GA19967@archbookpro.localdomain>
References: <xmqqmufipmfp.fsf@gitster-ct.c.googlers.com>
 <0598bbf4d0b2cb07ff6f06f904cbdd3f5a3ae1af.1567721303.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0598bbf4d0b2cb07ff6f06f904cbdd3f5a3ae1af.1567721303.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I should've noted earlier that this patch applies cleanly on top of the
"jc/tests-use-lf-from-test-lib" branch.

On Thu, Sep 05, 2019 at 03:10:05PM -0700, Denton Liu wrote:
> In many test scripts, there are bespoke definitions of the single quote
> that are some variation of this:
> 
>     SQ="'"
> 
> Define a common $SQ variable in test-lib.sh and replace all usages of
> these bespoke variables with the common one.
> 
> This change was done by running `git grep =\"\'\" t/` and
> `git grep =\\\\\'` and manually changing the resulting definitions and

Oops, this invocation wasn't exactly correct; it's missing the `t/` at
the end. The full invocation should read `git grep =\\\\\' t/`.

> corresponding usages.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> 
> [whoops, forgot to include the mailing list in the last email]
> 
> Sorry, I wrote this patch up before I saw the email about leaving this
> as #leftoverbits. No point in letting it go to waste, though.
> 
>  t/t1300-config.sh              |  9 +++--
>  t/t1404-update-ref-errors.sh   | 64 ++++++++++++++++------------------
>  t/t1414-reflog-walk.sh         |  3 +-
>  t/t1506-rev-parse-diagnosis.sh |  5 ++-
>  t/t1507-rev-parse-upstream.sh  | 12 +++----
>  t/t3005-ls-files-relative.sh   |  9 +++--
>  t/t3404-rebase-interactive.sh  |  1 -
>  t/t3430-rebase-merges.sh       |  1 -
>  t/t5601-clone.sh               |  1 -
>  t/t7406-submodule-update.sh    |  3 +-
>  t/test-lib.sh                  |  3 ++
>  11 files changed, 51 insertions(+), 60 deletions(-)
> 
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 428177c390..983a0a1583 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1294,26 +1294,25 @@ test_expect_success 'git -c is not confused by empty environment' '
>  	GIT_CONFIG_PARAMETERS="" git -c x.one=1 config --list
>  '
>  
> -sq="'"
>  test_expect_success 'detect bogus GIT_CONFIG_PARAMETERS' '
>  	cat >expect <<-\EOF &&
>  	env.one one
>  	env.two two
>  	EOF
> -	GIT_CONFIG_PARAMETERS="${sq}env.one=one${sq} ${sq}env.two=two${sq}" \
> +	GIT_CONFIG_PARAMETERS="${SQ}env.one=one${SQ} ${SQ}env.two=two${SQ}" \
>  		git config --get-regexp "env.*" >actual &&
>  	test_cmp expect actual &&
>  
>  	cat >expect <<-EOF &&
> -	env.one one${sq}
> +	env.one one${SQ}
>  	env.two two
>  	EOF
> -	GIT_CONFIG_PARAMETERS="${sq}env.one=one${sq}\\$sq$sq$sq ${sq}env.two=two${sq}" \
> +	GIT_CONFIG_PARAMETERS="${SQ}env.one=one${SQ}\\$SQ$SQ$SQ ${SQ}env.two=two${SQ}" \
>  		git config --get-regexp "env.*" >actual &&
>  	test_cmp expect actual &&
>  
>  	test_must_fail env \
> -		GIT_CONFIG_PARAMETERS="${sq}env.one=one${sq}\\$sq ${sq}env.two=two${sq}" \
> +		GIT_CONFIG_PARAMETERS="${SQ}env.one=one${SQ}\\$SQ ${SQ}env.two=two${SQ}" \
>  		git config --get-regexp "env.*"
>  '
>  
> diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
> index 970c5c36b9..2d142e5535 100755
> --- a/t/t1404-update-ref-errors.sh
> +++ b/t/t1404-update-ref-errors.sh
> @@ -32,8 +32,6 @@ test_update_rejected () {
>  	test_cmp unchanged actual
>  }
>  
> -Q="'"
> -
>  # Test adding and deleting D/F-conflicting references in a single
>  # transaction.
>  df_test() {
> @@ -93,7 +91,7 @@ df_test() {
>  		delname="$delref"
>  	fi &&
>  	cat >expected-err <<-EOF &&
> -	fatal: cannot lock ref $Q$addname$Q: $Q$delref$Q exists; cannot create $Q$addref$Q
> +	fatal: cannot lock ref $SQ$addname$SQ: $SQ$delref$SQ exists; cannot create $SQ$addref$SQ
>  	EOF
>  	$pack &&
>  	if $add_del
> @@ -123,7 +121,7 @@ test_expect_success 'existing loose ref is a simple prefix of new' '
>  
>  	prefix=refs/1l &&
>  	test_update_rejected "a c e" false "b c/x d" \
> -		"$Q$prefix/c$Q exists; cannot create $Q$prefix/c/x$Q"
> +		"$SQ$prefix/c$SQ exists; cannot create $SQ$prefix/c/x$SQ"
>  
>  '
>  
> @@ -131,7 +129,7 @@ test_expect_success 'existing packed ref is a simple prefix of new' '
>  
>  	prefix=refs/1p &&
>  	test_update_rejected "a c e" true "b c/x d" \
> -		"$Q$prefix/c$Q exists; cannot create $Q$prefix/c/x$Q"
> +		"$SQ$prefix/c$SQ exists; cannot create $SQ$prefix/c/x$SQ"
>  
>  '
>  
> @@ -139,7 +137,7 @@ test_expect_success 'existing loose ref is a deeper prefix of new' '
>  
>  	prefix=refs/2l &&
>  	test_update_rejected "a c e" false "b c/x/y d" \
> -		"$Q$prefix/c$Q exists; cannot create $Q$prefix/c/x/y$Q"
> +		"$SQ$prefix/c$SQ exists; cannot create $SQ$prefix/c/x/y$SQ"
>  
>  '
>  
> @@ -147,7 +145,7 @@ test_expect_success 'existing packed ref is a deeper prefix of new' '
>  
>  	prefix=refs/2p &&
>  	test_update_rejected "a c e" true "b c/x/y d" \
> -		"$Q$prefix/c$Q exists; cannot create $Q$prefix/c/x/y$Q"
> +		"$SQ$prefix/c$SQ exists; cannot create $SQ$prefix/c/x/y$SQ"
>  
>  '
>  
> @@ -155,7 +153,7 @@ test_expect_success 'new ref is a simple prefix of existing loose' '
>  
>  	prefix=refs/3l &&
>  	test_update_rejected "a c/x e" false "b c d" \
> -		"$Q$prefix/c/x$Q exists; cannot create $Q$prefix/c$Q"
> +		"$SQ$prefix/c/x$SQ exists; cannot create $SQ$prefix/c$SQ"
>  
>  '
>  
> @@ -163,7 +161,7 @@ test_expect_success 'new ref is a simple prefix of existing packed' '
>  
>  	prefix=refs/3p &&
>  	test_update_rejected "a c/x e" true "b c d" \
> -		"$Q$prefix/c/x$Q exists; cannot create $Q$prefix/c$Q"
> +		"$SQ$prefix/c/x$SQ exists; cannot create $SQ$prefix/c$SQ"
>  
>  '
>  
> @@ -171,7 +169,7 @@ test_expect_success 'new ref is a deeper prefix of existing loose' '
>  
>  	prefix=refs/4l &&
>  	test_update_rejected "a c/x/y e" false "b c d" \
> -		"$Q$prefix/c/x/y$Q exists; cannot create $Q$prefix/c$Q"
> +		"$SQ$prefix/c/x/y$SQ exists; cannot create $SQ$prefix/c$SQ"
>  
>  '
>  
> @@ -179,7 +177,7 @@ test_expect_success 'new ref is a deeper prefix of existing packed' '
>  
>  	prefix=refs/4p &&
>  	test_update_rejected "a c/x/y e" true "b c d" \
> -		"$Q$prefix/c/x/y$Q exists; cannot create $Q$prefix/c$Q"
> +		"$SQ$prefix/c/x/y$SQ exists; cannot create $SQ$prefix/c$SQ"
>  
>  '
>  
> @@ -187,7 +185,7 @@ test_expect_success 'one new ref is a simple prefix of another' '
>  
>  	prefix=refs/5 &&
>  	test_update_rejected "a e" false "b c c/x d" \
> -		"cannot process $Q$prefix/c$Q and $Q$prefix/c/x$Q at the same time"
> +		"cannot process $SQ$prefix/c$SQ and $SQ$prefix/c/x$SQ at the same time"
>  
>  '
>  
> @@ -334,7 +332,7 @@ test_expect_success 'D/F conflict prevents indirect delete long packed + indirec
>  test_expect_success 'missing old value blocks update' '
>  	prefix=refs/missing-update &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q
> +	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ
>  	EOF
>  	printf "%s\n" "update $prefix/foo $E $D" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
> @@ -345,7 +343,7 @@ test_expect_success 'incorrect old value blocks update' '
>  	prefix=refs/incorrect-update &&
>  	git update-ref $prefix/foo $C &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/foo$Q: is at $C but expected $D
> +	fatal: cannot lock ref $SQ$prefix/foo$SQ: is at $C but expected $D
>  	EOF
>  	printf "%s\n" "update $prefix/foo $E $D" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
> @@ -356,7 +354,7 @@ test_expect_success 'existing old value blocks create' '
>  	prefix=refs/existing-create &&
>  	git update-ref $prefix/foo $C &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/foo$Q: reference already exists
> +	fatal: cannot lock ref $SQ$prefix/foo$SQ: reference already exists
>  	EOF
>  	printf "%s\n" "create $prefix/foo $E" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
> @@ -367,7 +365,7 @@ test_expect_success 'incorrect old value blocks delete' '
>  	prefix=refs/incorrect-delete &&
>  	git update-ref $prefix/foo $C &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/foo$Q: is at $C but expected $D
> +	fatal: cannot lock ref $SQ$prefix/foo$SQ: is at $C but expected $D
>  	EOF
>  	printf "%s\n" "delete $prefix/foo $D" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
> @@ -378,7 +376,7 @@ test_expect_success 'missing old value blocks indirect update' '
>  	prefix=refs/missing-indirect-update &&
>  	git symbolic-ref $prefix/symref $prefix/foo &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/symref$Q: unable to resolve reference $Q$prefix/foo$Q
> +	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ
>  	EOF
>  	printf "%s\n" "update $prefix/symref $E $D" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
> @@ -390,7 +388,7 @@ test_expect_success 'incorrect old value blocks indirect update' '
>  	git symbolic-ref $prefix/symref $prefix/foo &&
>  	git update-ref $prefix/foo $C &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/symref$Q: is at $C but expected $D
> +	fatal: cannot lock ref $SQ$prefix/symref$SQ: is at $C but expected $D
>  	EOF
>  	printf "%s\n" "update $prefix/symref $E $D" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
> @@ -402,7 +400,7 @@ test_expect_success 'existing old value blocks indirect create' '
>  	git symbolic-ref $prefix/symref $prefix/foo &&
>  	git update-ref $prefix/foo $C &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/symref$Q: reference already exists
> +	fatal: cannot lock ref $SQ$prefix/symref$SQ: reference already exists
>  	EOF
>  	printf "%s\n" "create $prefix/symref $E" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
> @@ -414,7 +412,7 @@ test_expect_success 'incorrect old value blocks indirect delete' '
>  	git symbolic-ref $prefix/symref $prefix/foo &&
>  	git update-ref $prefix/foo $C &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/symref$Q: is at $C but expected $D
> +	fatal: cannot lock ref $SQ$prefix/symref$SQ: is at $C but expected $D
>  	EOF
>  	printf "%s\n" "delete $prefix/symref $D" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
> @@ -425,7 +423,7 @@ test_expect_success 'missing old value blocks indirect no-deref update' '
>  	prefix=refs/missing-noderef-update &&
>  	git symbolic-ref $prefix/symref $prefix/foo &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/symref$Q: reference is missing but expected $D
> +	fatal: cannot lock ref $SQ$prefix/symref$SQ: reference is missing but expected $D
>  	EOF
>  	printf "%s\n" "option no-deref" "update $prefix/symref $E $D" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
> @@ -437,7 +435,7 @@ test_expect_success 'incorrect old value blocks indirect no-deref update' '
>  	git symbolic-ref $prefix/symref $prefix/foo &&
>  	git update-ref $prefix/foo $C &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/symref$Q: is at $C but expected $D
> +	fatal: cannot lock ref $SQ$prefix/symref$SQ: is at $C but expected $D
>  	EOF
>  	printf "%s\n" "option no-deref" "update $prefix/symref $E $D" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
> @@ -449,7 +447,7 @@ test_expect_success 'existing old value blocks indirect no-deref create' '
>  	git symbolic-ref $prefix/symref $prefix/foo &&
>  	git update-ref $prefix/foo $C &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/symref$Q: reference already exists
> +	fatal: cannot lock ref $SQ$prefix/symref$SQ: reference already exists
>  	EOF
>  	printf "%s\n" "option no-deref" "create $prefix/symref $E" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
> @@ -461,7 +459,7 @@ test_expect_success 'incorrect old value blocks indirect no-deref delete' '
>  	git symbolic-ref $prefix/symref $prefix/foo &&
>  	git update-ref $prefix/foo $C &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/symref$Q: is at $C but expected $D
> +	fatal: cannot lock ref $SQ$prefix/symref$SQ: is at $C but expected $D
>  	EOF
>  	printf "%s\n" "option no-deref" "delete $prefix/symref $D" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
> @@ -474,13 +472,13 @@ test_expect_success 'non-empty directory blocks create' '
>  	: >.git/$prefix/foo/bar/baz.lock &&
>  	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/foo$Q: there is a non-empty directory $Q.git/$prefix/foo$Q blocking reference $Q$prefix/foo$Q
> +	fatal: cannot lock ref $SQ$prefix/foo$SQ: there is a non-empty directory $SQ.git/$prefix/foo$SQ blocking reference $SQ$prefix/foo$SQ
>  	EOF
>  	printf "%s\n" "update $prefix/foo $C" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
>  	test_cmp expected output.err &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q
> +	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ
>  	EOF
>  	printf "%s\n" "update $prefix/foo $D $C" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
> @@ -493,13 +491,13 @@ test_expect_success 'broken reference blocks create' '
>  	echo "gobbledigook" >.git/$prefix/foo &&
>  	test_when_finished "rm -f .git/$prefix/foo" &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
> +	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
>  	EOF
>  	printf "%s\n" "update $prefix/foo $C" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
>  	test_cmp expected output.err &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
> +	fatal: cannot lock ref $SQ$prefix/foo$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
>  	EOF
>  	printf "%s\n" "update $prefix/foo $D $C" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
> @@ -513,13 +511,13 @@ test_expect_success 'non-empty directory blocks indirect create' '
>  	: >.git/$prefix/foo/bar/baz.lock &&
>  	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/symref$Q: there is a non-empty directory $Q.git/$prefix/foo$Q blocking reference $Q$prefix/foo$Q
> +	fatal: cannot lock ref $SQ$prefix/symref$SQ: there is a non-empty directory $SQ.git/$prefix/foo$SQ blocking reference $SQ$prefix/foo$SQ
>  	EOF
>  	printf "%s\n" "update $prefix/symref $C" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
>  	test_cmp expected output.err &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/symref$Q: unable to resolve reference $Q$prefix/foo$Q
> +	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ
>  	EOF
>  	printf "%s\n" "update $prefix/symref $D $C" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
> @@ -532,13 +530,13 @@ test_expect_success 'broken reference blocks indirect create' '
>  	echo "gobbledigook" >.git/$prefix/foo &&
>  	test_when_finished "rm -f .git/$prefix/foo" &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/symref$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
> +	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
>  	EOF
>  	printf "%s\n" "update $prefix/symref $C" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
>  	test_cmp expected output.err &&
>  	cat >expected <<-EOF &&
> -	fatal: cannot lock ref $Q$prefix/symref$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
> +	fatal: cannot lock ref $SQ$prefix/symref$SQ: unable to resolve reference $SQ$prefix/foo$SQ: reference broken
>  	EOF
>  	printf "%s\n" "update $prefix/symref $D $C" |
>  	test_must_fail git update-ref --stdin 2>output.err &&
> @@ -614,7 +612,7 @@ test_expect_success 'delete fails cleanly if packed-refs file is locked' '
>  	test_when_finished "rm -f .git/packed-refs.lock" &&
>  	test_must_fail git update-ref -d $prefix/foo >out 2>err &&
>  	git for-each-ref $prefix >actual &&
> -	test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: " err &&
> +	test_i18ngrep "Unable to create $SQ.*packed-refs.lock$SQ: " err &&
>  	test_cmp unchanged actual
>  '
>  
> diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
> index feb1efd8ff..1181a9fb28 100755
> --- a/t/t1414-reflog-walk.sh
> +++ b/t/t1414-reflog-walk.sh
> @@ -18,10 +18,9 @@ do_walk () {
>  	git log -g --format="%gd %gs" "$@"
>  }
>  
> -sq="'"
>  test_expect_success 'set up expected reflog' '
>  	cat >expect.all <<-EOF
> -	HEAD@{0} commit (merge): Merge branch ${sq}master${sq} into side
> +	HEAD@{0} commit (merge): Merge branch ${SQ}master${SQ} into side
>  	HEAD@{1} commit: three
>  	HEAD@{2} checkout: moving from master to side
>  	HEAD@{3} commit: two
> diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
> index 4ee009da66..21a9c8ffb2 100755
> --- a/t/t1506-rev-parse-diagnosis.sh
> +++ b/t/t1506-rev-parse-diagnosis.sh
> @@ -8,10 +8,9 @@ exec </dev/null
>  
>  test_did_you_mean ()
>  {
> -	sq="'" &&
>  	cat >expected <<-EOF &&
> -	fatal: Path '$2$3' $4, but not ${5:-$sq$3$sq}.
> -	Did you mean '$1:$2$3'${2:+ aka $sq$1:./$3$sq}?
> +	fatal: Path '$2$3' $4, but not ${5:-$SQ$3$SQ}.
> +	Did you mean '$1:$2$3'${2:+ aka $SQ$1:./$3$SQ}?
>  	EOF
>  	test_cmp expected error
>  }
> diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
> index fa3e499641..8b4cf8a6e3 100755
> --- a/t/t1507-rev-parse-upstream.sh
> +++ b/t/t1507-rev-parse-upstream.sh
> @@ -28,8 +28,6 @@ test_expect_success 'setup' '
>  	)
>  '
>  
> -sq="'"
> -
>  full_name () {
>  	(cd clone &&
>  	 git rev-parse --symbolic-full-name "$@")
> @@ -129,7 +127,7 @@ test_expect_success 'merge my-side@{u} records the correct name' '
>  	git branch -t new my-side@{u} &&
>  	git merge -s ours new@{u} &&
>  	git show -s --pretty=tformat:%s >actual &&
> -	echo "Merge remote-tracking branch ${sq}origin/side${sq}" >expect &&
> +	echo "Merge remote-tracking branch ${SQ}origin/side${SQ}" >expect &&
>  	test_cmp expect actual
>  )
>  '
> @@ -156,7 +154,7 @@ test_expect_success 'branch@{u} works when tracking a local branch' '
>  
>  test_expect_success 'branch@{u} error message when no upstream' '
>  	cat >expect <<-EOF &&
> -	fatal: no upstream configured for branch ${sq}non-tracking${sq}
> +	fatal: no upstream configured for branch ${SQ}non-tracking${SQ}
>  	EOF
>  	error_message non-tracking@{u} &&
>  	test_i18ncmp expect error
> @@ -164,7 +162,7 @@ test_expect_success 'branch@{u} error message when no upstream' '
>  
>  test_expect_success '@{u} error message when no upstream' '
>  	cat >expect <<-EOF &&
> -	fatal: no upstream configured for branch ${sq}master${sq}
> +	fatal: no upstream configured for branch ${SQ}master${SQ}
>  	EOF
>  	test_must_fail git rev-parse --verify @{u} 2>actual &&
>  	test_i18ncmp expect actual
> @@ -172,7 +170,7 @@ test_expect_success '@{u} error message when no upstream' '
>  
>  test_expect_success 'branch@{u} error message with misspelt branch' '
>  	cat >expect <<-EOF &&
> -	fatal: no such branch: ${sq}no-such-branch${sq}
> +	fatal: no such branch: ${SQ}no-such-branch${SQ}
>  	EOF
>  	error_message no-such-branch@{u} &&
>  	test_i18ncmp expect error
> @@ -189,7 +187,7 @@ test_expect_success '@{u} error message when not on a branch' '
>  
>  test_expect_success 'branch@{u} error message if upstream branch not fetched' '
>  	cat >expect <<-EOF &&
> -	fatal: upstream branch ${sq}refs/heads/side${sq} not stored as a remote-tracking branch
> +	fatal: upstream branch ${SQ}refs/heads/side${SQ} not stored as a remote-tracking branch
>  	EOF
>  	error_message bad-upstream@{u} &&
>  	test_i18ncmp expect error
> diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
> index 209b4c7cd8..c841f9b454 100755
> --- a/t/t3005-ls-files-relative.sh
> +++ b/t/t3005-ls-files-relative.sh
> @@ -9,7 +9,6 @@ This test runs git ls-files with various relative path arguments.
>  
>  new_line='
>  '
> -sq=\'
>  
>  test_expect_success 'prepare' '
>  	: >never-mind-me &&
> @@ -44,9 +43,9 @@ test_expect_success 'ls-files -c' '
>  		cd top/sub &&
>  		for f in ../y*
>  		do
> -			echo "error: pathspec $sq$f$sq did not match any file(s) known to git"
> +			echo "error: pathspec $SQ$f$SQ did not match any file(s) known to git"
>  		done >expect.err &&
> -		echo "Did you forget to ${sq}git add${sq}?" >>expect.err &&
> +		echo "Did you forget to ${SQ}git add${SQ}?" >>expect.err &&
>  		ls ../x* >expect.out &&
>  		test_must_fail git ls-files -c --error-unmatch ../[xy]* >actual.out 2>actual.err &&
>  		test_cmp expect.out actual.out &&
> @@ -59,9 +58,9 @@ test_expect_success 'ls-files -o' '
>  		cd top/sub &&
>  		for f in ../x*
>  		do
> -			echo "error: pathspec $sq$f$sq did not match any file(s) known to git"
> +			echo "error: pathspec $SQ$f$SQ did not match any file(s) known to git"
>  		done >expect.err &&
> -		echo "Did you forget to ${sq}git add${sq}?" >>expect.err &&
> +		echo "Did you forget to ${SQ}git add${SQ}?" >>expect.err &&
>  		ls ../y* >expect.out &&
>  		test_must_fail git ls-files -o --error-unmatch ../[xy]* >actual.out 2>actual.err &&
>  		test_cmp expect.out actual.out &&
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 461dd539ff..9c152b6245 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1419,7 +1419,6 @@ test_expect_success 'editor saves as CR/LF' '
>  	)
>  '
>  
> -SQ="'"
>  test_expect_success 'rebase -i --gpg-sign=<key-id>' '
>  	test_when_finished "test_might_fail git rebase --abort" &&
>  	set_fake_editor &&
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index 7b6c4847ad..11141ac864 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -151,7 +151,6 @@ test_expect_success 'failed `merge -C` writes patch (may be rescheduled, too)' '
>  	test_path_is_file .git/rebase-merge/patch
>  '
>  
> -SQ="'"
>  test_expect_success 'failed `merge <branch>` does not crash' '
>  	test_when_finished "test_might_fail git rebase --abort" &&
>  	git checkout conflicting-G &&
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 4a3b901f06..3be025a658 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -434,7 +434,6 @@ test_expect_success 'double quoted plink.exe in GIT_SSH_COMMAND' '
>  	expect_ssh "-v -P 123" myhost src
>  '
>  
> -SQ="'"
>  test_expect_success 'single quoted plink.exe in GIT_SSH_COMMAND' '
>  	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink.exe" &&
>  	GIT_SSH_COMMAND="$SQ$TRASH_DIRECTORY/plink.exe$SQ -v" \
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index c973278300..df34c994d2 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -158,7 +158,6 @@ test_expect_success 'submodule update --init from and of subdirectory' '
>  	test_i18ncmp expect2 actual2
>  '
>  
> -apos="'";
>  test_expect_success 'submodule update does not fetch already present commits' '
>  	(cd submodule &&
>  	  echo line3 >> file &&
> @@ -168,7 +167,7 @@ test_expect_success 'submodule update does not fetch already present commits' '
>  	) &&
>  	(cd super/submodule &&
>  	  head=$(git rev-parse --verify HEAD) &&
> -	  echo "Submodule path ${apos}submodule$apos: checked out $apos$head$apos" > ../../expected &&
> +	  echo "Submodule path ${SQ}submodule$SQ: checked out $SQ$head$SQ" > ../../expected &&
>  	  git reset --hard HEAD~1
>  	) &&
>  	(cd super &&
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index a9d45642a5..ee602c4d9c 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -509,6 +509,9 @@ EMPTY_BLOB=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
>  LF='
>  '
>  
> +# Single quote
> +SQ=\'
> +
>  # UTF-8 ZERO WIDTH NON-JOINER, which HFS+ ignores
>  # when case-folding filenames
>  u200c=$(printf '\342\200\214')
> -- 
> 2.23.0.37.g745f681289
> 
