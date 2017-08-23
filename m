Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A0B31F4DD
	for <e@80x24.org>; Wed, 23 Aug 2017 21:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751061AbdHWV3T (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 17:29:19 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33371 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbdHWV3S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 17:29:18 -0400
Received: by mail-qt0-f194.google.com with SMTP id s11so717057qtk.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 14:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NQ0L1MGmskDEKIxi45QTV36nbR5jaJ+spIor342bUyM=;
        b=vEkNvuQf8HWwbZOOYugNKtut8j0hACiCfbUX9VXb51hTFE4dVFyaHKguHqiJKtQCbq
         xkdCO/ekMehAtCBaFtATgKm/EmNMf82NtjjDlt/fG5c15YJigJGIXGsAZ+F0PNQfZXXW
         gz/C1Ykd3NX+JpJDSbWHAZlxCxLkVlE83XgNW+h4NQN8AaFhUWz7wITm+kvAt8R4eh84
         pFP5iGiHio/w1izBDsGUIBt0tN2AMMZA5tYCxMJguwd6P8KlT1JSudnmVNo/ST+QAcBM
         sTrMWSp2dgadC0cpYccUJQrKL/Ih8jMx1DoAIHfk9W2x/+7raS71nsrDFB+6kOFH7yqB
         Gqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NQ0L1MGmskDEKIxi45QTV36nbR5jaJ+spIor342bUyM=;
        b=DxwrKsOHdHORevhSZMiWWT0EjjZt59YMoNGfz9AOBIELsI586sCjoSBOrdjTInUS5R
         cTJOkcTmoKJVxpk5RhN2pY8B9NC7IuDCztW3f0CfVuuFSbUEl2d5Fae5rX21WP+DZPRu
         42PLG1FlBeJYM8ppDLte6NtLXhcq13Bu8YpKV/67aePnfrl8DqPrW7QyqrUHQjdIjKeJ
         XeAPxGIFGqdxvi8AwPtzX9JS5aV9WlvNiL8PvkD6Z+GGCmgGrr9tH0N32JmT+9RsxSf/
         +1+2+6sNjN+pnZPkmcZ/Iz7UlVUIupiOlTZlwrfTIkUZr2aS67DBECJWqLfCrGpqdK2Z
         Xc4g==
X-Gm-Message-State: AHYfb5jWcrftFzxHUhJbnJBAWSiVGnfEmuf/bF5X2cClvLTAQuTCeDsl
        Gy+YSliCwnAJgQ==
X-Received: by 10.200.44.248 with SMTP id 53mr5954723qtx.282.1503523302955;
        Wed, 23 Aug 2017 14:21:42 -0700 (PDT)
Received: from localhost (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id f184sm1443077qkd.57.2017.08.23.14.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Aug 2017 14:21:42 -0700 (PDT)
Date:   Wed, 23 Aug 2017 17:21:42 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] Documentation: mention that `eol` can change the dirty
 status of paths
Message-ID: <20170823212142.GA1659@megas.kitware.com>
Reply-To: mathstuf@gmail.com
References: <20170822174918.GA1005@megas.kitware.com>
 <20170823211741.9633-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170823211741.9633-1-mathstuf@gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 17:17:41 -0400, Ben Boeckel wrote:
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index c4f2be2..3044b71 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -151,7 +151,11 @@ unspecified.
>  
>  This attribute sets a specific line-ending style to be used in the
>  working directory.  It enables end-of-line conversion without any
> -content checks, effectively setting the `text` attribute.
> +content checks, effectively setting the `text` attribute.  Note that
> +setting this attribute on paths which are in the index with different
> +line endings than the attribute indicates the paths to be considered

Oops, missed a "causes" in here. -----------^

I'll wait on uploading a new patch until after feedback on this one.

> +dirty.  Adding the path to the index again will normalize the line
> +endings in the index.

--Ben
