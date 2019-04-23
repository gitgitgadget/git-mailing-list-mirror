Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37F11F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 17:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfDWRHj (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 13:07:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45544 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbfDWRHj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 13:07:39 -0400
Received: by mail-io1-f67.google.com with SMTP id e8so940350ioe.12
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 10:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vzi51wA8nN52PV3FAdZNANniJ22NQm5hZAua7dKD3FY=;
        b=VcKR/lHPYY+SFyEfeuILrgR+1xVAg924SG64ElzydTKT8Hm1hNB6l71GI628+WbGPV
         j95i3BhEgQmwbAis+j85Wf2RPAb/sMkAgeuRP0rYYrCT91JDlG775wGQzOmDozwIpPJU
         DzQzL6ep++/VQB8xptuNogwSHcNu7lPSe2IwnU2vhAAUIdTAeymJA5twyvFrdIm+yOo2
         j81riNQVsRXUO8Mw0GUzTcohkMpdbS7YH+JsTc8r4XkD4gzcgTawdlhUUpSCrhVb2sSG
         es6FHLIIllHF0Agop7jE7qcmLxjWFCfXs64dGv7RXj1Bu0FHDOFftB/yFpTD8LFQR9yz
         kbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vzi51wA8nN52PV3FAdZNANniJ22NQm5hZAua7dKD3FY=;
        b=mUxCVavMW8ANcQDG/yQZy4+Uk9AMwG0AhEYnunqidN6/UnhrbgViGkzP1neL1Jl7F1
         +jB94ZRL3jAjYCDpJleMOLYw4xZw+dSE6HdUdxAvF/9LJfhvGzg3LFdI1cvWEoF1sGJV
         cKZV4uT8n1ezES+T/AdyyuYHAX+ol7C+H1fJffdFZ5PNHNK+i811wRzs2CkVjly9xmPv
         2+W2rPIiS5LXGqOnzxzwV28VsJCo7CQ9rnA98NCoNTuZCWB0xh1Tt7ZZ/TOOixEzpetV
         itbfm0tktkHgAozzIvSRHEkujv2F16PjXw4rH2fSaCySm6pQQIi69tqLaX0wjaAvAxbZ
         q/PA==
X-Gm-Message-State: APjAAAV9ec+439LIoXmP0TMRqPauwriuhN0fw0MRP34l0PGyb44fO+er
        a2Vu7mVtoL/BkVqP15gVJ0v/mLp6b9HA9+CAJZj/xw==
X-Google-Smtp-Source: APXvYqwePNaUtQ7DxfIghhFW/V86fMEjjbpF1v1LeCelTQXaymcJqrs//EaSWu2C781vFry2AwtKbvSD2iEjPJXAvzg=
X-Received: by 2002:a6b:b403:: with SMTP id d3mr6290823iof.262.1556039258019;
 Tue, 23 Apr 2019 10:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190330224907.3277-1-matheus.bernardino@usp.br> <20190330224907.3277-4-matheus.bernardino@usp.br>
 <20190331181209.GT32487@hank.intra.tgummerer.com> <CAHd-oW7yPj5Ons3kfdEHtFgowc=F=2BD9EvU+fJbHe9=UXhx1g@mail.gmail.com>
 <20190411210927.GE32487@hank.intra.tgummerer.com>
In-Reply-To: <20190411210927.GE32487@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 23 Apr 2019 14:07:26 -0300
Message-ID: <CAHd-oW48+cEqSMDFF3PXuOnzUvptM6q5Ba_Zb8gGhqa1bGNwZQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5 3/7] dir-iterator: add flags parameter to dir_iterator_begin
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 11, 2019 at 6:09 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 04/10, Matheus Tavares Bernardino wrote:
> > > > diff --git a/dir-iterator.h b/dir-iterator.h
> > > > index 970793d07a..93646c3bea 100644
> > > > --- a/dir-iterator.h
> > > > +++ b/dir-iterator.h
> > > > @@ -19,7 +19,7 @@
> > > >   * A typical iteration looks like this:
> > > >   *
> > > >   *     int ok;
> > > > - *     struct iterator *iter = dir_iterator_begin(path);
> > > > + *     struct iterator *iter = dir_iterator_begin(path, 0);
> > >
> > > Outside of this context, we already mentione errorhandling when
> > > 'ok != ITER_DONE' in his example.  This still can't happen with the
> > > way the dir iterator is used here, but it serves as a reminder if
> > > people are using the DIR_ITERATOR_PEDANTIC flag.  Good.
> >
> > This made me think again about the documentation saying that
> > dir_iterator_abort() and dir_iterator_advance() may return ITER_ERROR,
> > but the implementation does not containing these possibilities.
> > (Besides when the pedantic flag is used). Maybe the idea was to make
> > API-users implement the check for an ITER_ERROR in case dir-iterator
> > needs to start returning it in the future.
>
> Yeah, I think that was the intention.
>
> > But do you think such a change in dir-iterator is likely to happen?
> > Maybe we could just make dir_iterator_abort() be void and remove this
> > section from documentation. Then, for dir_iterator_advance() users
> > would only need to check for ITER_ERROR if the pedantic flag was given
> > at dir-iterator creation...
>
> Dunno.  In a world where we have the pedantic flag, I think only
> returning ITER_ERROR if that flag is given might be what we want to
> do.  I can't think of a reason why we would want to return ITER_ERROR
> without the pedantic flag in that case.

Ok. I began doing the change, but got stuck in a specific decision.
What I was trying to do is:

1) Make dir_iterator_advance() return ITER_ERROR only when the
pedantic flag is given;
2) Make dir_iterator_abort() be void.

The first change is trivial. But the second is not so easy: Since the
[only] current API user defines other iterators on top of
dir-iterator, it would require a somehow big surgery on refs/* to make
this change. Should I proceed and make the changes at refs/* or should
I keep dir_iterator_abort() returning int, although it can never fail?

There's also a third option: The only operation that may fail during
dir_iterator_abort() is closedir(). But even on
dir_iterator_advance(), I'm treating this error as "non-fatal" in the
sense that it's not caught by the pedantic flag (although a warning is
emitted). I did it like this because it doesn't seem like a major
error during dir iteration... But I could change this and make
DIR_ITERATOR_PEDANTIC return ITER_ERROR upon closedir() errors for
both dir-iterator advance() and abort() functions. What do you think?

> Though I think I would change the example the other way in that case,
> and pass DIR_ITERATOR_PEDANTIC to 'dir_iterator_begin()', as it would
> be easy to forget error handling otherwise, even when it is
> necessary.  I'd rather err on the side of showing too much error
> handling, than having people forget it and having users run into some
> odd edge cases in the wild that the tests don't cover.

Yes, I agree.

> > Also CC-ed Michael in case he has some input
