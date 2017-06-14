Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC0E20282
	for <e@80x24.org>; Wed, 14 Jun 2017 18:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbdFNS0M (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 14:26:12 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34203 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbdFNS0L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 14:26:11 -0400
Received: by mail-pg0-f68.google.com with SMTP id v14so1039949pgn.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b3T0H3lYHe+xwXBD73UNOjhh7Gs5nJQppUhf4X64ugQ=;
        b=uOR63SAGWeTkrOADsrQ8LG+aYYqNdZvvT1ZX+HR9WKhFqhixzga6HIlJ8lgRVmNaxQ
         ihE8DVu+/LOxzUVQ4lob291xXI0qY9AlF6RrOsae0+3rhPgA+Pffcujtk4IRi3cbfXl3
         MxcT4DeQfxNv5MI4fEx+1rys1JUGAyB8h+1sZhPtmY+pg+VBa/554dV0bFT7FGofpNc4
         nwGu/rmo51BfUxWEou5hx1XgvN+Ujz6BI3qiXlN1YfyBvVhpzy0YHzObZrubd1qJdyfI
         xxF4YagUcK1tWv/fGF3UkTHW5IjWMx/xi2g7FSIlGZNDl4mR3sCfgvhZYS0mEGi4kmUq
         ZaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b3T0H3lYHe+xwXBD73UNOjhh7Gs5nJQppUhf4X64ugQ=;
        b=ql7AC5OZOZdBHY1JvZpzPaGd+OXHUelGwoEm1BRJvsBCjegdHL3f3WVvnCg5DmQdb1
         O1kDFKFvyTDmfWnn7cJXM3P9vQDY0Z/7J4/631IL6fVkhCisQ0pQH32cFuLP6v9Zp9GM
         IWjsIRX+mo/sCTv78CoEPDq9oj95+542ccGZKAZdDG7+Jm9DA9b7CQG6LpNz4/O6GD9n
         Ql6kLWMei8Xv+jwU480zdGrlP4O4T+YA/wL2le+N9LhWATNSnQp1ztds7jJ8mvz4w7UJ
         EUhek8FvL9vysJeWe3xTberCcpw/L9ycKNmExppzGsEgzf1VkyTLitbl9/tdXOD/s56O
         0OHA==
X-Gm-Message-State: AKS2vOykh+hjw37RcmOUEpIKOXeQyfqFUxpt1DhIWJUYGCQ8E4d7CSfa
        AkRg8F1zymz77g==
X-Received: by 10.84.241.197 with SMTP id t5mr1543261plm.48.1497464770555;
        Wed, 14 Jun 2017 11:26:10 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8130:47b0:791f:5985])
        by smtp.gmail.com with ESMTPSA id m26sm1143809pgn.30.2017.06.14.11.26.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 11:26:09 -0700 (PDT)
Date:   Wed, 14 Jun 2017 11:26:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] sub-process: fix comment about api-sub-process.txt
Message-ID: <20170614182607.GW133952@aiede.mtv.corp.google.com>
References: <20170614151225.31055-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614151225.31055-1-chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder wrote:

> Subject: sub-process: fix comment about api-sub-process.txt

nit: this one-line description doesn't describe what was wrong and is
being fixed.  I think something like

	sub-process: correct path to API docs in comment

would be easier to understand in "git log" output.

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  sub-process.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

With or without such a tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

> diff --git a/sub-process.h b/sub-process.h
> index 7d451e1cde..d9a45cd359 100644
> --- a/sub-process.h
> +++ b/sub-process.h
> @@ -7,7 +7,7 @@
>  
>  /*
>   * Generic implementation of background process infrastructure.
> - * See Documentation/technical/api-background-process.txt.
> + * See: Documentation/technical/api-sub-process.txt
>   */
>  
>   /* data structures */
