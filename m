Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA8B1F42D
	for <e@80x24.org>; Tue, 15 May 2018 10:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeEOKBS (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 06:01:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:57835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752162AbeEOKBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 06:01:16 -0400
Received: from MININT-HARFK7P.southpacific.corp.microsoft.com
 ([37.201.195.106]) by mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0LvDpe-1eIH8u2y02-010LzH; Tue, 15 May 2018 12:01:02 +0200
Date:   Tue, 15 May 2018 12:01:00 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jakub Narebski <jnareb@gmail.com>
cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [RFC] Other chunks for commit-graph, part 1 - Bloom filters,
 topo order, etc.
In-Reply-To: <864lja2buq.fsf@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805151155160.77@tvgsbejvaqbjf.bet>
References: <86zi1fus3t.fsf@gmail.com>        <07250f7b-e880-26f5-d412-4fbe69affd41@gmail.com>        <86r2mh2cur.fsf@gmail.com>        <fca023a3-f849-4be8-db42-7027bfe7b0dc@gmail.com> <864lja2buq.fsf@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1439661099-1526378462=:77"
X-Provags-ID: V03:K1:qZktcCJNCvyPYgh8RvtYvMEr50d6+Yw+gnhB2NKvRUYJgkGXD5n
 MqV/akytyq6vB3to1e7WDmNJk6j4owZ3DJzBcWiXevz6bnRSGb8AGW21lgqrHS6WVjyjOoQ
 Ymiaqh3wADuisbiZ2XK5v+qsIi/1atGGY24+SyQJtLUyKxLt+aJLHdYbOwhxin+rFX/KUrE
 DfuOtK0T+6r9rMkleDS4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VBqT1m8N4/Q=:B07XjHV+7GKr41AoaCKUbb
 CKO/ydnZudgXd91dYZu4OWfgLRq/NgQyTXfk3WVWWxLB5nRXKTxNWASq5dTiZUBUj2aFAPNlB
 e4ylfssYOXUfdbXM1WFscis8kIvB+w4RcRf1u6ugsm4GUBxnljWvQQmxWdVU/9NzaJV4nHsi/
 4FAF38manxgmBDtNBD2XVXd51f7mc0sXOqMMG7VbAiNsOeqkzVbhXq5lkREytZPW+lZbMsjZj
 kbrRdx2pnBFUv+WQFCp3s2b+0nbT2MQq32/TJ+rVGKolia4qcEhg3gQ7X3O32jsVVhRL2nFey
 Ma83T6kKlZHW0XF+pxG8i/n7Aw7CjvIgHywHP8ABsXU7SyjMuSsxOCypd3EcmiFdHOdmHNgZY
 2MllOfdi8kjZjFllfENgH5OVjSeRnP/pMucCGFEX7qbs+MeLhALiykXtTBJurobQJNv01RgGH
 ivz4QTgGLImXKcYIapBX6Vm2ZhRBebGdGtS0zQEf6RAvx/sA4spwyJsWO2MyfBmAlFKlwdBdC
 1zbWqfDmw32h1xqzKeU1s5745+Kv0NfZLtfugCEa6AWTRGIpPis/5cYWeHoZ9Y6fpxnS1sOkH
 EaYV7PaXtv/V83AIwsRz07LdJdhye85Ytlj/osXlLT/ZW60dyR1tanv2Y2wEIHiNMNYEMNXu7
 xeL8pJgDsV5nkBxDDXF8ImRlukLj/fGPwovxtd2rgI9hPzvNJ7QrhMtRgl46oUX60l18lKrEb
 IGxS09Z9aOzz8Enw5vLfYqS4kGOT3L8YIREXoNrfFd+WDwkJok/iGELKSpRmEQ1p7X9Y2zGto
 sFri2LX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1439661099-1526378462=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Mon, 14 May 2018, Jakub Narebski wrote:

> [... lots and lots of discussions...]
>
> All right.
>=20
> Here is my [allegedly] improved version, which assumes that we always
> want to start from commit with maximum generation number (there may be
> more than one such commit).
>=20
> Let's add one more data structure:
>=20
>   RRQ : A queue, for storing remaining commits from R (starting point).
>   It is a priority queue ordered by generation number.
>=20
>=20
> InitializeTopoOrder(R):
> =C2=A0=C2=A0=C2=A0 Initialize IDQ, IDV, TOQ, RRQ
>=20
> =C2=A0=C2=A0=C2=A0 max_generation =3D 0
> =C2=A0=C2=A0=C2=A0 visit_order =3D 0
>=20
> =C2=A0=C2=A0=C2=A0 for each commit c in R:
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 max_generation =3D max(max_generati=
on, generation(c))
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 unless IsRedundantFilter(R / c, c):=
 # optional
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RRQ.Enqueue(c, g=
eneration(c))
>=20
> =C2=A0=C2=A0=C2=A0 while RRQ.Max =3D=3D max_generation:
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 c =3D RRQ.Dequeue()
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 IDV[c] =3D 0  # commits with max ge=
n have in-degree of 0
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 IDQ.Enqueue(c, generation(c))
>=20
> =C2=A0=C2=A0=C2=A0 # this would be almost no-op
> =C2=A0=C2=A0=C2=A0 AdvanceInDegreeWalk(IDQ, IDV, max_generation)
>=20
> =C2=A0=C2=A0=C2=A0 for each commit c in reversed R:
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if generation(c) =3D=3D max_generat=
ion: # then IDV[c] =3D=3D 0
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 TOQ.Enqueue(c, v=
isit_order++)
>=20
> =C2=A0=C2=A0=C2=A0 return (IDQ, IDV, TOQ, RRQ, visit_order)

Isn't it premature to throw out code at this stage? My impression from the
side lines is that Stolee is trying to get concrete code implemented, code
that can be tested against concrete repositories, so that the question of
singularly overall importance can be asked: is it worth it, is it really
faster? And by how much?

It may not be the best idea to distract Stolee from said implementation
(i.e. step 1) by getting ahead ourselves with steps 17, 18 or 19. The next
steps would seem to be step 2 and 3, and I am sure that Stolee would
appreciate your help in implementing them.

So at this point it would maybe make a lot more sense to help Stolee e.g.
by refactoring the rev-list code that is a *mess* around the topo order,
so that all kinds of cute algorithms can be implemented *directly* in Git,
and put to the ultimate test.

Ciao,
Dscho
--8323328-1439661099-1526378462=:77--
