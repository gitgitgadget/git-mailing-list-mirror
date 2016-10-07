Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E94A20986
	for <e@80x24.org>; Fri,  7 Oct 2016 14:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754997AbcJGOUN (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 10:20:13 -0400
Received: from mout.gmx.net ([212.227.15.18]:61723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753618AbcJGOUK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 10:20:10 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MGAdz-1bdMtb0oYp-00FCT4; Fri, 07 Oct 2016 16:19:28
 +0200
Date:   Fri, 7 Oct 2016 16:19:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
In-Reply-To: <e1b432bc-97b4-15be-aa44-71921c64cd15@gmail.com>
Message-ID: <alpine.DEB.2.20.1610071616390.35196@virtualbox>
References: <20161006114124.4966-1-pclouds@gmail.com> <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610071319520.35196@virtualbox> <e1b432bc-97b4-15be-aa44-71921c64cd15@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-799723535-1475849968=:35196"
X-Provags-ID: V03:K0:vggH7JlnGDu5f3FkK/aKWqR0N86wadBPF29rTvvHVVJy8TUmuAV
 4yr56oCBBoAo5saoCYTAWki/JRwbehPFZvsSPrOOJpMCLaUUAlkeNR4Ah9b3sXODVANwL6o
 JSOcwgEEBPEaDZtPctr8dgcTcA9My8Z50J25Y/Df3O24x3ioIzMAycMZDozlFrU31ilQ0gK
 KtWPattJdWcz4Ctrtgr7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kjyBC5cPYgs=:XozGmJB6gNcZ+rfG5v0ozw
 iJZ80YAXspMeAL8SIQGt+Hgv+4X2FVF1ms216lzc3tVwE9LKPnWdTME3pmo3hYb9PBbq6p8Yo
 HpLnVPoBDc6KdsysVWJBsn7sFrqFmKu+yw8TFtSeiZNUDkBHnKlFj79d45WXfzgJ2VOdcbXeM
 U38BgU9pYnFWsUC51oK9HV3iEGNAQHKw6XYCNQ4FslGO8NpJQIcnFcsw+teQ+364U1ZPWqIga
 1gaxKHX4TgaNpbDsUnIrhaz4Aig5ZFJ3kRChFtVs+kzrUmMKc1oStBfV6e1ww7rrnfCWqzFas
 fcCS3jmOnWAZReBkxzDS/4HoLoXMLO/fQ39ZyorI2J5MFS2OCfuwNVoRYtV2XBapJerfBZZsf
 URXLyPQTFrFUW9Yo5VZ2spnR711IRIjHMAK6eEOYvCSkmE6L52CFkLSezWIIHsz3ThledoVg7
 bgFG3a7MgoKqEwyqhYUxpVHxQPb7DOI9E+4O5lqxpN3ZInDkjEDkrsOg4gIB8AMlGPpxdvFr/
 kshJTqQmolTxDqPxA/M/Y+ZWAFQchfIHDKcLcQDvcgq96G/lqr8UPKtYESMVzEFpE2A+yALS5
 DUDgk11ufcne8L1hH7RvJPZYW4xXsbAtaLElmD5MJKh12XTe3F5Et1yWuOUr7WG5FtTZTk2ya
 NlU9rlXAFc9LdoaNg2wn3Dd3yLtQJzqwFcwaHeV/oElrUaxutYNKmAOYy1WgDLhymyju5LACY
 wHr/uVkKNdFPPl2aUKp6M/7kHYKjlODTG1Q8WwilzC34b23YjCkgAkdAnqbyqVy2F9SR1gozw
 hDjM9CF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-799723535-1475849968=:35196
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Fri, 7 Oct 2016, Jakub Nar=C4=99bski wrote:

> W dniu 07.10.2016 o 13:20, Johannes Schindelin pisze:
> > On Thu, 6 Oct 2016, Junio C Hamano wrote:
> >> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
> >>
> >>> Throwing something at the mailing list to see if anybody is
> >>> interested.
> >>>
> >>> Current '!' aliases move cwd to $GIT_WORK_TREE first, which could mak=
e
> >>> handling path arguments hard because they are relative to the origina=
l
> >>> cwd. We set GIT_PREFIX to work around it, but I still think it's more
> >>> natural to keep cwd where it is.
> >>>
> >>> We have a way to do that now after 441981b (git: simplify environment
> >>> save/restore logic - 2016-01-26). It's just a matter of choosing the
> >>> right syntax. I'm going with '!!'. I'm not very happy with it. But I
> >>> do like this type of alias.
> >>
> >> I do not know why you are not happy with the syntax, but I
> >> personally think it brilliant, both the idea and the preliminary
> >> clean-up that made this possible with a simple patch like this.
> >=20
> > I guess he is not happy with it because "!!" is quite unintuitive a
> > construct. I know that *I* would have been puzzled by it, asking "What =
the
> > heck does this do?".
>=20
> Well, "!" as a prefix is not intuitive either.

You do not use vi, do you? :-P

In vi, if you enter command mode (typing a colon) and then want to
execute, say, `pwd`, you type !pwd<Enter>

> Perhaps "!.", because "." is current directory, and the "." command
> (that is, alias to "source") doesn't make sense in git aliases.

If you want to execute, say, `pwd` in the current directory, that would
mean you want to write

=09!.pwd

But that already means "execute `.pwd`"...

> Note that we would have to teach git completion about new syntax;
> or new configuration variable if we go that route.

Why would we? Git's completion does not expand aliases, it only completes
the aliases' names, not their values.

Ciao,
Dscho
--8323329-799723535-1475849968=:35196--
