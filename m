Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368491F954
	for <e@80x24.org>; Sun, 19 Aug 2018 12:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeHSPdj (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 11:33:39 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:46510 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeHSPdj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 11:33:39 -0400
Received: by mail-ed1-f47.google.com with SMTP id o8-v6so6882809edt.13
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 05:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bIV5qIO3km4yXJUyPBkEtq+xWEJpEXxPpHtYAzgUzgE=;
        b=p+AjJ0Bn0e4MsX6NubTyDlUppgcCXDVjB+em+fEJ0g34gAJSf6Dk7D03jIBJsL8rhu
         Jc6JRvFordbtXghnKnkkFOj56PfNadkoiUg0xgyajkI7aGJ14EwCnmEgtuRJlPcG7Q1/
         c0v+bGU0pgtzJgmqZMptgvk8r6EoZFC6lrKXOqIxSDNb6+rGOH4gKbz2XnqgjplFMvLu
         tw5b7mfFtrRp0ix/P/KyiQ9YkNIxy6XHdn3fc3iH2llo59t+6QgpkldhZ2UC7NWReu7B
         46ulnA1Y/IHLMPXVr116z8KW43mgof1yfK3QEfj+GiUFDP+VjdX82qCK8ZGtLEslR4eU
         pKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=bIV5qIO3km4yXJUyPBkEtq+xWEJpEXxPpHtYAzgUzgE=;
        b=OLhID8k6GPkHEVbqk8m23n7/w6urguY1QREK2Chz/wCOzIUWowBpsxudSHAdYScOPc
         cfxYGlNZBpSI8T1eUEr5eiRIgP73zy34OlDGAACmVdjphqVfVwSri2ai8rhaIcb8tIuX
         ci1L2q1lTQ+LbS6CSTRzKsZnjCfwn6J60JzDsKqHep9Uhqisf86qSAwHZnuaiWmkJz9F
         q8dgAwYY3Rc/P9nOn/za7o5MGkxnZ/tPN6tQuL21iJBDCz8gUdU++d7iz08D7gumv7GA
         7lX3EvpXy/6HNjdGvsCojHdTZPekna2eV+0tnn8PD2FLIv3Q8zv7RLlK1eDU+2qfZEyM
         uUvg==
X-Gm-Message-State: AOUpUlFrtMIIU6MRlL+gGOwrS0dlVHLYu+x/e+fNeIa6bkig2h5W0A1N
        tef89JKO+8S+Oq4ytPSu7rG9PnV1
X-Google-Smtp-Source: AA+uWPyqHHYlzeUeTRKzVxmOcYhWWWQAAPmu3qCh4OWJjFpO2iP00/8dqWmxF1ojNG9XDqHbvYJlbw==
X-Received: by 2002:a50:8f05:: with SMTP id 5-v6mr50021460edy.192.1534681340859;
        Sun, 19 Aug 2018 05:22:20 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id b44-v6sm7009586edd.93.2018.08.19.05.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Aug 2018 05:22:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: Git Project Leadership Committee
References: <20180816224138.GA15490@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180816224138.GA15490@sigill.intra.peff.net>
Date:   Sun, 19 Aug 2018 14:22:18 +0200
Message-ID: <87zhxipmv9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 16 2018, Jeff King wrote:

>  - Christian Couder
>  - Ævar Arnfjörð Bjarmason

Thanks for the nomination. I'm happy to help the project by serving on
the leadership committee if you'll have me.

> Both are active, have been around a long time, and have taken part in
> non-code activities and governance discussions. My understanding is that
> Christian freelances on Git, which doesn't quite fit my "volunteer
> representative" request, but I think contracting on Git is its own
> interesting perspective to represent (and certainly he spent many years
> on the volunteer side).

I'd say I'd mostly be a "volunteer representative", but in the interest
of full disclosure here's the extent to which I'm not.

I'm involved in internal Git infrastructure at my employer, Booking.com,
and some of the the work I do on git is company sponsored, since it
happens to be stuff Booking.com needs from git. E.g. my recent
fetch.fsck.* series is one example of that, as well as the
"fetch.pruneTags" option in 2.17.

Booking.com doesn't really have any sort of git.git infrastructure team
in the sense that Microsoft & GitHub do. I'm on the team which, among
other things, manages our internal GitLab installation and git-related
things in general.

I'm trusted to spend company time on patching git when that's the
easiest or best way to accomplish some task. Usually I don't even
discuss the specifics of that with anyone, I just go ahead and do it.

I'm not aware of Booking.com, or its parent company Booking Holdings (or
sister companies) in any way being involved in any business model that
involves Git (unlike say GitHub, Atlassian etc).

So I can't imagine any situation where I'd need to recuse myself due to
real or perceived conflict of interest, but would of course do so if
there was even the appearance of impropriety.

Booking.com has also had a contract with Christian Couder to work on
things in git.git since 2015-ish. E.g. the rebase speedups Christian did
and the ongoing work on reftables is paid for by Booking.com.

During this time I've been the person tasked with managing the work that
Christian is doing on git.git for Booking.com, in a very loose sense of
"managing". It's usually just e.g. "hey rebase performance kind of
sucks, can you work on it?" "sure!".

I know Christian also does contract work for GitLab, e.g. I understand
that his delta island integration work these days is done on their
behalf, but I'll let him provide details on that or any other corporate
entanglements he may have to the extent he feels it's relevant.
