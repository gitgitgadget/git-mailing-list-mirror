Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAAFC20282
	for <e@80x24.org>; Mon, 12 Jun 2017 04:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbdFLEdT (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 00:33:19 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36108 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752000AbdFLEdS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 00:33:18 -0400
Received: by mail-pf0-f182.google.com with SMTP id x63so47073156pff.3
        for <git@vger.kernel.org>; Sun, 11 Jun 2017 21:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZEmM0ZOn4fGO0n0nKbBwA0H9uysihH+ezyXxseDfRhM=;
        b=bC+j23penx17e4xNl2bseQG1Czkeq9ltNzNRLCawUPP1J0ASONlydGVgG85X4nPoGc
         ctf5eeNhNDdcWWv1M71SirPx+MIXB289ekgxpntQt5pH8MJHiwkznEHaw21+rbL9M5Ox
         ywyPT0o24ZkIsngREBNh6Jjj9cn/NoeqrOJQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZEmM0ZOn4fGO0n0nKbBwA0H9uysihH+ezyXxseDfRhM=;
        b=PHla4XyZLS9LsIZQ67NlRSmSXmvZIXyzghDnipQ71x4XueEOLS4hhvH4JnJAFnugpb
         S6e1rw5iOfOmFxm6qEd+206UAM6wetCedxcawvYvUZmQggAPFHTnOvOI1Rbw6OPSEGKg
         la91dAQQY78AttFzTfP4HM2pXoSoPtOWO+IqLP9UqicWnsVt2Qjnq6h03h3gH6dP2DHG
         7ZZIAwqNIlHuas7ZNqkl6VQQgLjV0kvNdFVSXQmkK8jVU7kAmHTOQuxdtmFG3G0CPvyi
         ivhCMT5pOVRWUvNWCIJvFQr9Be2XNgQsE4OFXAk5TniozVstOAHcA3vUDrLglKl6tkiK
         rcCw==
X-Gm-Message-State: AKS2vOz11+ddCOaToRkKUppoXpGMFEPI2BX2UnZv4dPZX81DqUWXIWhr
        D3B+UUfTNQoZre3geS2WoQ==
X-Received: by 10.98.144.132 with SMTP id q4mr5428251pfk.8.1497241997825;
        Sun, 11 Jun 2017 21:33:17 -0700 (PDT)
Received: from localhost ([122.172.35.3])
        by smtp.gmail.com with ESMTPSA id x64sm17750133pff.123.2017.06.11.21.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jun 2017 21:33:15 -0700 (PDT)
Date:   Mon, 12 Jun 2017 10:03:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] send-email: Add tocmd option to suppress-cc
Message-ID: <20170612043313.GE5297@vireshk-i7>
References: <6367777092d93a62cc83c444061dde853ba3369e.1495107179.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6367777092d93a62cc83c444061dde853ba3369e.1495107179.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18-05-17, 17:05, Viresh Kumar wrote:
> This adds tocmd option to suppress-cc command which already supports
> cccmd and others.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/git-send-email.txt | 1 +
>  git-send-email.perl              | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)

Ping !!

-- 
viresh
