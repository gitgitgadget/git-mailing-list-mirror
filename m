Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBD131F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 17:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933593AbeGIRSU (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 13:18:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37538 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933392AbeGIRSU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 13:18:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so11787795wrd.4
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 10:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EASjInwGl0KBdoExVQCF9qhXmJYdzWyyhON1UJE64yM=;
        b=ighfV0mpfIv+Grau/FEmMNmq597IPlqvF4NXShFt6KknEag/m/GlcAaDNOvsmA3pMC
         rj0PbAPilhpdv5VCpoLV+SPuyVbCgAVTgyH532KtsOahYkLQ3irU6Na9H6GHVSOhHcwC
         OSdIDR2/yqqnxfNLAIdBiHqVKDjxb6GZA7J9lD5fSaAAXFNnD3GMUcin93g+cVBUIXsO
         OeZTaSlWYKUqZdx9RambCtriEZs8As3m9mrJ1qUOXrictypaDblzZgMZix6EG5gF0xyb
         c0p+0+nnRaqx+spIw8K2KvSTK/OdNcA2cjlflVPS+IEqIK2aJTZZKRrEvPKojh2gj0B6
         j9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EASjInwGl0KBdoExVQCF9qhXmJYdzWyyhON1UJE64yM=;
        b=OwpGcV+UidLAxMjD4OhsJr/nSkpLzv87nzI9hvfniVpvH817IS1AuYbUllWBXlsOP0
         eyzaXwTYI1o+UKrdrf5yL03pjcHpAfDPwm0iGXXK7lxwQArFdkLsHCJaGBrKha1ouhwY
         zoDK4/WS12/XaSzWpMDSgHEu83mMQs/1p5scF9LE25PA2ZO4nU05THebzi1NGR3uoctz
         Hk3josa6UMRxOjbBjlKJ+x/OUaLRiwHwVcuWldY5tCTbal1184fD2xoqD1AORA2npZ+s
         /C+y9MUQYFo8hyZ18StXmPvfOTmi6MH1/0lYmYqGXZAXztTNcw1v3/ixd1WnNs/TtydG
         ROyQ==
X-Gm-Message-State: APt69E3aZd4C/e5RSmeWKtKtjCjaIgGzn3C4KtEYd2y+9SBKhdIKLe6m
        f7+/z1kbnggbk7m/TdrXy/uLltGhFp3t4OCXw/w=
X-Google-Smtp-Source: AAOMgpc2NZ1z8FtkBDzvxmMWW3LWQQc20eBp1GJDOdrGrW7y3N3M0xn/rGJ4Gis3R5KGDP8vZF1wHn1biY8FxlNRrsQ=
X-Received: by 2002:a5d:46c6:: with SMTP id g6-v6mr14327802wrs.76.1531156698890;
 Mon, 09 Jul 2018 10:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180628074655.5756-1-predatoramigo@gmail.com>
 <20180708180104.17921-1-predatoramigo@gmail.com> <20180708180104.17921-2-predatoramigo@gmail.com>
 <857b04d8-37b4-596f-6f3e-45b6e2a59442@gmail.com> <CAPig+cQopjftfSoPHPZQAzECTAUUwZ-pXYMeWEV=VJBFm63t9g@mail.gmail.com>
In-Reply-To: <CAPig+cQopjftfSoPHPZQAzECTAUUwZ-pXYMeWEV=VJBFm63t9g@mail.gmail.com>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Mon, 9 Jul 2018 23:03:07 +0545
Message-ID: <CAOZc8M8qecSkH_zujcesSSGZy=9fS=phuEGMJPx_Vwit_2s+FA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] rebase: start implementing it as a builtin
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     rybak.a.v@gmail.com, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Jul 9, 2018 at 2:21 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Jul 9, 2018 at 3:59 AM Andrei Rybak <rybak.a.v@gmail.com> wrote:
> > On 2018-07-08 20:01, Pratik Karki wrote:
> > > +static int use_builtin_rebase(void)
> > > +{
> > > +     struct child_process cp = CHILD_PROCESS_INIT;
> > > +     struct strbuf out = STRBUF_INIT;
> > > +     int ret;
> > > +
> > > +     argv_array_pushl(&cp.args,
> > > +                      "config", "--bool", "rebase.usebuiltin", NULL);
> > > +     cp.git_cmd = 1;
> > > +     if (capture_command(&cp, &out, 6))
> > > +             return 0;
> >
> > Does strbuf out leak on return here?
>
> Good catch. This _is_ a potential leak. Here is an excerpt from the
> documentation of pipe_command(), which is called by capture_command():
>
>     Any output collected in the buffers is kept even if the
>     command returns a non-zero exit.
>
> So, yes, this needs a strbuf_release() before returning.

Hmm. This seems to be a problem. Thanks for reviewing.
