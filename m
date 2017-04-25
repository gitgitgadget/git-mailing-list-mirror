Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 483E0207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 20:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1953998AbdDYULC (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 16:11:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:60439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1949648AbdDYULA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 16:11:00 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MK0bZ-1d1jDc2ox3-001VEt; Tue, 25
 Apr 2017 22:10:54 +0200
Date:   Tue, 25 Apr 2017 22:10:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 8/9] Use uintmax_t for timestamps
In-Reply-To: <xmqqr30hw31s.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704252208520.3480@virtualbox>
References: <cover.1492721487.git.johannes.schindelin@gmx.de> <cover.1492771484.git.johannes.schindelin@gmx.de> <b59a414793492786937e910f6cd588b8e1751b4b.1492771484.git.johannes.schindelin@gmx.de> <xmqqinlu1o8u.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1704241226440.3480@virtualbox> <xmqqr30hw31s.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-632393274-1493151053=:3480"
X-Provags-ID: V03:K0:Ovnr0QmK3JnVpcyr3p8GK+iaL/5QgtymfHPmbluD3+AYVQyOFqZ
 ql+MPLI5xtKhSpA7hgN1alVeKFWpw02vWyqF8d7LbgNNUIkgUgMiBP2lw4hlUePQvy2COhx
 jDwB9Z5saOdgij0qq9+Uf1YNwLsLovloiEvBaRkZypJuIa4Hdb5/fUvstluqtZAIQ1yrvS4
 ONReTLwJ8l4azD58B5G+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TPfmbUuy9d4=:Xs1RIHhvPA0PJerMFCqXOv
 ecsqcD8ztBrYqgng6R/RsCC/O8EfB5GP4sIw2ib+ZHmntpbFgvg8DkbYCGG1jt5Pr7W9Bo40s
 OCU6x8nmkr22U+F68QEvWi3sAgevQH1S87rGecqKR+4VMETRGHtB5SBTOVebsnj0DGzmeHI0L
 HteEGNSFmdn/gox72jl8vrMgpVmUbmoQ/Y8Jh85u6b0r9poh6M37eFph+F/76axFR98lBh+iH
 lWm/NtiKD4iXi9fUQmy47Pze6oKfzBAQXiDkprPGILeu8Xz8k0lZM24EkrWxEmhXpwzwVFFtv
 fd9V6MSkllSL974g6J52OJRBk40x681b+zE9kPyZLYkIbDiqH8pDg1VsC1OgfxSYNpSecQs1O
 f8YNyUDf5VQ/Ncnwu9LTocI6n29UIC9GEAbBYkAxdZXfnSPO84sWirTnL2XCNmsNYPIRxoumh
 T7HbxAOzqP6CuLeqmpKzlYkhXy980yYpwtWQbgRr4Z6+HB2CtwhXbi7MV/6VEEQwhHackGdPP
 R4KTIakfknMd+fMvbbKDwafTJ/rotXmmkYmNsUjaoAIk/b76QfiiS65tLSFNBJJxHruznIH7k
 wok5BoWTlbSdtDL6zUt2k8mXp1N6a79Va/gz1KlSLvNSKFVn0Rw99qdTtLEZwMePqJ5QgvztA
 H99ZWY5vEbAwcrWA3SIl6XKbi0R/kG7wnYfdz6Pf2fVw56h6c4kjIAZ6RmRUYq/VpQrvhaZRT
 YYc+SI55zWJxUFqLzMD80gjytqA9MOGyAsptj91FNoHo7P1seoZXu5vCq0EZ1YlJ86QgxiIwS
 gYmZgon
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-632393274-1493151053=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Mon, 24 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> >> Should we at least clamp in date_overflows() so that large values
> >> representable with timestamp_t that will become unrepresentable when
> >> we start allowing negative timestamps would be rejected?  That way we
> >> won't have to hear complaints from the people who used timestamps far
> >> in the future that we regressed the implementation for them by
> >> halving the possible timestamp range.
> >
> > Please note that the date_overflows() command only tests when we are
> > about to call system functions. I do not think that it does what you
> > think it does (namely, validate timestamps when they enter Git).
>=20
> OK, then please read my question without date_overflows(), that is,
> "should we at least clamp the values with some new mechanism to leave
> the door open for supporting times before the epoch, even if (and
> especially if) we leave the use of signed integral type for timestamps
> out of the scope of this series?"

You are asking the wrong person because I do not care about timestamps
dating before the dawn of Unix.

In any case, it is a question unrelated to the work I performed in this
patch series: the raison d'=C3=AAtre of these patches is to allow timestamp=
s to
refer to dates that are currently insanely far in the future.

Ciao,
Dscho
--8323329-632393274-1493151053=:3480--
