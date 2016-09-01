Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2754B1F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 13:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932460AbcIANNB (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 09:13:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:62958 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752629AbcIANM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 09:12:58 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LtJ5T-1awEx80De7-012nEz; Thu, 01 Sep 2016 15:12:17
 +0200
Date:   Thu, 1 Sep 2016 15:12:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 13/22] sequencer: remember the onelines when parsing the
 todo file
In-Reply-To: <a9831d93-f5b4-d729-eae0-1f7c1123a6a6@gmail.com>
Message-ID: <alpine.DEB.2.20.1609011507130.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de> <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com> <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
 <a9831d93-f5b4-d729-eae0-1f7c1123a6a6@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-650386486-1472735240=:129229"
Content-ID: <alpine.DEB.2.20.1609011507410.129229@virtualbox>
X-Provags-ID: V03:K0:zTkRxi/PtpW1dyQnRJaoQrg75tKtU9eOHBDMaK3BqUYkE+QfECJ
 5smcFGtt9LvC8vblH1Bt5r/esc32TvQTd/oN9D0KA9YzBvbuxIwNHYZBAbZR1itSCvD3JMP
 dgpOBVPX4Y/c+4jp45sAjscCn/qr2b/tJHEm78dYx7KEWzk4nBceo/g7+kjcYll1C7U4fCQ
 oeo/gdGVUwYS0JvNGAEvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0iBIsw8LWrw=:RgAKh0XBQ/Ua8MCEXj1tw3
 NcpjGYF/iE5UboamBvP8V385+WldMRFAZBogEm/C8lxv8CkYYccABYd5Xc7R+WL+zDocKWAy3
 uQAAjYcCVJ/EVY7xEtWEsG3IQN+w6IEJ7wQmWi3pCyxHORIhwvly3N4YTdjXb6QFkEykktS9f
 ZDMFhvULrn0JbbzE1350AWpVbo3/z/7ijtw3iJJNrrBBQpyKfJ/XventVkEMlrRDAaOE5DvEw
 N2aGWvNejArPc/6gDYq8buHowNAzF5S9jI+DEo+h+AtIDmJ0ZfFu6ltX0NDd+1GXzB5bOJomx
 GoHTcAoUsY1tqYYUv0sLgY1PrEIBmRnB9+lLMFB0haAvpq/D8Ah573YvnjYiBnIqe7am9PELx
 3tVVd5Cv79BzAGWUs12cjaLLf4d+zVG0o7Wi5Om7vcG1gyaGJ3/gL/1Qwer56b83MXMCPTjPo
 UzGFP3acjzX9m80bmWdgTE27jIN3Yp8ifI5oYYogyiIS8Xx33TH1NZuvybuJNwvZcNYlKT28m
 DuhjVmY+KGBt8OR+mTad9ExoUEoneyjR+C6dW6egkx6xSLtPLXEEtTETKUt+J9Xd566TDmuOu
 14l3fh35kNweBD4RAAwQDgPQoGA4OOsrp8Waol+4eXnsex9ukiow0V8i+ix2FX06Zb3aWIhM3
 sFQkGMy8eN6t5iFHcL8duHIBkkHrxE4xj1f+LdHHmbBvCmJ5+bEGeCHNDYMN1qWmBxN419kFS
 /vbNGRMp7DsSo+Gm0ocF8rd5KltkvNgTYvKXSQII0xP6rXUghUXY2fzsar1WU8RferL/RnLOg
 NWLNAfk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-650386486-1472735240=:129229
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.20.1609011507411.129229@virtualbox>

Hi Kuba & Junio,

On Wed, 31 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 31.08.2016 o 21:10, Junio C Hamano pisze:
> > Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
> >=20
> >>> diff --git a/sequencer.c b/sequencer.c
> >>> index 06759d4..3398774 100644
> >>> --- a/sequencer.c
> >>> +++ b/sequencer.c
> >>> @@ -709,6 +709,8 @@ static int read_and_refresh_cache(struct replay_o=
pts *opts)
> >>>  struct todo_item {
> >>>  =09enum todo_command command;
> >>>  =09struct commit *commit;
> >>> +=09const char *arg;
> >>> +=09int arg_len;
> =20
> > I am not sure what the "commit" field of type "struct commit *" is
> > for.  It is not needed until it is the commit's turn to be picked or
> > reverted; if we end up stopping in the middle, parsing the commit
> > object for later steps will end up being wasted effort.
>=20
> From what I understand this was what sequencer did before this
> series, so it is not a regression (I think; the commit parsing
> was in different function, but I think at the same place in
> the callchain).

Exactly.

> > Also, when the sequencer becomes one sequencer to rule them all, the
> > command set may contain something that does not even mention any
> > commit at all (think: exec).
>=20
> The "exec" line is a bit of exception, all other rebase -i commands
> take commit as parameter.  It could always use NULL.

There is also "noop".

> > So I am not sure if we want a parsed commit there (I would not
> > object if we kept the texual object name read from the file,
> > though).  The "one sequencer to rule them all" may even have to say
> > "now give name ':1' to the result of the previous operation" in one
> > step and in another later step have an instruction "merge ':1'".
> > When that happens, you cannot even pre-populate the commit object
> > when the sequencer reads the file, as the commit has not yet been
> > created at that point.
>=20
> True, --preserve-merges rebase is well, different.

It is mis-designed. And I can be that harsh because it was my design.

In the meantime I came up with a much better design, and implemented it as
a shell script on top of rebase -i. Since shell scripts run like slow
molasses, even more so on Windows, I have a loose plan to implement its
functionality as a new --recreate-merges option, and to deprecate
--preserve-merges when that new option works.

It needs to be a new option (not a --preserve-merges=3Dv2) because it is a
totally different beast. For starters, it does not need its own code path
that overrides pick_one, as --preserve-merges does.

But I get way ahead of myself. First we need to get these last few bits
and pieces in place to accelerate (non --preserve-merges) rebase -i.

Ciao,
Dscho
--8323329-650386486-1472735240=:129229--
