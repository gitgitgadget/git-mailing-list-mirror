Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43EE01F731
	for <e@80x24.org>; Fri,  9 Aug 2019 03:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405051AbfHIDVP (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 23:21:15 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:43755 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbfHIDVP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 23:21:15 -0400
Received: by mail-ot1-f41.google.com with SMTP id j11so26911979otp.10
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 20:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SS80EETt+erUzLkX1lz7RNsqEoXeXvlGjpndKGfbNgA=;
        b=UCvWdsi+BIB1SZtfAzcrKsLq8WxZc/V7kXi+WfSJRiiIC/+M4iUM5O1LjBJ/yZkM0H
         SPH2pTsaYHJ3nJtSgSuEke75tFnLHw0t0uNFIvXOtYnRCNHiMXmztH+Z2spClo7Y+YFP
         Ale14QqklkEjgEnXCLpoho2NUu7UCluVOaLFnFJX2BONhWBW8fYnHEaBFjclMJxOnni4
         gF+I9LesXeTyqzk8EDLdL8tjZncsGOGtt1c3WjWn3ohyOMr6IA+jdiXYbM8yFi6Xc8kS
         SILTcY7kwA21121BkANHvDomSpJTqAJmOK+HA5GfjpdOQlutfC3mBfsMb7OhZ6HEBgG6
         RggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SS80EETt+erUzLkX1lz7RNsqEoXeXvlGjpndKGfbNgA=;
        b=ZQYU1704O52an3zGAqsNAdJ/yKiQfqvPhdMwuyyDc3d94D0qRz0xvQDe4JyvdqDTe7
         eVhnxRsi7Js8yuEMYfmhjyRGsxRwXw27zJFfViVebKU7Uv5G38xfKouWV5Unng5/ArG9
         NtsT+6hfg38OnYh4Dw3/DqfqnjlvVbHJ6KK+753xPIc+VhE1AqYd2Cql848JLzjq5kU9
         S0B0d9mNJ862cvVVMcblpyJRXqL2kaF3mPGzHsDvYWj75vbH+lcISG7bBRQnREzVmt89
         NUTaCUT4HomRwWGSEd6lRG8Ge950cKQyLGHzTV0JRwPxaT39q57ZhaPtKrOdP5aJesGP
         j/Ag==
X-Gm-Message-State: APjAAAXKV7Np3cu22Nq5U9M+CNT65bL7SzuRsIZ0UMU39/wxcGVDONR7
        JMkA8Z8oKUmsdTpBySp0E1uloMmhFHEtqMK+eG7C1sUY
X-Google-Smtp-Source: APXvYqy/B5hnlPYjywdtsoSPBJVYtU0tE4f4EqIWh7gQn2lKmuSjU0Lt7UqeXBHT00mrbWR203ETKajIcEzjnynLJyk=
X-Received: by 2002:a05:6638:52:: with SMTP id a18mr20386240jap.75.1565320874053;
 Thu, 08 Aug 2019 20:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com> <20190809001315.GA87896@syl.lan>
 <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org> <20190809020732.GA89008@syl.lan>
 <CABURp0oFNWfWEwnkjV1+Tag91HTRBCaJjyvc8CXtPGu78DhtSw@mail.gmail.com>
In-Reply-To: <CABURp0oFNWfWEwnkjV1+Tag91HTRBCaJjyvc8CXtPGu78DhtSw@mail.gmail.com>
From:   Ariadne Conill <ariadne@dereferenced.org>
Date:   Thu, 8 Aug 2019 22:21:02 -0500
Message-ID: <CAAOiGNzuLu26H56RvNCT=1iPQWOtGQJACO-pS8azerUio--=tw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Thu, Aug 8, 2019 at 10:07 PM Phil Hord <phil.hord@gmail.com> wrote:
>
> The issue of deadnaming aside, turning on log.mailmap by default is
> the sensible thing to do given that other Git features already honor
> it that way.  Having it ignored-by-default (but only sometimes) just
> adds confusion when a mailmap is available.

This is my point exactly!  My motive for improving this behaviour is
entirely irrelevant, honestly.  I regret ever bringing it up elsewhere
in the discussions, as it's completely irrelevant.

> > > >  - The '.mailmap' provides a list of transgender individuals, along
> > > >    with their deadname, which can be used to harass them.
> > >
> > > This is potentially a problem but it's not as bad as you depict.  A
> > > mailmap rule can match against e-mail only, which is precisely what I
> > > have done in my projects.
> >
> > Ah, I may be severely mistaken -- my memory was that '.mailmap'
> > rewriting could be used to rewrite both name and email, not merely
> > email. I thought that records could take:
> >
> >   A U Thor <author@xample.com> -> B C Xyzz <newname@example.com>
> >
> > instead of canonicalizing by email alone. If this is the case, then I
> > completely agree and share the opinion that this is not as bad as I
> > originally depicted.
>
> The long form you give there is to be used in case the old email
> address is not a unique key. See 'git help shortlog'.
>
> The problem we have at work is that one woman's old email address
> includes her deadname, like <firstname.lastname@company.com>.  I will
> leave it up to her whether she chooses to be listed explicitly in the
> mailmap.  I have wondered if we should permit hashed email addresses
> to be used for this specific case, but this also has its drawbacks.

I'd be open to looking into adding support for hashing the e-mail for
cases like this if people are interested.  The
firstname.lastname@company.com case is certainly a tough one to crack
otherwise, but I think that a solution that works for most cases still
is useful.  In the meantime, I think it makes sense to let people
decide whether they wish to use mailmap for this purpose, based on
their own understanding of the risks involved.

Ariadne
