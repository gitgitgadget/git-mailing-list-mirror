Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB8B8208E8
	for <e@80x24.org>; Mon, 23 Jul 2018 17:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388064AbeGWSnc (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 14:43:32 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43113 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388037AbeGWSnb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 14:43:31 -0400
Received: by mail-pl0-f66.google.com with SMTP id o7-v6so518758plk.10
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t8ax6IVjQOa4ECfb2F4Alss9Irx79lqaqxTjpki3hbY=;
        b=AqnD7d/qyHWyz/TGkTbBAa80rk3/nBAHEAsrHdv4TvMO9dsehoo7sgW4FWVImyG6+Q
         x3vldnIeeHHO14m6JzNhpHaEzk/4D3l35p3wC8pbhQy0Yl+rrv10QrY7O3GVpoyJHxIz
         4SBWy48KlDfG84Ohb+6zTcUkUMpk2UPGI3EPijoSQY5Igi8oZjAwTik1bwQQIvHQnEFJ
         9jJmZHXBa9pNQX2G1R4xA0U/HANJm/Di77wGjmVKjEsoEjWXgQPZuYBLAe1o04dsW1JG
         BJ0vYQtgXCJboONXjVo3QMKDIIlmVCpcEQJEaCcq6nWYi69WBwTUO7rjKuHvmVxie4sd
         7dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t8ax6IVjQOa4ECfb2F4Alss9Irx79lqaqxTjpki3hbY=;
        b=M8d060D+pz/k1AUyrh0W/2mRlec3/XzRPYe5phZFhAmDxRcov0NcEFNtltS25AT4em
         vRSFu0bqa0cSxEalld11YLgvyOTzVVG9tWxN645Cx50XiiKiy5IsKsAVvfNVmOpYjE1K
         iG4p9nI1idFDLg/j1s3elUG9RGP9Q3tHxLguNXPU3LrkHUegbKGuGhdK9vWVxbSttUJG
         P4ipIrsxhRckywVdxWkTk4fEq4u39vlsjkYbLSlB56k6iy0Uf3ml5sH7WszN+Z+uIkzJ
         x+7Z7KUP0PtthmXZ/+mjzFqk9NxDecq892IVQOTmN9prwYqSNwbECi+H4Ji0pqz0EkWI
         VUGw==
X-Gm-Message-State: AOUpUlGmgeaTy7I4iTYVB1X89THg6nIbzxHfndnkWycYpVjJN51jy0Ov
        kuYCsWPkQZ4eqBRNywoZSpw=
X-Google-Smtp-Source: AAOMgpexrWNqqJOThFW+f7rKunFPQqJyTe+3I/J45fjkjU8APoWUPlDmStB7aAkGrrJFNZ+PReeaAg==
X-Received: by 2002:a17:902:8f96:: with SMTP id z22-v6mr13818989plo.190.1532367673859;
        Mon, 23 Jul 2018 10:41:13 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id w70-v6sm14024507pgd.18.2018.07.23.10.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 10:41:13 -0700 (PDT)
Date:   Mon, 23 Jul 2018 10:41:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/9] vscode: hard-code a couple defines
Message-ID: <20180723174108.GA9285@aiede.svl.corp.google.com>
References: <pull.2.git.gitgitgadget@gmail.com>
 <3770bd855c6f3e69acfe418ea7fe5b40454e4dfb.1532353966.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3770bd855c6f3e69acfe418ea7fe5b40454e4dfb.1532353966.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Sadly, we do not get all of the definitions via ALL_CFLAGS. Some defines
> are passed to GCC *only* when compiling specific files, such as git.o.
>
> Let's just hard-code them into the script for the time being.

Could we move these to ALL_CFLAGS?  Is there any downside other than
increased rebuilds when options change?

Thanks,
Jonathan
