Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0B420966
	for <e@80x24.org>; Wed,  5 Apr 2017 21:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755868AbdDEVeA (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 17:34:00 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34818 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752697AbdDEVd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 17:33:59 -0400
Received: by mail-pg0-f68.google.com with SMTP id g2so3805508pge.2
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 14:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nooIPPz7AHHb8dmFucrAyANBoec+L7CS5neX3VCK5os=;
        b=RrYu9WndROZJB7UtuG0u3tw2EGyuwgf8+hwNGD/pVeXS45I40rqsm7b8sSaWKplLtY
         DTaDzvhpfUnw7/nlV4lMhhipU0xxThEVYNzem7jRB76GeVGVUDCc2mohiJzryNj6nsrh
         FdHqElShsMzJiTpXZV5FJkx9xjhb5geRYviu9sTGi3vnOxlWTBWLtw6FOS3dNE9PrtvA
         L6uZ8vbUR3kEMGCG8byJX1bAkGPdyAjltoUBvwp+hdRI2OgH/0ItulUzgPzWn7cG+T3M
         1t7aL+IYMoTQuEdEj0iyEePacVZYGmDubZgGQVtfAvT00g9JsS4DROj7NPxhYFDzOpxL
         ps7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nooIPPz7AHHb8dmFucrAyANBoec+L7CS5neX3VCK5os=;
        b=Ueg0egS0mLwOY36yCEqaUAav+sm5imzrvaNBI4WoKzANa3l0Wz4uxtWdTd2eSIsUFv
         TaCqk9C952BttKHEG2cN4hU8kubkoTsXqozX8HfrFk3x2wb0um1YB+OwaQ/JQrBNQQnj
         /6ZAw4KNKIyads33DvG4Kw6TvOG/qnkQoBRaPcmXYW06anPmVmkQE5u19IuRyE9AER3A
         KpIhvOiy2sxuebjrhNiyorVuqIkHfFpcHV8GiJjiqnl7OIuFjpuavIOna8Xn80FUYTa9
         F8SU5Y2fXcdx+MgrJLWkcnvNPAIaTn/73nejO3y7GhTj5a9VNdOuO8QIMk0P49lfFl0O
         oQZw==
X-Gm-Message-State: AFeK/H2n8ne9QUWgudcHE/ZYtiNVMMR6jhqLPzMXzX4q0myF0b4w3/Oi9lIF0Q5s2bL/mQ==
X-Received: by 10.84.130.99 with SMTP id 90mr39180573plc.94.1491428038197;
        Wed, 05 Apr 2017 14:33:58 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:55a8:b4cb:debd:758b])
        by smtp.gmail.com with ESMTPSA id l1sm39228333pfk.8.2017.04.05.14.33.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 14:33:57 -0700 (PDT)
Date:   Wed, 5 Apr 2017 14:33:55 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 2/2] p0005-status: time status on very large repo
Message-ID: <20170405213355.GH8741@aiede.mtv.corp.google.com>
References: <20170405195600.54801-1-git@jeffhostetler.com>
 <20170405195600.54801-3-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170405195600.54801-3-git@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git@jeffhostetler.com wrote:

> +++ b/t/perf/p0005-status.sh
> @@ -0,0 +1,70 @@
> +#!/bin/sh
> +
> +test_description="Tests performance of read-tree"
> +
> +. ./perf-lib.sh
> +
> +test_perf_default_repo
> +test_checkout_worktree
> +
> +## usage: dir depth width files
> +make_paths () {
> +	for f in $(seq $4)
> +	do
> +		echo $1/file$f
> +	done;
> +	if test $2 -gt 0;
> +	then
> +		for w in $(seq $3)
> +		do
> +			make_paths $1/dir$w $(($2 - 1)) $3 $4
> +		done
> +	fi
> +	return 0
> +}
> +
> +fill_index () {
> +	make_paths $1 $2 $3 $4 |
> +	sed "s/^/100644 $EMPTY_BLOB	/" |
> +	git update-index --index-info
> +	return 0
> +}

Makes sense.

> +
> +br_work1=xxx_work1_xxx
> +
> +new_dir=xxx_dir_xxx
> +
> +## (5, 10, 9) will create 999,999 files.
> +## (4, 10, 9) will create  99,999 files.
> +depth=5
> +width=10
> +files=9
> +
> +export br_work1
> +
> +export new_dir
> +
> +export depth
> +export width
> +export files

Why are these exported?  test_expect_success code (unlike test_per
code) runs in the same shell as outside, so it doesn't seem necessary.

> +
> +## Inflate the index with thousands of empty files and commit it.
> +test_expect_success 'inflate the index' '
> +	git reset --hard &&

What does this line do?

> +	git branch $br_work1 &&
> +	git checkout $br_work1 &&

Is it useful for these parameters to exist in the test script?  I'd
find this easier to read if it named the branch explicitly.  For
example:

	test_expect_success 'set up large index' '
		git checkout -B million &&
		# (4, 10, 9) would create 99,999 files.
		# (5, 10, 9) creates 999,999 files.
		fill_index dir 5 10 9 &&
		git commit -m "large commit"
	'

> +	fill_index $new_dir $depth $width $files &&
> +	git commit -m $br_work1 &&
> +	git reset --hard

What does this line do?

> +'
> +
> +## The number of files in the xxx_work1_xxx branch.
> +nr_work1=$(git ls-files | wc -l)
> +export nr_work1
> +
> +test_perf "read-tree status work1 ($nr_work1)" '
> +	git read-tree HEAD &&
> +	git status
> +'

Looks reasonable.

Thanks and hope that helps,
Jonathan
