Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D5032036B
	for <e@80x24.org>; Thu, 13 Jul 2017 20:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbdGMUPn (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 16:15:43 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35707 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753179AbdGMUPm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 16:15:42 -0400
Received: by mail-pg0-f67.google.com with SMTP id d193so8062361pgc.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Fp9gecIxrFobn5XwOwxJSmkKlhNuQw0YWa/WK56NlBA=;
        b=rhei1VnAlaGgy7ONfgzvChnVkx6VKxmRvz4L2YypL/pAJLNUAgAg/iG9Fx+GSlFacq
         frk1AdVYmGGOyf0MDLhyeAn7N2G3veBa6fD35tnnAD4z6WcvtUmvcK6azZMuVBCAbedu
         HbDOXdF6Wemmj5ckmnR+ZbbrXB1MAMWyOiRanDOxZWwJLEweXpuWJrrO5/CmHSi2+SJC
         yrw3ofEFhxX32b1eqAI6VZoK5U3sDObwKqc+yJvPKbOxCE/6muBpoxD+sZAp7XVkFwXD
         yzTsmfXVEC035Z/QfJi6ceKNPA0bNw1ZYfy5bnLwJgplAGKfNUhbrpxGZ/3SN9ZVrDMJ
         HvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Fp9gecIxrFobn5XwOwxJSmkKlhNuQw0YWa/WK56NlBA=;
        b=pfhTKg6TZRxLKNMEjlFnWQE3ayMLgM8IL1rzWsIYG6/43dun4UFmpEn8Fsk+N72f/I
         cEv363IDgF+jYeI+VGidEq7H9MoZfA0NzU8L7A07ftmeaUwTwxqi3sY18NSsGVsB7ZC1
         DbrHdf4B6ISjU5X3t/Q1x3vtEEWmKk5CuQ60MeOUNjpW6F/Mh0CNwkByTtRxbb2pDssW
         qPqTafcPE4RTYrqhmRIwTsC0mQ1mCZEjjysuOdMZoE8qoLR6hn+mb0P4Fi8ScHJWoTBu
         CP5vuLyfK/PqR9Ti7w4/en73os6BNBcJnJslsqPhDdfDqbvcO98IkQTRnc/HTnRDJKRe
         eqQw==
X-Gm-Message-State: AIVw1102wpBwjgHUHcf4Qqt1o7ooSN/IEEXNsaXWJZEpaAIGmbuG8Sxd
        k8ZGq74V5L3UxA==
X-Received: by 10.84.232.205 with SMTP id x13mr11793068plm.245.1499976941611;
        Thu, 13 Jul 2017 13:15:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id i27sm14741041pfi.82.2017.07.13.13.15.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 13:15:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 02/15] docs/for-each-ref: update pointer to color syntax
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
        <20170713145620.pwsyvsudtnyfcvxg@sigill.intra.peff.net>
Date:   Thu, 13 Jul 2017 13:15:39 -0700
In-Reply-To: <20170713145620.pwsyvsudtnyfcvxg@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 13 Jul 2017 10:56:21 -0400")
Message-ID: <xmqqwp7cum8k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The documentation for the %(color) placeholder refers to the
> color.branch.* config for more details. But those details
> moved to their own section in b92c1a28f
> (Documentation/config.txt: describe 'color' value type in
> the "Values" section, 2015-03-03).  Let's update our
> pointer. We can steal the text from 30cfe72d3 (pretty: fix
> document link for color specification, 2016-10-11), which
> fixed the same problem in a different place.

Thanks.

> While we're at it, let's give an example, which makes the
> syntax much more clear than just the text.

Nice.  Thanks again.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-for-each-ref.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 03e187a10..cc42c1283 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -156,8 +156,10 @@ HEAD::
>  	otherwise.
>  
>  color::
> -	Change output color.  Followed by `:<colorname>`, where names
> -	are described in `color.branch.*`.
> +	Change output color. Followed by `:<colorname>`, where color
> +	names are described under Values in the "CONFIGURATION FILE"
> +	section of linkgit:git-config[1].  For example,
> +	`%(color:bold red)`.
>  
>  align::
>  	Left-, middle-, or right-align the content between
