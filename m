Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C7C11F859
	for <e@80x24.org>; Tue, 30 Aug 2016 06:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757451AbcH3GZi (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 02:25:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:62071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757432AbcH3GZh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 02:25:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MMCSP-1bjroF3q9t-0081Ni; Tue, 30 Aug 2016 08:25:31
 +0200
Date:   Mon, 29 Aug 2016 19:10:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/22] sequencer: use memoized sequencer directory path
In-Reply-To: <10e19839-2875-2610-0af3-0b86831916f0@gmail.com>
Message-ID: <alpine.DEB.2.20.1608291908140.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <d032a9d765aaca0655b1e363e67d9bf24864396c.1472457609.git.johannes.schindelin@gmx.de> <10e19839-2875-2610-0af3-0b86831916f0@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1545185318-1472490659=:129229"
X-Provags-ID: V03:K0:rOA73LvJMrm0zhjlqmf4aGrfX9QZ9KYqExA3pj1++otdq5l8QZF
 P53a/jjAF/qkUiiRUTTyEQ4UUK8AL9lGk0SzkwD+XGXPmLOjPh0fEgEEBWFls7YJvqa5B+v
 QcEw5ZtXHhZnLu2ASw18m+WnxR40zwBfP3G4z2VnzZG67etOOINq56GjYkY842dZLe24UuG
 9GymFliMZwPA9JMn+JSTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mrZ8oIZxfug=:SkXUty0x63ETIqFGEuBBcJ
 5h75UaaZrZ7R66E4omWN5O25O8RrlrtEX735IRWwaGSudKV41xoC8hDr3huP5OYUHfST69i7k
 z8pQchW/m039+gBYkIR88H6FsGNVbfaColBRr1h0TJKB+3aogwpEQt5NejyGFisFS8zEcFTF4
 F+a1s79nHZGLsMMQdqW+DCGLs5URf//ZGaW6JbyscmLJxIXL/vyFaLfnkhbdFSp7/ZmLnl22H
 PGCrFBGh3KmC0BpjLjREzh11bXaAMwvCr0KWqm032R6KbuOue6b2AYLDgxCJkreuQsWyubY+Q
 6j4S9+B1g0RXpWYQEKmqfaY9voXqLB3MksWs5a/FUV+bIexUFvPUPY6x+MwJ0jqsmnSUVXeZ7
 fHGcjWzrHxSm8uiK+mAoLwc0yi6wXwUFYmvsoXo+kRcCTWvJVtI/kgXs5fa4NoP20eRi5fuYE
 AiObWxtrTiuIkzPzzN0alsl6LKtjmpT3g7si6EywMMHrThXiMZHainJbSkDG3IGd2ghPeMz2e
 vYsnIo+q2ruhOwi6HoVOtPd7rQy0WU7tcofOenHmZDh1Dfz0bHWUSyDNGRznpg7kRKr96HlMw
 GXTsqwqFrhqIRoICugnCS24KdxBSDAvXd3CiZaJ6FtfzZMSQxeLxlk8r4ev4Tsf/0bJzSEqXI
 trls21pdqLLEUml3AvH4BwSy3TYVw2vegWwXgpYAixUKJgTQX3t7TTV0YlsGuEypkWTx2oiM6
 SvL6rIYOeSSCwjsguKdT9EYMDPlxSro5NFt3jt+bOsn/I253nEq2qmTqFLMlcs37lZrijewJR
 7zCReXI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1545185318-1472490659=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Mon, 29 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/commit.c |  2 +-
> >  sequencer.c      | 11 ++++++-----
> >  sequencer.h      |  5 +----
> >  3 files changed, 8 insertions(+), 10 deletions(-)
>=20
> Just a sidenote: it would be probably easier to read with *.h before
> *.c (at least this particular one).

I agree, but I did not find any way to reorder this without substantial
manual work...

> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 77e3dc8..0221190 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -173,7 +173,7 @@ static void determine_whence(struct wt_status *s)
> >  =09=09whence =3D FROM_MERGE;
> >  =09else if (file_exists(git_path_cherry_pick_head())) {
> >  =09=09whence =3D FROM_CHERRY_PICK;
> > -=09=09if (file_exists(git_path(SEQ_DIR)))
> > +=09=09if (file_exists(git_path_seq_dir()))
> >  =09=09=09sequencer_in_use =3D 1;
> >  =09}
> >  =09else
>=20
> So it is more "Use memoized sequencer directory path" rather than
> "sequencer: use memoized sequencer directory path" - it replaces
> all occurrences of SEQ_DIR,... that's why it can be removed from
> 'sequencer.h'.
>=20
> Though perhaps I misunderstood "sequencer: " prefix there.  Don't
> mind me then.

The idea is that this path is declared and defined in the sequencer. There
are other call sites, too, so they have to be changed at the same time...

I'd really like to keep the "sequencer:" prefix because it is semantically
correct: this change is about the sequencer, not about the other call
sites.

Ciao,
Johannes
--8323329-1545185318-1472490659=:129229--
