Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14EDA1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 09:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbfJ2JPl (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 05:15:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34703 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731536AbfJ2JPl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 05:15:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so9119819pfa.1
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 02:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kOsisgkdOUqCFGAcsAUtKTUJB9LETnEb8LuIaXx552Y=;
        b=DTvQvaxmBay95IOuuI0xWuEsHo2i27CMkh2PLEXuhu1GOZhUb6C2QYdzaSIAjsbwaU
         ewo2bNk/gG0nISdD1ctzyYjq0wJ/mEf7SrcGs4q0KPHnxoOVEp89Bmbx0+0WfrvVzLaa
         5cCF+ie/FhMlnhvzu2LrsM+6Ae/s0upQaTiu0xvQ2crqaFxStH3blSJgIPfW8lA0tr8u
         em5UEL1KTsAaI0y0Jp+ZGdif/BxZRAiusu524zBimvv1QRG9Jaua4CjLpyKb7SlY6LuK
         Jgx+1Bf+dXCV7+ZZqfOjvNVSkegLwOxmYf/h2N5cYKNd0ZIDQGZTylcbMJyZoRVcFBeg
         sO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kOsisgkdOUqCFGAcsAUtKTUJB9LETnEb8LuIaXx552Y=;
        b=NWj5XfxKntYIweD08TN0JhdgAxXeTAKr/As+TJccpb+wluszKIxhlJdUf7GGUORSAI
         ZFNlsY2s3LRSWSAkc1ogHN64DGLrx9WbxHukQVU4IkERfLL4asLtH5rr7HQJd/UDi8qX
         rsF1zgDzHIPBDvEnqUCn4gkOwKYuCpB0NL/I4WC9jlv3LKwgPZCUbnVM3stwAPG1ZZbH
         n2W3/XAV0yjJGeLunC56Bpyzla5j/g/mJbkR6nZ6PPK4I/oECgCddHARVtl8kwECLK+Y
         1veCUNNLIxeuVHi9/uA5+seNRFytocNaQHEQArVwoOf1t8A0WP2KBXzDh8LH2BYWtp2u
         8MCw==
X-Gm-Message-State: APjAAAVoMJoY0bdZzY5QHUm3Tmcvgh0LzGytdSD8HDNaZFB+wYXLH0kE
        +gKK6AdyWnpIrhj1Oo+rmMc=
X-Google-Smtp-Source: APXvYqyS82EyidWWWMukHmpnvwy/FPnTOMJPa0wutyrY0tqiITesf5eFB3vP7NeP3Xa1l/EDobV9+w==
X-Received: by 2002:a63:e454:: with SMTP id i20mr26062840pgk.319.1572340540535;
        Tue, 29 Oct 2019 02:15:40 -0700 (PDT)
Received: from localhost ([2402:800:6374:2b0b:2c45:12eb:cc8d:f995])
        by smtp.gmail.com with ESMTPSA id i16sm13184932pfa.184.2019.10.29.02.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 02:15:39 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:15:38 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] submodule: teach set-url subcommand
Message-ID: <20191029091538.GB17223@danh.dev>
References: <3c7a496209d2d8d2162ef3ea7565eef0b0ca0576.1568750590.git.liu.denton@gmail.com>
 <d8841c6009c91ac921d30b35ed9a441c87b332e2.1572337964.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8841c6009c91ac921d30b35ed9a441c87b332e2.1572337964.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-10-29 01:34:19 -0700, Denton Liu wrote:
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 1f46380af2..f1c4689f24 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -16,6 +16,7 @@ SYNOPSIS
>  'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
>  'git submodule' [--quiet] update [<options>] [--] [<path>...]
>  'git submodule' [--quiet] set-branch [<options>] [--] <path>
> +'git submodule' [--quiet] set-url [<options>] [--] <path> <newurl>

I skimmed over this patch and found no options.
[<options>] should be removed

> @@ -180,6 +181,11 @@ set-branch (-d|--default) [--] <path>::
>  	`--default` option removes the submodule.<name>.branch configuration
>  	key, which causes the tracking branch to default to 'master'.
>  
> +set-url [--] <path> <newurl>::
> +	Sets the URL of the specified submodule to <newurl>. Then, it will
> +	automatically synchronize the submodule's new remote URL
> +	configuration.
> +
>  summary [--cached|--files] [(-n|--summary-limit) <n>] [commit] [--] [<path>...]::
>  	Show commit summary between the given commit (defaults to HEAD) and
>  	working tree/index. For a submodule in question, a series of commits
> diff --git a/git-submodule.sh b/git-submodule.sh
> index c7f58c5756..f7374ddbd6 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -12,6 +12,7 @@ USAGE="[--quiet] [--cached]
>     or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
>     or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
> +   or: $dashless [--quiet] set-url [--] <path> <newurl>
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>     or: $dashless [--quiet] foreach [--recursive] <command>
>     or: $dashless [--quiet] sync [--recursive] [--] [<path>...]
> diff --git a/t/t7420-submodule-set-url.sh b/t/t7420-submodule-set-url.sh
> new file mode 100755
> index 0000000000..9bc941ced3
> --- /dev/null
> +++ b/t/t7420-submodule-set-url.sh
> +		grep "url = \.\./newsubmodule" .gitmodules &&

grep -F "url = ../newsubmodule"
will be easier to read.

-- 
Danh
