Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 202D61F597
	for <e@80x24.org>; Mon, 23 Jul 2018 21:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbeGWWcL (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 18:32:11 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44992 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388077AbeGWWcL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 18:32:11 -0400
Received: by mail-pl0-f67.google.com with SMTP id m16-v6so753628pls.11
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 14:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FFWLBKhGrYWW7KJQgAaWrndKukwAYP2nqEwUONVGu+U=;
        b=nc22Gyyd7dfV/r2+2S7aDvmwV6HHfFu0pJgIFgUKvA9SjGGiIRkTJvq5bYlEiqSiDM
         yIMPTBIXktmo4BdNUiDmTjFwheGrtr6BsNqFYox8w1meRGU1k6NBFXzhRGk5X76CXrBp
         q00PI/8hRJx3iK44ILjI7qI+q99nd4CeD83clH7Po/HG4/aRIKaV7i0xqHR6Sz0Q2dUE
         5MUAuOyZBWAE0tf9QkkKnD9e2eLk9mtaGjobq1HeFYsUFxpVEjZv3pQ6CbH94r9eFbPA
         Vih+fAoI5Vt3vHeYiamwSXbeE9r0EA597qpTIuTRVqYTVTAt6WmGqSgi5BMNnXifcrLz
         agqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FFWLBKhGrYWW7KJQgAaWrndKukwAYP2nqEwUONVGu+U=;
        b=JMnf5Y+nFGqB96CyvyC06RKOOcj0gRaW5cckBvI9CKE50mDewqRoxvzy3+sTzH3Qpb
         UaUHGMGHyLogISQxmnjx66BjSyR3Ns4dYnke3XL+/bh8VTovhibVFvGlvXrrBXsYR4BH
         PAa9uc+bQZcGJAFCPHPM+53anFPFvcuUuuLfDNZvzj+RJUscwsEgcAsMg7VUetVe/OiB
         LI36BjNtNDJKQzpHgJyEF+Sj4s+irqN21l80j9MM7In1dEuDJf/uUpV5zClhT/5eIQNj
         J0kKr0lujVTWCQsw0ChJP0CksMcd3YFVkDZctnD+m+MIc6VAOnv4S1HbgYTaAVIXo1Li
         Hf5A==
X-Gm-Message-State: AOUpUlF14UQKMtdf2PdPJbw94L0eRUUjMYrMBUNlhQq2oAeNFWkVf0k9
        lKMLIld85DBLeXtP6Bu6w5vkUefB
X-Google-Smtp-Source: AAOMgpdralCjCzAPuAVqT9NN7iYwkKJxsrqtgt8pLFuCSQpwkbcOWiVogLF/mT78yAdGh11346qzZA==
X-Received: by 2002:a17:902:76c2:: with SMTP id j2-v6mr14243042plt.19.1532381344067;
        Mon, 23 Jul 2018 14:29:04 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e185-v6sm15262344pfe.172.2018.07.23.14.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 14:29:03 -0700 (PDT)
Date:   Mon, 23 Jul 2018 14:29:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: mark die strings for translation
Message-ID: <20180723212902.GD9285@aiede.svl.corp.google.com>
References: <CACsJy8CJG5RCL40vCbNnQMHmtjQmch9qntxeh_Pt6ZUfnRN9uA@mail.gmail.com>
 <20180723175635.31323-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723175635.31323-1-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  fetch-pack.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
