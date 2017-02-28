Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F98D201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 17:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751589AbdB1RnP (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 12:43:15 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34525 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbdB1RnO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 12:43:14 -0500
Received: by mail-pg0-f65.google.com with SMTP id s67so2359664pgb.1
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 09:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vLGaDQPH86A+Hi662q5XjSL1Tnh6RecN0+jdzBWyjXA=;
        b=d1yM5LopO/wOy5cVWHBZxsDHS0oo82CVFG3GHJhPU/Koze8GVfKjDdqhJtYWzmjOQE
         ja65AHhOq/WHA4g3snAnzIXDJnaN+pVc3orbsnfiSQUvKu+ZVAmeobOTiN/f/1JjiC+w
         XZF79gj1GQpRSEAuXr3Morhc9nobpSV/c06AxlhvlcLnx6IQFrXJ4P/9+xx/tvNeUF93
         MC7yVcH6PxfLRdtqw//aU4eGxJVOBGGGDp4Nb5b4aI2XaUIH5L9FiSBpjgZ/HWg5UOBh
         2ouJbbj9q5g8risz4XesuOP5ALaUnyFnC7tJtGBcb0QM1zUdnwasFiLraW0+kwkcONQA
         Kxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vLGaDQPH86A+Hi662q5XjSL1Tnh6RecN0+jdzBWyjXA=;
        b=EQBQA2VumQtKdX+p9Ygku0ENDPnrsWK00O46d4su25cRQNXgJua8OvnXqd691ooMPk
         v0AUz7KGlddd6LGv+PhK9BtWCSPUQ6hY97SzesVMtveqcXguNVobUbOSozKUIyinsoFD
         NusiwOfL958OPtfkFtMW2yvQyxZ3gug8jTPOO/1/F/7YeCKVHb6pCr0lEThGov5K9yu4
         5+1VhXc87PS4jkBj6b9s3DAYu+C2Ds2VIWrWPeg/dqnReA3p4pbmalqvpe1cFwSSF/iD
         9e3mB36BVk1mCSKtTQ0qnx0y6wnhao3eFZV8zCXU8g1YRAb8i3CCDKJkX53irINLfczy
         vRSA==
X-Gm-Message-State: AMke39k5c+oFHZvb4ifDeAwI1gvFKQnvugYm+ix6YbNL0HLd5m/hBd/NFnQMDFcKLuQHAQ==
X-Received: by 10.84.143.195 with SMTP id 61mr4539964plz.46.1488303134248;
        Tue, 28 Feb 2017 09:32:14 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id c2sm5461372pfl.61.2017.02.28.09.32.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 09:32:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <patrick.steinhardt@elego.de>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/2] docs/diffcore: fix grammar in diffcore-rename header
References: <2882e77a58e4219d60a39827c3ea8d4537d5178a.1488272203.git.patrick.steinhardt@elego.de>
Date:   Tue, 28 Feb 2017 09:32:12 -0800
In-Reply-To: <2882e77a58e4219d60a39827c3ea8d4537d5178a.1488272203.git.patrick.steinhardt@elego.de>
        (Patrick Steinhardt's message of "Tue, 28 Feb 2017 09:59:04 +0100")
Message-ID: <xmqqr32ikyqr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <patrick.steinhardt@elego.de> writes:

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/gitdiffcore.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
> index 46bc6d077..cf009a187 100644
> --- a/Documentation/gitdiffcore.txt
> +++ b/Documentation/gitdiffcore.txt
> @@ -119,7 +119,7 @@ the original is used), and can be customized by giving a number
>  after "-B" option (e.g. "-B75" to tell it to use 75%).
>  
>  
> -diffcore-rename: For Detection Renames and Copies
> +diffcore-rename: For Detecting Renames and Copies
>  -------------------------------------------------
>  
>  This transformation is used to detect renames and copies, and is

Thanks for carefully reading.  Both looks reasonable.
