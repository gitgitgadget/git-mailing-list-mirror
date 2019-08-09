Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15731F731
	for <e@80x24.org>; Fri,  9 Aug 2019 03:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbfHIDHw (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 23:07:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33736 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbfHIDHw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 23:07:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id z17so2323192ljz.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 20:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xkw7Lj7r6ovvCmT4lJ/Z9TNVx+1/vr4Ipoyyndje6zk=;
        b=i3TOFAzmQmbq95kTB/waW0nq5b28Wc9aR7tpzI3P300x5ObpDcckhYn/lwgGDaKwE7
         Us1udgPOIzoTOQE0H/sx1LwnnSJcaK8gJbyaAJbxqXvRHCL34Kii1IpmoGlf3gkQXu+I
         /gwuMBgXOy1BhAM4bn/NlsCWMxLz1YdGQ7j/3YwmgGJI8zuaHwullqXXQlJhIyolp/Qb
         THtb6PcQBYtBD6/ARjnA0tZAochJ65w6eA79ByrILG5iE0vhmPtwJOonvl0U8Ao9RsUz
         X8PIx/qhp7Zgv0wIjr0TUK0GUw7Ko++w2dwVWkNB2WaC3AlKcRhIC/mHXc0cpqxhPxW2
         cR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xkw7Lj7r6ovvCmT4lJ/Z9TNVx+1/vr4Ipoyyndje6zk=;
        b=TAcqRhaLea6/UAb4xglU+84SOxaCaNjKqlIoo5oaF7BAjB2jjGdxieRWrUfZ0LCOHj
         cCX5yGdpLaObGk2Zp1+k7K6QhUhjERw4benJnk8E2SuZSB7b6TBCcgjMqytu5QR6p43S
         EILpoyhj9m4knq8Svha+jNJPgMXKLqFx5vSrwCMd1ifMbZjV6pKKTUJxKblbLw0XJ6+F
         h6teW8GvnMe1SXTjLN8zilm8fxlESgD/M5Iywsqfv540s+NXegYNYmI3n3HXXRFDW8bJ
         oorppGYUG9IhdZRNH7++D6wQ4Wf+jeJ0Eeh8xzo+hfghJ/TFaYDqOpQaul+Cn9ixSVVR
         C+cg==
X-Gm-Message-State: APjAAAVVcjBMK2ElnQlkQqAVnnKv6Rx6PIsJVUB+b16+7AgGfXFXdbtz
        zcqmef0GWDuawha5HGqN+vrA6c/seNcAGVM2NGQ=
X-Google-Smtp-Source: APXvYqwUDilXP9n2B8H9vFOEZngfK4oibMY62Haj+y6q9s7nMjrBRojiu57icmwnT0dISJoL9HGKwQZRDW2qEVauKR8=
X-Received: by 2002:a2e:b047:: with SMTP id d7mr10187233ljl.8.1565320070427;
 Thu, 08 Aug 2019 20:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com> <20190809001315.GA87896@syl.lan>
 <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org> <20190809020732.GA89008@syl.lan>
In-Reply-To: <20190809020732.GA89008@syl.lan>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Thu, 8 Aug 2019 20:07:36 -0700
Message-ID: <CABURp0oFNWfWEwnkjV1+Tag91HTRBCaJjyvc8CXtPGu78DhtSw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Ariadne Conill <ariadne@dereferenced.org>,
        Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The issue of deadnaming aside, turning on log.mailmap by default is
the sensible thing to do given that other Git features already honor
it that way.  Having it ignored-by-default (but only sometimes) just
adds confusion when a mailmap is available.

> > >  - The '.mailmap' provides a list of transgender individuals, along
> > >    with their deadname, which can be used to harass them.
> >
> > This is potentially a problem but it's not as bad as you depict.  A
> > mailmap rule can match against e-mail only, which is precisely what I
> > have done in my projects.
>
> Ah, I may be severely mistaken -- my memory was that '.mailmap'
> rewriting could be used to rewrite both name and email, not merely
> email. I thought that records could take:
>
>   A U Thor <author@xample.com> -> B C Xyzz <newname@example.com>
>
> instead of canonicalizing by email alone. If this is the case, then I
> completely agree and share the opinion that this is not as bad as I
> originally depicted.

The long form you give there is to be used in case the old email
address is not a unique key. See 'git help shortlog'.

The problem we have at work is that one woman's old email address
includes her deadname, like <firstname.lastname@company.com>.  I will
leave it up to her whether she chooses to be listed explicitly in the
mailmap.  I have wondered if we should permit hashed email addresses
to be used for this specific case, but this also has its drawbacks.

Phil
