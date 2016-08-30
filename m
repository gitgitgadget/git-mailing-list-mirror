Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E4D62018E
	for <e@80x24.org>; Tue, 30 Aug 2016 17:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933277AbcH3Rhn (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 13:37:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:60703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933497AbcH3Rhj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 13:37:39 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LfkJC-1bLSvc3rzu-00pJ36; Tue, 30 Aug 2016 19:37:27
 +0200
Date:   Tue, 30 Aug 2016 18:48:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/22] sequencer: future-proof read_populate_todo()
In-Reply-To: <cb4402e9-6765-961d-0d67-43b74db05ef1@gmail.com>
Message-ID: <alpine.DEB.2.20.1608301846360.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <4043fd4b955d6a3bed1b187d9529d5382db5b961.1472457609.git.johannes.schindelin@gmx.de> <cb4402e9-6765-961d-0d67-43b74db05ef1@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1469541981-1472575724=:129229"
X-Provags-ID: V03:K0:14Io0vqsVjlK1AZ+4FB/+BhdF/vd+LM6upE+9HXsRLF0StM9zhY
 67sm5p4CvZqqV30qWB+vpdvrlklsOQn9BUAAzx/bCK4rOJRgyoC1bSoRdiWNW6yGsHWHMji
 miLlmYO2SO4H7qucv2V7yiLVTvd6cwmVD/fOOOdix4D8pW6HD9gqggiBsTj5X0uvrdMHc/3
 FHdULtVtocLL/GujK2R+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nwRurKIfWQ0=:3fc/7JpAZ1JGXmu7RuJX4e
 VIpJSXoRaSpjFEJdJRDaeRzHXzLW5udQ9QuMxfGcDd9gdRZCvXcrQxBHsTKz5bN7SNry+6+FR
 8B/gQLQMT5oha/7hanWtW0fi9ZtyqhuGoDxZakM0aniCtw5bASY8oA19Nt4PGKt9AwBKAGNQi
 lfDECoPVazCeox+aT1xBwsdUGlLYK80+0sVxonk8pK7FxyxFQfzeY9tsuowpvTaXVmnR+BrMN
 C3WLysrtwnidexsFhY4JylKBSmgVaT17ktsgAU/9nXVTE2anM90i+subkRS9Fp15C1YI+NUvH
 pQtO79KjF9J0RZpIMgABNHj4s/sa4/KvctnDrNIZgCx6WXKMJX5483sGF1ElieVh3zxNkq6VZ
 jo6rDnQcMjtHp9fDgb6rMR6JlwdGEa3g+lol82iFv0bIuPHju4I8fuPRGkR8fxMXKhX1Hay4F
 0/6qX33wv8jzABd/JnbD+hnjQkA5OxmDmE94HcI+ZKOzwcO025kfW9VXVX+RzHt6EvcWL0QaP
 SbI942RcvfdWhdpnZfufqcZ65Vp+Q3xHDRa5Ff1ts/p1Awn4Ci4PmCZ/6p3fGybCH4uIYjspk
 EEqgKwdPu7TEiIJCnoYbiBRAaaZEFCd03sccN4aqZPcyVyS8LrDToEaZhICstWmJOHJTzlL5Y
 lZ45RFAbc7XJw9GpgzWBtx07oUzvPLaAw9bcrd5fOwcWWm0/n3wTMJ8ZKmbzO2cZJTuj7ImWc
 CY9lw1o9U1QObbV3XYx8jChr/bj5fARzJXue6PH6xEovuQHXMPLQoaUAmMxSYKk55v7kNrVWo
 4GQquXa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1469541981-1472575724=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Tue, 30 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:
>=20
> > Over the next commits, we will work on improving the sequencer to the
> > point where it can process the edit script of an interactive rebase. To
> > that end, we will need to teach the sequencer to read interactive
> > rebase's todo file. In preparation, we consolidate all places where
> > that todo file is needed to call a function that we will later extend.
> >=20
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  sequencer.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/sequencer.c b/sequencer.c
> > index 8d79091..982b6e9 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -32,6 +32,11 @@ static const char *get_dir(const struct replay_opts =
*opts)
> >  =09return git_path_seq_dir();
> >  }
> > =20
> > +static const char *get_todo_path(const struct replay_opts *opts)
> > +{
> > +=09return git_path_todo_file();
> > +}
>=20
> I guess that in the future commit the return value of get_todo_path()
> would change depending on what sequencer is used for, cherry-pick or
> interactive rebase, that is, contents of replay_opts...

Right.

> >  static int is_rfc2822_line(const char *buf, int len)
> >  {
> >  =09int i;
> > @@ -772,25 +777,24 @@ static int parse_insn_buffer(char *buf, struct co=
mmit_list **todo_list,
> >  static int read_populate_todo(struct commit_list **todo_list,
> >  =09=09=09struct replay_opts *opts)
> >  {
> > +=09const char *todo_file =3D get_todo_path(opts);
>=20
> ...and that's why you have added this temporary variable here, to
> not repeat get_todo_path(opts) calculations...

=2E.. and to repeat only 9 characters instead of 19...

> > -=09fd =3D open(git_path_todo_file(), O_RDONLY);
> > +=09fd =3D open(todo_file, O_RDONLY);
> >  =09if (fd < 0)
> > -=09=09return error_errno(_("Could not open %s"),
> > -=09=09=09=09   git_path_todo_file());
> > +=09=09return error_errno(_("Could not open %s"), todo_file);
>=20
> ... So that's why it is s/git_path_todo_file()/todo_file/ replacement,
> and not simply...
>=20
> > @@ -1064,7 +1068,7 @@ static int sequencer_continue(struct replay_opts =
*opts)
> >  {
> >  =09struct commit_list *todo_list =3D NULL;
> > =20
> > -=09if (!file_exists(git_path_todo_file()))
> > +=09if (!file_exists(get_todo_path(opts)))
>=20
> ...the s/git_path_todo_file()/git_todo_path(opts)/, isn't it?

Correct.

> Looks good; though I have not checked if all calling sites were converted=
=2E

Thanks for the review!
Johannes
--8323329-1469541981-1472575724=:129229--
