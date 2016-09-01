Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18FF81F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 13:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932589AbcIANmj (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 09:42:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:57484 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932577AbcIANmi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 09:42:38 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LqzIJ-1bBbcx3HUZ-00efAO; Thu, 01 Sep 2016 15:42:32
 +0200
Date:   Thu, 1 Sep 2016 15:42:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/22] sequencer: support amending commits
In-Reply-To: <dd7e4c82-cedb-6cde-a186-8b52bac3a5b8@gmail.com>
Message-ID: <alpine.DEB.2.20.1609011540550.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <c4e474af8e6237522f4c452ca90c2e2670059e60.1472457609.git.johannes.schindelin@gmx.de> <dd7e4c82-cedb-6cde-a186-8b52bac3a5b8@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-892349001-1472737352=:129229"
X-Provags-ID: V03:K0:yN9dz/UflfJ14+zyWGkjg+DocJsHe6lMh4mLTXeEInZkFz7cltN
 4ghIJp2e958eGwBrDimXJjRWltw0lCi4M8MzB/nU+BIEIno2rtZdcD0VaT8q/QCsFuN11CX
 bRONYEjvsIKE/QfdR8g4yqLFWgnNwC9LeAw/Lma5IPPt2uAeGA98vY0vJE/q0OeT4jJHj7K
 ncQMu4z/e3z2/zLksmVIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wE7sB2SPW3M=:tJSCliLOU6Rnte2KSy35Lr
 gRAT1jCMxwjayqxzoCLq7ccYcW+qeABL0vCtpWwn1/K0ERC2G3bBkj2BdNwYoQQrAxxyO66Wz
 pAfXLN8WTmPf2seT8Sd2HdMt9E0+FotmU0Bf2v+tFw2yOybJwZBsu7wH92hwu3k9uZbqhyRya
 fNWjBUAKwl9QqUiowebqQB/beQqG1wHrWn1Ly8nPhIFa3X/pGZANO1k7n9CciAuqRRDbCtN4q
 SR5HJp1m92hAO0oz2XULZWxQs+bvAG7qWStxRCml0D06HHPXP6Ek2Np2GgAgImL/VzwyFvtln
 e91jYCVhANpwKunkaZty3krNjXPLimXR89xUREp/24ndXpFlXNoxisrsGZR5apbgCQMD59SPs
 EeEUBF2brAfpypo4NQrTWcI0IzQF6jF+A1XA/nt+iMu2q3ImeyfPde5mjA+7HV1HlhaXN7jcI
 FDtwb9IMXVcY4EHLEEU2hNcrlxIrgtCJxn0qYGOQ1uDUm7nQpEljh4YiXkx5s4c2Kw+mRkCOD
 qI4YpIDj96wGkWwjZyUx1ylUNXS+vf0J/HMnvv+9HNLSR91c277w9oN7ETBhGVGlMkdQL12nj
 fsWpI6H3LpjQF6GMNTbUIV/2PLgE1LzbIpMZy946gxRiBYHrCLzzPcSZ3h9fisT9iIi2s5w8q
 V20qWbgOCjk3GYGLCE/J/Cm8d0iP0Edz9R8gzFdq4Jtb3T7usbLyWv0AaQkb8bfQDyYnqPgWr
 yhkQ1efPUeaREnGnk/HZJ1JdOdnNAJqP8S2eQW1dJk4TmcsDe6TxYG1BOCQpxvQHYSaqiqcC3
 zwnzraQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-892349001-1472737352=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Wed, 31 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:
>=20
> > diff --git a/sequencer.c b/sequencer.c
> > index 7e17d14..20f7590 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -478,7 +478,7 @@ static char **read_author_script(void)
> >   * (except, of course, while running an interactive rebase).
> >   */
> >  int sequencer_commit(const char *defmsg, struct replay_opts *opts,
> > -=09=09=09  int allow_empty, int edit)
> > +=09=09=09  int allow_empty, int edit, int amend)
>=20
> I guess we won't get much more parameters; it would get unwieldy
> (and hard to remember).  Five is all right.

It will eventually get a sixth, cleanup_commit_message.

> >  {
> >  =09char **env =3D NULL;
> >  =09struct argv_array array;
> > @@ -507,6 +507,8 @@ int sequencer_commit(const char *defmsg, struct rep=
lay_opts *opts,
> >  =09argv_array_push(&array, "commit");
> >  =09argv_array_push(&array, "-n");
> > =20
> > +=09if (amend)
> > +=09=09argv_array_push(&array, "--amend");
> >  =09if (opts->gpg_sign)
> >  =09=09argv_array_pushf(&array, "-S%s", opts->gpg_sign);
> >  =09if (opts->signoff)
> > @@ -779,7 +781,7 @@ static int do_pick_commit(enum todo_command command=
, struct commit *commit,
> >  =09}
> >  =09if (!opts->no_commit)
> >  =09=09res =3D sequencer_commit(opts->edit ? NULL : git_path_merge_msg(=
),
> > -=09=09=09opts, allow, opts->edit);
> > +=09=09=09opts, allow, opts->edit, 0);
>=20
> ... even of this makes one need to check the calling convention,
> what does this 0 mean.

Yeah, but it will not remain "0", but be replaced by a variable named
"amend"...

Thanks for the review,
Dscho
--8323329-892349001-1472737352=:129229--
