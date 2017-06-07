Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C88051FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 17:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbdFGRkD (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 13:40:03 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36315 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbdFGRkC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 13:40:02 -0400
Received: by mail-pf0-f181.google.com with SMTP id x63so8036854pff.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 10:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+fgj0zn8+V7F3awy8vHiNjGVXFnEkd1bXRB994sQW18=;
        b=dVTLoHHKsjvdStMEgvoHKqsa0rRTEuI2UVypabTMJje/Gwzhgxjs1tvy2Kp30fFgUL
         93Tfvm1wLU08nDl6M9sTjcxWwh2xC+huhnKDevL2OK30ztYCXgophG+jZiaX3pwyOHnU
         5PSWQhn3CyVTVasXfkcaH+suwxev56Scg8m7InxC1gL860QtBnMi5nOs9SYNymtKy6iz
         Qbg3HCi+05AP0g6dhK0GK5z7Pu+cviJPILE4lmeee7PbPKxyE3lmBvJBmG0As560DdtI
         6UmfFI0PLFt9ZaxCs2ZA70vm6TvcdROv4sj8ptTN/s97RznLuJEbnl5HrJNhwORP4czm
         pJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+fgj0zn8+V7F3awy8vHiNjGVXFnEkd1bXRB994sQW18=;
        b=AmEzJWzPo80MxNawvaGtfsu5CJ3YxhEg+4o23l5O1M6r6czLn9sHpVxyVt2HNEg1sP
         8dMKq27tAMQQZkPMu+Cd5qinyuB37xDClhkFg5YL3c+xiomaCraGs7unlSx6aCMLWugj
         ZpwZdgO2lFbbn5hHKD0TpQhC6xoysLjVjw2T+eGLSAARcq1NtGUoONFm/q+reMJPn9NE
         MyJRiUU7FfMk9gIS1kUns0+iLJINniur1r7XPEP9EtznnOeQj4XocrJsfElWpISjekTH
         D82PJOwsjZBC7NmVyZvgZf2v7dm++LksqUAXDNJN2SaWBkO/fMmwInb6Xa3PV5bm+5Eq
         IUFg==
X-Gm-Message-State: AODbwcAmFQJj0Ypm9v8u0Zcfy4XRPb6PmDXXwlS/37Nhnf5mavOIGGB5
        KCwyQWJZG2R5iLaV
X-Received: by 10.98.155.154 with SMTP id e26mr33156110pfk.24.1496857201440;
        Wed, 07 Jun 2017 10:40:01 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:793b:8a31:813b:ceb2])
        by smtp.gmail.com with ESMTPSA id t198sm4697137pgc.33.2017.06.07.10.40.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Jun 2017 10:40:00 -0700 (PDT)
Date:   Wed, 7 Jun 2017 10:39:59 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        git@vger.kernel.org, jrnieder@gmail.com, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t4005: modernize style and drop hard coded sha1
Message-ID: <20170607173959.GA110638@google.com>
References: <xmqqwp8o7gdc.fsf@gitster.mtv.corp.google.com>
 <20170607021805.11849-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170607021805.11849-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/06, Stefan Beller wrote:
> Use modern style in the test t4005. Remove hard coded sha1 values.
> Combine test prep work and the actual test. Rename the first
> test to contain the word "setup".
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> Junio wrote:
> > If it helps, I _can_ make any set of declarations to make it sound
> > more official, e.g. (the remainder of) June is the "make sure our
> > tests are ready" 
> 
> If it helps, I can write code for that. :)
> 
> Do get a good grasp on which tests need to be fixed, I changed the seed
> value for the sha1 computation and then run the test suite. There are a lot
> of tests passing for this, but also quite a few failing. Then I picked t4005
> randomly to start with. This patch works even with a crippled hash function
> as we use hash-object to get the object id.
> 
> Thanks,
> Stefan
> 
>  t/t4005-diff-rename-2.sh | 95 ++++++++++++++++++++++--------------------------
>  1 file changed, 43 insertions(+), 52 deletions(-)
> 
> diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
> index 135addbfbd..f542d2929d 100755
> --- a/t/t4005-diff-rename-2.sh
> +++ b/t/t4005-diff-rename-2.sh
> @@ -3,84 +3,75 @@
>  # Copyright (c) 2005 Junio C Hamano
>  #
>  
> -test_description='Same rename detection as t4003 but testing diff-raw.
> +test_description='Same rename detection as t4003 but testing diff-raw.'
>  
> -'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
>  
> -test_expect_success \
> -    'prepare reference tree' \
> -    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
> -     echo frotz >rezrov &&
> -    git update-index --add COPYING rezrov &&
> -    tree=$(git write-tree) &&
> -    echo $tree'
> -
> -test_expect_success \
> -    'prepare work tree' \
> -    'sed -e 's/HOWEVER/However/' <COPYING >COPYING.1 &&
> -    sed -e 's/GPL/G.P.L/g' <COPYING >COPYING.2 &&
> -    rm -f COPYING &&
> -    git update-index --add --remove COPYING COPYING.?'
> +test_expect_success 'setup reference tree' '
> +	cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
> +	echo frotz >rezrov &&
> +	git update-index --add COPYING rezrov &&
> +	tree=$(git write-tree) &&
> +	echo $tree &&
> +	sed -e 's/HOWEVER/However/' <COPYING >COPYING.1 &&
> +	sed -e 's/GPL/G.P.L/g' <COPYING >COPYING.2 &&
> +	origoid=$(git hash-object COPYING) &&
> +	oid1=$(git hash-object COPYING.1) &&
> +	oid2=$(git hash-object COPYING.2)
> +'

This conversation looks good to me.  The only thing that made me scratch
my head a bit were the shell variables origoid, oid1, and oid2.  It was
just slightly confusing figuring out where they came from in the tests
below before I noticed they were initialized up here.

>  
> +################################################################
>  # tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
>  # both are slightly edited, and unchanged rezrov.  We say COPYING.1
>  # and COPYING.2 are based on COPYING, and do not say anything about
>  # rezrov.
>  
> -git diff-index -C $tree >current
> -
> -cat >expected <<\EOF
> -:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234	COPYING	COPYING.1
> -:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 06c67961bbaed34a127f76d261f4c0bf73eda471 R1234	COPYING	COPYING.2
> -EOF
> +test_expect_success 'validate output from rename/copy detection (#1)' '
> +	rm -f COPYING &&
> +	git update-index --add --remove COPYING COPYING.? &&
>  
> -test_expect_success \
> -    'validate output from rename/copy detection (#1)' \
> -    'compare_diff_raw current expected'
> +	cat <<-EOF >expected &&
> +	:100644 100644 $origoid $oid1 C1234	COPYING	COPYING.1
> +	:100644 100644 $origoid $oid2 R1234	COPYING	COPYING.2
> +	EOF
> +	git diff-index -C $tree >current &&
> +	compare_diff_raw expected current
> +'
>  
>  ################################################################
> -
> -test_expect_success \
> -    'prepare work tree again' \
> -    'mv COPYING.2 COPYING &&
> -     git update-index --add --remove COPYING COPYING.1 COPYING.2'
> -
>  # tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
>  # both are slightly edited, and unchanged rezrov.  We say COPYING.1
>  # is based on COPYING and COPYING is still there, and do not say anything
>  # about rezrov.
>  
> -git diff-index -C $tree >current
> -cat >expected <<\EOF
> -:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 06c67961bbaed34a127f76d261f4c0bf73eda471 M	COPYING
> -:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234	COPYING	COPYING.1
> -EOF
> +test_expect_success 'validate output from rename/copy detection (#2)' '
> +	mv COPYING.2 COPYING &&
> +	git update-index --add --remove COPYING COPYING.1 COPYING.2 &&
>  
> -test_expect_success \
> -    'validate output from rename/copy detection (#2)' \
> -    'compare_diff_raw current expected'
> +	cat <<-EOF >expected &&
> +	:100644 100644 $origoid $oid2 M	COPYING
> +	:100644 100644 $origoid $oid1 C1234	COPYING	COPYING.1
> +	EOF
> +	git diff-index -C $tree >current &&
> +	compare_diff_raw current expected
> +'
>  
>  ################################################################
> -
>  # tree has COPYING and rezrov.  work tree has the same COPYING and
>  # copy-edited COPYING.1, and unchanged rezrov.  We should not say
>  # anything about rezrov or COPYING, since the revised again diff-raw
>  # nows how to say Copy.
>  
> -test_expect_success \
> -    'prepare work tree once again' \
> -    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
> -     git update-index --add --remove COPYING COPYING.1'
> -
> -git diff-index -C --find-copies-harder $tree >current
> -cat >expected <<\EOF
> -:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234	COPYING	COPYING.1
> -EOF
> +test_expect_success 'validate output from rename/copy detection (#3)' '
> +	cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
> +	git update-index --add --remove COPYING COPYING.1 &&
>  
> -test_expect_success \
> -    'validate output from rename/copy detection (#3)' \
> -    'compare_diff_raw current expected'
> +	cat <<-EOF >expected &&
> +	:100644 100644 $origoid $oid1 C1234	COPYING	COPYING.1
> +	EOF
> +	git diff-index -C --find-copies-harder $tree >current &&
> +	compare_diff_raw current expected
> +'
>  
>  test_done
> -- 
> 2.13.0.17.gf3d7728391
> 

-- 
Brandon Williams
