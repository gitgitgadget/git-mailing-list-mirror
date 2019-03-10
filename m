Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1EC520248
	for <e@80x24.org>; Sun, 10 Mar 2019 18:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfCJS0I (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 14:26:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43555 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfCJS0H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 14:26:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17so2652784wre.10
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 11:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EzT2TsFDKiW3MElOgU5GY3IedBSp2n08oVyXWDjWsAg=;
        b=slLUPrgBH96VbANEarHN5wfGtdQyHyh0zsc98nnDKPEnP4EOaczeBTfcKZXY9ZAMR8
         phnCTRuL09FSQ5HX8CVoc0auS2QZIMl4UqHPLFGE9m6sZOSkhh6fCQFuGySMy5xjA02K
         cgodid90N/g/NE2q+XrzL0QuahLeFE5YcG0kwrGULNa+p5rbWAE+dMNWQh+cSetKXkhe
         228S0RzLHG3GlNP58NO2+6qs+YN0a8bkX7bHTdRVnfPOE5eSXLfCxwzqVfxfDNts18jY
         yJbIh5tl8UsL4FdztXaQCvt8TrvzSlOTPmQ/l99gvSOgjRI98RW9Zxp1XfA+6FkGPTRI
         2u9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EzT2TsFDKiW3MElOgU5GY3IedBSp2n08oVyXWDjWsAg=;
        b=tXNuM7OTEbZBG7Mgon+8wRdfyDC9l+R2olJ/eBjOjq1gn1XuW56WE6ezU5cm0dggcJ
         UAOocnORyu0fBc9JwdRh5dCJw8hQqCXdB/X+JPE1BgDucWSF+uLK4H0M3/4nWZAcZ3X/
         nFKNJj1oyeA3OTGqoegbevcjRjqu1xQ6wlxJzy5SLDoeBF2+altMIGIGoxcZ2apb6Q7G
         X9+aeAKpXJFvtN8wvRD+Fj2gfp8MzO+m8jNKd1J0qKvIFoV4IrCjEP8CDF+YorI33eR3
         MuJf/cdb33LbVQGTK5MYSfvSt88TBmvjmnoiz8nw2WeyfT18EbMBuk/H9ksny8aRcaIu
         0NRg==
X-Gm-Message-State: APjAAAVRpPoOif0PBLI5Hnm4r4rzfm+o3EgebNfiLvxD6mnDEm+vS4uV
        NK6Cm/WZsm/ubnE9lQb+FQvuSyHV
X-Google-Smtp-Source: APXvYqyZSxlydEO47innrR52CnQadH9icOnMNpATO1qIVAIbaZ0dGIY0jCcM3DCzRraYrBx1jUW6qQ==
X-Received: by 2002:a5d:5111:: with SMTP id s17mr17451068wrt.183.1552242366278;
        Sun, 10 Mar 2019 11:26:06 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id q10sm3204092wrr.75.2019.03.10.11.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 11:26:05 -0700 (PDT)
Date:   Sun, 10 Mar 2019 18:26:04 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     sushmaunnibhavi <sushmaunnibhavi425@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSOC][PATCH] Fixed an issue which contained extra unnecessary
 code
Message-ID: <20190310182604.GG31533@hank.intra.tgummerer.com>
References: <20190310143126.GA13588@hacker-queen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310143126.GA13588@hacker-queen>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: [GSOC][PATCH] Fixed an issue which contained extra unnecessary code

Commit messages (and titles) should always be in the imperative mood.
The title in particular should be a short description of what the
patch is doing, and should give meaningful information to people
reading the output of 'git log --oneline'.  Also we usually prefix the
title with the area of the code we're touching.

The title above is very generic, and thus not very useful to future
readers.  Something like

    compat/regex: remove unnecessary if

would give future readers a bit more context.

On 03/10, sushmaunnibhavi wrote:
> From 5a6c233c6bf0a35aca000b32b9e936a34532900a Mon Sep 17 00:00:00 2001
> From: sushmaunnibhavi <sushmaunnibhavi@gmail.com>
> Date: Sun, 10 Mar 2019 19:37:33 +0530
> Subject: [GSOC][PATCH] Fixed an issue which contained extra unnecessary code

The four lines above don't need to be included here, as they are
already defined by the email headers.

The one line that may be useful here is "From: sushmaunnibhavi
<sushmaunnibhavi@gmail.com>".  That should be your full name, and
match the name in the Signed-off-by line.  Usually people just set
that up in the "From" header in the email, but if you are unable to
configure your mailer like that, including a "From: Sushma Unnibhavi
<sushmaunnibhavi425@gmail.com>" before the rest of the commit message
also works.

> Signed-off-by: Sushma Unnibhavi <sushmaunnibhavi425@gmail.com>
> ---
> Since '\n' and '\0' are char_len==1,it is not necessary to check if the char_len<=1.

This explanation of why this is a good patch should be included in the
commit message before your Signed-off-by.  If we want to apply this
change (which I don't think we want for the reasons stated below), I
think this needs a bit of a deeper analysis in the commit message, to
convince readers this is the correct thing to do.

Also please wrap commit messages at 72 characters.

>  compat/regex/regexec.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c

This file in compat/ was directly imported from upstream gawk.  We
generally don't patch this type of imported file, to make updates from
upstream easier, unless there is an actual fix from upstream that
needs to be fixed that's not going to be fixed upstream.

As this change at best removes a redundant 'if' (I can't comment on the
correctness, as I'm not familar with this code), so it is not worth
changing this file in our codebase.

> index 1b5d89fd5e..df62597531 100644
> --- a/compat/regex/regexec.c
> +++ b/compat/regex/regexec.c
> @@ -3799,11 +3799,6 @@ check_node_accept_bytes (const re_dfa_t *dfa, int node_idx,
>    char_len = re_string_char_size_at (input, str_idx);
>    if (node->type == OP_PERIOD)
>      {
> -      if (char_len <= 1)
> -	return 0;
> -      /* FIXME: I don't think this if is needed, as both '\n'
> -	 and '\0' are char_len == 1.  */
> -      /* '.' accepts any one character except the following two cases.  */
>        if ((!(dfa->syntax & RE_DOT_NEWLINE) &&
>  	   re_string_byte_at (input, str_idx) == '\n') ||
>  	  ((dfa->syntax & RE_DOT_NOT_NULL) &&
> -- 
> 2.17.1
> 
