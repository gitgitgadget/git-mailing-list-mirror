Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACE951F404
	for <e@80x24.org>; Mon, 13 Aug 2018 20:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbeHMXUe (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 19:20:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55993 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMXUe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 19:20:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so10144692wmc.5
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 13:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9bZM+nWUH39SNxFibn6uRTkTig7YjFK82UZYQJquyQI=;
        b=bsgt2Hp1uCPHIg/JC+4jShai03zAoiVlrWz4ep4mtQf2gk3hoGnwVhJRrvAbLNKy36
         sLuv2w0yfCCMjL8AWYrTEVf2R8LzpfBbv4bWpl+1euTBFZgt/lU/rcTylnsiLSm8d5yD
         LkMLUrBLPzD5Ri51KuUozhE7HZML6b0m9ygCMHXQqL1ukc2WfjoicbOvxXPzQg7Tknka
         qWn9rbRkUPEa8OC9811ppaWGXZXJdkqI8VU6r/TaFzBb1hROd8fT/2dhndSwJGWlmQqH
         /8460rfeKalI2aQHZLyOy4nMiuVf6xobWYefnTIPgc07E//avtGeRvAzkj0k50o45Uqw
         x2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=9bZM+nWUH39SNxFibn6uRTkTig7YjFK82UZYQJquyQI=;
        b=Ui/RFN56wKzDUTmm/lwMqZLwy1xbpCdSSOrfRALrBn2GmSKIYTeHvQKn+g7fsO52vg
         GqJcNXS+3k6ACoffJ1ZVzsshnN7hX+7AWKbO6CmzxCAkKg1jGb9ufRmaQ38STIn3eRIA
         3bjC3c3/B9Bpq2hFQmNQ93Pt9hVIJmtZQzV+hhZUH1SBE/jZephZ0nIaymR9eRazheZk
         s9uhLxUnVZYAYeRy6clVnkipiJ5ZTgh+S3y6SgGoPjYFLmKN/ECdjPkOJ6E3Yy1MJQUu
         491EgRV8y2c7+ZSpIEDslJG6jozupFfiF/xvSAq3gNRvWhhoZomYTanC9mfHS0JJ0CdQ
         tWQg==
X-Gm-Message-State: AOUpUlEiXLLFGach8CBGotEg7EihNFNOMKxIdYKpfHwL1Uiyims0LYaT
        UTNKMMdCY9WjSwLLlZBmZg4=
X-Google-Smtp-Source: AA+uWPzxqgcc/q3hoQvkfETmm90CBheeJli7BrQP8Cre6VJ3o/DFvUSyievI+CCjBJTJH5YksqSW+Q==
X-Received: by 2002:a1c:ee15:: with SMTP id m21-v6mr9155356wmh.112.1534192604163;
        Mon, 13 Aug 2018 13:36:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i205-v6sm15625328wmf.30.2018.08.13.13.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 13:36:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Contributor Summit planning
References: <20180813163108.GA6731@sigill.intra.peff.net>
        <87h8jyrtj6.fsf@evledraar.gmail.com>
Date:   Mon, 13 Aug 2018 13:36:42 -0700
In-Reply-To: <87h8jyrtj6.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 13 Aug 2018 20:49:33 +0200")
Message-ID: <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>    Or would those companies be OK with trusting that some 20-ish of us
>    can hold our tongues for one day and not ruin the surprise?
>
>    There's also overlap with the remote A/V concerns there. I.e. an
>    acceptable compromise for those companies might be to talk about
>    those features freely in the contributor summit trusting that it's a
>    closed forum, but that wouldn't work if it's going to be broadcasted.
>
> 1. git.git$ git log --pretty=format:%aN --since=2018-01-01|sort|uniq -c|sort -nr|head -n 20

You'd need --no-merges there at least.

Oh, using "git shortlog" might be also simpler ;-)

