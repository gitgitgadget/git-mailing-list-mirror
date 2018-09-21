Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDBD21F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbeIVEOL (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:14:11 -0400
Received: from mail-yw1-f46.google.com ([209.85.161.46]:43676 "EHLO
        mail-yw1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeIVEOL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 00:14:11 -0400
Received: by mail-yw1-f46.google.com with SMTP id k66-v6so232785ywa.10
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 15:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jItLA7luY1+UxTfdrGSWoFU0nboBX7tEM0YrqrdC6mQ=;
        b=Owi3Xsq7GGeHASVPycMe3ijOygBBQw94NLQ+ijgskisigIli0mlOIjJZgB+MWKUoNZ
         uFavkfZbHM/AVLzGePPFYM8C355TZVAR0w69bvZnBX6B7u10NNbpvTw1CPZvsTdD6wmr
         Ibo+wmVZCLNbsLfIJdjKwJV9rzXIFvAY+bR3nRMFRXTruApggHUcw63UcYXomWQrj2bk
         6BAjBA8RcM46dtHY4hYilCrH3j2NUT+5BpNGA6T9hsK01YHidRGD6lJClges27OyVOPi
         FhGW4MYBJVtET8QxIsFhaYsBeS9oleqkv1TOHcLp4oauu14hfoAADOJBxCB1BWcQLCzr
         urLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jItLA7luY1+UxTfdrGSWoFU0nboBX7tEM0YrqrdC6mQ=;
        b=InYlRg3Va7DEKIqltJNtEBrIB2kxVZ7kUJtAMK4vo1Ho+21hDUZRL8U1CXKvIYWVhD
         heSabm1jsh3OmHuT6FFI9Wv1a6n9ieBxoED78o2ajCFuSp2MTkNPwlMg5Q41mSNX/hgi
         1avIfgNekHZAL7F8OgGayNilTP1BUhjy2yLMTo/tBy1YIks+9NKCKEDMPOCEAm4Iqjnw
         FDp++S0h0vXrSb++8S+m+VFZf4GHjCLdBPZCgiBimK6uNjok6jeyLJay60/Wyj9GCeHQ
         lt9xh9d+1/WJqhImpABa+rsCzvmJrGq3MhpxKesA8jC2uNpfe4xNMgrqKzOfXA0WJRIf
         69fg==
X-Gm-Message-State: APzg51A9nygAS8Krv3ipvfjecap3RIZw2vid0/y5c6Q6WA+ivIm7hlXC
        UkbJprgO7rZHlFW/uXc8x02vgTMmnwhN4zIVdZSpEw==
X-Google-Smtp-Source: ANB0VdZBZdoZ2yMHWCONppcd8GMIlL7NixxEU6YTNzj+yv+up+1A67Lv00vl0MCLfi1uNqgs3eiTedxfxb90/bFni8Q=
X-Received: by 2002:a81:2908:: with SMTP id p8-v6mr2324616ywp.407.1537568598138;
 Fri, 21 Sep 2018 15:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537466087.git.me@ttaylorr.com> <cover.1537555544.git.me@ttaylorr.com>
 <6e8f65a16dc0be84234d2be93bb4a5c9a585dd57.1537555544.git.me@ttaylorr.com>
 <xmqqbm8qv9hy.fsf@gitster-ct.c.googlers.com> <20180921213753.GA11177@sigill.intra.peff.net>
 <xmqqtvmitsi4.fsf@gitster-ct.c.googlers.com> <20180921221832.GC11177@sigill.intra.peff.net>
In-Reply-To: <20180921221832.GC11177@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 21 Sep 2018 15:23:06 -0700
Message-ID: <CAGZ79kaT=zvwLxJys76DOHc5HABpvu2fwqaq7dZ=j7PiCgaTYQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 3:18 PM Jeff King <peff@peff.net> wrote:

> I agree that core.* is kind of a kitchen sink, but I'm not sure that's
> all that bad. Is "here is how Git finds refs in an alternate" any more

This touches both "refs" and "alternates", which are Git concepts
whereas ssh is not.

> or less core than "here is how Git invokes ssh"?

Arguably core.sshCommand should be deprecated and re-introduced
as transport."ssh".command. :-P
