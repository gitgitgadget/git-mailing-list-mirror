Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09201F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 14:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbcIAOON (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 10:14:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:56208 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753066AbcIAOOM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 10:14:12 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MO77c-1bkwOw3fts-005d7R; Thu, 01 Sep 2016 16:13:58
 +0200
Date:   Thu, 1 Sep 2016 16:13:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 21/22] sequencer: left-trim the lines read from the
 script
In-Reply-To: <7996a963-52b5-5f3c-f686-f5cf22573573@gmail.com>
Message-ID: <alpine.DEB.2.20.1609011608440.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <8c30113a920e075e5ecd68ba31b4007de3e2dbc2.1472457609.git.johannes.schindelin@gmx.de> <7996a963-52b5-5f3c-f686-f5cf22573573@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1858442267-1472739238=:129229"
X-Provags-ID: V03:K0:TOZXm4CdUI+tvlcACTmbGuq6I7Oq2hekPnDhhh4Tfc4hFdcWzgr
 8lpGU9UFHhqFaXuzfmqx1DYZO/ilwinHisn9n6ZK9rHJ2r1PZH/4MaqPDer5h1uk2uD0ooq
 pOhQm3PmNUldelyHkRtCeawrnbm/eU1j/Wn6dFYMmyqrNjyMNO9eLcUkMLzInVyjp4uJl54
 Dzu9NJiEtyoccdNZJnQgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J99LZsHH+e4=:J2oI+yxaTC4LL0aM7jQrMs
 DrXcveUX8rl3apRbeTV7hDW1js4o0RsY9VyTB+EIne/JpX6soBUwOTfBz/WSs/wEbNdi4wimu
 8QxuqVkpOOTlMZgEOTu9mhyTz5/CzyGVHV9n5iSopVsf7ONP/Y8JuzL+gpOfeTykmwLtL+odp
 s1gh8mtpFOVmc87xVuyXyQizuWj7Yf3LUAUCWBar+DceY91j1UlGH9pR932NhLdfrpBPUWC4L
 6uv2InCcp7UzAL1TDAlNVKw1fmlKnzKaPUZlWC1vkdsexEpX0rQEafdmV+dKfgP8xxD1/ufLE
 s86zc7RKDyJkdatuDvMmwki70KbWqY8NTRe/eYeIAs/0XM7MBuU5ha1Nxc36pFcsoHmYBPlaU
 H8eciNzP8TWJRaZgJI5OL3uSv6vEDAfi/TWBklq+rTJP1bOwMYJ6TSTyIQpv8DJDarejlk8fR
 1mVGhiPWL5XNG+jZJCb25hnD+2nxLYHZqbLiNaKuMrzft8JKV2xrnaf1bQE2STWS7s68SEcMP
 Q2hGNIcZsLf1mVpl668xvSFlFv+aN0PPuo2OpM4OxJN2H0obzN+3dB9l56048rRWMIu5YYCB6
 dCPdzFELj/+KOdjzgN7YcfRHEAKgNrtjM134WS5ZD6F4E5ekfp86dWHXYEIZObYi1Xuvhenu1
 0QYImHa+/4yRnxyEVAKJr4VvKIMQjLZhT6NL4vpNEFyHz9DckuCvaQH5Ed2Bk5+QMtfvUx5uK
 3rRNquH9PjA+7RmNkT9UBQCzwBubRL6CP3dsMxEtrOMlpFpDmD4Zkq5O5SUTMIKehopXiCZ5e
 m/Xk/rl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1858442267-1472739238=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Thu, 1 Sep 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:
>=20
> Subject: [PATCH 21/22] sequencer: left-trim the lines read from the scrip=
t
>=20
> In the subject, it should probably be without "the", as "lines"
> are plural.
>=20
> s/left-trim the lines/left-trim lines/

I am happy that we stepped outside of the "code correctness" land into
"grammar fix" land, as it surely means that you are convinced the code is
correct? ;-)

Fixed.

> > Interactive rebase's scripts may be indented; We need to handle this
> > case, too, now that we prepare the sequencer to process interactive
> > rebases.
>=20
> s/; We need/; we need/

Hrmpf. From http://grammar.ccc.commnet.edu/grammar/marks/colon.htm:

=09There is some disagreement among writing reference manuals about
=09when you should capitalize an independent clause following a
=09colon. Most of the manuals advise that when you have more than one
=09sentence in your explanation or when your sentence(s) is a formal
=09quotation, a capital is a good idea. The NYPL Writer's Guide urges
=09consistency within a document; the Chicago Manual of Style says
=09you may begin an independent clause with a lowercase letter unless it's
=09one of those two things (a quotation or more than one sentence).
=09The APA Publication Manual is the most extreme: it advises us to
=09always capitalize an independent clause following a colon. The advice
=09given above is consistent with the Gregg Reference Manual.

Based on that, I think that a capital is the correct case here.

> 'bol' is beginning-of-line, isn't it (a complement to eol)?

Yep. How did you guess? :-)

Ciao,
Dscho
--8323329-1858442267-1472739238=:129229--
