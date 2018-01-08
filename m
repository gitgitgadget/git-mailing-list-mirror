Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73FC11FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 18:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755876AbeAHSgg (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 13:36:36 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34401 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755730AbeAHSge (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 13:36:34 -0500
Received: by mail-qk0-f196.google.com with SMTP id b76so2515917qkc.1
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 10:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yn8awq8ipJW3Dhix8qZg9/QT12qEbmrY1iNIibcEs6s=;
        b=YMpb4EKyN4eEbLcx0Wp7kHcruS1SkuO8dlI0utv6SJQicqBrk3dFTXszTlToo3fHZo
         y+qX7cpZUg82Cq9aBTF57SQcpv5Z73gSrSrDwjsndsCZ96NNgWPYZRmF9n3oZVqcgm05
         GWEJJ7nTeEaQbFS/hmqxHCyNaU3DqGAmf87mO/0OnpLwPAILRbmJGWHZaAGRYGoA5xkl
         G3oZ6RUKhiqkur7U5XYruEak+nQg3AN+hzedzC45lBlBTT1zhgmnDeu8RDPcK5wnwuVF
         ZMb5SRiabWqJITvW1RQiInlq/HTDjMKiFBf1JCwon1MiisF0EbmB30JO00Qxj8kPZCKt
         XLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yn8awq8ipJW3Dhix8qZg9/QT12qEbmrY1iNIibcEs6s=;
        b=h0P/6onD2SyF60g5DqhC2TUkfJnHkJoQ4ha7KjIhX4aKveEB18eNz2DZ03LSvO4g/q
         Y815uB/fxb09uf6FWUncMk4UWdGSpGOZaUQ6wZKqctdcnmRb20njw4q/zciC3WYprbJn
         ZAZ9SUNx1vafHyTuRil1f6EvugtQN35JSDLwWNA8EQvQQDCz5+flpQwReDQPMsAHwMLH
         peQCE73FJDvrxuHCRbloHa9aYEGD2LVgeTpR3OK0WImRaSJ2LzyOE9AZ+NmRtfEP/yKV
         D7YIBa9kt/zEbg3BBY5mc2fIbIZoP2Vm08WOQlQCg6Y1YfQaatuUjaJ5G5jMPOLywWgP
         lZpQ==
X-Gm-Message-State: AKwxyteIT5hqlhfiJf5DZ8Jvr+VnhCm0ubRyar5yBotMnO0iXT9HyAdP
        6xCnywVC0zinqksNzxWU9vAiNsrJ9TRkWw5vnSYVBwWz
X-Google-Smtp-Source: ACJfBotlbk7QA0RunqVcnrSUveV3yzrUsan6tjzy3VXwgRe3e2qv59LvlnKTbbLBsVe1PiqUQ2KQJjQX3vstrIObcQk=
X-Received: by 10.55.72.75 with SMTP id v72mr16807933qka.295.1515436593392;
 Mon, 08 Jan 2018 10:36:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 8 Jan 2018 10:36:32 -0800 (PST)
In-Reply-To: <20180106184614.20115-3-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com> <20180106184614.20115-3-kaartic.sivaraam@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Jan 2018 10:36:32 -0800
Message-ID: <CAGZ79kYyUcun4spUKVsOb+SucCe6=1cizrfH7hrFoyKteWZ_9w@mail.gmail.com>
Subject: Re: [PATCH 2/8] Doc/gitsubmodules: clearly specify advantage of submodule
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 6, 2018 at 10:46 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
>  Documentation/gitsubmodules.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
> index bf46b0fb5..cb795c6b6 100644
> --- a/Documentation/gitsubmodules.txt
> +++ b/Documentation/gitsubmodules.txt
> @@ -57,7 +57,7 @@ Submodules can be used for at least two different use cases:
>      * Size of the git repository:
>        In its current form Git scales up poorly for large repositories containing
>        content that is not compressed by delta computation between trees.
> -      However you can also use submodules to e.g. hold large binary assets
> +      Therefore you can use submodules to hold large binary assets

If this improves readability by a lot, I'd be all for it. But this use
case is just
exemplary. There are also cases of submodules that do not contain big files,
but e.g. have a lengthy history with lots of small files.
So I don't know, as I would want to keep emphasized that this is just
an example.


>        and these repositories are then shallowly cloned such that you do not
>        have a large history locally.
>      * Transfer size:
> --
> 2.16.0.rc0.223.g4a4ac8367
>
