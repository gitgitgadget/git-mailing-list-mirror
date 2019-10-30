Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0848A1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 18:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfJ3S27 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 14:28:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37710 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfJ3S27 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 14:28:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id q130so3272391wme.2
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5UO4ps0+OFusJz7j4yJ4GiRd+ITeTp0ktShiUu/BnCk=;
        b=CtjvQEIVOCq5sVlXpQdD603FhHLAcVRn467cXSfI8MYqUeyGuTvBf+SG2N/GWB/1mm
         +vzFWVSwgtAcSXSaLXHsOVQ7sND2H2SPNGnyG2cqvqxEHSZhMviicpu2GLF8mGzuWGva
         IvSKte4AK4+ovk0SHWkrjP2A+HTfad4On26+UIJQnGh2ii6UUN6lvytRHsDvQsJtOpV1
         lHIeuiEoQEFcH2zuyZhhLjaKSBt83DLaK9Inl46vjKTHWVdAAfCeLHefHVVCgAZpuG/H
         v81YOVjAl1JVWWqFu3XcGZZbueoZmb34nDUA8cYCXMM4Ykrff3iX41oAqz6rM0R4nqA3
         Ugzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5UO4ps0+OFusJz7j4yJ4GiRd+ITeTp0ktShiUu/BnCk=;
        b=pYYRfrFgwQa2vip0m2RHfA1X8/YpHOUxV31dbDNDC8+1kfIcp4vpKmjx+GhzJJ6qCn
         dSIaeNrOprDHiDLhrCuFgERC4B1cP+vDNOcxNQ60fWO4qTvScQa81LD2pznlMnQtXCUv
         gXQMP04VhUE54LvM3GfcLkHJEkXRGryWGC4rwFXw45G1jIs7BDpHZsCCXz3w3efBcMs4
         wzrQ1CL73vo+B0ZqNa7v/137242Cie5xqW1JBc+8MXnjFfd9ow2PkAMsqoJ9du68D4ye
         oBQ6QB0OkG1/lKG96Hp36Zt8P3pPzErxPt0tBnd6D8ssVzLo4z97OG0Zk+2MMEtVl3Zz
         qqTg==
X-Gm-Message-State: APjAAAXRDaCAIJf4ALDhTPB48OG80j8m/7Il50dawD0ml1l0GASc5ZnA
        m8MbNTYKFFbtkXHYtbRyMHiBbLUD
X-Google-Smtp-Source: APXvYqyUYQosPaVHtJXhMSEUxs6MJLzhClmgEcrduEole5U+yLaQATx+dMH/TD2E9euHXqrNgWJ4QQ==
X-Received: by 2002:a7b:c7c8:: with SMTP id z8mr800826wmk.29.1572460136762;
        Wed, 30 Oct 2019 11:28:56 -0700 (PDT)
Received: from szeder.dev (x4db90119.dyn.telefonica.de. [77.185.1.25])
        by smtp.gmail.com with ESMTPSA id l22sm1544452wrb.45.2019.10.30.11.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 11:28:56 -0700 (PDT)
Date:   Wed, 30 Oct 2019 19:28:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Mattias Hansson <mattias.hansson@axis.com>
Cc:     git@vger.kernel.org, Mattias Hansson <hansson.mattias@gmail.com>
Subject: Re: [PATCH] ls-remote: Remove conflicting option "-h"
Message-ID: <20191030182854.GX4348@szeder.dev>
References: <20191030173337.6574-1-mattias.hansson@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191030173337.6574-1-mattias.hansson@axis.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 30, 2019 at 06:33:37PM +0100, Mattias Hansson wrote:
> From: Mattias Hansson <hansson.mattias@gmail.com>
> 
> The "-h" option is documented to limit the result to heads, which is a
> bit nonintuitive since "-h" is commonly used as the short option for
> "--help". However, "-h" currently displays the usage information
> which proves that there's a double reference to the option.

Interesting.

While 'git ls-remote -h' shows the usage information, 'git ls-remote
-h origin' does list branches from the given remote.  This is
intentional: 'git ls-remote -h' without a remote listed branches from
the default remote for years, but, as you pointed out, it's
nonintuitive, so it's behavior was changed to what we have today in
commit 91a640ffb6 (ls-remote: a lone "-h" is asking for help,
2011-09-16).

I think the short option should stay, because removing it will break
the case when the remote is specified on the command line.

However, its description in the usage string and in the man page could
be improved to point out this caveat.  Doing so in the man page is
surely not too difficult, because we can dedicate a whole sentence or
even two to this corner case, but I'm not sure how it could be
sensibly squeezed into the usage string.

> This patch will remove "-h" as a short option for "--heads". This
> will maintain the current behaviour and correct the misleading
> documentation.

Note that '-h' is documentet in the man page as well, so if we decide
to go for removal, then it should be removed from the man page as
well.

> Signed-off-by: Mattias Hansson <hansson.mattias@gmail.com>
> ---
>  builtin/ls-remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 6ef519514b..85ce336fc3 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -63,7 +63,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>  			   N_("path of git-upload-pack on the remote host"),
>  			   PARSE_OPT_HIDDEN },
>  		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
> -		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_HEADS),
> +		OPT_BIT(0, "heads", &flags, N_("limit to heads"), REF_HEADS),
>  		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
>  		OPT_BOOL(0, "get-url", &get_url,
>  			 N_("take url.<base>.insteadOf into account")),
> -- 
> 2.22.0
> 
