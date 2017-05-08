Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41DC21FDEA
	for <e@80x24.org>; Mon,  8 May 2017 11:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753980AbdEHLfm (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 07:35:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:53687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752759AbdEHLfm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 07:35:42 -0400
Received: from virtualbox ([95.208.59.245]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvQkh-1e8Dhc3x8V-010fOa; Mon, 08
 May 2017 13:35:36 +0200
Date:   Mon, 8 May 2017 13:35:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Daniel Ferreira <bnmvco@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] add--interactive: add builtin helper for interactive
 add
In-Reply-To: <CACBZZX6_GbqNpTXTB8UQJzvD2nx_UTN8fwHV8Aczg+b9XoO_tg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705081334440.146734@virtualbox>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com> <1494009820-2090-3-git-send-email-bnmvco@gmail.com> <alpine.DEB.2.21.1.1705052328380.146734@virtualbox> <CACBZZX6_GbqNpTXTB8UQJzvD2nx_UTN8fwHV8Aczg+b9XoO_tg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-537285441-1494243335=:146734"
X-Provags-ID: V03:K0:Y44O+rlUVXiLd5uyitey7/m9+jokIYWT0dNTsJF/4KU2KVreXRN
 /Pcz+mDa8vyJUX8lUITLkkltVcnuxESCpHej59ecdtFxJ4d0Np7EUHYbdukA/uOZx+7+F3c
 3AVdgNu0qt1rrw7GvvYDwWPecfS7f73oRX54xhr4uVgShjwrDcoHJNbUSiSRB2Yhai89VU4
 r4zHghlBusaQHuJbZdSlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PV/0wWvkjmA=:UglFITc7y52PCBhGq/jJzm
 L0RXlkfI/IIIXtbzjtXxwDH0skZmMtp/bylsZaLQvfbJhn5E+qcgvdtVNmuXsKWSA2l6xjFyE
 +oXvK+E51RsvRHBhO0E/nDA22XDHlrLWco0KrQ+S1deViiGVdMbNbZjaNKxaJCUscVk/pzaPg
 eHditaEBRT3ITFXXk0ioNRHvdgQKeNDvJbdxi8fWTVlV1kU10jpe+yvUbLE/8SjdT3/Og5kpm
 baiwYfiucG4D5PZ9cn0CVizjrIKdIPR82hE7FxMDCVXNUINKrIHwPeAuJuJ1pAz9gS1omCVhj
 I8AoUG5lqMxjUj7IglnqFFUvjnsdKvETe+8jJujsE+v0O87SZO7T0f3N+l6ui67nD1zgGCsF9
 jbdY/fD2ZNpOT3mNei4233LMlEZN4KZ1INCsRBotcglTCuKr2R4YZ2PjoQ/7FbnMPv8VdlBeT
 PNO8KKH0+hwTiS8uIfhy4t7/Ni7b4i538KGR5pChbnb4hJsSD/KsVTUlY8Oi7udeyxEbkv/UP
 FelfF3VvKVLlF3J/6w+IH7svo2XLclemPhJD6dYsJaUQS2gWb+T+63w+Mwb54OIrHXLvQFytF
 1AS7v7CvElYuOEcNEqivJMRGqSSJQPf6PNPODR+y62anbHdRuEdm4RPWnj2S4LEz65LDw8Xj4
 dVZIViNc8UpCBWLQl2uFC9dydGt0Epy7UaP/c29mIRSOyPXa7tm8tzC00iIPYWCsKPa7WUR8D
 z3/XfFhRxm0qs+WQpMggDHIjB0P+lZjEoF1kJQXdPE1qruiVf+Z6IIHNdaHjiRUGglOaJGlgr
 qJ1xAjE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-537285441-1494243335=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Sat, 6 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Sat, May 6, 2017 at 12:30 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Daniel,
> >
> >
> > On Fri, 5 May 2017, Daniel Ferreira wrote:
> >> +static void print_modified(void)
> >> +{
> >> +     int i;
> >> +     struct add_interactive_status s;
> >> +     const char *modified_fmt =3D _("%12s %12s %s");
> >
> > We cannot really translate that...
>=20
> He copied this from the *.perl code:
>=20
>     # TRANSLATORS: you can adjust this to align "git add -i" status menu
>     my $status_fmt =3D __('%12s %12s %s');
>=20
> And one translation at least makes use of that (and probably others shoul=
d).
>=20
> But porting the /* TRANSLATORS: ... */ comment over is missing, and
> should be added.

Ah, that explains it. It still is not really translateable, but with the
comment, even *I* understand why it is marked for translation.

Thanks,
Dscho
--8323329-537285441-1494243335=:146734--
