Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45C531F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbeGJSSN (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:18:13 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:36109 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732200AbeGJSSN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:18:13 -0400
Received: by mail-wr1-f54.google.com with SMTP id h9-v6so15600371wro.3
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hx0l8d4pi0dxm7qXYX8jG0qNz4LfyiSx2pX4iA6huX0=;
        b=Q+IQjfcMGMSgBLkiXrsMVlUdxJDx0ZsEyVLzLn1xlZvV/fu1jBgfyQmO4az3c5YZWH
         N3pDuZ79WxohINP3tzsL/99SxY7EvGuNdS4Fd8d9fW056P04hSBxYXWPKztHU0Un656Q
         Gcsx8lnABCQWzLfQ1cIniDYaDaJjhBQrPGGeCNJzZxmA9tI7YyYbZDFe79Xv2W6v9T6E
         NWWnWB8lxQvzp3gG0S9iY7fWToNVEn3lg+x93qJsdSv18RBZ9u38CI7Fyb1TunNd3ykn
         hXI0kKA4Y9tX9eqYCK9dXQoB0vWDlRSIM7+QJhcf9AyQMIDrOFE9iSouknekC3ZC+Cte
         CFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hx0l8d4pi0dxm7qXYX8jG0qNz4LfyiSx2pX4iA6huX0=;
        b=dxP2/8g1SZp6HRTZovLZ0NTdmCaMuGwgZ+UOqCbBZ7cblN+nougr1IZP9H2cYiz4qx
         tfFgHZ2pPHAd59e+HN1krp4kQ0T6wBmG81bYQknd4ipR0UNE1R7LFA16m3yTnWCNbqRu
         f30tR8IH8GB8iyZm2GJ9vteW+SY3tjzlXhb/XZJT0TCZL7/1oMvRU8UpnyUFPjZfzIMQ
         LQyS6EFtTLrjcfbjZqHw8lAuF/kXjasF0XIJ54Vz0t25rUAY9JQ8AISaWK376u1qjl/4
         +N8I7w1yV8Z+Cj79LMP3Kh6uBKiDphL/k5orY0d+rhd+2Sb1itrYwNy92JifOlT4n9Jm
         eAHg==
X-Gm-Message-State: APt69E0i8CXlMdusAMBdqKM4DKoh8hkGiEUdhkK1msJ45yqaqFTJJXrS
        3NYN29PffUaZwEiOygd0Ub48rNYGIJsyMbaXFPV9X6qm
X-Google-Smtp-Source: AAOMgpdNFuzFsbShz22KDgQ1tNqf9DGU4jv47F1YcoMW71q0/N1Vof/Cqg0Lrb6Y/zLX/Jdlc4mHAsT7t4e0RnSsQws=
X-Received: by 2002:adf:ae51:: with SMTP id u17-v6mr17539259wrd.201.1531243436379;
 Tue, 10 Jul 2018 10:23:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:f30b:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 10:23:55
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1807101517290.75@tvgsbejvaqbjf.bet>
References: <cover.1529616356.git.jonathantanmy@google.com>
 <cover.1531168854.git.jonathantanmy@google.com> <f1ccfdccc851039cf62978d162cd9de99ea619de.1531168854.git.jonathantanmy@google.com>
 <20180710115344.14392-1-szeder.dev@gmail.com> <nycvar.QRO.7.76.6.1807101517290.75@tvgsbejvaqbjf.bet>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 10 Jul 2018 10:23:55 -0700
Message-ID: <CAGf8dgK3bWgAEE6Fuck=BHUG47V0kXi-Ph_gJnhk0mz2_84h3g@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] commit-graph: add repo arg to graph readers
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 6:18 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> 32-bit builds complain about this:
>>
>>   t/helper/test-repository.c: In function 'test_parse_commit_in_graph':
>>   t/helper/test-repository.c:28:9: error: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'timestamp_t {aka long long unsigned int}' [-Werror=format=]
>>     printf("%lu", c->date);
>>          ^
>>   cc1: all warnings being treated as errors
>>   Makefile:2262: recipe for target 't/helper/test-repository.o' failed
>>   make: *** [t/helper/test-repository.o] Error 1
>
> Let's also state how we usually fix this:
>
>         printf("%"PRItime, c->date);

Thanks for noticing this - I'll do this if a reroll is needed.
