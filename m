Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0FAA1F404
	for <e@80x24.org>; Sat, 11 Aug 2018 08:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeHKLEV (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 07:04:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45594 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbeHKLEV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 07:04:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id s16-v6so5853117edq.12
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Ab+eoEVL6i5DpK07/5QpvbdReO7+OOVbG2WsEXRi8oY=;
        b=MasehKO7NpXK5VZGsXjP1SdY3uhfGH3AV5mfobdXav8fKpix27tDkVHqcy6ghy30w/
         RYfNRCRyur9pBH1vLV8CAxN7sRqUvJ/4Y8IGf+k9p2ezKn4Fs/g2WshectR9FBZtJ7L1
         QsL7q18Fg0gyYlFX3SttsDUHfoP3qzoYTLqpqti2k4+ks0vpTu4W4779uHZ7SXN44luk
         vdn7dopgugkM4MeEniVqdEkIybK/eyHdvdpzIuNqtiR738M6KouRPfU2qaw76dzHHYYk
         ajpti3Ggce4+1TYJZS8GBmbR4Sv/njS9Y14KlC8/D5BK94mFjZEMJo0ksnd7jf329JEO
         q3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Ab+eoEVL6i5DpK07/5QpvbdReO7+OOVbG2WsEXRi8oY=;
        b=GJM2Wbz+Xk7KyGsozdjYR7h2N8eiOqqO5gYWDwpZo8n3wgcQJmw0vQQOxHUuUeIpNf
         8yf9kzuh8gVM0+aUaU0ElC+46+Um/Rg2nsFUZL2yAhFplDWiKN92Nvb+ElnAOQIGhbSo
         hYp+QpF3DqKHXm73inCWAC8cv7Po8wA/EeBrIxgBBGfJ45fydtog42a0A1JYfQxiLEm8
         4OxaZ0/bvwnvQ/bgnttnIQAt333+3YUGHD9i6q9TuWjGK5731wYPV9Q3cCTbLsWn41Ei
         k4YLe+tjzgzU/sMUM0KtjHUfe6xCJGQFlfkX1jR+ZwNvGWOKRbtNJv3Qw7hIxpxE+/LG
         ZR4Q==
X-Gm-Message-State: AOUpUlEIc3NM9EfjhOTobqkiswKPHftK7MUpUbjiU52jFFfchSX0fvX6
        zW6/XZb31+eVK491M5+Badc=
X-Google-Smtp-Source: AA+uWPzzbp2nVdj7h8R0pbn+WSifCBos2rd6S9E/hioMPVo2i0xtnOl0od90uVE/M8GgaJDYo7bd7w==
X-Received: by 2002:a50:a3ce:: with SMTP id t14-v6mr12271817edb.227.1533976254370;
        Sat, 11 Aug 2018 01:30:54 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id s23-v6sm6497164edm.74.2018.08.11.01.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Aug 2018 01:30:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Dan Shumow <danshu@microsoft.com>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: [PATCH 0/9] Add missing includes and forward declares
References: <20180811043218.31456-1-newren@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180811043218.31456-1-newren@gmail.com>
Date:   Sat, 11 Aug 2018 10:30:52 +0200
Message-ID: <87mutts3sz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 11 2018, Elijah Newren wrote:

[CC'd sha1dc maintainers, for context the relevent patch is
https://public-inbox.org/git/20180811043218.31456-8-newren@gmail.com/T/#u]

>   * Patches 6-8: These patches might need to be submitted to separate
>     projects elsewhere.  Let me know if so.

Yes, for sha1dc (your 7/9) it's much better if we submit patches to
upstream and then submit a patch to git.git to update from upstream, as
my 23e37f8e9d ("sha1dc: update from upstream", 2018-08-02) sitting in
'next' does.

When we build that library we define SHA1DC_NO_STANDARD_INCLUDES, so we
don't use the codepath you patched, so your description of "I was bit
yet again by compilation errors[...]" doesn't add up in that case. I
assume you just started adding stdlib.h where you could grep for
stdint.h.

When I check out sha1collisiondetection.git stand-alone (which will use
that path) and compile it, it works fine for me. This is on GCC 8.1.0 on
Debian, so perhaps that patch isn't needed in that case.
