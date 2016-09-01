Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04CE51F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 13:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754858AbcIANee (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 09:34:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:65223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932509AbcIANec (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 09:34:32 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lm7MT-1b6fXU3Ubh-00Zhft; Thu, 01 Sep 2016 15:33:53
 +0200
Date:   Thu, 1 Sep 2016 15:33:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 16/22] sequencer: prepare for rebase -i's GPG settings
In-Reply-To: <xmqqmvjszoia.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609011533190.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <c6a37af958f59390c00429a5b38b34d34c9a5b95.1472457609.git.johannes.schindelin@gmx.de> <104de15c-77e8-9474-9579-4934ca8a4323@gmail.com> <xmqqmvjszoia.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-140856504-1472736833=:129229"
X-Provags-ID: V03:K0:ZnvF7TCzhf5fPfkjWv+4/HPFPYgg+yTjH5FOi5pnKSWpk+hujZ5
 k17hxX+HpKsEINxsjl8ifb85t0Ml6OWlGtjCDZzb5tpsMrrMWQ3jQbgM/MaNNIMd9b51zvg
 4Tc7dBjpgFPcjDxngEoEj/4G/5hDCFT+eks177HfGSkv2jgIanjIPlGo9oFp1KaLt5hQ7AW
 ywOVUGlLllCGAvRDS3+cg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:voD/nT1k+J0=:7Tc0XTfP+YhNJjCbYbx35v
 +hkbyKBrztu2jlaOOqD+EaTJPVP+4b8Y1JxDJ+H2TokT3fPC+49ogHF22wqy2tmBNicHSXJeb
 DiVIimJzBbZKWixsu6rGjs/DuOxtQuuIIW1445MR+Jkpp3aXQrczjl0Jwfw0eOsybCDZIA/Gy
 58ULR1xBhwd7RZQxs2yZYDGPvdHmIUw3TmaNz8ORQN97aQuhOSIweYAd8L6w2skI4unSSS41J
 TwTYXQLXYGodwjGVd8dCon8OabYJwpuMuvVR1tjOdiXm25iQli63afgR2K96FRcDTbTbl9ppw
 7HMQvrLZMGMYhQJfH087BoCu+EBDun8ryW0nAxApjkav+OJsfvpjjpFfKwPIPeewX/5MlFDX0
 FzJqds4F25tZ4+GxIk9vwyZ9OopSKQZ7Yk4eRXZwCX9z+fhkdPmYDt0M+YCGmh5IaIoBP6mPn
 MoP/sAOgZV4880leb6X+0IEeTNuOS9CWEDGSmKuVvx66jmfmIc+vBXQVwVQpVk+XEADqRqEWo
 Dm9u5yo08ttPcuuBs5vRt+02R1wwhANqM02Kcji5e2W5AVKswJyYWx0L3tMktiDO4Lmk8R/RB
 2SaARoWbQJDy1+cySCXoW9bictMUQm4nT5gQaCxQO9Ff7RXHJUdk5ZWC4tdidVSsfkZpV75OX
 eicextBnjo1uCycGE7EmejHrsqblOH3Ctm3BV6WtiWOdIZZfTkv9cJ0mYpkx/yg9WDZzRhwbM
 3wuQx9ruT2ZqgkDCetocCJBNjJeLbrHbey7jdwoRYtSRmRzmx1mxrFlDwsSGkOryea3rx+7FZ
 oRnuc/p
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-140856504-1472736833=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Wed, 31 Aug 2016, Junio C Hamano wrote:

> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>=20
> >> +=09=09=09else {
> >> +=09=09=09=09opts->gpg_sign =3D buf.buf + 2;
> >> +=09=09=09=09strbuf_detach(&buf, NULL);
> >
> > Wouldn't we leak 2 characters that got skipped?  Maybe xstrdup would
> > be better (if it is leaked, and not reattached)?
>=20
> An attempt to avoid leaking by calling free(opts->gpg_sign) would
> make it crash, which would be even worse ;-).

As I pointed out in a couple of replies yesterday: we cannot assume that
gpg_sign is free()able. That's the entire reason behind the
sequencer_entrust() dance.

Ciao,
Dscho
--8323329-140856504-1472736833=:129229--
