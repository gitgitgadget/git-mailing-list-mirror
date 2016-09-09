Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2DA91F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbcIIOXY (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:23:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:57178 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750744AbcIIOXX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:23:23 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lq9se-1b4eAf1iam-00dkKM; Fri, 09 Sep 2016 16:23:17
 +0200
Date:   Fri, 9 Sep 2016 16:23:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 10/22] sequencer: avoid completely different messages
 for different actions
In-Reply-To: <198780d4-dbef-c0cc-fb4c-fc8986a33002@gmail.com>
Message-ID: <alpine.DEB.2.20.1609091613000.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <1e940c58329ff5f224ec5bc48927a28ff4d1bf66.1472457609.git.johannes.schindelin@gmx.de> <30b04497-dfb8-914b-42c4-8bc66347d347@gmail.com> <alpine.DEB.2.20.1609010950150.129229@virtualbox>
 <198780d4-dbef-c0cc-fb4c-fc8986a33002@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-967006451-1473430997=:129229"
X-Provags-ID: V03:K0:0/MH5REbGJ6cmXuaORJtbdT9NvnkmxSEA2bNQhoFLhzotJgpomS
 Mt9a+QSIO5knqy07Hi9m6NNlgyEFjEbyBYkXEvzb3UxU6cqXamMhK86GlqZsGNbGY6UzAnA
 6vFQ9BQCQ4fsqnt2Ip1+tuyMfJV9IWdClOU/F7JltHgKEwiY16bsyeOUUEmhU+0U/GsgHnM
 FL+Nq/oHG97eoVWzxNexw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yBFAH3KzR/Q=:fAbX5BdaLclqXe7YorELmG
 dcsJ3QGCRsRzL9LTjIYfEd363/Ry69jVzx1+B16QbzccZKvEHyZeV2LsMW2qgoVk6RIBsZfEC
 W/7GS/tuVn0+ZIZaBH9EJnDALSSF8vrqZiIOCOwHGi9hXirn3UColg7kZ+GgQ2qBs5HUvlePT
 sKG3kF2hTiRheaxgDfp4Vy1EuQk3jZNcLmXugLAQKg3q2k4BUiyckclrh4s486DCGDzzdicxY
 AR6AyZ5ud6KXqHK7s3HOPNKd/mL4nw+TPmZl2Vybg7EkBwlVvl/aC32gVtHglApijknGQrqxj
 9Gj6rnX4wWmJmiK+08kufGlhXNa7+WAJE8UqAUWICWvgt/Cf2rx9xRXmVx0gtX4xnVZf6VYhn
 p0ZoeewYV0zZgqxtZ7qdaH9AXe4D4O92aswJokdRYuG5ytkFiUmj7S4Zf5eecRyLerlBcF5V7
 +dFs2qlWiU1/I6rrJtfhUVEpx4rujC16W2IqVQipqirs/YEQe4OiJ4u1H1t1raRMRzScVP0c6
 6hipDBfo/WyQbcHWnKVIqgceEMWCne9ArfAQLDe16rBMvnWITSpgktmQ3jLP0fRnzcNuRjYgh
 oD/40swFttrNsgyU0OzDFwbXlXWNpA+1DcN00ImECkgI/Q1gnR5m+X8G2bb1v2zngedCVk11r
 Bva4zzD093wd2U5bDbEGlI5bpAm5hykAgm9Vlvr1Sy4r/925Ro7kKSHL5VvgHvPm/WEri6uPb
 JxJD2BWftLrWSC6XOgYyRSlnvVZ5fjg80vH6Go8aNhY1YqXdhvWhO6O3+nQTOqGvrezblfAfU
 QB9mtr2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-967006451-1473430997=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Fri, 2 Sep 2016, Jakub Nar=C4=99bski wrote:

> W dniu 01.09.2016 o 09:52, Johannes Schindelin pisze:
> > On Wed, 31 Aug 2016, Jakub Nar=C4=99bski wrote:
> >> CC-ed to Jiang Xin, L10N coordinator.
> >> W dniu 29.08.2016 o 10:05, Johannes Schindelin pisze:
>=20
> [...]
> >>> -=09/* Different translation strings for cherry-pick and revert */
> >>> -=09if (opts->action =3D=3D REPLAY_PICK)
> >>> -=09=09error(_("Your local changes would be overwritten by cherry-pic=
k."));
> >>> -=09else
> >>> -=09=09error(_("Your local changes would be overwritten by revert."))=
;
> >>> +=09error(_("Your local changes would be overwritten by %s."),
> >>> +=09=09action_name(opts));
> >>
> >> If I understand it correctly, it would make "revert" or "cherry-pick"
> >> untranslated part of error message.  You would need to use translation
> >> on the result with "_(action_name(opts))", you would have to mark
> >> todo_command_strings elements for gettext lexicon with N_(...).

Okay, that is easy enough.

Ciao,
Dscho
--8323329-967006451-1473430997=:129229--
