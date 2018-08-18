Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01E01F954
	for <e@80x24.org>; Sat, 18 Aug 2018 06:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeHRJgE (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 05:36:04 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:51857 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeHRJgE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 05:36:04 -0400
Received: by mail-it0-f49.google.com with SMTP id e14-v6so14259028itf.1
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 23:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7v6zQ3idoMEqNjywu9DGT46mhw6LzAxeF3NRIFFgzCg=;
        b=ZF2rCDj/3EPdAFjz7OpppsRVEjJ00oLrbHgUVCo9fZgcYadPmE7w5JPoIMqzpLQG4N
         i1+nT7XVwF7vWtmqs+MFZS9lwi6j6htamjrVI9Lu7QWVwuNRVYB7X8AfC7Z1JiRv8TiJ
         6W5C8a3XXCKmMnlGdQG2hpzXFFpc+0xQ+zzwnUzbQ3da1enPdi6RSgoADcmOLFIDZJRl
         Uq8ebhTmoFS4FY3E0pi47jOQks7+vhix8ETqtWrTLAzH8khYcXqRehu19u1D1nM0kkgg
         ywz75R4ZudUV/eoKlHJ7Rbv/nQO5XVOXXoRZaHV8x9xGLsh3apZCfbnNUKVvNDIQUQxW
         cpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7v6zQ3idoMEqNjywu9DGT46mhw6LzAxeF3NRIFFgzCg=;
        b=WKsR4OcDD0cZg8DNkICfIFkIpsTsF6jNHVG16vHAvK0+L4FGdOcUrPBOXKtAtYnvZZ
         6Mk/aCCnfMniNcBC7Uuiy/yn1Ybrxu4FnLpPCuE36eBBxsi5aEDhhujEkSoDi/yW5KnV
         W9gTuxT8e1aO2rYNKdY5Xs50HPzsGKkKcIK0D16JwS2wdFXJfxq3zW855oiwStRyDzIh
         V8Zg2RBCsEqUcLqwGAiS+sRnfojwjBABPg5BCTL/YY6EZpIuglk374S0XnRroJ9ztZTB
         DLoK8rPQRXZSvxPuiXTZabiAsiCAyhTT6cb6JYDXWcvmyuXSBmld7GyRurKUZzXtx14S
         2uYw==
X-Gm-Message-State: AOUpUlFgr+uxjF6S3+shd6uBCERZIBMhijNncmFCHQYSPUa0rGZaLQ50
        IYDT4JP+Kzlatqcl5Ip5dyhvvhBAI0cTyY9wY8Zdc8ly
X-Google-Smtp-Source: AA+uWPyMkk41Yiui7YZc47iBMwF7YkeyAzmpDx+kzsyv/h5v4LCvT54NoRoAbxJzR9odvrN+HP/FPfsbd+lfpW6BgIA=
X-Received: by 2002:a24:328d:: with SMTP id j135-v6mr6732627ita.5.1534573771248;
 Fri, 17 Aug 2018 23:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 18 Aug 2018 08:29:04 +0200
Message-ID: <CACsJy8BCJSj__vmw-S0komzWyQGyFS0GjXT1fV6VCX_MLPXwHA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #04; Fri, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 18, 2018 at 12:44 AM Junio C Hamano <gitster@pobox.com> wrote:
> * nd/unpack-trees-with-cache-tree (2018-08-13) 5 commits
>  - unpack-trees: reuse (still valid) cache-tree from src_index
>  - unpack-trees: reduce malloc in cache-tree walk
>  - unpack-trees: optimize walking same trees with cache-tree
>  - unpack-trees: add performance tracing
>  - trace.h: support nested performance tracing
>
>  The unpack_trees() API used in checking out a branch and merging
>  walks one or more trees along with the index.  When the cache-tree
>  in the index tells us that we are walking a tree whose flattened
>  contents is known (i.e. matches a span in the index), as linearly
>  scanning a span in the index is much more efficient than having to
>  open tree objects recursively and listing their entries, the walk
>  can be optimized, which is done in this topic.
>
>  Will merge to and cook in 'next'.

Please hold.

I was going to address your "The last step feels a bit scary" comment
by auditing and adding some cache-tree validation. I'm seeing some bad
cache-tree when running more validation through the test suite. Maybe
it's just bugs in my validation code, but better be safe than sorry.
-- 
Duy
