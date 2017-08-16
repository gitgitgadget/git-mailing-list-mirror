Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99A2C1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 22:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbdHPW7Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 18:59:24 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:37644 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbdHPW7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 18:59:24 -0400
Received: by mail-pg0-f51.google.com with SMTP id y129so30167208pgy.4
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Tyu0atv80sGdzYqd0yLkW8HoUNFnllKLml/yEnM83Q=;
        b=UrkhZZYMQgEGOGIdoltRHnkmhiJ8AgohtzrauUYYawerWxXe/q3QzKEnwwkzB9GDiT
         7Pv8mGQoH16Q9CWbeC+Irgp0LatbNYmQYfQMl6qZBU1b4QDk0FMT39utHQpNUVjHCjQi
         Se9JIeyQbXgJEN/mfXFNMic6dRHEkSShg7GSyw0XNSILMxtIiV0m6peDEpJneIn5HgAt
         ZVHBKfzopbnUsIuVMFCDVmIQ16DIktCTSe2voduPXZm2v+3jZvcGXiHiu9P0GoUK81Ls
         cXdLrUGXhg/ukvaieXe/sD9nAeJ8MfwuVG5DmtJ3ea0UKdtu+vOgDWltDnR9/4iTY/WZ
         Qw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Tyu0atv80sGdzYqd0yLkW8HoUNFnllKLml/yEnM83Q=;
        b=sOh/wMUBnN/HiJEw1+mFou81B2iket58dY6UZyWtxtV2cYJcUWQXmaGh4u8iJf8OXz
         nFGMJJ0RIbkwLPO+s4T9BzdhPWvrnihfdLUgpKGcTj3JvRxc3PuymKy3tYqDfC0gcFjm
         ZFXKFm8ZSOOnfuIbKfTQIP4HuSWIjBPmrbYAtt2Mh9Dg49OrLwqqnN0CoEvxDGqZRkG8
         t7Q5FixnTgomy08MR5yGiqj89CGRuD8aYJp1eOklgsyJnDTKu5omjbf0Ai4DPRQdhsfz
         9d5LXwg4PXVYClYtob1mo2pxdNLgOyEWxId9zWeCtePdmgpQF8YA57EvZKbmx2rVQrL/
         Ik7A==
X-Gm-Message-State: AHYfb5h//57fQM+dzTovniVWJIH7KFQ7PG96qNlYAgQj1wbWC6s1cs/c
        tkYLV7c4vDfjYA==
X-Received: by 10.99.101.131 with SMTP id z125mr3005912pgb.297.1502924363450;
        Wed, 16 Aug 2017 15:59:23 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:3932:90a0:1342:ce37])
        by smtp.gmail.com with ESMTPSA id j26sm4752486pfj.69.2017.08.16.15.59.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 16 Aug 2017 15:59:22 -0700 (PDT)
Date:   Wed, 16 Aug 2017 15:59:20 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule.sh: remove unused variable
Message-ID: <20170816225920.GJ13924@aiede.mtv.corp.google.com>
References: <20170816225042.32765-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170816225042.32765-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> This could have been part of 48308681b0 (git submodule update: have a
> dedicated helper for cloning, 2016-02-29).
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for cleaning up.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index e131760eec..9dcec7b356 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -611,7 +611,6 @@ cmd_update()
>  		die_if_unmatched "$mode" "$sha1"
>  
>  		name=$(git submodule--helper name "$sm_path") || exit
> -		url=$(git config submodule."$name".url)
>  		if ! test -z "$update"
>  		then
>  			update_module=$update
> -- 
> 2.14.0.rc0.3.g6c2e499285
> 
