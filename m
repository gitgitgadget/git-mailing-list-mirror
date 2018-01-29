Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76B8B1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 21:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeA2VFd (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 16:05:33 -0500
Received: from mout.gmx.net ([212.227.15.19]:63048 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751812AbeA2VFb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 16:05:31 -0500
Received: from minint-kr8j64v.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MQQzk-1eCexH2JkC-00TpJv; Mon, 29 Jan 2018 22:05:27 +0100
Date:   Mon, 29 Jan 2018 22:05:26 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 4/8] rebase-helper --make-script: introduce a flag to
 recreate merges
In-Reply-To: <CAPig+cSn_X-0iir-cKSd=P8p5QCxrR2qU_GBj7zDbv8zTc+AQw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801292200550.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <b9cb2d915aa4ff564b1960ce0352664b1d26eecb.1516225925.git.johannes.schindelin@gmx.de> <CAPig+cSn_X-0iir-cKSd=P8p5QCxrR2qU_GBj7zDbv8zTc+AQw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1cXcqYKRYMnLF7fsSwsBzQidxF9aFTZwn5qMlT8bwXoU+6xSB2o
 My36BY/kx+dTKN6i0BiKfkG3glvvdJGMjTVWKYpVL5UgmKpjQwXG5RQGVYc3S+yNYwZlDnL
 Tih8q/o6IkbL+ui1xyh0WUFG8DE+Ds/u8ZPq4q3rhHEKFrvuwaEUZFr677Dq2PSsWnFlJiy
 7dObfYa5SlH/dH2yIIh7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LSVdKw3/TfU=:3jygqlpcA2wXrake5sAA0g
 0trHsoYsbbZucY4pTlgULEXYZNosGOhw8y6lAY4wWAE+oVXoUnduMuCH4CvhKtmhb/Jk12ufQ
 LPZKaxB24YSJFHPNcnr0GXYSYs9ZypKETbWbPEEy1g0i2fRS563KxRgbcdXMdaH+w/p+VYKN7
 02sdhW2PqR/H/yVGb4UC51TjCYNUxrrClcqRffUV04zxh/I9+/AqrWQl+v1lqJ14ZcYk0YTGV
 P6GaIflLpO5092AsCJX1KhKmBxPVQ2JUSoSOcJjt+1EVpxroum5DB84qGM8TcDVqa3MGmgpm9
 9k2mZwOpcjHg4q8AIj1uzpzEUAOCFEK8X9pXxZP0zW4dSdIPEkatFBzxOaV6PXIoVMuWUFfFM
 h5hrXSP68j6gQcv6Hd4UZUKF9+54mR36XvUlOmru42YoeLjcU6PQ5bTPd/mepeicJnl0LdPfM
 Qf7dEEePSjDrtbHG783k0pZitACHy7j4KqVHnlHvSWnJFoM59QAYFN/x17aN2tHb5JgDSRY5j
 hcn4cVwzuD4CgPs68W9UnuVF3vOIWUOUrW8wxQDZD5jERXnVjqO/GoWrnwporJglR1dEj6Tuk
 AY10ccaFAnJhkve/rCC+eXuUqVtlyDDbdcWLiMYO5xTlfSv/BG6DReWi64zKU40j/MH2tzAst
 ZQmwtbyh5mAUyZ/WCwuha0iL+ZAsuFX0tmLuerAZbfIbcXzhNld/pceilPJOgGt9dzlTPkKrs
 c745qw7M2lEphDlNu5aqdzop4UvLPa4R9F9FjBE7qcxDE5RDQDjrVO2ZNq1yrh3tOn/S/ImiY
 eEa3nY2pmY8a61H6mB/5r6PlqiYY8w5ke9436ap2sYoEee07ykdEfsrgEtgKHpadEhwrrJJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 19 Jan 2018, Eric Sunshine wrote:

> On Thu, Jan 18, 2018 at 10:35 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> 
> > structure (similar in spirit to --preserve-merges, but with a
> > substantially less-broken design).
> > [...]
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/sequencer.c b/sequencer.c
> > @@ -2785,6 +2787,335 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
> > +static const char *label_oid(struct object_id *oid, const char *label,
> > +                            struct label_state *state)
> > +{
> > +       [...]
> > +       } else if (((len = strlen(label)) == GIT_SHA1_RAWSZ &&
> > +                   !get_oid_hex(label, &dummy)) ||
> > +                  hashmap_get_from_hash(&state->labels,
> > +                                        strihash(label), label)) {
> > +               /*
> > +                * If the label already exists, or if the label is a valid full
> > +                * OID, we append a dash and a number to make it unique.
> > +                */
> > +               [...]
> > +               for (i = 2; ; i++) {
> 
> Why '2'? Is there some non-obvious significance to this value?

I personally found it irritating to have labels "sequencer",
"sequencer-1". It sounds *wrong* to have a "-1". Because it is the second
label referring to the term "sequencer". So if there are two labels that
both want to be named "sequencer", the first one wins, and the second one
will be called "sequencer-2".

Hence the 2.

> > +static int make_script_with_merges(struct pretty_print_context *pp,
> > +                                  struct rev_info *revs, FILE *out,
> > +                                  unsigned flags)
> > +{
> > +       [...]
> > +               is_octopus = to_merge && to_merge->next;
> > +
> > +               if (is_octopus)
> > +                       BUG("Octopus merges not yet supported");
> 
> Is this a situation which the end-user can trigger by specifying a
> merge with more than two parents? If so, shouldn't this be just a
> normal error message rather than a (developer) bug message? Or, am I
> misunderstanding?

You are misunderstanding.

This is just a place-holder here. The patches to introduce support for
octopus merges are already written. They are lined up after this here
patch series, is all.

As such, please do not occupy your mind on the specifics or even the
upper-case of the "Octopus". This line is here only as a hint for the
reviewer that this is not yet implemented. And BUG(...) was chosen because
that way, we are not even tempted to waste the time of translators.

Speaking of wasting time... let's move on to further interesting code
reviews.

Ciao,
Dscho
