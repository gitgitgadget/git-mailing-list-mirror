Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360471F462
	for <e@80x24.org>; Tue, 21 May 2019 08:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEUIcU (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 04:32:20 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40292 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfEUIcT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 04:32:19 -0400
Received: by mail-it1-f194.google.com with SMTP id h11so3363434itf.5;
        Tue, 21 May 2019 01:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I+h1YZrTDmKlD5sMhKmtJB756Lv1rsdZchXT/qjmFr0=;
        b=WU11g7eodKvj0jUc/K95u8KduoqHBD0MzyPoeO1NZAAjups6XlRbqUh8Tylz3QwJcL
         Gb7Tm55QGaJ3oGsFXFImeY6wSjcIVQetOuRlZ5OHqqlsbpI6DJgZpW1Ck7AB9bY5Z/zX
         kC5/09eJPUrEFYhQCm8TjjUvo65GTV5a/Og5DqcbbKV/R1BFKh/4odHsuIaFtuArr3hu
         ecOGZweCaSHd4tqr3QFheqN/xjqt9rBxZSuA1Bu9EboQLUvwzkF76K/1ihIPHKH5wZqU
         BSriLwH9YS2TZ+EntdvKhe04XByKEfs8Yt0XFABQoX8lx2eQ8G6TADcoV48PWPyXn2SM
         61zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I+h1YZrTDmKlD5sMhKmtJB756Lv1rsdZchXT/qjmFr0=;
        b=DzndgebdbvWZ+tP9xzL+ElAvL7XpTTzkLimISwtgmX6hoH59kZ2wtmyDbiqrue4IYB
         5xlitGiqarTn4jdDPFQwrkpp12MG/mRK/qmDHmr3NmDLjE/RMGyy00UaUgiWvnTbUfka
         VLQA9GDMxG9lz16TYv8bJb2+6QklU837Z4avWuGQBTppbZMRuCmoKUOKu+8QMrln/53j
         OB7Z0YxkSEbbDSB5IvpLixlJuogzszw2E3AF2+dRmRUY1tL87bteVAtfaiJ+gTaIIEIV
         NI9OpcvsbawUIJO08OXgZpf8IfFazuJ0gK0D+VtDTWp7wuiSfucuTNCJ08ao9Ub3Cefx
         49Nw==
X-Gm-Message-State: APjAAAXf7em3fCUxX32hXvjutemDEPzfS1pk4E2zzsLq0q0VqvSCxvve
        T1Jvna60zYby34Bab5Qoqlx+Vey7iKCzAllAbyU=
X-Google-Smtp-Source: APXvYqy6Tl5gUHWyF/Tm4q5p2sdj9gQ6LoZpoJQDSDZrElkev6O7L9QwjLgQsNbcGxOiH7ejJLGV9FUPmaLKPdvJd5U=
X-Received: by 2002:a02:3002:: with SMTP id q2mr12336301jaq.30.1558427538902;
 Tue, 21 May 2019 01:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36la24t1.fsf@gitster-ct.c.googlers.com> <CAGyf7-F-d-n39fJmjYc_2rjqQa4d7PFCx63LwW3m7PFetEgzEw@mail.gmail.com>
 <87ef4svk1k.fsf@evledraar.gmail.com>
In-Reply-To: <87ef4svk1k.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 21 May 2019 15:31:52 +0700
Message-ID: <CACsJy8AdhQH25NeDKKdSBctXcU=oyGcJ05XaNryj22GUQH5Btw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.22.0-rc1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 21, 2019 at 5:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, May 20 2019, Bryan Turner wrote:
>
> > On Sun, May 19, 2019 at 10:00 AM Junio C Hamano <gitster@pobox.com> wro=
te:
> >>
> >>  * The diff machinery, one of the oldest parts of the system, which
> >>    long predates the parse-options API, uses fairly long and complex
> >>    handcrafted option parser.  This is being rewritten to use the
> >>    parse-options API.
> >
> > It looks like with these changes it's no longer possible to use "-U"
> > (or, I'd assume, "--unified") without adding an explicit number for
> > context lines.
> >
> > ...
>
> I don't know if argument-less -U was ever intended, but I think in light
> of what you're saying we should consider it a regression to fix before
> 2.22.0 is out. CC-ing Duy who wrote d473e2e0e8 ("diff.c: convert
> -U|--unified", 2019-01-27).

There should be no behavior change in this series. Period. I'm pretty
sure I misread the old opt_arg() code and this is the result.
--inter-hunk-context is also affected. I'm working on it.

> The bug there is that the old opt_arg() code would be torelant to empty
> values. I noticed a similar change the other day with the --abbrev
> option, but didn't think it was worth noting. Maybe it's a more general
> problem, in both cases we had a blindspot in our tests.

Hmm.. this one is different (at least it does not use opt_arg()). But
I'll double check.
--=20
Duy
