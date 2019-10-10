Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 335C01F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 18:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfJJSqL (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 14:46:11 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:50809 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfJJSqG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 14:46:06 -0400
Received: by mail-vk1-f202.google.com with SMTP id r128so2472823vke.17
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 11:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SYBvqr/GHU71s1UZJxfsmWo16+X9ElaliCntf/wLwrQ=;
        b=lrm1g4HjOkxfE9PFORJTJm6zG1aBbeE1dONEr3nexGBHAtV4vs0F3pcFBUFzeXFhGY
         PZPxtdLY6RHrnPismTx5rAnDZ/7ExVs0tSCl0kXdZq+jv5sOvatL2QIiEbhMNv4HfadD
         6s3BME383nnTwcgGY3WFwPVwpzJZk6Dz1C2vLTnWjopaCGjxMzZnqdkSlRWpEKIWP3p0
         T2lCbSmGl1e9YLrsFc+Ojww3KsDiNyRzxwMFz45Q49Kfk72PDI8xQGoy8AhmBfTPmcVH
         wti84EWUidDv3MbfZMIqlxI+F8xpPyXEvfvK2VL0caH9UsDTCspwTSE7y57iIp01v25c
         Mdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SYBvqr/GHU71s1UZJxfsmWo16+X9ElaliCntf/wLwrQ=;
        b=eljh4jnZQEISc8sd++/M80glBagr1FdinHXv7dZxivWDhr2N/Es3Bs8pcOQ/WDLlUV
         sa/Pac/n8v6dSA2Z4M2jc7JGTb3jeinpliqy8VXnR11UvV8rR2KHJ1vEx1nEroMjpkc5
         LKCu8MmSU059q50uHE7IRRhIXt4sKtlTYLPGdvbB9bBtsTDE7HG0gwz0dH5xptgNG8Am
         dJAVl6K/alb5UEr2lIJNkp04sw4aEtDFxBexXdyZ/gcOJ8+qqymLmtqGwXx1JdPEQXbl
         M7i9MKI8dASEzYlJi94+7u4SU/6ahTWwDC31LLas/8guycP90s1Byw5JMTub87Drptu9
         tBEw==
X-Gm-Message-State: APjAAAUoWBod5sFB1S/ob5T+QINaO8/WHlJZ7ziyeMTSqv7a0JpCRHVU
        AAzX+yyREea58JdZwAFBCWGVklF3Hr3RIci3IDVm
X-Google-Smtp-Source: APXvYqw5zLBFlHKv9cAgkAM2MG4t1ZJxeZhwRSTlYaTuXzdj8QAa9vlg0wo2vyiSxjGfg/yrVYGuDojU7l8cfuLL+/Rz
X-Received: by 2002:a1f:2ac3:: with SMTP id q186mr6287843vkq.57.1570733165391;
 Thu, 10 Oct 2019 11:46:05 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:46:02 -0700
In-Reply-To: <20191010114814.GA9876@wambui>
Message-Id: <20191010184602.95191-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191010114814.GA9876@wambui>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: Re: [Outreachy] Outreachy initial contact
From:   Jonathan Tan <jonathantanmy@google.com>
To:     wambui.karugax@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hello Jonathan!
> My name is Wambui and I'm one of the applicants in the current round of
> Outreachy applications. I wanted to write an initial email to introduce
> myself since I'm interested in working on your mentored projects!
> 
> I have been going through the mailing list threads about Outreachy and
> I found a list of good first issues to begin with. I'm looking forward
> to working on one of the most used system in open source!
> 
> Wambui Karuga

Hello, and welcome! Thanks for your patch in your other email [1] - I
have just replied to it.

[1] https://public-inbox.org/git/20191010115230.10623-1-wambui.karugax@gmail.com/
