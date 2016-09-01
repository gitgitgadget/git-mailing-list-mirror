Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463EF1FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 10:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932474AbcIAK1k (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 06:27:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:51126 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932298AbcIAK1j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 06:27:39 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M6SJX-1arrfE2xX1-00yPpr; Thu, 01 Sep 2016 12:27:31
 +0200
Date:   Thu, 1 Sep 2016 11:37:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 13/22] sequencer: remember the onelines when parsing the
 todo file
In-Reply-To: <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609011052260.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de> <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com> <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-496063899-1472722664=:129229"
X-Provags-ID: V03:K0:q1DQZobLODdLLWeZ2E4HmaJZFp9HJXNh5rA6IvGVU73iIr/rLQy
 Ba6/dOSEyuzso/E/YjUfUfBy8zmisXM5suluXkfhVaJiFxva/PnTKBH1bYZc4WOjIhJ9V2Z
 NzP648d5tDLGgeIEBCP7XlkOUpa6nK6gfOrsV2M7MuH35gGunb+x0FY6o+6Josdm7dj3RPu
 z9U8AJCLFZMds/49Q54gQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XEb2Lw5mimc=:/oHfRd+bW0ihrwTeNx+GxS
 rWw4TMeQs0GRZzMSnV2ZfrsIonZgvF9PHKTVTWcSQf6yrlWJaOf0TUJrzbQ2/Z6nIXIJb/Ad1
 jln2Mzmd6mcBQK5CijGChZ378FfDP/OfLWowPVdhJ6BQ2dq0GSo2yQrvF4sbt/BqAth56cpUg
 m8ptvAdlxBHh1WM5vF6X3enxVBlzCnnnAVjfVZeetgJH+WLH6sefy4ZKJmIWENBtSH+6viT7+
 5xSCX5NEXqOMDEfvl/ftArO3I6tUXYUXitxWxZHmndNnFn7odwjmURk9JLPdIDAiguzL9PQ/5
 RjSWbeY2/KpRWJ9NrWG7RyM+mS59JtBekzRPbUQhF7L88EZCptvobMWrW35k+H1BvHjLfbLhl
 FUGfezygWR3HejcKqmJBhwT98tF3GeDjHRBH88XixuFDSiT2MK2uXXJT6K7gi+84KfNf6wIsE
 2UfAn9D/A7WPN82Vi+l9TxRvPtSBb7ADwixcaiGXf74potL2GshDcEAJZtAYjr/nrBCgNpx5+
 R0wRJ5I5wzEakwLEGwmRlGbMLrp+lcaHbasboyylfj9MFqOcczazm+oBWIjDQeDY+ZLbJszMI
 BcWnYinWQgu6FkfNKoj1GSf7B3GbFJpKJ3UyqL6Nu9QVS6FN6jQ9h1f5//kpRu9Xa8pHXneUQ
 FaoZihmWNIMO7e2EucaBn6UPlLJG9l2CFDVWrMcTt0t31Su5fVSLNRHD57xrPfMFSbq2HxLlM
 rHXRuN/g5NIzxerCleWju/1NDIbnBOkNXIgubTuslLlLfklOZB3ItwbMP4ZID33MNGcP3SPtn
 deUHTAI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-496063899-1472722664=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Wed, 31 Aug 2016, Junio C Hamano wrote:

> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>=20
> >> diff --git a/sequencer.c b/sequencer.c
> >> index 06759d4..3398774 100644
> >> --- a/sequencer.c
> >> +++ b/sequencer.c
> >> @@ -709,6 +709,8 @@ static int read_and_refresh_cache(struct replay_op=
ts *opts)
> >>  struct todo_item {
> >>  =09enum todo_command command;
> >>  =09struct commit *commit;
> >> +=09const char *arg;
> >> +=09int arg_len;
> >
> > Why 'arg', and not 'oneline', or 'subject'?
> > I'm not saying it is bad name.
>=20
> I am not sure what the "commit" field of type "struct commit *" is
> for.  It is not needed until it is the commit's turn to be picked or
> reverted; if we end up stopping in the middle, parsing the commit
> object for later steps will end up being wasted effort.

No, it won't be wasted effort, as we *validate* the todo script this way.
And since we may very well need the info later (most rebases do not fail
in the middle), we store it, too.

> Also, when the sequencer becomes one sequencer to rule them all, the
> command set may contain something that does not even mention any
> commit at all (think: exec).

Right, in which case the "commit" field will have the value... *drum
roll*... NULL!

> So I am not sure if we want a parsed commit there (I would not
> object if we kept the texual object name read from the file,
> though).  The "one sequencer to rule them all" may even have to say
> "now give name ':1' to the result of the previous operation" in one
> step and in another later step have an instruction "merge ':1'".
> When that happens, you cannot even pre-populate the commit object
> when the sequencer reads the file, as the commit has not yet been
> created at that point.

These considerations are pretty hypothetical. I would even place a bet
that we will *never* have ":1" as names, not if I have anything to say...
;-)

What is not so hypothetical is that after parsing the todo_list, we will
have to act on the information contained therein. For example we will have
to cherry-pick some of the indicated commits (requiring a struct commit *
for use in do_pick_commit()). Another example: we may need to determine
the oneline for use in fixup!/squash! reordering.

So: keeping *that* aspect of the previous todo_list parsing, i.e. store a
pointer to the already-parsed commit, is the right thing to do.

Ciao,
Dscho
--8323329-496063899-1472722664=:129229--
