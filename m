Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B10203F3
	for <e@80x24.org>; Tue, 25 Jul 2017 00:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755843AbdGYARA (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 20:17:00 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33312 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755414AbdGYAQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 20:16:58 -0400
Received: by mail-pf0-f177.google.com with SMTP id s70so52739342pfs.0
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 17:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yh7u9JFvMogEMoMb4X8xo9IGksX8FQP4130Hm9YVVR8=;
        b=qrAQbaNe/2Rwm0jWyREqigo8kqIF7ZxBiPsyq7a4Gh0R2EXU7J9moli1cs1GOYsGy2
         rfGQLRK2Xi8eAIFqZrXMq7iPz80WPqatlDEhHVprt3l5/0DxfnSPqepsBv3nU0gJsRZF
         6GH1LjX6lkN1U2KQ6PBzFF/sfA0iHtCehCGC8spba6osQrIQwu7ZeSRzn/wwBmbjLSbg
         m62Ce9d90YFyJemvQZuMMofbTBgFkD65+ugbYaE06Bd1dYK8n9NbEaykPHV1wmAXQ3iH
         GTAu2WKGqgbNNY0moEeX6kg6SwyIkpHsmRaiRNrLGjsnRRC+5wlXDqSwIPLpFiO2bIxp
         E8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yh7u9JFvMogEMoMb4X8xo9IGksX8FQP4130Hm9YVVR8=;
        b=h6W/vkjr2KHkxY2kq67WF0TgesxPu6PLp1dH+bHq5c2n1/bEBpa89RTFKOAgASfEyh
         CQlvhdL8IsWDvCP0w6qvofbxRXLlnyVos0dODUOkmxw5zU7G6jvpeMYzIuH0J6GiHiAp
         xYiSKABdYtnYU8EIF0voCmtZQ7MqjWPecvzJGbZGF8Y2jKuLtlDG7tmjL2c5mJAJ3Pyy
         tGiS0opmkJPPRRusnBItwIxwv/boQK6bcmabCfbS+RG6J9h6DXiQa3Xuinr5BHhYxMzR
         8NSV2Yeddu6HM8T44Jwv7YduB6ggb6SHZzVVLpzbgj7YqZM77ySSrVpNXLotQ+DF1i9H
         bOTA==
X-Gm-Message-State: AIVw110kuMQqgf4ADEw/egkQw59OOH/Td5HNCJZXfCBSASVqyosmDQIx
        Fjc9QbREtuM1Do/Wzks4VA==
X-Received: by 10.98.9.85 with SMTP id e82mr17660800pfd.266.1500941818195;
        Mon, 24 Jul 2017 17:16:58 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c4bc:947:66f8:1cfe])
        by smtp.gmail.com with ESMTPSA id 10sm25009156pfj.61.2017.07.24.17.16.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 17:16:57 -0700 (PDT)
Date:   Mon, 24 Jul 2017 17:16:56 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH 12/13] submodule foreach: document variable
 '$displaypath'
Message-ID: <20170725001656.GH92874@google.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
 <20170724203454.13947-13-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170724203454.13947-13-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/25, Prathamesh Chavan wrote:
> It was observer that the variable '$displaypath' was accessible but

s/observer/observed 

> undocumented. Hence, document it.
> 
> Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>  Documentation/git-submodule.txt |  6 ++++--
>  t/t7407-submodule-foreach.sh    | 22 +++++++++++-----------
>  2 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 8e7930ebc..0cca702cb 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -183,10 +183,12 @@ information too.
>  
>  foreach [--recursive] <command>::
>  	Evaluates an arbitrary shell command in each checked out submodule.
> -	The command has access to the variables $name, $sm_path, $sha1 and
> -	$toplevel:
> +	The command has access to the variables $name, $sm_path, $displaypath,
> +	$sha1 and $toplevel:
>  	$name is the name of the relevant submodule section in `.gitmodules`,
>  	$sm_path is the path of the submodule as recorded in the superproject,
> +	$displaypath contains the relative path from the current working
> +	directory to the submodules root directory,
>  	$sha1 is the commit as recorded in the superproject, and
>  	$toplevel is the absolute path to its superproject, such that
>  	$toplevel/$sm_path is the absolute path of the submodule.
> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index 0663622a4..6ad57e061 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -82,16 +82,16 @@ test_expect_success 'test basic "submodule foreach" usage' '
>  
>  cat >expect <<EOF
>  Entering '../sub1'
> -$pwd/clone-foo1-sub1-$sub1sha1
> +$pwd/clone-foo1-sub1-../sub1-$sub1sha1
>  Entering '../sub3'
> -$pwd/clone-foo3-sub3-$sub3sha1
> +$pwd/clone-foo3-sub3-../sub3-$sub3sha1
>  EOF
>  
>  test_expect_success 'test "submodule foreach" from subdirectory' '
>  	mkdir clone/sub &&
>  	(
>  		cd clone/sub &&
> -		git submodule foreach "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual
> +		git submodule foreach "echo \$toplevel-\$name-\$sm_path-\$displaypath-\$sha1" >../../actual
>  	) &&
>  	test_i18ncmp expect actual
>  '
> @@ -206,25 +206,25 @@ submodulesha1=$(cd clone2/nested1/nested2/nested3/submodule && git rev-parse HEA
>  
>  cat >expect <<EOF
>  Entering '../nested1'
> -$pwd/clone2-nested1-nested1-$nested1sha1
> +$pwd/clone2-nested1-nested1-../nested1-$nested1sha1
>  Entering '../nested1/nested2'
> -$pwd/clone2/nested1-nested2-nested2-$nested2sha1
> +$pwd/clone2/nested1-nested2-nested2-../nested1/nested2-$nested2sha1
>  Entering '../nested1/nested2/nested3'
> -$pwd/clone2/nested1/nested2-nested3-nested3-$nested3sha1
> +$pwd/clone2/nested1/nested2-nested3-nested3-../nested1/nested2/nested3-$nested3sha1
>  Entering '../nested1/nested2/nested3/submodule'
> -$pwd/clone2/nested1/nested2/nested3-submodule-submodule-$submodulesha1
> +$pwd/clone2/nested1/nested2/nested3-submodule-submodule-../nested1/nested2/nested3/submodule-$submodulesha1
>  Entering '../sub1'
> -$pwd/clone2-foo1-sub1-$sub1sha1
> +$pwd/clone2-foo1-sub1-../sub1-$sub1sha1
>  Entering '../sub2'
> -$pwd/clone2-foo2-sub2-$sub2sha1
> +$pwd/clone2-foo2-sub2-../sub2-$sub2sha1
>  Entering '../sub3'
> -$pwd/clone2-foo3-sub3-$sub3sha1
> +$pwd/clone2-foo3-sub3-../sub3-$sub3sha1
>  EOF
>  
>  test_expect_success 'test "submodule foreach --recursive" from subdirectory' '
>  	(
>  		cd clone2/untracked &&
> -		git submodule foreach --recursive "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual
> +		git submodule foreach --recursive "echo \$toplevel-\$name-\$sm_path-\$displaypath-\$sha1" >../../actual
>  	) &&
>  	test_i18ncmp expect actual
>  '
> -- 
> 2.13.0
> 

-- 
Brandon Williams
