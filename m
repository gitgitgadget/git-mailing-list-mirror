Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298381F51C
	for <e@80x24.org>; Tue, 22 May 2018 22:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753373AbeEVWcM (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 18:32:12 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46741 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbeEVWcL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 18:32:11 -0400
Received: by mail-pl0-f66.google.com with SMTP id 30-v6so11729947pld.13
        for <git@vger.kernel.org>; Tue, 22 May 2018 15:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0bAgo74EmRLBH2qF6rhqFMHd1knOKztwsfDZsETEBis=;
        b=Dq8tS20sz+/YaPBC2O0jTKRtxO9d1HN9MeMeFS7rfncWUoddq4E8R73HVu7S3NLUm4
         rosP2aIQ/ZcsZfXrft4gdSJxDrcgQfLbUqg4N2BU+OxPtu3EGebJ5/OOEGQK2nwg/us9
         omGbWX3HWV9az1987xuS8Ds2YRPrF2Sto9PUqq/MJrXWQetPQbEavQ/vdm+JKd+Ykhin
         uBmMnz1dCVO0cghBY5mz9Ez0A6POg9Z2E1dGzsHcZb9o7MMC0oMJNns0qW0VICdMJt0a
         mWIgHA5oBB2ckKX5L/SsrAcUNv0nRHoSbMSF5+ZusiEK7s4nx/s7AdcOzo4ehtilS2yK
         8hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0bAgo74EmRLBH2qF6rhqFMHd1knOKztwsfDZsETEBis=;
        b=d/CHBKQydQqyLPSJjCqocr4bvQXCTdWe5e+ZZX4Nc+8T8pzfJajlxS4VmxbWrWxx82
         +4SDMSrrYJIXOywqRJ0IfsxeBiOfx6pJdAY6vcB8rVoSeYGgWfZM/1LpSTkXc0ggVUbG
         H2+1EQaT46V/IylqMinlgBWTKR9nCixkKlVBu0NqgfaFiLCPhL0gRJ5mDnyoRX8c0qb5
         CRNtl/Vt5SMNGaZvHfqBt3jdhzlysWvANCb8YO6l5TwYoTeKSz1utCG7B1RJjLl2OrUG
         gMdkKLaQsfC6J2CeUna8s8yqNzSAZmS/Z5Tx6AR/IWJ2dB4nsRz5/mcbZm3CYkFoyYn2
         kaNw==
X-Gm-Message-State: ALKqPwdfsEqDFxyVoZ/X/fEQP17WxXTIj1ow6biUshg0p1u3KR36pJ7H
        8lF2bYykcKWjwv08vFoHP8jRFPyw
X-Google-Smtp-Source: AB8JxZrJDIWGr0wTiZ9KEFkqQYF6yfHKCFoYt3ml2jHeqCd1re4N/swAoTH6LbD/ER9awTS1KIUl0w==
X-Received: by 2002:a17:902:9004:: with SMTP id a4-v6mr310919plp.143.1527028330885;
        Tue, 22 May 2018 15:32:10 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c4-v6sm12839428pgv.20.2018.05.22.15.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 15:32:10 -0700 (PDT)
Date:   Tue, 22 May 2018 15:32:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config: document value 2 for protocol.version
Message-ID: <20180522223208.GQ10623@aiede.svl.corp.google.com>
References: <20180522222718.81173-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522222718.81173-1-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Update the config documentation to note the value `2` as an acceptable
> value for the protocol.version config.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/config.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index a05a88fec..ce778883d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2637,6 +2637,8 @@ protocol.version::
>  * `1` - the original wire protocol with the addition of a version string
>    in the initial response from the server.
>  
> +* `2` - wire protocol version 2.
> +
>  --

Should this mention where the user can find more details (e.g.  by
saying link:technical/protocol-v2.html[protocol version 2])?

See the reference to the credentials API in "git help credentials" for
an example of how that renders.

Jonathan
