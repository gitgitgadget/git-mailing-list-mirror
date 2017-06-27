Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 060A820401
	for <e@80x24.org>; Tue, 27 Jun 2017 21:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753669AbdF0VJL (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 17:09:11 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34604 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753661AbdF0VJK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 17:09:10 -0400
Received: by mail-pg0-f51.google.com with SMTP id t186so21423173pgb.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CqNGa8gUvmef+eDWNDJ3FpL2Ea1ZjpqcFLKZ6DJ7zkw=;
        b=tfu3uh/1rTSPBypB2DC3k7i0CSzIB/9tTt5/LHoB13BWR9RwCxDDEdmHHU5iE3cfYo
         2vG4Pkl/BhpZ8mLU+etxm217+/5yTSq7hHltmPD4iynOyViM75g19+mAiFuvhQfyRG75
         oiH2DIpTVU4lQXXXwJhZLp+o1i+3yriOUdano7ScBgTfzeVC0hsaWUY+7P3+oaxuPIym
         zUeWfy2QOFABUtOcv6yOSuJ5o5e45NDyA0gEYdSearudE+/E9O7MIVlpym8+Zgirt0d4
         3MUdlC7Nz7LbUHDfCSavtUJCIAG2b64Nw2ts8kFxI0TWwLWMXOD3UOCF6FD9PGxXl9OQ
         SGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CqNGa8gUvmef+eDWNDJ3FpL2Ea1ZjpqcFLKZ6DJ7zkw=;
        b=fcuFUJnW0r4IuyfKqDKCeIxKE9ONFjf6aWgRKLfKvFXRC+abnRvByL119+QDhII+Fg
         gx5Tos7BWogSfN+16NZddKftI1P/l84Fk3exixCh2XJEnmzgSsH/KKCxGwDFiGP69BY8
         ARtQnBP9gKrAHdkmYPeeIXvD67lMHnmh6O8V4uPuDkYwZal12Yv3Vc0lVaHbT6QBu78y
         JdRwxt6eI7W/egOmpovQK618GyQZEttP7ijJndbBGi24eaJZmJyL5LZo6CsePdaa/MzK
         ine4364BLhZZaUbTa/JX+1+fieB/9uuZwaa16tYdypOY1aZJ4RulRADgm1SzRd1H8hjo
         HEYA==
X-Gm-Message-State: AKS2vOwvQMXd4AWF4EF1M1qJx49IAdD3iYYyHTooQOqhav55iQkqjGah
        m1GXC+9m2BK3Lw==
X-Received: by 10.98.75.91 with SMTP id y88mr7235658pfa.227.1498597749193;
        Tue, 27 Jun 2017 14:09:09 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:fc4e:7a94:7527:a2f5])
        by smtp.gmail.com with ESMTPSA id d15sm251609pgt.44.2017.06.27.14.09.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 14:09:08 -0700 (PDT)
Date:   Tue, 27 Jun 2017 14:09:06 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Silvio Fricke <silvio.fricke@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] ls-remote: remove "-h" from help text
Message-ID: <20170627210906.GJ161648@aiede.mtv.corp.google.com>
References: <cover.1498591103.git.silvio.fricke@gmail.com>
 <c49b244848de20ad058a46023aeb266f4b361e4a.1498591103.git.silvio.fricke@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c49b244848de20ad058a46023aeb266f4b361e4a.1498591103.git.silvio.fricke@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Silvio Fricke wrote:

> This regression was fixed in 91a640ffb6d9 ("ls-remote: a lone "-h" is
> asking for help") and the wrong help text was introduced in ba5f28bf79ea
> ("ls-remote: use parse-options api").
> This patch removes the "-h" on the help text.
>
> Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
> ---
>  builtin/ls-remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Without this patch, I'm able to run

	git ls-remote -h .

This patch removes that support.  Intended?

Thanks and hope that helps,
Jonathan
