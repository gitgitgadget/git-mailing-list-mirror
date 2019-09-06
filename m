Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF5E1F461
	for <e@80x24.org>; Fri,  6 Sep 2019 11:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404307AbfIFL4A (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 07:56:00 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34986 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391517AbfIFLz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 07:55:59 -0400
Received: by mail-io1-f68.google.com with SMTP id f4so11354380ion.2
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 04:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXt9fGFlv8mjaA+10WjfOP893uSGTz25kxq4BIzmC+U=;
        b=pWy2Y3eR6/CmcFFwGU/D0AeZl6QXhynshnfM8SXgk4oYAw3M7wMtPZOJ+0YikVUaw+
         Fzh9FBzfw6b4pzjXF9qmQtsXTIhUxm9L+gIUbTkRNUGuM+eMNDx9qW+7TCPJIcTed+pO
         qMLGHUY60Ik+DvqfXzIdu+Eh3wrNhA+lwLq+jkiNS4oAlVredAtO2hW5EASh5w9c/qWN
         1oJE/eBd34EvPTGpaI75MeoRtyx7BhevehMmR5OidTBoXwXDE1TCsoCiw5hr4qiJQNCp
         kOMW7bhI9viVFhcTkuvDU8d2dZAmfoQFOQ3jmdnethWyvRAtxvAMDWA+QcyOp1NttrFL
         hNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXt9fGFlv8mjaA+10WjfOP893uSGTz25kxq4BIzmC+U=;
        b=OHhRAni5IFiAQs5uLGFHNhXC3I8gAA3zpH1jppqoiu/25X6qrQwt5HyYi23G8wKizT
         DOVZKbQ/GaVp/OaxzwUMrdIVqfojxkjbvi+JJSWFaJPWRpAwo93pxZ2ObZ9xKcjUR6IT
         2X5osAI+m2NRstBIqFNNNjg31Pl1Dbcffa5SMYNBKgxjIjU/3XEGEwqC2Qb+hdERDTkm
         RSmaWKJVkU8rDQ6ysuk82gj1bkpU1c3qcrzw2CV9S2AfQpJxg6r0r8WkkHrYN+lPmAKO
         wdeLWU9XtB6ZLlmYasiBvmVqvG90ADtNmF1btljfx1sq3XP3UcTVe8Cp5i5zoCP9Z5k4
         h7Zg==
X-Gm-Message-State: APjAAAUAxSyHR57uXr5X33gggGabb7Pd1sjGZY1M62/tVBIDdjMTQ1np
        OiWff6NcUapWH4OE7N+nPrX8ENnEQqrzlvPCGms=
X-Google-Smtp-Source: APXvYqxJ1tUmu8fdkg+tz6xRK1JkCLKVHQm+GroNteCDDe/ePHLPMl81VHL+tRv1/prdrjOuqsuU/Z+CoGvmHi6HZDA=
X-Received: by 2002:a05:6638:692:: with SMTP id i18mr9493092jab.108.1567770957806;
 Fri, 06 Sep 2019 04:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190827051756.GA12795@sigill.intra.peff.net> <20190904194114.GA31398@sigill.intra.peff.net>
 <20190905193959.GA17913@google.com>
In-Reply-To: <20190905193959.GA17913@google.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 6 Sep 2019 04:55:46 -0700
Message-ID: <CAPUEspgyLHSwLBn2EkFyfxuU9KTx+CURTvjmenz2edw-htRxBA@mail.gmail.com>
Subject: Re: Git in Outreachy December 2019?
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm interested to mentor/help too, but I am definitely not a (some
people would even argue against "reliable") contributor but I might be
better than nothing and could pass my "lessons learned" along, so
hopefully next contributors are less of a pain to deal with than I am

Carlo
