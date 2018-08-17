Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A29C1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 18:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeHQVeL (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 17:34:11 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35079 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbeHQVeK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 17:34:10 -0400
Received: by mail-io0-f193.google.com with SMTP id w11-v6so7668811iob.2
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FTj/kyCoRRyAW6TCmdKj3Yy9h8+yxHpeiSa/buXrcdI=;
        b=twSGsBQxY7xkc1rLd1XQ9GuMSiQUCmHPmkkr/lv1ZYkz/e7On1nstMRkXd8/uXu0J6
         ejF0loZkDEQQ0eG8MyCB71uYMelnLH6VqzMIW5z7mS2A5H/N2PuXDlMJp/ooAhi09r1k
         xcc0jPODj8tGx/19fgWhVXmNQGKxmC/H7qEmbiTKIWnl3v5aBqf/Q6XqegEc0CTcldb7
         SMWBSC5Ur9cyzSYCaZvxtieEAYLRZdw2N70kfPeHk0zphDVs6xkdmkPX2P4W0SnvAuNr
         JzxBa9Au2MDVg/6WTui8SEHVIqhAbYvbzbh+V1KW0D7skNb6zRxLb4HAsWANBUCrMBNY
         ImYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTj/kyCoRRyAW6TCmdKj3Yy9h8+yxHpeiSa/buXrcdI=;
        b=ilfjBZvCxN0D3AHIikhV+aiyMcumsEca12exEx86p6WLC3od0k6Lrqjk9sPVCjkCXg
         bO6k0Gt/Zsq3+QMoTo1ktaAv5EfjTqKfHtKexooV7lIDjJ250lPqsCTxh2U0cRrwwJ8b
         sBQCNNLEB6wbOdMwi+/cOk5fEve43LoAv+t4XTsECcGxYjH1GdzDXZKUd3NhFK+x328N
         9fSXoTacKgsGJ24FwYn1b/2vUAiUghnZ1g03k69qdKAXSELpQZ59/PRBBDDtm+3TcVmn
         IM0hsNbzQg1b/TLEZiyeLaqTN6/qnApthW/el7ciL9rG/4QO6of36TDXDs6vJv3Yp21W
         bSuA==
X-Gm-Message-State: AOUpUlEDNa6UCUY5l8vIMrLKsJ//SoGrTz/MmQBsbAX3EVIjKzoG6B+o
        YgXn9bR6iFqVgwhmUcoK/b7f/VsgUzrVujsusDg=
X-Google-Smtp-Source: AA+uWPxBHy9HfnnS2+2dE8bmOS2+JLCATTX85Z+17KcYiEGRGJytOjyYd8WVwzcEEMz+EBljfxqgdCUafEWQgksaARc=
X-Received: by 2002:a6b:8f4b:: with SMTP id r72-v6mr30279843iod.118.1534530585923;
 Fri, 17 Aug 2018 11:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <1534498806.1262.8.camel@gentoo.org> <20180817130250.20354-1-avarab@gmail.com>
 <CACsJy8DH2tESV4xkCYutH=Ye37zGwifGdJhdnNOsRd+JusdOwg@mail.gmail.com>
 <20180817151012.GA20262@duynguyen.home> <xmqqpnyhaq93.fsf@gitster-ct.c.googlers.com>
 <xmqqlg94c46f.fsf@gitster-ct.c.googlers.com> <20180817173308.GA9111@sigill.intra.peff.net>
In-Reply-To: <20180817173308.GA9111@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 17 Aug 2018 20:29:19 +0200
Message-ID: <CACsJy8DW6MP-a8u8KgB0ueO8d9eWmoZwF6c0Z5i+Psy980XcHg@mail.gmail.com>
Subject: Re: [PATCH] refactor various if (x) FREE_AND_NULL(x) to just FREE_AND_NULL(x)
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 7:33 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Aug 17, 2018 at 10:07:36AM -0700, Junio C Hamano wrote:
>
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > It is a bit sad that
> > >
> > >     - if (E)
> > >       FREE_AND_NULL(E);
> > >
> > > is not sufficient to catch it.  Shouldn't we be doing the same for
> > > regular free(E) as well?  IOW, like the attached patch.
> > > ...
> >
> > And revised even more to also spell "E" as "E != NULL" (and "!E" as
> > "E == NULL"), which seems to make a difference, which is even more
> > sad.  I do not want to wonder if I have to also add "NULL == E" and
> > other variants, so I'll stop here.
>
> I think it makes sense that these are all distinct if you're using
> coccinelle to do stylistic transformations between them (e.g., enforcing
> curly braces even around one-liners).

Googling a bit shows a kernel patch [1]. Assuming that it works (I
didn't check if it made it to linux.git) it would simplify our rules a
bit.

[1] https://patchwork.kernel.org/patch/5167641/
-- 
Duy
