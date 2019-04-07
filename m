Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A034620248
	for <e@80x24.org>; Sun,  7 Apr 2019 21:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfDGVEs (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 17:04:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33620 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDGVEs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 17:04:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so13779060wmi.0
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YvSMjMZySrFyxjys0KKFDkpH0gCAcvnJwtAtKn1vKfE=;
        b=CesOrnBJG+aFCLR5Y43ONW8k+iLYZcodR6l280KxZ+/i3Zd9bl3X6fnRwQgWpe4o0a
         ej1n4iC7kW5tM3TjE6yrGI0Z2EEWOHsNSRUOsmH3xPUvaNJJWaHmObvaW+TtucrlwYa2
         uleUpyR5xSsm8H2/h1fRFFdDPtBzqR5PlL80x/IVakJxXVuermnF0DEjoU9yl9azj2ao
         aR9RDJZovONhnzsGQk/rxLsnhRvP2lHNtlvr+ERL4cMfc9oWjXDcVQI/XYWLxR68t+NO
         LHLzmcQDeErzQLKuGRWXkZVlzPjGQFTm1GYYnuOZPpcmX7o+U7vWvYCY83QJpaLHv2m/
         ynrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YvSMjMZySrFyxjys0KKFDkpH0gCAcvnJwtAtKn1vKfE=;
        b=hPZy4VcylhUYx5XOvG7y/OfEloZ2NJuGMzFF59O7KCkw2NOALwS0kLWzra72ACnbyj
         mSNHD8eumwm1I+kKE8JdP1qiJhRTIbmMQ/1k2G+XUMHLkQfR1H/uw/zEhBvoMcE3GiIc
         YDiutR9Cp8bPAqu0bikAXWZwL/ObC88jYE2rX9xaXZoNZc9plZzTTJxcQjZIh4hQuvmN
         MEeZUl0iLaipPBv6JWRqSFL/fulhQS68pxFxupdDQfuc508XXWr9YdIw5RulcvY7K0rs
         iP06LfipXqX89UpJ8Z2QK2jBGB8jPKsIUqY0Y9jw4fqPhVhd16LnIYoaRT6fzNl5DmT2
         +IPQ==
X-Gm-Message-State: APjAAAWkxJFWekfT52su3dh/4D1512LpRWvODAgX3Vboild4mJj1f+4x
        R0Kj+zBzKHZg3QyM7s/9mjQ=
X-Google-Smtp-Source: APXvYqx74+UZNSzk9peYs8DLlY27JkspCkmUEXQ5oYixfK/qqomFXRpRoTaTGWyD0UvXhUQMaqHj3g==
X-Received: by 2002:a1c:9ad6:: with SMTP id c205mr15666661wme.46.1554671085991;
        Sun, 07 Apr 2019 14:04:45 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id p3sm41824628wrx.71.2019.04.07.14.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 14:04:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        GitList <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] describe doc: remove '7-char' abbreviation reference
References: <20190406132747.16376-1-philipoakley@iee.org>
        <20190406132747.16376-3-philipoakley@iee.org>
        <87bm1ha8ek.fsf@evledraar.gmail.com>
Date:   Mon, 08 Apr 2019 06:04:44 +0900
In-Reply-To: <87bm1ha8ek.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 07 Apr 2019 22:05:07 +0200")
Message-ID: <xmqqh8b9cys3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I've been meaning to follow-up on
> https://public-inbox.org/git/20190204161217.20047-1-avarab@gmail.com/
> where I among other things wanted to just have these instances all say
> "commits will be abbreviated as described in XYZ in linkgit:<something>"
> and summarize what happens there.

Thanks for a pointer.  I do recall that I found that one very
promising.  I can see from
https://public-inbox.org/git/xmqq7eefv02i.fsf@gitster-ct.c.googlers.com/
that I was mostly OK with the end-user facing documentation part,
and also from
https://public-inbox.org/git/xmqq36p3uxq2.fsf@gitster-ct.c.googlers.com/
I was OK with the idea of exposing the computation but found that
the exact command option it was done with was suboptimal; neither of
these was pointing out any incorrectable flaw).

> I don't mind if this goes in, I mainly wrote this E-Mail as a brain dump
> since it jolted my memory on the topic, and so that I could dig it up
> later & see how I intended to follow-up on those #leftoverbits
