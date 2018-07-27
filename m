Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BA5A1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 14:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbeG0Pu4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 11:50:56 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:50446 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730771AbeG0Pu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 11:50:56 -0400
Received: by mail-wm0-f45.google.com with SMTP id s12-v6so5474409wmc.0
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+J+4ZnoutJ4JZOCR6qHxIlncBILExdDk0BuWxHkbCmI=;
        b=RAd1PzxPMIcf4ad+lxGN0AGIRNpumCgNalUqYL44849WfgYpjN63tSwQ7oYvkCRUx0
         7HeYu4LsOfyl1oadKhLZsrZVPyin+i520bURYKY76K2Rx3m8HC+p4kR+mmcUu7WTaxHm
         HkuvxMZSgTeZlDXPmEKgiOYPDw8iSTmUFOUkQmPn5dPdXGCRlGMYSsxY9m+u1BrZ4UFg
         FupFF7ugK7INPOo2SE0oRjKYpewfDZcoEwVXoJv24woFcCK6+Lrudr4QfMZtTX8Tg7tv
         6qBKXXZgiPO3DxYfl5bJ7DGV7VE7OYT3Jv6vd0eHNh7BSoekwo8FH4myaAr5Pijz8Dml
         eqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+J+4ZnoutJ4JZOCR6qHxIlncBILExdDk0BuWxHkbCmI=;
        b=U2eXFmefa2eqCdVPxeOBZdgTpx7bBSgKwBA1vSUCoKVS0RfB3b76/06afVDcNAXJyS
         ZfqUqXIlqPGhwm9QjxssHFZ7N2Lv8qvidoYngjPNpj/pEAijOWeQQ3SAMDoreEvwj6bt
         WadixzflmKwaYPpv4oChFVrvZTsF+YXYel4Ka8L5fPaiuREv9KN0d5yFEcl7ysjvw4RR
         xXzuhUBuVQgIDydKkAiY6hkPwPQu1ky5xOP/bDfjM3AstxbN6DJuJtJ28euwJ6PG+tZE
         72mBNWDpz0xlrJX7HOBLhWYRSOSRbXPv23pagDI5Q5q2wWpJKk7VqMzA/s2C190vzKhE
         ZNlw==
X-Gm-Message-State: AOUpUlH2Lt2ZqWKNVR/ZOx1gwigAijg9Eu5cThVawbqHfI7UYDRNnh+d
        JuSP720hzDSY9tbiQ0Imiew=
X-Google-Smtp-Source: AAOMgpeP91Z54y4ZlDdWICDjJHeQ3Ucp78ZpQguRmKyG5+uQbVVyBKFIlAgjeNxwLDTuVZQV/AcHrA==
X-Received: by 2002:a1c:8682:: with SMTP id i124-v6mr4679087wmd.77.1532701724372;
        Fri, 27 Jul 2018 07:28:44 -0700 (PDT)
Received: from evledraar ([5.57.20.50])
        by smtp.gmail.com with ESMTPSA id m207-v6sm6523769wma.31.2018.07.27.07.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 07:28:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 27 Jul 2018 16:28:42 +0200
Message-ID: <87fu0469d1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 25 2018, Junio C Hamano wrote:

> * js/range-diff (2018-07-25) 21 commits
> [...]
>
>  "git tbdiff" that lets us compare individual patches in two
>  iterations of a topic has been rewritten and made into a built-in
>  command.
>
>  Undecided.
>
>  Many "The feature is useful" comments without much real review; we
>  know the feature is great as this mimicks tbdiff already so that is
>  not news.

Count me in the "this is useful" camp, but also I did look at the latest
submission this time around, but had nothing to say, so I didn't say
anything :) The latest round was about renaming the command itself,
which was good, but the actual functionality was hashed out in previous
rounds.
