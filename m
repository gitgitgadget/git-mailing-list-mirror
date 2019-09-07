Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0E21F461
	for <e@80x24.org>; Sat,  7 Sep 2019 23:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393417AbfIGX20 (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 19:28:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39336 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfIGX2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 19:28:25 -0400
Received: by mail-io1-f65.google.com with SMTP id d25so20901683iob.6
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 16:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2mnc97DqR52vCsJY4LoQoOx4LuFpdct/b3aMbPeBPmI=;
        b=SbBa8k6DkE6NuLw0bWGFUj+cdsHAt5CiTyu0sOSq4DhuUfKchKaReKUERdyQWjFZ9H
         sWlEn6amYjN0gr1lujFngFzXOj/X3Fn7Obrh63csfUXWkOPuUBnSX62tQAg0N7R6U8+K
         kpYbMFhkHIpfcsf1WBe3gyPUokly6Q4pJXidZbetF4zTmaMSW3HUjvCa3JVcRUgot34s
         kTrL9NBszUUeL4HpVCAjOWiGZsH5v1ysGSCpsYTCP7BMjShXz/DvgczMOBSHAbGkcY/v
         EtkLy5VBg1NNWWyh1r7JYQHaCV8+aShDp9vsRXndVaMLCT7lyLBVXsIfLreW+3iEJbt0
         IGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2mnc97DqR52vCsJY4LoQoOx4LuFpdct/b3aMbPeBPmI=;
        b=P6VWM1QAhaO9oNJBlZLgUkuce1Il4+DDSqXT9H8nKr6bNBvnBzi+EpCyhIr7Af+wWx
         ByJb3Fxu5wvo1es5p5dHO0yKZU+rZCF0fZSjMHmQPJJgwpbRHJAhIETllpURkzBVw+KS
         LmqgcngGq5+KZkjJibBvUJlDcSWE7e8RUDTUU6CoGLsBS0VrL2+uK8ZlxyIF4GP0qXLR
         V5oH1xZPXXZjZnMJYhPTI2U7cRMSdnEqEaYnl+uGlg0lPsJplKJDq46MlZOgmd5McbaS
         kGpkm5hTkI1VDgRP3aFoYI97PMIgSBc35ldyHjoYTpDV6S7aH/QhCP6WEMKpi2Qh05ng
         vqDw==
X-Gm-Message-State: APjAAAXuBI3cA0Pl9J3ODVz+Y1fnWmCF+7FuuQgBvhcaGY0MD2dTNpBU
        GF0biKu6wTb9Wmwkx7UtaVTeauaB1UA=
X-Google-Smtp-Source: APXvYqxgdWvlHujfJti/YavF/gy948aBpBiscBjtIDY0QXFkztsu1yocCtSxYci+Z1RKNRxTYJLnpw==
X-Received: by 2002:a6b:fa07:: with SMTP id p7mr18984920ioh.164.1567898904582;
        Sat, 07 Sep 2019 16:28:24 -0700 (PDT)
Received: from localhost ([206.121.37.170])
        by smtp.gmail.com with ESMTPSA id s201sm23308511ios.83.2019.09.07.16.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 16:28:23 -0700 (PDT)
Date:   Sat, 7 Sep 2019 19:28:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Freese <ericdfreese@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] for-each-ref: add '--no-symbolic' option
Message-ID: <20190907232821.GA42449@syl.local>
References: <20190907213646.21231-1-ericdfreese@gmail.com>
 <20190907213646.21231-2-ericdfreese@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190907213646.21231-2-ericdfreese@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sat, Sep 07, 2019 at 03:36:46PM -0600, Eric Freese wrote:
> Using the new flag will omit symbolic refs from the output.
>
> Without this flag, it is possible to get this behavior by using the
> `%(symref)` formatting field name and piping output through grep to
> include only those refs that do not output a value for `%(symref)`, but
> having this flag is more elegant and intention revealing.

Please include a 'Signed-off-by' trailer from yourself in this commit.
You can write one yourself, but instead use 'git commit -s' when
committing.

> ---
>  Documentation/git-for-each-ref.txt | 3 +++
>  builtin/for-each-ref.c             | 4 +++-
>  ref-filter.c                       | 4 ++++
>  ref-filter.h                       | 3 ++-
>  t/t6302-for-each-ref-filter.sh     | 6 ++++++
>  5 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 6dcd39f6f6..be19111510 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -95,6 +95,9 @@ OPTIONS
>  --ignore-case::
>  	Sorting and filtering refs are case insensitive.
>
> +--no-symbolic::
> +	Only list refs that are not symbolic.
> +
>  FIELD NAMES
>  -----------
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 465153e853..b71ab2f135 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -18,7 +18,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
>  	struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
> -	int maxcount = 0, icase = 0;
> +	int maxcount = 0, icase = 0, nosym = 0;

I'm a little timid around a single-bit value prefixed with 'no'. Maybe
it would be clearer as:

  int sym = 1;

...instead of the negated form. Of course, the rest of the readers of
this variable would have to be updated, too, but involving fewer
negations seems like it would only improve the clarity.

>  	struct ref_array array;
>  	struct ref_filter filter;
>  	struct ref_format format = REF_FORMAT_INIT;
> @@ -46,6 +46,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  		OPT_CONTAINS(&filter.with_commit, N_("print only refs which contain the commit")),
>  		OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't contain the commit")),
>  		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
> +		OPT_BOOL(0, "no-symbolic", &nosym, N_("exclude symbolic refs")),

I'm a little bit weary of this "no-" prefixing, but this time for a
different reason. The parse-options API has a built-in "negative" option
to pair with each 'OPT_BOOL'. So, for example, in the line above yours,
it is actually the case that you can run 'git for-each-ref
--ignore-case' just as much as you can run 'git for-each-ref
--no-ignore-case'.

Applying your patch shows that I can write the following:

  $ git for-each-ref --no-no-symbolic

Which is likely unintended. There are two ways that you can go about
this:

  - write this as 'OPT_BOOL(0, "symbolic", ...)', to make sure that the
    option you _actually_ want is the one generated by the complement,
    not the complement's complement.

  - or, pass 'PARSE_OPT_NONEG' to tell the parse-options API not to
    generate the complement in the first place.

I'd lean towards the former, at the peril of having a meaningless
default option (i.e., passing '--symbolic' is wasteful, since
'--symbolic' is implied by its default value). But, there are certainly
counter-examples, which you can find with

  $ git grep 'OPT_BOOL(.*\"no-'

So, I'd be curious to hear about the thoughts of others.

>  		OPT_END(),
>  	};
>
> @@ -72,6 +73,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  		sorting = ref_default_sorting();
>  	sorting->ignore_case = icase;
>  	filter.ignore_case = icase;
> +	filter.no_symbolic = nosym;
>
>  	filter.name_patterns = argv;
>  	filter.match_as_path = 1;
> diff --git a/ref-filter.c b/ref-filter.c
> index f27cfc8c3e..01beb279dc 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2093,6 +2093,10 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>  		return 0;
>  	}
>
> +	if (filter->no_symbolic && flag & REF_ISSYMREF) {
> +		return 0;
> +	}
> +

In Documentation/CodingGuidelines, we avoid braces around single-line
if-statements.

>  	/* Obtain the current ref kind from filter_ref_kind() and ignore unwanted refs. */
>  	kind = filter_ref_kind(filter, refname);
>  	if (!(kind & filter->kind))
> diff --git a/ref-filter.h b/ref-filter.h
> index f1dcff4c6e..23e0d01a33 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -65,7 +65,8 @@ struct ref_filter {
>  	unsigned int with_commit_tag_algo : 1,
>  		match_as_path : 1,
>  		ignore_case : 1,
> -		detached : 1;
> +		detached : 1,
> +		no_symbolic : 1;
>  	unsigned int kind,
>  		lines;
>  	int abbrev,
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 35408d53fd..ab9c00fff4 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -454,4 +454,10 @@ test_expect_success 'validate worktree atom' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'filtering with --no-symbolic' '
> +	git symbolic-ref refs/symbolic refs/heads/master &&
> +	git for-each-ref --format="%(refname)" --no-symbolic >actual &&
> +	test_must_fail grep refs/symbolic actual

This style is uncommon, and instead it is preferred to write:

  ! grep refs/symbolic actual

Since 'test_must_fail' also catches segfaults, whereas '!' does not.
Since we'd like this test to fail if/when grep segfaults, use of the
later is preferred here.

> +'
> +
>  test_done
> --
> 2.23.0

Thanks,
Taylor
