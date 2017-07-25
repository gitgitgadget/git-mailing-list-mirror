Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78AB0203F3
	for <e@80x24.org>; Tue, 25 Jul 2017 00:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbdGYAPZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 20:15:25 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35523 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbdGYAPX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 20:15:23 -0400
Received: by mail-pg0-f48.google.com with SMTP id v190so63634481pgv.2
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 17:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DUQzZCqALCBY/OBg/g8IDRco/y+wgeeV5pamyFT6qJ0=;
        b=tBDdYr3MnbJN/zXhtBw8OUPAV3qftu3f3ZxeEs0IfEIYRnWbjpobZegkGGs2b2yFUr
         xA5PudUaYp3jBRVTvWnGmw3ywW2OtaZb/rdfnlDNqHR7NywYVe5NfRMZn1kZ2dVBX329
         pevaM/Ae3zxiTvUsTEAYYokm9WtPy/Zvazos/vQfr1ADLF9PEVCBldYUFWXetZczTqbb
         1UiHq1lpUWhf+OQzLos7CuZQjlpfI557UhnNRINTIRJLrnQgbp4t6T1dRyVyQXKpwRzj
         Jd/YDEAGmpTqTt1/OeyQ6PEDwVVX9F4ampVENxC3ENhM2Rgmn/02Xq6d5qEPVGZt2pmU
         T7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DUQzZCqALCBY/OBg/g8IDRco/y+wgeeV5pamyFT6qJ0=;
        b=NPkb6jMFgvxfloHLi+6AtHbbISaCWukWm3/S1RYCWK1NeBA8hACbc+0WSZQKr3vvUT
         TWUAMN1RFxhGTNnKa0R2Ok4UP7qolIUXwOmJYXc4V8ZJh7Y06g17Ll5x5aBSReTHAhWK
         AzfZ/ysKJDsGwNv9tb+fHpsFpAgPVrYpjKTpMGS3NOoKE17ZNSEZ2ijPVnH3KSKdxBma
         TUgrHAmfNCD9wPti4EHMbOa3lovgElZTKrtSFk+uzu3tMltMftvz01QgAeKssjh7qaAK
         tb8h1nxqxgJUIWRI+pyBGrcX4lXUAEFHp8Z4dTmSl8CerjmPsPGOFCFKof7E0Fbmiety
         vwQQ==
X-Gm-Message-State: AIVw113HuibvvF1k4lx23GrplkhK/0DbYodmj9UBPySVdtitNDd2XRX3
        IzWZwIcmwEX/eBtE
X-Received: by 10.98.107.201 with SMTP id g192mr17976411pfc.65.1500941723060;
        Mon, 24 Jul 2017 17:15:23 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c4bc:947:66f8:1cfe])
        by smtp.gmail.com with ESMTPSA id 83sm6998141pfu.78.2017.07.24.17.15.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 17:15:22 -0700 (PDT)
Date:   Mon, 24 Jul 2017 17:15:20 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH 10/13] submodule foreach: document '$sm_path'
 instead of '$path'
Message-ID: <20170725001520.GG92874@google.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
 <20170724203454.13947-11-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170724203454.13947-11-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/25, Prathamesh Chavan wrote:
> As using a variable '$path' may be harmful to users due to
> capitalization issues, see 64394e3ae9 (git-submodule.sh: Don't
> use $path variable in eval_gettext string, 2012-04-17). Adjust
> the documentation to advocate for using $sm_path,  which contains
> the same value. We still make the 'path' variable available and
> document it as a deprecated synonym of 'sm_path'.

I assume then at some point we would want to drop support for 'path' via
a normal deprecation cycle (whatever that might be, 6 months or a year
or more).

> 
> Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>  Documentation/git-submodule.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index ff612001d..a23baef62 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -183,12 +183,14 @@ information too.
>  
>  foreach [--recursive] <command>::
>  	Evaluates an arbitrary shell command in each checked out submodule.
> -	The command has access to the variables $name, $path, $sha1 and
> +	The command has access to the variables $name, $sm_path, $sha1 and
>  	$toplevel:
>  	$name is the name of the relevant submodule section in `.gitmodules`,
> -	$path is the name of the submodule directory relative to the
> -	superproject, $sha1 is the commit as recorded in the superproject,
> -	and $toplevel is the absolute path to the top-level of the superproject.
> +	$sm_path is the path of the submodule as recorded in the superproject,
> +	$sha1 is the commit as recorded in the superproject, and
> +	$toplevel is the absolute path to the top-level of the superproject.
> +	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
> +	variable is now a deprecated synonym of '$sm_path' variable.
>  	Any submodules defined in the superproject but not checked out are
>  	ignored by this command. Unless given `--quiet`, foreach prints the name
>  	of each submodule before evaluating the command.
> -- 
> 2.13.0
> 

-- 
Brandon Williams
