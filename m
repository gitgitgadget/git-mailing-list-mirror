Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 971DD20281
	for <e@80x24.org>; Tue, 23 May 2017 19:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757598AbdEWTGZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:06:25 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35001 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbdEWTGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:06:23 -0400
Received: by mail-pf0-f178.google.com with SMTP id n23so123226932pfb.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vUsaPaAw2jkypv291UtCrliNL5FJHcIzS6JbUqUlAQY=;
        b=e25rncyN3fFr8XxfDVu0WOa+cSrfAUUHSPOD4Aw7d/pYZq1Fkdu4UvDAmFtx/OlQRH
         DSOv2+4/F/b9AsS+Q9d59TfWDxMJlrWYcOh6uwUXXT7nLVyACnGfk2RsmoIlDvYxx2AG
         nEdzZVK96RjtaklMcnS7C3IVbJZLGbE01St0TnlpzIO71bn55YQ/8/YXIJJB/So0/zrJ
         v02Rhky4k9pwJQ7aN6AgW30W+WSsh8reuMnmJr1f98Zkv63yejNm2Jf/BzvH0pKppPe3
         nCYOTlSdCMQZTJUPEQepd9HCadvp3aPl/lKhfVl+17PTYHPTCi9ePoKQvmN1v2tk4sm9
         PbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vUsaPaAw2jkypv291UtCrliNL5FJHcIzS6JbUqUlAQY=;
        b=dTg7FTeBE6Nog3B+Wktz2dPEv7mqsYo0KAf9Y2gqiFqUlY9qOFyV0Vpc9M33QEQJRR
         n9oAy58G/8tWtQci5Qqi6cnLYgS1OoDHZ9fgoYrEQnn1qTqaNk7wvgcX8/xjZ5aSxiVG
         PYVAxqCfefhJV5k4gjtmezhNw5z5z191aEL60/xl0vNW/lpcdcW2nlWRBwmFa3PU35T2
         3rH4aW+9aZQzxmA7F0srn4jsesTJo65tWQKvke1jxUHguvjanJlH/Z+V8xpJW+TgME77
         nAhDt9heDjZjGTfFKZchk+vqYoSKTXp0umHnf+79LwOkqlt+YMDaRnX+ZnL2V1AqQV4F
         YAqg==
X-Gm-Message-State: AODbwcAPBWkt+EZ+tcW0MzXrWsZV/1ymtJ9d3ANycUbtm6wqM83E5tgt
        iX4wpxmmVjQpWnKg
X-Received: by 10.84.173.195 with SMTP id p61mr38085086plb.83.1495566382913;
        Tue, 23 May 2017 12:06:22 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6539:887d:745f:6fdf])
        by smtp.gmail.com with ESMTPSA id a78sm3891798pfk.122.2017.05.23.12.06.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 12:06:21 -0700 (PDT)
Date:   Tue, 23 May 2017 12:06:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com,
        christian.couder@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com
Subject: Re: [GSoC][PATCH v4 1/2] t7407: test "submodule foreach --recursive"
 from subdirectory added
Message-ID: <20170523190617.GE115919@google.com>
References: <20170515183405.GA79147@google.com>
 <20170521125814.26255-1-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170521125814.26255-1-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/21, Prathamesh Chavan wrote:
> Additional test cases added to the submodule-foreach test suite
> to check the submodule foreach --recursive behavior from a
> subdirectory as this was missing from the test suite.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> It was observed that after porting the submodule subcommand to
> C, it passed all the test from the existing test-suite.
> But since there was some observation made, where the output of
> the orignal submodule foreach subcommand wasn't matching to that
> of the newly ported function, this test has been added.
> 
> After which, it can been seen that the patch fails in test #9
> of t7407-submodule-foreach, which is the newly added
> test to that suite. The main reason of adding this test
> was to bring the behavior of $path for the submodule
> foreach --recursive case.
> 
> The observation made was as follows:
> 
> For a project - super containing dir (not a submodule)
> and a submodule sub which contains another submodule
> subsub. When we run a command from super/dir:
> 
> git submodule foreach "echo \$path-\$sm_path"
> 
> actual results:
> Entering '../sub'
> ../sub-../sub
> Entering '../sub/subsub'
> ../subsub-../subsub
> 
> ported function's result:
> Entering '../sub'
> sub-../sub
> Entering '../sub/subsub'
> subsub-../sub/subsub
> 
> This is occurring since in cmd_foreach of git-submodule.sh
> when we use to recurse, we call cmd_foreach
> and hence the process ran in the same shell.
> Because of this, the variable $wt_prefix is set only once
> which is at the beginning of the submodule foreach execution.
> wt_prefix=$(git rev-parse --show-prefix)
> 
> And since sm_path and path are set using $wt_prefix as :
> sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
> path=$sm_path
> It differs with the value of displaypath as well.
> 
> This make the value of $path confusing and I also feel it
> deviates from its documentation:
> $path is the name of the submodule directory relative
> to the superproject.
> 
> But since in refactoring the code, we wish to maintain the
> code in same way, we need to pass wt_prefix on every
> recursive call, which may result in complex C code.
> Another option could be to first correct the $path value
> in git-submodule.sh and then port the updated cmd_foreach.
> 
>  t/t7407-submodule-foreach.sh | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index 6ba5daf42..58a890e31 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -79,7 +79,6 @@ test_expect_success 'test basic "submodule foreach" usage' '
>  	) &&
>  	test_i18ncmp expect actual
>  '
> -

The removal of this line seems unrelated to the rest of this patch.  Was
this intended?

>  cat >expect <<EOF
>  Entering '../sub1'
>  $pwd/clone-foo1-../sub1-$sub1sha1
> @@ -197,6 +196,40 @@ test_expect_success 'test messages from "foreach --recursive" from subdirectory'
>  	test_i18ncmp expect actual
>  '
>  
> +sub1sha1=$(cd clone2/sub1 && git rev-parse HEAD)
> +sub2sha1=$(cd clone2/sub2 && git rev-parse HEAD)
> +sub3sha1=$(cd clone2/sub3 && git rev-parse HEAD)
> +nested1sha1=$(cd clone2/nested1 && git rev-parse HEAD)
> +nested2sha1=$(cd clone2/nested1/nested2 && git rev-parse HEAD)
> +nested3sha1=$(cd clone2/nested1/nested2/nested3 && git rev-parse HEAD)
> +submodulesha1=$(cd clone2/nested1/nested2/nested3/submodule && git rev-parse HEAD)
> +
> +cat >expect <<EOF
> +Entering '../nested1'
> +$pwd/clone2-nested1-../nested1-$nested1sha1
> +Entering '../nested1/nested2'
> +$pwd/clone2/nested1-nested2-../nested2-$nested2sha1
> +Entering '../nested1/nested2/nested3'
> +$pwd/clone2/nested1/nested2-nested3-../nested3-$nested3sha1
> +Entering '../nested1/nested2/nested3/submodule'
> +$pwd/clone2/nested1/nested2/nested3-submodule-../submodule-$submodulesha1
> +Entering '../sub1'
> +$pwd/clone2-foo1-../sub1-$sub1sha1
> +Entering '../sub2'
> +$pwd/clone2-foo2-../sub2-$sub2sha1
> +Entering '../sub3'
> +$pwd/clone2-foo3-../sub3-$sub3sha1
> +EOF
> +
> +test_expect_success 'test "submodule foreach --recursive" from subdirectory' '
> +	(
> +		cd clone2 &&
> +		cd untracked &&
> +		git submodule foreach --recursive "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual
> +	) &&
> +	test_i18ncmp expect actual
> +'
> +
>  cat > expect <<EOF
>  nested1-nested1
>  nested2-nested2
> -- 
> 2.11.0
> 

-- 
Brandon Williams
