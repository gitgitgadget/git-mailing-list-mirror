Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97CBB1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 21:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbdBIVSk (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 16:18:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:65092 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752125AbdBIVSj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 16:18:39 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSp1l-1d1Te71oVZ-00RpUa; Thu, 09
 Feb 2017 22:11:50 +0100
Date:   Thu, 9 Feb 2017 22:11:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Mike Rappazzo <rappazzo@gmail.com>
cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] rev-parse --git-path: fix output when running in a
 subdirectory
In-Reply-To: <CANoM8SWv+KD92T263gS0Uxxi2ekNQdo0aNGx3AmweVasXk3GbA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1702092208220.3496@virtualbox>
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de> <CACsJy8CigsWjAq5cmJ=cbBmj=DdJtHdMKxmoifftuz9+9kqJiQ@mail.gmail.com> <CANoM8SWv+KD92T263gS0Uxxi2ekNQdo0aNGx3AmweVasXk3GbA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1504858224-1486674710=:3496"
X-Provags-ID: V03:K0:+JW3c9g8uanj+1UiVRpJZil1wyvgqhX3Ld1mf31UwcEy6JJUuO+
 R/ZO3XeLmgI2i4X0Gq0W9MrV2DjBZt456UXgS5Rk5BVPmSLdBjvblyOt+6AP9cLSFW1d3Ek
 cekfZx65RWP11ts7pexWbZ6wAg7oP/3j0exugEN42OX2yWY+BNBQUebWC523JsFE5t9KKYO
 m9VKWkHb5d4XHLv0EVTfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ij1QPBKedOk=:++7bHnmJMmrXrrPIxbWMNF
 msBelbBlBjikF2Sqoi/tjtKa5ebieT7gpvC/C/7w5oZC/WDqNK3SUtbFoxJwipYI94dDH3KPI
 ACzRaMGWOuyvoxyttiFHpZM1Eo/wnIXq4VEGdYfD1M1Rp3gZn+U2pE2kqIE/I0DBZtiH1/gD9
 MJVfrPYsQVTi98h/nQ1CR3iHibwA+gYQOXDjgLnQGroVi8HLM8rfFu67Kvt+V5i4bzI8T+Lzp
 JBnc0JYNVqH2qOQy1jgPGpjoVRWwgHmbGCJaAivKP7ICuW/A20s2kXHix83PrWtfpoeds23fc
 ozLcCYNCs+L3V19+xwtioU0rzMSd1/YB4CLeaoUhllsmFiuU3M5txFF+AGCIaSQ/sfN1sOPxS
 HJlXmrL/ZrFJjMHbWPu3J9Uh7Z7vycbi8I3DbG8s6bVW3ECY9WfDkYGMq3ksnD14rjKdx+X93
 zDZXpVEhsheYXvATExe1WOvu2LtkfR3qs6D6GAAireLnh+iqQidwNke0GfZmhuo9eEUnIY4oL
 VckyeSJOY4DVA8N+P8Q+NG50pUKAh1KxuKQglBfYJ0KGpicsrOC5zD+nGbYOBLQT1CqZQv5Yy
 CZRSpCWWswzU06EyUIgr6zjpk7sYc1pNDTQLzzZa6YTGIw0j1skqxEZYOvBvi8aN1QHJTIpXy
 91BFG+x2MRinRJbad0ZKsG9tDhkQt/2kNhpTI57bpRV1ZNE5A0z/lg2lnLsqATZyDZTIqbNjY
 zTla6RuGH7/8iV6aMtrEXg8fhgtKzy1b1OK4XfzP1gFVwBLTVPJMvFort9hTV3FSm3xTZgnTh
 +lafHIe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1504858224-1486674710=:3496
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Mike,

On Thu, 9 Feb 2017, Mike Rappazzo wrote:

> On Thu, Feb 9, 2017 at 4:48 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> > Relevant thread in the past [1] which fixes both --git-path and
> > --git-common-dir. I think the author dropped it somehow (or forgot
> > about it, I know I did). Sorry can't comment on that thread, or this
> > patch, yet.
>=20
> I didn't exactly forget it (I have it sitting in a branch), I wasn't
> sure what else was needed (from a v5 I guess), so it has stagnated.
>=20
> There was also another patch [1] at the time done by SZEDER G=C3=A1bor tr=
ying
> to speed up the completion scripts by adding `git rev-parse
> --absolute-git-dir` option to deal with this case as well.
>=20
> > [1] http://public-inbox.org/git/1464261556-89722-1-git-send-email-rappa=
zzo@gmail.com/
>=20
> [1] http://public-inbox.org/git/20170203024829.8071-16-szeder.dev@gmail.c=
om/

Ah, so I was not the only person reporting this bug, but I am seemingly
having as much luck getting a fix in.

I had a quick look at your v4:
http://public-inbox.org/git/1464261556-89722-3-git-send-email-rappazzo@gmai=
l.com/

It seems you replaced the git_path() by a combination of git_dir() and
relative_path(), but that would break the use case where git_path()
handles certain arguments specially, e.g. "objects" which knows that the
=2Egit/objects/ path can be overridden via the environment.

I tried very hard to keep that working in my patch, essentially by
emulating what git_path() does already when being called in a worktree's
subdirectory: make the path absolute.

Ciao,
Johannes
--8323329-1504858224-1486674710=:3496--
