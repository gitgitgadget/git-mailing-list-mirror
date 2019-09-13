Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E2D21F463
	for <e@80x24.org>; Fri, 13 Sep 2019 22:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfIMWJF (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 18:09:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44802 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfIMWJF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 18:09:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so15934851pgl.11
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 15:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P0ReMnA5kgYXKuYLHkzcH2ZaRGeRpLDTwKRKk/R1KdM=;
        b=NWbqxpPMjZjPiRrl3pf4xXc9EbZxZQ6h8D5bbMm6zIYwJ4ZlE4fRJx0/lPd/GbyRKr
         XJv93Kt8JUI0k4afuTAlOCdfK7unr4BtdlesJQE79dPXlkdsQwWxdUfd1YMdkSi7cMgb
         oe7lbWtCe6y+EdBnX+r2NaiVbmSKmyVgSQDx/6Lou/uGQCggQLfTM7llOsrshsXH2ZU/
         2oSQ/8XIiILBiH69WARyb93RpPa1KemD/yPI7yrKf4jjCrxCLl+baDAqAeaCAr0SdvQ9
         a2YOTYnY5EoNmRrRYId9KCKfX40Te/eEV2ET06xqKYY0abdPDhAf6f2c5ttEVH1JGpbu
         UZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P0ReMnA5kgYXKuYLHkzcH2ZaRGeRpLDTwKRKk/R1KdM=;
        b=axFFb3p/DkBCnBRsSRZG4f0M9BehibnejZn5tDNfO3uI+ft0m34BQ4IFYDNqnNlkpx
         YT9rn4JzUsWevYhBlbsStCCwmiHKCtysgXX+Wqz/YjP3XgFmXL/qoAMDkqmuYvFRyNNh
         J4IVZDoRUKP7vIlt+EIl2mYQMBF7Qk9lUOHJey6xpIPGS1G4KHTmi9D1bQin7IadAIwY
         yZ9oUbLU+UBdgtvXqf09t63WdQt62vxZrJGySP6O0loA4VEgJDkZ8AWgnT+8T1BvinC2
         DMSCAvXE12kucH9b1R/faisom90aaVz1nvrHJmDCuAbWEv9r4ph9jn/EGZUMoIvs1lEp
         VhAg==
X-Gm-Message-State: APjAAAVaJ3GYFNtjMb2gOeF3us+UXcWBfzlbVJe/ndBAwonjKq/BiVau
        /yAWifBQHLaNkwuc/UDyTzLu7q3yuTE=
X-Google-Smtp-Source: APXvYqzJZQ6GhwVnhHBVdWN0+x0g34um8Pn06y2zHGZRhb8VzgfsQO2UoBNnZ4jEeh/0H+Pgnu9kbg==
X-Received: by 2002:a17:90a:3301:: with SMTP id m1mr7893149pjb.27.1568412544830;
        Fri, 13 Sep 2019 15:09:04 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id w13sm30377529pfi.30.2019.09.13.15.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 15:09:03 -0700 (PDT)
Date:   Fri, 13 Sep 2019 15:09:02 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git-submodule.txt: fix AsciiDoc formatting error
Message-ID: <20190913220902.GA93452@dentonliu-ltm.internal.salesforce.com>
References: <796a25ee1e9a9c0421d42ab6644e81d23a9bd99b.1568142486.git.liu.denton@gmail.com>
 <xmqqk1acdqf8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk1acdqf8.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 11:03:39AM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > Remove surrounding parentheses so that the "index term" syntax is not
> > triggered (and because it looks nicer without them anyway ;) ).
> 
> "Correct" always trumps "nicer", though ;-)
> 
> The $USAGE string in the script describes the available options to
> this subcommand like so:
> 
>     or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
> 
> which is, "you can give either --default or --branch <branch>, but
> not both".  What the original, if there were no special meaning in
> double-paren, meant to say seems to (almost) match that.
> 
> > -set-branch ((-d|--default)|(-b|--branch <branch>)) [--] <path>::
> 
> I say "almost", as it gives a wrong impression that you can give
> "-b" without "<branch>" X-<.
> 
> Now what does the updated text say to us?
> 
> > +set-branch (-d|--default)|(-b|--branch <branch>) [--] <path>::
> 
> I think the attempt to cram the short-form is unnecessarily
> cluttering and making the result incorrect.  How about doing
> something like this instead?
> 
>  Documentation/git-submodule.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 0ed5c24dc1..816baa7dd0 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -173,10 +173,12 @@ submodule with the `--init` option.
>  If `--recursive` is specified, this command will recurse into the
>  registered submodules, and update any nested submodules within.
>  --
> -set-branch ((-d|--default)|(-b|--branch <branch>)) [--] <path>::
> +set-branch (--default|--branch <branch>) [--] <path>::
>  	Sets the default remote tracking branch for the submodule. The
> -	`--branch` option allows the remote branch to be specified. The
> -	`--default` option removes the submodule.<name>.branch configuration
> +	`--branch` option (or its short-form, `-b <branch>`)
> +	allows the remote branch to be specified. The
> +	`--default` option (or its short-form, `-d`)
> +	removes the submodule.<name>.branch configuration
>  	key, which causes the tracking branch to default to 'master'.
>  
>  summary [--cached|--files] [(-n|--summary-limit) <n>] [commit] [--] [<path>...]::

Hmm, I don't really like this since with every other subcommand, the
short-forms are in the command summary so it's obvious to the reader
in a quick glance which options are available. With this change, a
reader would have to not only read the summary line but also scan the
blurb below.

In the context line above, we see `[(-n|--summary-limit) <n>]` as a
possible way of notating a short and long option with argument. What do
you think about the following potential output?

	set-branch (-d|--default)|((-b|--branch) <branch>) [--] <path>::

Of course, we reintroduce the double paren problem but I can dig into
asciidoc syntax and figure out how to escape it properly.
