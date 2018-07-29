Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCB0F208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 21:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbeG2Wzv (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 18:55:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32833 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbeG2Wzv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 18:55:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id r24-v6so6727424wmh.0
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 14:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U3DbGmrYbex6FwosLthOMzOTuf84NeASTrJfFglmHo0=;
        b=kdI/t65HBayNrGBeMhCfgTrEQuwXRjHYhM2Su0VjArFg0cWBHEL+4lF9AoOLNESgOH
         1qNsM9CrdB7GfWdj60EbAzS8K8bs0WVeIov3Uyw7GLwbdRaTtnh75L9A+VBChiuBWDP7
         FlRav3DnPTvv6R7vvLapM2p/sfv8cWgmUunvg3PoTV1e07+a8GWTh7iWzDKsHWfjLFy1
         bcwyC4VabYPawex4oNSli309eJillD8qIWiPIuRudbxY/rbZNPpOS7LddaQmqYkVEbDl
         nUc5UX0OYqxo2sliLf8XWDUqCGZ9uRwPBr6bCVr6lwrRh4LqK5btJ7geDebzepQjJWQn
         qXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U3DbGmrYbex6FwosLthOMzOTuf84NeASTrJfFglmHo0=;
        b=KjYuD8ocQWIE6RiqiMDbhp7UKaw9gQrt6VmDZbmjI7Vdd34yzDvdFhUQp2yfVvWHf0
         3/J41safRD+JL3kIeOEnx2QC51O/AVUJH3zcWqjD1iFMHd8R06jZUZ57OoAfujUSTXIw
         gFFhT6Vjk6irWWjs0+/lT2Tw2ooIr2wkcl6XfJjwh8JX1R6zX3uqinana+WmJ0GbhvSV
         ekbq7xIwge7xzEpT/+eNlFdinRQHu7hxqMBeZ+n95V1t++4Z9dLcFuhNaOrtzWb8qWwc
         oPbC/uiLqlKiX99USPZI/MgIIZDIBbUUNuT2xOHXUC4caIReU/q4l+XHdflrMEHnXaj9
         cROQ==
X-Gm-Message-State: AOUpUlHbLNHc9IEmspL1+XHqW4S+KQaxvlL1um7Q9SNxELjhXx25V+QN
        0mkOFUDO/qq5T26h+xrnoIk=
X-Google-Smtp-Source: AAOMgpcd4YVVlGp8Q+5IX0Iw8tch0ntZom33nJQNetB9O1VT0tblkunyena0/LTdxuvb93dsYJSc6w==
X-Received: by 2002:a1c:ec9d:: with SMTP id h29-v6mr12991515wmi.94.1532899436384;
        Sun, 29 Jul 2018 14:23:56 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id n12-v6sm19554235wrm.62.2018.07.29.14.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 14:23:55 -0700 (PDT)
Date:   Sun, 29 Jul 2018 22:23:54 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 17/21] range-diff: populate the man page
Message-ID: <20180729212354.GB9955@hank.intra.tgummerer.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
 <pull.1.v4.git.gitgitgadget@gmail.com>
 <9e09c6be66e960db496b1c9a30eb5040242ab764.1532210683.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e09c6be66e960db496b1c9a30eb5040242ab764.1532210683.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/21, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The bulk of this patch consists of a heavily butchered version of
> tbdiff's README written by Thomas Rast and Thomas Gummerer, lifted from

Thanks for the mention here, but this was really mostly Thomas Rast's
writing.  My contributions here are very minor compared to his :)

> https://github.com/trast/tbdiff.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-range-diff.txt | 229 +++++++++++++++++++++++++++++++
>  1 file changed, 229 insertions(+)
> 
> [...]
>
> +CONFIGURATION
> +-------------
> +This command uses the `diff.color.*` and `pager.range-diff` settings
> +(the latter is on by default).
> +See linkgit:git-config[1].

Would it be worth implementing a `rangeDiff.dualColor` configuration
at some point?  Dual color mode seems like something I would like to
have on by default, even if we are not making it the default for the
command itself.

(Again this is something that can be a future enhancement).

> +EXAMPLES
> +--------
> [...]
> -- 
> gitgitgadget
> 
