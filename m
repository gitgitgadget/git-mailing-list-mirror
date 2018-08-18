Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 824C71F954
	for <e@80x24.org>; Sat, 18 Aug 2018 16:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeHRTVO (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 15:21:14 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:39605 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRTVO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 15:21:14 -0400
Received: by mail-wm0-f46.google.com with SMTP id q8-v6so9997846wmq.4
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OsrasvmqnzAXEHnq9jGHDoDg0UUeUL8xr2Q3i+NjSS0=;
        b=X53Mv8zTbbmf3iK68azq8cGAwAqXWvvnJA4XpgOaY0mpxMyCx8ujlXWPjpom+5gt8N
         yvfB1Ih5amyyN0AT8AiYEAl0GIIwFrLCDCT3/acDMrOSHKjnERisWwwlkvgUlM6h6UG/
         nhYhBUcNxyxpKrG1562LnM59wOKVMwhincxBfVn2s1TISKLXxjoeoHCYjHYmfg+mXa5j
         PMmOsxGlZoAt6VLG+MZhboEpjf8eZTI48MAKMNP0nC2yBzN2XBurV3dD3XCp7MnUuWZX
         oizfGzt9c0vA6S2ux4HhpsjxVB1m73gQWgBy9fVW2y5okZCucc7+2w0b2fg6+4QjeS60
         ov8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OsrasvmqnzAXEHnq9jGHDoDg0UUeUL8xr2Q3i+NjSS0=;
        b=fJx1hY7Jm55RvuxOUIj0seL+ruBI514MZBY2M3dbgXOWlUcEXiaODgkklW3c+HwvcI
         tj03AUBIHa0Q3SH0srkXSGLJd1SZz1aClCQYtOHTuWov8vq6CpuD/LX246TjrUcC2nUg
         idsU+9M1/Iyge+UPiHb3Yb48z13NYv3ZjYESScYZiWvAaoNH37j+AaNW3JHesfWYh8s2
         9pOaGB6h+tz1p0JPfI7q2wCta2/T20C3wLE1x6YHynBqZURr2Bv0DdaI+8T+cQnOQPtd
         5T3GhoHZVf1urWTznfdsNghCnXA5o6A+zM/WLhHePeqoRVlkqEOW/igZ+vDkspll5zZL
         nKNA==
X-Gm-Message-State: AOUpUlF+j2HStNQAiIhY/UjXUEjFxTL+looBKiF3nqs20RK11Bc7e95M
        Ac/4daAD8VQ44FaNGnMgsTA=
X-Google-Smtp-Source: AA+uWPx7pFWGBiWLdglThEfJn7CGP6MkJofKI4KQnWmRX5kbH+P1/xt/UhGJkweGtupKS+H9aeO/ZQ==
X-Received: by 2002:a1c:e70b:: with SMTP id e11-v6mr20488702wmh.22.1534608779326;
        Sat, 18 Aug 2018 09:12:59 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id d123-v6sm6732756wmd.9.2018.08.18.09.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 09:12:58 -0700 (PDT)
Date:   Sat, 18 Aug 2018 17:12:57 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 20/26] stash: add tests for `git stash push -q`
Message-ID: <20180818161257.GD11326@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <5ec3429340f43caad79e4213a7994738cb5d33c7.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ec3429340f43caad79e4213a7994738cb5d33c7.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Paul-Sebastian Ungureanu wrote:
> This commit introduces more tests for the quiet option of
> `git stash push`.

I think this commit should be squashed into the previous one, so we
have implementation and tests in one commit.  That way it's easier to
see during review that there are tests for the change.  For more
discussion on that also see [1].

[1]: https://public-inbox.org/git/20180806144726.GB97564@aiede.svl.corp.google.com/

> ---
>  t/t3903-stash.sh | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 8d002a7f2..b78db74ae 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1064,6 +1064,27 @@ test_expect_success 'push: <pathspec> not in the repository errors out' '
>  	test_path_is_file untracked
>  '
>  
> +test_expect_success 'push: -q is quiet with changes' '
> +	>foo &&
> +	git stash push -q >output 2>&1 &&

We create an untracked file here and then call 'git stash push', which
will not create a new stash, as we don't use the --include-untracked
option.  In fact, right now this test is doing the same thing as the
test below.  There should be a 'git add foo' above the 'git stash
push' call to test what we're claiming to test here.

> +	test_must_be_empty output
> +'
> +
> +test_expect_success 'push: -q is quiet with no changes' '
> +	git stash push -q >output 2>&1 &&
> +	test_must_be_empty output
> +'
> +
> +test_expect_success 'push: -q is quiet even if there is no initial commit' '
> +	git init foo_dir &&
> +	cd foo_dir &&
> +	touch bar &&

The typical style in the test suite for creating a new file is to use
'>bar', unless you care about the 'mtime' the file has.  We don't seem
to care about that in this test, so avoiding 'touch' would be better.

> +	test_must_fail git stash push -q >output 2>&1 &&
> +	test_must_be_empty output &&
> +	cd .. &&

The above should be in a subshell, i.e.

    (
        cd foo_dir &&
	touch bar &&
        test_must_fail git stash push -q >output 2>&1 &&
        test_must_be_empty output &&
    )

then you don't have to do the 'cd ..' in the end.  With the 'cd ..' in
the end, if one of the commands between the 'cd foo_dir' and 'cd ..'
fails, all subsequent tests will be run inside of 'foo_dir', which
puts them in a different environment than they expect.  That can cause
all kinds of weirdness.

If inside a subshell, the current working directory of the parent
shell is unaffected, so we don't have to worry about cd'ing back, and
subsequent tests will get the correct cwd even if things go wrong in
this test.
	

> +	rm -rf foo_dir

We'll want to run this cleanup to run even if the test fails.  To do
so, the 'test_when_finished' helper can be used.  Using that, this
would go at the top of the test, as 'test_when_finished rm -rf
foo_dir'.  Otherwise if any of the commands above fail, 'foo_dir' will
not be removed, and may interfere with subsequent tests.

> +'
> +
>  test_expect_success 'untracked files are left in place when -u is not given' '
>  	>file &&
>  	git add file &&
> -- 
> 2.18.0.573.g56500d98f
> 
