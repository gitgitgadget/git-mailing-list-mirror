Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A7471FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 20:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751068AbdFPUiM (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 16:38:12 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35163 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbdFPUiL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 16:38:11 -0400
Received: by mail-pf0-f194.google.com with SMTP id s66so8055316pfs.2
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 13:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fYzI6AzfO18azWzcB9jlbugpjWrMjoy59gwgRn3p8Q8=;
        b=OP6C+t+sbZf+EetEFhK+kQWudRGYhoSbhtDIsbZfUViYqH35hjjdnMwfY5Zqm/uoUy
         toD/lkXOrAcvpc1juPG9EFDKwjByaHNtMaoh6kxxz3lgkAathEI51lQ1k4psy8uXW/xZ
         IfRmlZnWjEok5KoFwjzdA6dluUxlicYnrFuTD1Z1l67+EhcUZC2qNIScDmRcrampR+Na
         s1oKLjfoDP4oCHFX1t30WPWbCm7rTHuJI1BLuKt1/D6n/R/rYt6ot+iaIfWcgJMjLwIR
         iB6JoxdiSTqP12evdBrVFOtfWgJhDQCJMGyLu2OCaDmf0cHHcXHWRwLZCJprHCtJxFB+
         5UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fYzI6AzfO18azWzcB9jlbugpjWrMjoy59gwgRn3p8Q8=;
        b=JHi7hHYnZHZt6Ttv/cuOixK7vJJNLJWCAGmvpBArzDKpvH5Q4m8/McT9cbTMomm2BH
         8A9rbxV1uzC+ol9qPDNRDR419ri0Tb8+44botIJyiEnvkgRYcCCFkhh3dwa/KQzOC6re
         GzcNMlCnijkl67c+Qkbz5O2kD7jYgL1mONyN7A0idCRSqEwhFgpCQ8Imq5YcbRzBHU3q
         2+nl5BqMeCkKP+KTP/gQAJZQqfle7kc2icvWD/Cjj+p71zDXqjHcJ1Rk0U+yTm/+JuzD
         fXympHbUZv3RIZe9Nz6PQF5y1EZL3s1mg+R0UU6M5kaF11f+bjIjNZcprnE7q6zNWDtU
         egdA==
X-Gm-Message-State: AKS2vOzIr8Gnq5ehkTNO740qLE7L4GqkNdFow0wrk1UvzFiNutWW0hwU
        4gMZNuvLS38W4g==
X-Received: by 10.84.142.131 with SMTP id 3mr14161035plx.33.1497645490672;
        Fri, 16 Jun 2017 13:38:10 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:61d1:2cfd:fa77:c70e])
        by smtp.gmail.com with ESMTPSA id u78sm6629400pfd.109.2017.06.16.13.38.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 13:38:09 -0700 (PDT)
Date:   Fri, 16 Jun 2017 13:38:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCHv5 2/2] Documentation/clone: document ignored
 configuration variables
Message-ID: <20170616203807.GA133952@aiede.mtv.corp.google.com>
References: <CAM0VKjmxtqB2zrWOW8T9O1ReWNPTZA7V3-Dei7GecB3nxVh2Dg@mail.gmail.com>
 <20170616173849.8071-1-szeder.dev@gmail.com>
 <20170616173849.8071-3-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170616173849.8071-3-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor wrote:

> Due to limitations/bugs in the current implementation, some
> configuration variables specified via 'git clone -c var=val' (or 'git
> -c var=val clone') are ignored during the initial fetch and checkout.
>
> Let the users know which configuration variables are known to be
> ignored ('remote.origin.mirror' and 'remote.origin.tagOpt') under the
> documentation of 'git clone -c'.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  Documentation/git-clone.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
