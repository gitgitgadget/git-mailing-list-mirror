Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DD111FA14
	for <e@80x24.org>; Fri, 26 May 2017 16:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944258AbdEZQdb (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 12:33:31 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36569 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944195AbdEZQdX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 12:33:23 -0400
Received: by mail-pf0-f174.google.com with SMTP id m17so16047247pfg.3
        for <git@vger.kernel.org>; Fri, 26 May 2017 09:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tf14LzRHimQTIP9aMfdaLg370TJCnwcv3pGpzcA37is=;
        b=HdTrh/4UI9CQT1Z83t5BYS6PhLQF5r8f1TiQpzJPlVNIsZ3undaSLa5xdSnjqDfGZf
         olX9s1DDilFQdcQI9j9kWxhMmBpVXpYx/eCYo5jUM4xrsdLVIM2HKIokMsKK54OXAUN2
         yFaUm+KKfLvqQnfzCauPkKC8r/a2SvQP8lGXdvCVfypidzQcHvTudCeodYZyorOp0A2F
         0oGX+RM28N6lJMSogt3u8Nu2auobLvvWY32zfCTH8qqG6qOXdkajzY1RJQtRkUcG56eN
         vwITcdJJxvuYxOvCoecteu7M6jVXhciH6t+QXFmfGqTSzBhssJzpsgOjOr3lSIhFmlQa
         clDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tf14LzRHimQTIP9aMfdaLg370TJCnwcv3pGpzcA37is=;
        b=oTk754gkBuevtDHZI/fMocScmJmAbNGT6f0kV/tmWZqsrU52VvAOTkWdW8JRr4JCee
         uR3daQogHKwN5j+VWJdI8ieYyAZldTouFdlCoGJ0TW1GMlrZYarpVYM0LycppvzWVrDk
         enFeZcA19jH5s1hd3vnbQUFWJ/BVbcc+JerTZoHEEJWuom2XnZ8DuWSPiHRqIbASxzA4
         Y7LHNuUW96xqXsi0kslDwz4P2Pn+RU6KOljz6vHHZxn48Ajl+1CkfiB6V6TAwt034/2d
         R2Oy9Jr18eZs8WeZ2CYdAeVGFp6sVuNMXZ9QD1KL2vlgF1caGtB4ZDIxlyKuNL0HLWrN
         aiDQ==
X-Gm-Message-State: AODbwcADuhuN5JrSmczdtpmq2gLFkXIOUv+QFxckND0dgCdcNGitkxQw
        bjaOJZkBrYvR51dX
X-Received: by 10.98.80.152 with SMTP id g24mr3349966pfj.222.1495816402284;
        Fri, 26 May 2017 09:33:22 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:56f:46ea:751:c7c2])
        by smtp.gmail.com with ESMTPSA id l85sm2635712pfj.130.2017.05.26.09.33.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 May 2017 09:33:21 -0700 (PDT)
Date:   Fri, 26 May 2017 09:33:19 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        ramsay@ramsayjones.plus.com, sbeller@google.com
Subject: Re: [GSoC][PATCH v5 2/3] t7407: test "submodule foreach --recursive"
 from subdirectory added
Message-ID: <20170526163319.GA4592@google.com>
References: <20170521125814.26255-2-pc44800@gmail.com>
 <20170526151713.10974-1-pc44800@gmail.com>
 <20170526151713.10974-2-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170526151713.10974-2-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/26, Prathamesh Chavan wrote:
> Additional test cases added to the submodule-foreach test suite
> to check the submodule foreach --recursive behavior from a
> subdirectory as this was missing from the test suite.
> 
> Helped-by: Brandon Williams <bmwill@google.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> Additional test added to check the bug fixed in the [PATCH v5 1/3] of
> this patch series.
> 
>  t/t7407-submodule-foreach.sh | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index 6ba5daf42..1c8d132d8 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -197,6 +197,40 @@ test_expect_success 'test messages from "foreach --recursive" from subdirectory'
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
> +$pwd/clone2/nested1-nested2-../nested1/nested2-$nested2sha1
> +Entering '../nested1/nested2/nested3'
> +$pwd/clone2/nested1/nested2-nested3-../nested1/nested2/nested3-$nested3sha1
> +Entering '../nested1/nested2/nested3/submodule'
> +$pwd/clone2/nested1/nested2/nested3-submodule-../nested1/nested2/nested3/submodule-$submodulesha1
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

small nit: You can either merge the two cd commands to 'cd clone2/untracked' or
better you can even avoid the subshell entirely by doing the following:

  git -C clone2/untracked submodule foreach --recursive \
    "echo \$toplevel-\$name-\$sm_path-\$sha1" >actual

Or something akin to that.

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
