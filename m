Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1BF620248
	for <e@80x24.org>; Fri, 15 Mar 2019 23:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfCOXFT (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 19:05:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35956 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCOXFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 19:05:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so6641751wrd.3
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 16:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4+uwUa0oS0XaKtrdieG+fzCiZtxWY8BMmBu8oaVc/Cw=;
        b=es5glH5U/pe3ruikOceA9CC9uV9w2b1xIRVYUVvJ9zV9RxtLWi7TNCUxq2wR9xVf2b
         Y12eWPoJSJxBqcSIOUWkLSj7lQIDGeOSSncuKaOs0BS+R5ab1/VLZ0axa3wX/C1xqzns
         0sJmZ+udo3zu57WXFxgMWGXV/SpMH2gTXPgKEWItwb0Q2PA45ImELPaN+Fxs0YImpRmB
         AW+zlTUlum3OFn8LJH9VKgJ+wPB9Jy1DFy63WoyTjvrXPyEHxJVxlEVy3ZGIchWwcawT
         yjIUeLj1FtLVPwKWFsydAXjC1pXdNAekVGQ80d3xamwtMjLk+3g8M4l68w5nBY+mgRTt
         kgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4+uwUa0oS0XaKtrdieG+fzCiZtxWY8BMmBu8oaVc/Cw=;
        b=M3KIFd0ACpG5VqaXWv0UPqm7yiwKjIADUv3vYlSGvZGFA7ek0R6HgSY3f4rUhdms/V
         UdVJ05GTuKJrIH2zMMGYeciMQM9BfLsQb1Czz8sS52ZoyTBMQCGFqManINvXEuxnVif2
         By8MbV+AIqxsOR5NZw/XW37KtqKOnJ39PPKHfbmOkoMF6ELclkiekGnWgPCMiuvJSX5I
         RpM3kRUoeW2I4wPkuLFVAGD4dKb2KnE0bz0qF6/TsjD4EqBSny+/KKLL5jOWHgj/ikfk
         6mrVH0fi+iRyw7B4DGRrL/Q5kLGbU0BuzgKmZjtKCv67QZc3J3m7uDokFIFSyd0VvLjo
         Emkg==
X-Gm-Message-State: APjAAAX/Yg3IFcsXyc7C/2li6ouTxCm1j1WoJbyun+2jvmiEuUddNeUl
        gP6g45Jhjf0EDTJT7rx4Lcsvyuni
X-Google-Smtp-Source: APXvYqwZmKTKOpZTjgm+8sNqNBIyY9c9DyD8vBF+vlUx4/hO30tNNGCUrwQMHTZNp9cAx714kuMyhg==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr3862310wrn.21.1552691117668;
        Fri, 15 Mar 2019 16:05:17 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id q19sm3288723wmq.23.2019.03.15.16.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 16:05:16 -0700 (PDT)
Date:   Fri, 15 Mar 2019 23:05:15 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     jkapil.cs@gmail.com
Cc:     git@vger.kernel.org, alban.gruin@gmail.com, avarab@gmail.com
Subject: Re: [GSoC][RFC/PATCH 1/1] userdiff - support shell script
Message-ID: <20190315230515.GJ16414@hank.intra.tgummerer.com>
References: <20190315150142.20672-1-jkapil.cs@gmail.com>
 <20190315150142.20672-2-jkapil.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315150142.20672-2-jkapil.cs@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: [GSoC][RFC/PATCH 1/1] userdiff - support shell script

We usually have the subject in the format "<area>: <short
explanation>", so in this case it could be "userdiff: support shell
script" (without the quotes of course).

On 03/15, jkapil.cs@gmail.com wrote:
> From: Kapil <jkapil.cs@gmail.com>

Ideally the name you are using for your contribution should be your
full name, including your last name.

> Made a minor change of adding regex for identifying functions in shell scripts.

The commit message should be in the imperative mood, see also
Documentation/SubmittingPatches.  In addition the "minor change" bit
should be omitted, as it doesn't add any actual value to the commit
message.

So the above should just be "Add regex for identifying functions in
shell scripts".

> This regex has been tested separately from git.
> For testing with git, please let me know.

For testing you could have a look how other userdiff drivers are
tested in t4034.  The easiest way is probably to have a look at a
patch for a userdiff pattern that was added previously.  For example
have a look at 0719f3eecd ("userdiff: add built-in pattern for CSS",
2016-06-03).  (I found this commit by looking at the git blame output
for t4034.)

Both the two lines above and the line below should go below the ---
line, as they should not be part of the history in the git project,
but serve only as additional commentary for reviewers looking at this
patch.

> This is just to get familiar with whole workflow, regex for word_regex parameter will be added in next patch.

There should be a Signed-off-by: line here.  For its significance
please see Documentation/SubmittingPatches.

Another thing you should consider is whether someone attempted to add
support for this before.  And indeed a quick search through
public-inbox turns up [*1*].  It's always worth having a look at
previous work, and things that can be learned from that.

*1*: https://public-inbox.org/git/20170329165331.17742-1-pickfire@riseup.net/#t

> ---
>  t/t4018-diff-funcname.sh | 1 +
>  t/t4034-diff-words.sh    | 1 +
>  userdiff.c               | 5 +++++
>  3 files changed, 7 insertions(+)
> 
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index 22f9f88f0a..68092eaeaa 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -44,6 +44,7 @@ diffpatterns="
>  	python
>  	ruby
>  	tex
> +	shell
>  	custom1
>  	custom2
>  	custom3
> diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
> index 912df91226..de21f36d97 100755
> --- a/t/t4034-diff-words.sh
> +++ b/t/t4034-diff-words.sh
> @@ -314,6 +314,7 @@ test_language_driver php
>  test_language_driver python
>  test_language_driver ruby
>  test_language_driver tex
> +test_language_driver shell
>  
>  test_expect_success 'word-diff with diff.sbe' '
>  	cat >expect <<-\EOF &&
> diff --git a/userdiff.c b/userdiff.c
> index 3a78fbf504..1743608da2 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -170,6 +170,11 @@ IPATTERN("css",
>  	 "-?[_a-zA-Z][-_a-zA-Z0-9]*" /* identifiers */
>  	 "|-?[0-9]+|\\#[0-9a-fA-F]+" /* numbers */
>  ),
> +
> +PATTERNS("shell",
> +	"([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*\\([[:space:]]*\\)[[:space:]]*\\{[[:space:]\\(\\)|\\[<>?`/~!:\'\"%^&*+A-Za-z0-9_$=@;#,.-]*\\}",
> +	".*"
> +),
>  { "default", NULL, -1, { NULL, 0 } },
>  };
>  #undef PATTERNS
> -- 
> 2.14.2
> 
