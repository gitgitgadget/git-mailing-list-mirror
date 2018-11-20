Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C2B41F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 21:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbeKUI3Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 03:29:24 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:44407 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeKUI3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 03:29:24 -0500
Received: by mail-pl1-f172.google.com with SMTP id s5-v6so2245415plq.11
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 13:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UFHIerlR+Wt43dyLtVWK4dNfitIycoZlXFKnOLuoNJY=;
        b=JKJU0bpDrs/GigE+0HpBiLDCqzypPqdKGxYXOgaeFSYns7Z6oB16SLtB0fp8HL93zx
         P4vtFQfTcT0yfrhHe9ghmXaGRA9CxjRH0Mzpn6SKqQNh/PaMUPl9Qe36VI33U/2wSXmu
         unLlOdLsjrMf4TzujGA6C+yg0RKn2OW4FUNq0KiRGUq0bocM+0mhDJPCyd2ENKcmvVv8
         wYqpvDCSJOalfwWsKfF9GmzWOcoS966YkCkGw9gOjmTHswmFj6GxVkjIz/IJzXUg86CG
         lXFV3ECcMxmQDuM2R3xXqPfDTrYDZemVIH5ffXvEf7PxG6J1PfJe5KGO/OpvTQYkbOn0
         yCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UFHIerlR+Wt43dyLtVWK4dNfitIycoZlXFKnOLuoNJY=;
        b=KceGNXMFKEG8NavMbytCE9MNqzFRaLn/93kwtwKijkZHLLjAgJ2wDNIQRUR/H/nkTb
         WjUN40LIIZJqaBtJ+cN9G1ul6ufqwCOiIa1Evme4HhCDuNz/EzB2ldw0labN8q4J+q9x
         YOe3qqHfKrjAh/7luTb8SY1oAV7074kTgb5Dgp15dnAd40Mv0mYPTxVnuWJ2dAHm847d
         QrsNoxdfr1EpKBz5kjDxFOFDFwh1W5uljA4m/yMNUetTSI5tJ4qtwiNHHRbavijbqqN1
         5qUFqfchSJQjhIQYg5h5UM5l/XYZ2DkqWg3IYAmPSKPW06kNyX+Su9TQJyvN2MkCgIm3
         i1xQ==
X-Gm-Message-State: AGRZ1gKi+ZEB/dis6sM+5uWfk3zF7AgwK7BKkTutRJrMCEwRyO2rDanx
        0kjjUXwJAtwHHg5uvI7Wx5A=
X-Google-Smtp-Source: AJdET5fM4G1kHsuwgVf90vQTu7nkVbKyy9LLGVtDKE8wApyq3gESy7EsEg+poBM6lV4GDWTRBzJmew==
X-Received: by 2002:a62:a511:: with SMTP id v17-v6mr4004052pfm.18.1542751086034;
        Tue, 20 Nov 2018 13:58:06 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id i123sm24699727pfg.164.2018.11.20.13.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 13:58:05 -0800 (PST)
Date:   Tue, 20 Nov 2018 13:58:03 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Sven Strickroth <email@cs-ware.de>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] .mailmap: record canonical email address for Sven
 Strickroth
Message-ID: <20181120215803.GA149929@google.com>
References: <15b7df69-25d8-c168-dd43-a43b7fee23d2@cs-ware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15b7df69-25d8-c168-dd43-a43b7fee23d2@cs-ware.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sven Strickroth wrote:

> Subject: .mailmap: record canonical email address for Sven Strickroth
>
> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---
>  .mailmap | 2 ++
>  1 file changed, 2 insertions(+)

Thanks for taking care of it.

[...]
> --- a/.mailmap
> +++ b/.mailmap
> @@ -235,6 +235,8 @@ Steven Grimm <koreth@midwinter.com> <sgrimm@sgrimm-mbp.local>
>  Steven Grimm <koreth@midwinter.com> koreth@midwinter.com
>  Steven Walter <stevenrwalter@gmail.com> <swalter@lexmark.com>
>  Steven Walter <stevenrwalter@gmail.com> <swalter@lpdev.prtdev.lexmark.com>
> +Sven Strickroth <email@cs-ware.de> <sven@cs-ware.de>

Is the above line needed?  It's not clear to me from the commit message
what it does.

> +Sven Strickroth <email@cs-ware.de> <sven.strickroth@tu-clausthal.de>

This line looks good.

>  Sven Verdoolaege <skimo@kotnet.org> <Sven.Verdoolaege@cs.kuleuven.ac.be>
>  Sven Verdoolaege <skimo@kotnet.org> <skimo@liacs.nl>
>  SZEDER G??bor <szeder.dev@gmail.com> <szeder@ira.uka.de>

This line does not seem to have survived mailing.  Fortunately it's a
context line, but thought I should mention it for the future.

Thanks and hope that helps,
Jonathan
