Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56613C433EF
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 13:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D22F6112F
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 13:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbhKMNII (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 08:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhKMNIF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 08:08:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49E4C061766
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 05:05:12 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r8so20482821wra.7
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 05:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AAlVVae6hea/nwptHOSzo1ocPmWtWLJCCRdPqgrrOps=;
        b=EDPJyxi7mPUF/02Fe4u8ns+JaYoslnB+DMtw0c+F6oH4N3w6ug6UZjc4V+bJjvu/oq
         u+KNFEIinVSlwPAHfUt/WXL05Hdxoa/OtHbUR32TrNqH4cy05kG9+giPg2U/2XBAzv32
         SgXpMadIgMR0yUdPSVyZ59MmFu8s9TnlsDCC8DAYDCsNpZTLef8GExqvAPkN5QryKRfE
         Kszja6k5YBvzTneIgqU9F3I2Z58BBMRVIQMIj9FpM+SKSvBDc6yJ8QHsNdjIQcUmcWk0
         /uIrEEcq3y+upcmqg6RpZkKEy5moGZsxdj7Jc5gWPsM16C0PMl2sGaQXPtdw6LAIoFee
         VTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AAlVVae6hea/nwptHOSzo1ocPmWtWLJCCRdPqgrrOps=;
        b=CFqiWTX+lLKUQICf0CNri+AoK/XPO1x+FVR5afaTIa5Wc40yxtEG1HzGolYH81mb9+
         1stRmc1azmHHB+RqhIMo9Hmmamzh2CVK6D8qtENs76BH/p7wccaBx+bSVFPESViRL9EW
         CGyTZn88dWqfAcaJ0ncB6kUHeWiFzdpj6a4o0mIj19LG6frlZhrQhyT+UybfSD8r3pf4
         +l6lorElPhMbaLb4d5G9OgT0ep7L7oqw+Ot9CUeMuZpKBp+UHYl6HK4ydUJzskF/pw0D
         5SvT+VZ1ztbpHJAWeM7w9RvxmOuDSvVS14sw3aqL0kdI3OXCafJHtHRdNhZrW/h7cblV
         4myg==
X-Gm-Message-State: AOAM533stCqs9Odw5HJX5cGT6WvXVBrysEq9IKOYUtsokL9MtjDQ458h
        Jhh0aLlGcvJ/+Oi+rMzsbnaw0O6Cerw=
X-Google-Smtp-Source: ABdhPJwD1RG+vJy3D0v2M4VCunildil/E45RvodAgfE7sCr/DhYK1EjGVbQPCAht6eM4vOB9XnM4bw==
X-Received: by 2002:a5d:584c:: with SMTP id i12mr28738909wrf.95.1636808711479;
        Sat, 13 Nov 2021 05:05:11 -0800 (PST)
Received: from gmail.com (194-166-80-250.adsl.highway.telekom.at. [194.166.80.250])
        by smtp.gmail.com with ESMTPSA id f18sm8387405wre.7.2021.11.13.05.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 05:05:11 -0800 (PST)
Date:   Sat, 13 Nov 2021 14:05:08 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Saksham Mittal <gotlouemail@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] MyFirstContribution.txt: fix undeclared variable i in
 sample code
Message-ID: <20211113130508.zziheannky6dcilj@gmail.com>
References: <20211113122833.174330-1-gotlouemail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113122833.174330-1-gotlouemail@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 13, 2021 at 05:58:35PM +0530, Saksham Mittal wrote:
> In the sample code given to print the arguments given to ```git psuh```,
> the iterating variable i is not declared as integer. I have fixed it so
> the error is no longer there.
> 
> Signed-off-by: Saksham Mittal <gotlouemail@gmail.com>
> ---
>  Documentation/MyFirstContribution.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index 015cf24631..434a833a0b 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -297,7 +297,7 @@ existing `printf()` calls in place:
>  		  "Your args (there are %d):\n",
>  		  argc),
>  	       argc);
> -	for (i = 0; i < argc; i++)
> +	for (int i = 0; i < argc; i++)

It is declared, there is an "int i;" a few lines up.
