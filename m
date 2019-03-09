Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7843B20248
	for <e@80x24.org>; Sat,  9 Mar 2019 16:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfCIQpN (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 11:45:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37831 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfCIQpN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 11:45:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so540227wmg.2
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 08:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=viEvVlVEK3JbTFLOnXGFu3D7PdhSB64lP2qnL5CkX0U=;
        b=badejTU3jpjyBV+COUzJFGmcFGpV5ey1ZlMsx+1ObKc5YNBtLdyHauhmtR/GHadoaP
         yw8J2GtROx29IbDacr+qBV7OyE1vEM9SQO/AyjdXnFZMx/jdrl+0YwDSfFvcEPtZcmCC
         HM7HT+kYIHe/ZHjljKhFUNeKqcEnej3S0uPC1/sIA5HWFdQrT/uvV3VXy8YY/EE3cMD5
         dLUGnH+GFPIJn6pHi9tiz8otWFGxVgI6CL8HuQEL3zXyO4hqzhttUM/rEr3tnJTBPZxz
         ND5hcgwkw2MjSTo1S9Joe1vINzLg/GuzZ/KQ4NzOpnJGObzBKnjHW+/s33mGg4/5YE7E
         2Xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=viEvVlVEK3JbTFLOnXGFu3D7PdhSB64lP2qnL5CkX0U=;
        b=uma7PT1ppneQNC3qBAzuZ3Gj8eElySg32TXUjoizNqZlZxnJqO2QGxRXdNgDGxA0+X
         0DPHqJBNoDZYtDeeB+u/1yR1MmxrCX0oSX+LvB/XdKqXNQOnYVVaxzn7AHkBvJBzHBT0
         82JOACimfrgK2DORgrppNn89kue0XfGup01ucgdeIgnZxjMcON5p+VvVeVX0IQrMtBb0
         GZOLKqIeo0L/afJMD77GUMczaN8OSCZPst0WIHC7eTVVTTD1fjx7pxQvnEVvUVdPOQL/
         EyWJKb1pAHuCvT1GKyKj7iMiuaFTl6CevKR2Mo2wSd127koH8H4UOoFAxcjlLNw/44nu
         /f9A==
X-Gm-Message-State: APjAAAU59SzrMLQybRx+jK+FNkb7Qjc98Vgc75Cnfsg5Ragvhi+RiuCx
        521YokbCTjRm1LmNpxamTR4=
X-Google-Smtp-Source: APXvYqx73Ev4C0rJEYOtTlsK73e/Hw7Rgf8bntXo12UiZFrT7Pa9Be8jYe9cwyVCIa6VnBtDlrH8yg==
X-Received: by 2002:a1c:9684:: with SMTP id y126mr12802781wmd.124.1552149910040;
        Sat, 09 Mar 2019 08:45:10 -0800 (PST)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id w24sm6221005wmi.40.2019.03.09.08.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 08:45:08 -0800 (PST)
Date:   Sat, 9 Mar 2019 16:45:08 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jonathan Chang <ttjtftx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH] tests: avoid using pipes
Message-ID: <20190309164508.GB31533@hank.intra.tgummerer.com>
References: <20190309154555.33407-1-ttjtftx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309154555.33407-1-ttjtftx@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

welcome and thanks for the patch!

On 03/09, Jonathan Chang wrote:
> This is my attempt for this year's GSoC microproject.
> 
> I copied the commit message of the commit[1] mentioned in the microproject
> page[2]. Is this OK?
> 
> Here is a summary of what I did:
> 	- simple substitution as in c6f44e1da5[1]. 
> 	- besides simple substitution, I moved some git command out of command 
> 		substitution to improve readability, which was not possible with pipes, 
> 		while in these cases keeping them inside won't discard git's exit code.
> 	- use actual1 and actual2 in cases where actual is already in use.
> 	- use `sort -o actual actual` to avoid using actual1 and actual2.
> 
> [1] c6f44e1da5 ("t9813: avoid using pipes", 2017-01-04)
> [2] https://git.github.io/SoC-2019-Microprojects/
> 
> ---------------------->8-------------------
> The exit code of the upstream in a pipe is ignored thus we should avoid
> using it. By writing out the output of the git command to a file, we can
> test the exit codes of both the commands.
> 
> Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
> ---
>  t/t0000-basic.sh       | 28 ++++++++++++++--------------
>  t/t0003-attributes.sh  | 13 ++++++++-----
>  t/t0022-crlf-rename.sh |  6 +++---
>  3 files changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index b6566003dd..adc9545973 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -1118,27 +1118,25 @@ P=$(test_oid root)
>  
>  test_expect_success 'git commit-tree records the correct tree in a commit' '
>  	commit0=$(echo NO | git commit-tree $P) &&
> -	tree=$(git show --pretty=raw $commit0 |
> -		 sed -n -e "s/^tree //p" -e "/^author /q") &&
> +	git show --pretty=raw $commit0 >actual &&
> +	tree=$(sed -n -e "s/^tree //p" -e "/^author /q" actual) &&
>  	test "z$tree" = "z$P"
>  '
>  
>  test_expect_success 'git commit-tree records the correct parent in a commit' '
>  	commit1=$(echo NO | git commit-tree $P -p $commit0) &&
> -	parent=$(git show --pretty=raw $commit1 |
> -		sed -n -e "s/^parent //p" -e "/^author /q") &&
> +	git show --pretty=raw $commit1 >actual &&
> +	parent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual) &&
>  	test "z$commit0" = "z$parent"
>  '
>  
>  test_expect_success 'git commit-tree omits duplicated parent in a commit' '
>  	commit2=$(echo NO | git commit-tree $P -p $commit0 -p $commit0) &&
> -	     parent=$(git show --pretty=raw $commit2 |

This line is a bit oddly indented.  This is of course not something
you did, but it did leave me puzzled why the indentation was here
before and if the conversion is actually correct.  To help reviewers,
it would be nice to fix the indentation of this line in a preparatory
patch, and clarify since when this indentation was there and that it
is not correct.

That is if I'm not missing something, and there is not actually a
good reason for this to be indented, but judging from the original and
the conversion in this commit, I don't think there is.

> -		sed -n -e "s/^parent //p" -e "/^author /q" |
> -		sort -u) &&
> +	git show --pretty=raw $commit2 >actual &&
> +	parent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | sort -u) &&
>  	test "z$commit0" = "z$parent" &&
> -	numparent=$(git show --pretty=raw $commit2 |
> -		sed -n -e "s/^parent //p" -e "/^author /q" |
> -		wc -l) &&
> +	git show --pretty=raw $commit2 >actual &&
> +	numparent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | wc -l) &&
>  	test $numparent = 1
>  '
>  
> @@ -1147,7 +1145,8 @@ test_expect_success 'update-index D/F conflict' '
>  	mv path2 path0 &&
>  	mv tmp path2 &&
>  	git update-index --add --replace path2 path0/file2 &&
> -	numpath0=$(git ls-files path0 | wc -l) &&
> +	git ls-files path0 >actual &&
> +	numpath0=$(wc -l actual) &&

This test is actually failing now (and so is the one just below).  The
reason is that 'wc -l <file>' outputs the number of lines followed by
the filename, so numpath0 includes that.

We have a helper function that avoids exactly that,
'test_line_count'.  See t/README or t/test-lib-functions.sh for more
information on that function.

Before submitting a patch series, please also run the test suite, or
if you are only modifying tests such as in this case, at least the
tests that are modified.

>  	test $numpath0 = 1
>  '
>  
> @@ -1162,12 +1161,13 @@ test_expect_success 'very long name in the index handled sanely' '
>  	>path4 &&
>  	git update-index --add path4 &&
>  	(
> -		git ls-files -s path4 |
> -		sed -e "s/	.*/	/" |
> +		git ls-files -s path4 >actual &&
> +		sed -e "s/	.*/	/" actual |
>  		tr -d "\012" &&
>  		echo "$a"
>  	) | git update-index --index-info &&
> -	len=$(git ls-files "a*" | wc -c) &&
> +	git ls-files "a*" >actual &&
> +	len=$(wc -c actual) &&
>  	test $len = 4098
>  '
>  
> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index 71e63d8b50..14274f1ced 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -203,15 +203,18 @@ test_expect_success 'attribute test: read paths from stdin' '
>  test_expect_success 'attribute test: --all option' '
>  	grep -v unspecified <expect-all | sort >specified-all &&
>  	sed -e "s/:.*//" <expect-all | uniq >stdin-all &&
> -	git check-attr --stdin --all <stdin-all | sort >actual &&
> +	git check-attr --stdin --all <stdin-all >actual &&
> +	sort -o actual actual &&
>  	test_cmp specified-all actual
>  '
>  
>  test_expect_success 'attribute test: --cached option' '
> -	git check-attr --cached --stdin --all <stdin-all | sort >actual &&
> +	git check-attr --cached --stdin --all <stdin-all >actual &&
> +	sort -o actual actual &&
>  	test_must_be_empty actual &&
>  	git add .gitattributes a/.gitattributes a/b/.gitattributes &&
> -	git check-attr --cached --stdin --all <stdin-all | sort >actual &&
> +	git check-attr --cached --stdin --all <stdin-all >actual &&
> +	sort -o actual actual &&
>  	test_cmp specified-all actual
>  '
>  
> @@ -301,8 +304,8 @@ test_expect_success 'bare repository: check that --cached honors index' '
>  	(
>  		cd bare.git &&
>  		GIT_INDEX_FILE=../.git/index \
> -		git check-attr --cached --stdin --all <../stdin-all |
> -		sort >actual &&
> +		git check-attr --cached --stdin --all <../stdin-all >actual &&
> +		sort -o actual actual &&
>  		test_cmp ../specified-all actual
>  	)
>  '
> diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
> index 7af3fbcc7b..b4772b72f7 100755
> --- a/t/t0022-crlf-rename.sh
> +++ b/t/t0022-crlf-rename.sh
> @@ -23,10 +23,10 @@ test_expect_success setup '
>  
>  test_expect_success 'diff -M' '
>  
> -	git diff-tree -M -r --name-status HEAD^ HEAD |
> -	sed -e "s/R[0-9]*/RNUM/" >actual &&
> +	git diff-tree -M -r --name-status HEAD^ HEAD >actual1 &&
> +	sed -e "s/R[0-9]*/RNUM/" actual1 >actual2 &&

Nit: rather than actual1 and actual2, it might be nice to give the
files slightly more meaningful names, maybe "output" and "normalized",
but feel free to try and come up with something better than that.

>  	echo "RNUM	sample	elpmas" >expect &&
> -	test_cmp expect actual
> +	test_cmp expect actual2
>  
>  '
>  
> -- 
> 2.21.0
> 
