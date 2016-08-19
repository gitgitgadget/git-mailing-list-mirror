Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A670D2018E
	for <e@80x24.org>; Fri, 19 Aug 2016 12:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752244AbcHSM0S (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 08:26:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:62839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750721AbcHSM0R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 08:26:17 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lxdfb-1b7a6l1DFj-017GOB; Fri, 19 Aug 2016 14:25:52
 +0200
Date:   Fri, 19 Aug 2016 14:25:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] cat-file: support --textconv/--filters in batch
 mode
In-Reply-To: <20160818154213.GA17141@tb-raspi>
Message-ID: <alpine.DEB.2.20.1608191423440.4924@virtualbox>
References: <cover.1471524357.git.johannes.schindelin@gmx.de> <2315ae5ab6918a7c1567f11a64093a860983bc20.1471524357.git.johannes.schindelin@gmx.de> <20160818154213.GA17141@tb-raspi>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1125215240-1471609552=:4924"
X-Provags-ID: V03:K0:6EXvzWUdLhRMneca0JClRJwfBIzlfkxSEm7DQAUaEZJRavnPD4G
 JHrgxOQOq9+v03P+r1PoJ6/xriEoDXms9ZPqqU/BhqRS55GX2Rl6RDpYSs1XtsDhKc7mTv4
 4p/aXFM+xHM4ME+QzVaLzEG7tWz6xGdmbg5dv/JAjbni48wCRwqlAzPmJdoSRBsudW+Cnir
 nikyVUUfH5NPG8yDaiA5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lS5eBOcNjjE=:k0j6CY7pkdFj8P9WYnRZCJ
 rOCt1+aIGebW5Wt26NCVnK3U73rOGWqLp353kc1E+bp1bYpKZMDynNUmdxow8UTT1rKzvMKt8
 M2uTQMaEj5WGFaTQCfXgbpjvfT+Z0nXBHpbTrA+lctgUTFHhZalyUzgGl8poissYI8gf9FPVT
 8C//8PCDQMfRYIC/sf2i/ZUcIZISr31UIaWrvTMSujDxB5jM896iAEMZ9bjqCqdVj3NOgvkyi
 C6xF5yoaZ8ojm661DeM43N8RatXPptYD3dIzPE/JTp6Xxu1T9wzYzgAKPUOdQKN6qyJB7WQVJ
 Vz8R/UF1ZU26G7rj7WEKII9llbWV2ttrl0TijUb41n3oaZ2o0iGrjLpAjXOddiuFuavUKrosK
 BPNn1y+M56Zx+peuKsC0D4z+FPnzAm8Ju0pGFS7nAJLgjAvUZObI6aTzRFrqgE2SAjzj4zUJ0
 H3Vc59sbCdVB7AEIMGrIHydllN7oDMYZ0AWqm9gnxaSE3VH/JXUbepdLftHv00SMfk+J+Iv47
 FbvDcOKSsDFCnemOOgiBOs53dUvPnMpOZs07IwilsA69hH+41uledR8pYzC0TKWexDqoG+y0j
 LXlgXkdfog8scH+pFBbx5oT4lRpsoxALdZsG+r+BxalIc3A49QGtO1EzwvF0G8a3lNsL5Pw12
 djyVNeK/dWkpptauSMy1Wo9XtHWqKrSfWPJa1Kw9Brqr/XmsDc50olk/RyThUzCkJK+Cm6YsY
 FEXFHBR7BfDjBmGldoDQjzElBb4MRc4ZM2MSewGSfovYVx/zqOldU79bsDBaQib8UDVeySLQf
 q+xSAEn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1125215240-1471609552=:4924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Thu, 18 Aug 2016, Torsten B=C3=B6gershausen wrote:

> On Thu, Aug 18, 2016 at 02:46:28PM +0200, Johannes Schindelin wrote:
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 5ff58b3..5f91cf4 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -17,6 +17,7 @@ struct batch_options {
> >  =09int print_contents;
> >  =09int buffer_output;
> >  =09int all_objects;
> > +=09int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
> How do I read 'w' and 'c' ?
> wilter and cextconv ? Does it make sense to use an enum here ?
> Or a #define ?

Sorry, Torsten, this is not my doing. So I cannot explain why it is not an
enum.

I *guess* the rationale for 'c' being the cmdmode of --textconv is "c for
convert". That is why I chose "w as in worktree" as new cmdmode.

Ciao,
Dscho
--8323329-1125215240-1471609552=:4924--
