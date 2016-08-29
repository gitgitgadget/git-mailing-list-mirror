Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49BEB1F859
	for <e@80x24.org>; Tue, 30 Aug 2016 06:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751136AbcH3G34 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 02:29:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:61213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750697AbcH3G3z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 02:29:55 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MNIO5-1bkyCi1ZdZ-006uwZ; Tue, 30 Aug 2016 08:29:49
 +0200
Date:   Mon, 29 Aug 2016 19:15:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/22] sequencer: avoid unnecessary indirection
In-Reply-To: <90d26cba-0013-eb31-ba40-52f3e2f9d239@gmail.com>
Message-ID: <alpine.DEB.2.20.1608291913270.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <e5e6c27038c7db226a787da6b7ee343b2b310654.1472457609.git.johannes.schindelin@gmx.de> <90d26cba-0013-eb31-ba40-52f3e2f9d239@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-743086972-1472490918=:129229"
X-Provags-ID: V03:K0:rLW6AMsC7Yqw5Hw2nkUaweQ9M+tsfwgqXni38N5Ff54mEUAn2x9
 AQFasmI56r0Nh5HLjIMyqfGP8ufWRsfO5C0T2t/lGjPfffFLJOH26LEAr9ERUGhu/1IbvOL
 ef3UJ5Q6PZxvwxfX4dVIiA4mWfHfKN7ixXBpYu1eqenKKYsDiB3jDLkpneRGc5rme1Ytct+
 qru/XgKo0vsP7B/qlt5uA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2W3UcGReIqE=:qtvxB/OWfjAQ0MlTtHh2Ha
 gs27fsK4zNTXploaSLGIPYa/j/r+V2jAPp51xjsDDxoch828Ive/zrZhLroiH5Jba0sHYNf2J
 pGiSmNFLa4Yvxovd/CzFvvmJHOGw3RvFadC81EvpUnOCc+iKOI8oAG1niGCz+OQ86YJaBEKm9
 y6TETZKdeVGGRL2QyQ62MiUYAjWnjY5buB6tra5KiG0tWQlXMjmLrKwwDTZTiahtJss+TbcTZ
 BGQfRuUvVVjx5eZC/nbpb4zSqs4NbngbR+uMnvk36HRMtrPMy0GrNXcc85AoKC4J49q2RjgMf
 2qUvakB+pkpjnG/GvSpx3dPDQzlLrCAt3jqs8cXk2pPPbpbzjzU58xGzPakfjXsoU3RrJ4VOR
 BaMN4sefDZhVyleLXxGrR7SGLowo+/icb979ty1huOn5rcNVwwLHCEN0c8zLy992iS+fhI7io
 h6/Ku0xzFWSTK1RO75iILGj4EVz5TByQRNP1Ji+d5ZJJNjt8qnbmkhLIG0PqQZ579Nov3mVjs
 81TrXgUGvzP05Z0l8E7bI7+I6/LqDNrrVrAr4EV7ELtPfh4ew1dt237p3Zs51JARFLmhSKzvZ
 UNKbigvGnzzr+4PTq2VuB9uCtUvfhgEOzf/PMEm0RkiC2iWqkh80xeR6iA/wIqoekwkAiOwa0
 EOXswRwiQgPaQHso6qdyxAMPw6NRfzMnPxIjRxIebt7Y2N3AFF1YGQojiIxGsMpaexhngKaNX
 VgTVeM3zr6CH82L9Z3tNp4bdG0GXQuzZPunFhU9L4Pzkp35u/cu/AAado4J699qSrj+Hio/6q
 1q6b6sM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-743086972-1472490918=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Mon, 29 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:
>=20
> > We really do not need the *pointer to a* pointer to the options in
> > the read_populate_opts() function.
>=20
> Right.
> =20
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  sequencer.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/sequencer.c b/sequencer.c
> > index 4d2b4e3..14ef79b 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -809,11 +809,11 @@ static int populate_opts_cb(const char *key, cons=
t char *value, void *data)
> >  =09return 0;
> >  }
> > =20
> > -static int read_populate_opts(struct replay_opts **opts)
> > +static int read_populate_opts(struct replay_opts *opts)
>=20
> Especially that other *_populate_*() use 'struct replay_opts *opts':
>=20
>    read_populate_todo(struct commit_list **todo_list, struct replay_opts =
*opts)
>    walk_revs_populate_todo(struct commit_list **todo_list, struct replay_=
opts *opts)
>=20
> Though they use **todo_list, because they modify this list;
> maybe that was why read_populate_opts was using **opts instead
> of *opts?

I won't speculate about the reasons why it was made so.

About read_populate_todo(): it uses **todo_list, but still only *opts.

In any case, in a later patch, the todo_list parsing is completely
revamped anyway, so I did not want to "fix" anything that would get
reverted later on.

Ciao,
Johannes
--8323329-743086972-1472490918=:129229--
