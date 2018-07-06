Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A10661F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 23:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932657AbeGFXHf (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 19:07:35 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51029 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932439AbeGFXHe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 19:07:34 -0400
Received: by mail-wm0-f48.google.com with SMTP id v25-v6so16181037wmc.0
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 16:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RRLukgMn4HunyXwVZjxaGHUMits5DpFl1oruZyQ7jCU=;
        b=liMWaMH5nL20MJDY4Q1akqifmc7ykmrYSSFXTXAX0w41bzWoZDZfA9S5aoNtZjj2id
         SKiNDuMg09bdH+Kv3YyrmVB1tmMO2v5H0NYAW2YdJumcThepf6gODfA6AkxCNKdNAv3R
         QGN0lbNl70FVTXwhBncyVW5JGP5djOnbuTFfnwzr2wdvI5lgU+pmQjzldXOdZ4SrPmfP
         XZ0WBHVAyzpxGKeyyAR86Wy/Yq4IAxqbYBikNsJVVqO4eSOesZeTVH8O20iyCLqtFmM/
         7IbLtTqHcWXTrXZxGeGL7Xwoe+C2xKIJoTUKV0ScY8Wb0SVZzN6Q9LNO2a6wVWdLJCkJ
         Nf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RRLukgMn4HunyXwVZjxaGHUMits5DpFl1oruZyQ7jCU=;
        b=e+G/oE62mawCUWS8qRF1naH+wuTXpJCuIRTaAtOYZCce8VEby3rL3g7sHzSZ4iVzEc
         aaWEfSoG2DQAGQhqZ8pERgRPQtvhNxYLF64suUybY6rk/rpdCCLYLtsQZSi8yJmN1mNl
         cTQI4H2L4M3E8dL5RtUmLWm4+xBK90MTP0TaGzVxNq63vNbBAdAuw5QcGILHukDxEoPG
         q9tRV1AjJWP8j7LFYPuxi7FGebrlqh8hLurOjxETHPtA7uWoimLEDr+HhxXktSvN9f5X
         Yc22tI916266Ftp1WoPe0Hjcx42h5TA4L0SDLNHu6PAu+OjX1eABQU5vtEYseUU4wWpo
         S+kg==
X-Gm-Message-State: APt69E3lwYknnfrEv17cbKoQf0t1AYJWokudJU7j0kp1xrgM9yRj7oIN
        zpSVIb0lB3428VQrC4vngIaCJc7Z
X-Google-Smtp-Source: AAOMgpcN2rg3NLRFljizm/H6eHh8dQt4Wy5PvwsewghjQ3OSiO0Xe5tEad9aQfouB2SjzqP5IaS1Bg==
X-Received: by 2002:a1c:b9cf:: with SMTP id j198-v6mr7853577wmf.93.1530918452905;
        Fri, 06 Jul 2018 16:07:32 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t10-v6sm5669086wrs.59.2018.07.06.16.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 16:07:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's (not) cooking
References: <xmqqlgaogeff.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 06 Jul 2018 16:07:31 -0700
In-Reply-To: <xmqqlgaogeff.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 06 Jul 2018 15:57:56 -0700")
Message-ID: <xmqqh8lcgdzg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I'll be pushing out the integration branches with some updates, but
> there is no change in 'next' and below.  The following topics I gave
> a quick look and gave them topic branches, but I had trouble merging
> them in 'pu' and making them work correctly or pass the tests, so
> they are not part of 'pu' in today's pushout.
>
>     pk/rebase-in-c
>     en/dirty-merge-fixes
>     en/t6036-merge-recursive-tests
>     en/t6042-insane-merge-rename-testcases
>     ds/multi-pack-index

Also I ran out of time looking at various interesting things that
happened during US holiday, and didn't get around to a few
interesting topics.  So they are not even in the above "not in pu"
list, but they did hit my mailbox.  I just haven't got around to
them yet.
