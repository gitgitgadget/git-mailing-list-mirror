Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D871620248
	for <e@80x24.org>; Thu, 28 Mar 2019 13:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbfC1NQr (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 09:16:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32893 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1NQr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 09:16:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id q3so17190837edg.0
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=cfVutT9BklGy4992TJ3HWf7HSRc3CFrXf0LP8q6Xc1s=;
        b=pWto4Bv3SgTIQ0+uU2ChIhCIgKuS3/dL61YG/t0558SWBgQjWorqTlxozZ38XW1NRI
         Bz6yxAht7c9C8IW3/egpM+Fn/2/7hI/kpQnhukTBjbc7d4TwJ+WyKa8SuSolD0mvdaNn
         3SKyhR3zIGOZFao4AsOmDLmbps1QZEv1gO4mb1No4dYoB1lT53eHAZKpvoduUS78IpVo
         oz9VRvyhP7/e/duTF2lcrxEL7EFu5gZu4c4qwjfgfy/CSwsg8EEr9P1lE6TXONjppR9w
         MFKj40cRz/uJ+LTmNPfuZnrGM0uIUJ5E9KyGoww0T7Esm8FeByAvVuV5O6EKs/FpRvHv
         bmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=cfVutT9BklGy4992TJ3HWf7HSRc3CFrXf0LP8q6Xc1s=;
        b=U3Qc0MwfNoTzfmL3mxyXA7XXKH7T6Atd9dNxykXT0Y1MLHpAfbD/3Tga1b9p4Aa385
         8Xs+H5XE6SoZD34bZLapUG59t3EiQb5tkjT5XtNq2yVjVyhPBMtfZoPVMx+UbNo3LkE7
         cEa8T7PMXubi/1uVrrMSTu6qr8p0UmH6npjT4MzP+3XHJwlEqGpNe1aaDKX/3IplujsK
         Wt1f51+6e1vkFm1gyjY7nddxzgcAqR/5f4pWCFQVwKJmR/S+EVxkXn2CeJGZA+3skipY
         qvm8sKSjTTVjZZd2CpA3jFo0sdTlD+a+SfLGfnTxuY/iI9AWhwZI9axWabgWE1HyK8J+
         kTfQ==
X-Gm-Message-State: APjAAAXWwCXK2ylpPOHk30zKjDPb4QnmPJiJjS/QxFYsuycpzhSlyn61
        IjAiRtd9E5OoFpdvKj4uZ84=
X-Google-Smtp-Source: APXvYqxAKDPqRWGhom7C16UbsaIhM0IVY61Xl09j+tnKzFAOEgaXgm6OjoMFQ36Equ4RulQZC/Xs/Q==
X-Received: by 2002:a17:906:fd5:: with SMTP id c21mr24339736ejk.86.1553779005651;
        Thu, 28 Mar 2019 06:16:45 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id 5sm7930128edp.50.2019.03.28.06.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:16:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victor <__vic@ngs.ru>
Cc:     git@vger.kernel.org
Subject: Re: Strange behaviour of git log --follow
References: <web-54136765@mx30.intranet.ru>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <web-54136765@mx30.intranet.ru>
Date:   Thu, 28 Mar 2019 14:16:43 +0100
Message-ID: <87zhpf9m10.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 28 2019, Victor wrote:

> Hello.
>
> $ git log include/__vic/mutex.h
> commit 9429293f8f8fb0819c77cf1f723567f6edc8fb6a
> Merge: 96dd9a2 f484f4e
> Author: __vic <__vic@ngs.ru>
> Date: 2017-12-13 10:41:32 +0300
>
>     Merge branch 'generic' into posix
>
> commit f484f4e8aae32041ba56bdce12d1efd8491e94d5
> Merge: 86b848a b9bbbe6
> Author: __vic <__vic@ngs.ru>
> Date: 2017-12-12 17:35:10 +0300
>
>     waitable_event, thread, mutex
> $ git log --follow include/__vic/mutex.h
> $
>
> Why --follow makes git produce truncated history for file that wasn't
> renamed?
>
> My repository is available here
> https://github.com/2underscores-vic/__vic

I just briefly looked at this. It's because all changes to the relevant
file are in merge commits. If you run the "log" with "--stat" you'll see
no output.

Something in the --follow machinery takes the same shortcut on merges
and doesn't consider them.
