Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6601F954
	for <e@80x24.org>; Tue, 21 Aug 2018 16:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeHUTeQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 15:34:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:37073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbeHUTeP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 15:34:15 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LlE86-1gQw8Q1RPK-00b0Yo; Tue, 21
 Aug 2018 18:13:24 +0200
Date:   Tue, 21 Aug 2018 18:13:23 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] diff.c: add --output-indicator-{new, old, context}
In-Reply-To: <CAGZ79kY8oadQ2nKWr7znMa8QJgLcidb0FefPDBaba+q2J=nfPg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808211813020.73@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1808161022180.71@tvgsbejvaqbjf.bet> <20180817204354.108625-1-sbeller@google.com> <20180817204354.108625-2-sbeller@google.com> <nycvar.QRO.7.76.6.1808202129420.73@tvgsbejvaqbjf.bet>
 <CAGZ79kY8oadQ2nKWr7znMa8QJgLcidb0FefPDBaba+q2J=nfPg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qdTQ7ZCS3qtGyk0zkvs9KH8OMThMSkInF8fbPp2hNuYdLEP7+Fx
 l/5tjTWeKG4DsUKSAfnzJjYFwimk1HdNoAk/reg8nrHVjtsHJtjiJgDdTDQNZbXnoXTH1Ed
 zhu/1+/d0FzsdzNE/yNn7pSEWFoVUb7U9wAQEfjvSHin8PrtA/u4dijzEgYTSEghXQry6m+
 G2bEfMEECCN2cOSfE8FhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JNXoFnT41l8=:6GNCED/bFzM/nrtnY+bhym
 ux57ytVZpn7T3D2+3mMbUKJf03wHmfQOMG8a0mZQndBPC52XdtjpdaGGUqNxpPahk/yaTFaAW
 cSEHbphdad4GDw0jiI84tb7+WqsdzRifpYl7adrsLJTYSfCzJBNvqMyuYX0/D7zojuLKidSaT
 IzBAaA2sCsggcPplcbQG5tVEe18CCud/uUQJGLDQu9L6wRj1ZZcpC2FIND+SBNQ2SvKp4rWSx
 U/ON7QFvFXBjMgfVWJMwuMNg1M4oES6q0uzUhjbLy3NZ9XKejG/GzDWTjMtKhbu7GuaDRNwTJ
 x10sv/8iVeHlGeDljNNOTYPAe+UpjCHB91GIVk9OfyMwAeVICXuWlOgWwc0/BADEkhvLmrVog
 EIvgr9kgDrL+M5fCrEpi2jkc2n+JQehBPgJON02APeMe/w2/gcZdxw9QjQG8xJ4Ma2yA7FSzS
 yD4ILis24GpZcW5Qs/mZ6Tv1hmQDFduCx6L3OM5VPHFNQexZHRDADzE1/TFBi8lls13wpcWzL
 dZyFXGbihWgJ/INyZJT2oJMkDHopOhVwl+y3CMf83o7N8OAgN9ofZtjkmHSSxlLWqojXScJyb
 nY4HZAdFQLG3YkfHy1KKDmf0x+IqzT3kjAJoaLJsi1/RBj5JqYv1IMuJdQnVmx0osq4GnLUXX
 +jJi/gqCu4tDkx1ar63E8JPRH+Y+vQ1PNfcUEQhwSAFRDmCR5MjjY7eaJq4v3eRfLUb8UKBeM
 EbCqYnMZomhgv95VEMHlL1A64QoozSLAbY0featVWCoEMqF+g9uOyWCGvgXHLU7EL/hxNjrYg
 +mW0VJK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 20 Aug 2018, Stefan Beller wrote:

> On Mon, Aug 20, 2018 at 12:31 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Fri, 17 Aug 2018, Stefan Beller wrote:
> >
> > > This will prove useful in range-diff in a later patch as we will be able
> > > to differentiate between adding a new file (that line is starting with
> > > +++ and then the file name) and regular new lines.
> > >
> > > It could also be useful for experimentation in new patch formats, i.e.
> > > we could teach git to emit moved lines with lines other than +/-.
> >
> > Thanks.
> >
> > > diff --git a/diff.c b/diff.c
> > > index c5c7739ce34..03486c35b75 100644
> > > --- a/diff.c
> > > +++ b/diff.c
> > > @@ -1281,7 +1281,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
> > >                       else if (c == '-')
> > >                               set = diff_get_color_opt(o, DIFF_FILE_OLD);
> > >               }
> > > -             emit_line_ws_markup(o, set_sign, set, reset, ' ', line, len,
> >                                     ^
> > Here we already pass `o`... so...
> >
> > > +             emit_line_ws_markup(o, set_sign, set, reset,
> > > +                                 o->output_indicators[OUTPUT_INDICATOR_CONTEXT],
> >                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > ... here, we could simply pass `OUTPUT_INDICATOR_CONTEXT` and let the
> > callee look it up in`o->output_indicators[]`...
> >
> > I read all three patches and did not see a reason why we could not
> > simplify the code that way.
> >
> > Other than that: great!
> 
> Thanks!
> 
> I considered it, but was put off by the (small) effort of yet another
> diff refactoring.
> 
> I'll include it in a resend if a resend is needed, otherwise
> I would suggest to make it a patch on top?

Sounds good!
Dscho
