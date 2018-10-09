Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BC851F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 03:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeJILOC (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 07:14:02 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:35861 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeJILOC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 07:14:02 -0400
Received: by mail-ed1-f53.google.com with SMTP id c26-v6so378375edt.3
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 20:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OZr8pHOW1pcs3WLmOhLsr5bvMhOgG60c6vft1xVgHf4=;
        b=Iyu9fr5DOBZzYJ0LFr3wg2XtdfEkWhtKeumghFepOEG9tCy2dbFEYHvfZE1v+NPq0M
         gGMccRVfn+TGVqNl7cfosYOG8483pQr7XHFqlmDcZ3zkLIgP5MQllSMHxXfmbv76QFQr
         nvgDlt81BJXawAdftOuP6rRCZLiYMphbecdkn+OBvNwgA9/zSAwlsTjXdYBxzWrF5XKS
         b7m0l/Ac0QwTDM3oAvgjwRGm7echmhzzFEms46KPAn1JROMIMHFXoAQmq3aWwMx0s6Hr
         zYO2HEmmy4xQcunX8Lv1ah4gdq2KzVrsziPkzDL/E1CUYHBuvuivIo/VNXS+Zv75ME9Y
         wOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OZr8pHOW1pcs3WLmOhLsr5bvMhOgG60c6vft1xVgHf4=;
        b=D4t49N7C+cUEcO+hPu+L2taLDcVHpf14lSSp/yfIc8XEsPVtrVM+XySZH3aIly4Sgz
         eYknETUhBLqSwA3cVE3KPrkgLBfnq9rAXs4cNqpBMhSjgBvGw58Z4BPTR4feBtP4fHTL
         bRMvKgF6V6pSCzA6kUOnOgc7YyWSTS5U4ReSliHeVp9+b2F9GwCncFvdU5RmGNUvw/9T
         GHM7bXc1fEXz2h2oddwY0CMEtevmyXNR2AEXcyOexdP/kPT3zDV9y0WHooU17N8lymL7
         XjLV4Ir8wn1k4apKyPgEnElFnNYk8RdtHGRct720YyLWi00bELoeyEMTpqAdE5squJn+
         9uXg==
X-Gm-Message-State: ABuFfohJ333xCa6jpY4mADgNUCc1WjzX1jhvtp++FXo6Gnd42+qe2vat
        3p2JIYXWFV4iOGSDbMJ9ixWEV0jvVG8inqAEZeE=
X-Google-Smtp-Source: ACcGV60tKF3GdJMWCnRP3AiJTMrdZlXQDOgnRdc15URdujg3PvzN/IdfU6SmYvmxp65KubKwhH52XG+LxpiGKgRP6TA=
X-Received: by 2002:a50:bc12:: with SMTP id j18-v6mr11087739edh.154.1539057548153;
 Mon, 08 Oct 2018 20:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1810061712260.2402@hadrien> <CACBZZX6PmG=-8563eYE4z98yvHePenZf_Kz1xgpse0ngjB5QyA@mail.gmail.com>
 <xmqqd0smvay0.fsf@gitster-ct.c.googlers.com> <alpine.DEB.2.21.1810070719200.2347@hadrien>
 <xmqq8t38t4r7.fsf@gitster-ct.c.googlers.com> <20181009032124.GE6250@sigill.intra.peff.net>
In-Reply-To: <20181009032124.GE6250@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 8 Oct 2018 20:58:56 -0700
Message-ID: <CA+P7+xpnVeWrW5r6uj4E4NSFPjhA_f0iwaCTJb8-WFqZChHEvA@mail.gmail.com>
Subject: Re: git log -S or -G
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 8, 2018 at 8:22 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Oct 09, 2018 at 08:09:32AM +0900, Junio C Hamano wrote:
>
> > Julia Lawall <julia.lawall@lip6.fr> writes:
> >
> > >> Doing the same for -S is much harder at the machinery level, as it
> > >> performs its thing without internally running "diff" twice, but just
> > >> counts the number of occurrences of 'foo'---that is sufficient for
> > >> its intended use, and more efficient.
> > >
> > > There is still the question of whether the number of occurrences of foo
> > > decreases or increases.
> >
> > Hmph, taking the changes that makes the number of hits decrease
> > would catch a subset of "changes that removes 'foo' only---I am not
> > interested in the ones that adds 'foo'".  It will avoid getting
> > confused by a change that moves an existing 'foo' to another place
> > in the same file (as the number of hits does not change), but at the
> > same time, it will miss a change that genuinely removes an existing
> > 'foo' and happens to add a 'foo' at a different place in the same
> > file that is unrelated to the original 'foo'.  Depending on the
> > definition of "I am only interested in removed ones", that may or
> > may not be acceptable.
>
> I think that is the best we could do for "-S", though, which is
> inherently about counting hits.
>
> For "-G", we are literally grepping the diff. It does not seem
> unreasonable to add the ability to grep only "-" or "+" lines, and the
> interface for that should be pretty straightforward (a tri-state flag to
> look in remove, added, or both lines).
>
> -Peff

Yea. I know I've wanted something like this in the past.

Thanks,
Jake
