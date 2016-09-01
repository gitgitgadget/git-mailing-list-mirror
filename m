Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 688271FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 07:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754742AbcIAHw2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 03:52:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:51469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754506AbcIAHw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 03:52:27 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MegeC-1bUGzc43cu-00ODcs; Thu, 01 Sep 2016 09:52:21
 +0200
Date:   Thu, 1 Sep 2016 09:52:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 10/22] sequencer: avoid completely different messages
 for different actions
In-Reply-To: <30b04497-dfb8-914b-42c4-8bc66347d347@gmail.com>
Message-ID: <alpine.DEB.2.20.1609010950150.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <1e940c58329ff5f224ec5bc48927a28ff4d1bf66.1472457609.git.johannes.schindelin@gmx.de> <30b04497-dfb8-914b-42c4-8bc66347d347@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-526280653-1472716340=:129229"
X-Provags-ID: V03:K0:vIsFnXdAPxrrhlXKgtnFJyF2+FYymKu+Q8EuifwPJaOkxznq86A
 o7m8qO6g/fAezIlHQDE7rO80wDxNAqHogU6pdNUofBnpPkkwNUURLwxFl/19iVFTC9YtDMZ
 leHNg/vBYTd8OC9EcfeKQx2yQ3axomtrYXDLT83yPgdBjLg5OZYG8Al9nEqQysqaivmLkBn
 woSf5iErea2FjyoiOl1MQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WNgBuDHKWFs=:YlTisa/G7H+yghH/JxZcY1
 C+/j2HiyLQu0wcS/loH853eTil+qYWuxMSlYzqpvrvlQWa+Lb28+0YMzZkhMoSQghNo8q/cc9
 4b13p+nunJrCNZg9jMdNvREZApLQ/F3hJ8Ja9+QAKGbwst0WsTlRBe4lloFvTmxo2VtiS0L3p
 O1waJrKRMtczmlYMxiPD78M+Z6tDqBCvepvs2be7OZi2UaccuOdyN/qXGCGJZPltyYQMoReIP
 lDJWQijgjsRwATLc92euEOA2jKMKbJuTb3wv0oTu5wENfoj2otJScoSGB4ZvfxXwlRndtLmCG
 cN+GFUtpQyeSGwsUNPsqhOjH7DuE0gOTHxmBHd+EmcfdMGiMmN5yvEBcjkdV5Lv5Lcvh6LPOs
 5l6gY5sfykaLC88vZq51ccs9E/9sYyvpd3sC99z+04sR2b02M3DTwDlT+KCfLpBwTjIS+D2Hz
 rPJ/bhfiEB01+Rlu5gRFz5PAT7ecn3AHXNQIPIN7E63D0SiIn+UIVYtxlUa7lbpfMYoIEGykx
 2p955xBs9B5vZL/51EyRtYLMI2FPV+Vi93u1BdDzQj71EoyvimsBsv1K8L8VWjEh2YsVaPr50
 gU9Pz72IbXCXI01EoRbEbo9cIQMF/z8vHnTGC6pNPf37/Hdvu/X43F/OAmhCE69YdVWO6VdYT
 o3UG2jtDNuaDNqXxlBIgnPru91timsNPRyTGUZ8QaCAe2gflcafDoMq53surKGqLAO6lILnTd
 NM6R5cdPnKX4fGfBH8SoHH2vGjJ59YFAoF2ivCn9xkLM0wcp1ep2rl7jf9db+KAAnm65rWVpP
 pffehAL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-526280653-1472716340=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Wed, 31 Aug 2016, Jakub Nar=C4=99bski wrote:

> CC-ed to Jiang Xin, L10N coordinator.
>=20
> W dniu 29.08.2016 o 10:05, Johannes Schindelin pisze:
>=20
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  sequencer.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/sequencer.c b/sequencer.c
> > index cbdce6d..1b65202 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -232,11 +232,8 @@ static int error_dirty_index(struct replay_opts *o=
pts)
> >  =09if (read_cache_unmerged())
> >  =09=09return error_resolve_conflict(action_name(opts));
> > =20
> > -=09/* Different translation strings for cherry-pick and revert */
> > -=09if (opts->action =3D=3D REPLAY_PICK)
> > -=09=09error(_("Your local changes would be overwritten by cherry-pick.=
"));
> > -=09else
> > -=09=09error(_("Your local changes would be overwritten by revert."));
> > +=09error(_("Your local changes would be overwritten by %s."),
> > +=09=09action_name(opts));
>=20
> If I understand it correctly, it would make "revert" or "cherry-pick"
> untranslated part of error message.  You would need to use translation
> on the result with "_(action_name(opts))", you would have to mark
> todo_command_strings elements for gettext lexicon with N_(...).
>=20
> I am rather against this change (see also below).

Okay.

Unfortunately, I have to focus on the correctness of the code at the
moment (and Git for Windows does ship *without* translations for the time
being anyway, mostly to save on space, but also because users complained).

So I will take care of this after v2.10.0.

For the record, how is this supposed to be handled, in particular when I
introduce a new action whose action_name(opts) will be "rebase -i"? Do I
really need to repeat myself three times?

Ciao,
Dscho
--8323329-526280653-1472716340=:129229--
