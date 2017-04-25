Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13B15207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 11:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947010AbdDYLas (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 07:30:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:55746 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1947007AbdDYLaq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 07:30:46 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGoU1-1cpS1J0MBl-00DVY2; Tue, 25
 Apr 2017 13:30:32 +0200
Date:   Tue, 25 Apr 2017 13:30:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Philip Oakley <philipoakley@iee.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Ashutosh Bapat <ashutosh.bapat@enterprisedb.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Bug with fixup and autosquash
In-Reply-To: <93E7A279BF61414D9EE8BB12B88E16E8@PhilipOakley>
Message-ID: <alpine.DEB.2.20.1704251328480.3480@virtualbox>
References: <CAFjFpRe8zqxs4OLbCrjnuEzF=75sbBJ+HuZqek49B=O=TFHq8A@mail.gmail.com> <xmqqbmucuwb0.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702092142020.3496@virtualbox> <xmqqwpcznjqi.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702092301070.3496@virtualbox>
 <xmqqd1ernh7g.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702101654500.3496@virtualbox> <93E7A279BF61414D9EE8BB12B88E16E8@PhilipOakley>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qrUShiSoFDS0debYTPLPX3Qq5Rzp8WV4Gs0IYMybYdnhUx0Mh7h
 0V2Pfp4cshJZLq10ttXkoi3D08yhovMnE947/zDunD9sO/DylM0wrpjJLNjmXZY3qnJGnLx
 FQOBxzYwGMDRwaG/+teh8juVfw68huVuKBUOrdiLHnkhBfcXh+LNBUHaCV8KGOarIeuwXNO
 fcmjafDTRwZYl1NDyd3Gw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dugPfh1nRrA=:ir2cCIEl+Kf6ZcnGqqoiDz
 lAzaUmZABul6JjvPLPL52T8YMlVe+D1qgzeBAvheDBE0ybTfm0MlFCiSE1XuQNN5hgePGL9Np
 qePFckJmc6Lf2OYVs1juHjJUHLzV8o+t4E7O/0+q22/xs/A1Udd6jJhbGpevZoaxjxpbBoJWM
 ATOqerOSSnTdvm5r2ox+/guc9cLpM0lvQTDnfjiWJL4dT+UWSF5fYIuYRXnrxjQyhKXmPjueo
 fjZuu/NQGVukYL7PLzMnXsfMsULlueZ2nYP8OWX0j6p1MR8OIxoGNs96Sh0PTGz81yeltHv7T
 g9x74i5h8ja9yI4C5iB9VIA//576kA9gnSJplhYVOsIcU2cHdYKRUcFlIfv+AFOGFmw8vGc4q
 lIENzvTjxqNJ7qlJcygqv/kFqkZaZo+MdAzf59OgSnc9AIYovnpOGYAr6H2uKeMEBQM7TS7fj
 cnF9tuUp7Wzdip0eGf4wecU4EIU9UR+Pq8JQStWWYPX75j0eDN3Qf5MhUNeMLBqsPMF17JdQ3
 HVJoJSfxtLTalK92U/HhPmtNkBAEUUYh18XsEgSeV5UEUDYyZ31lqrK2eIP81y/X6ks+tr1Ox
 WBqaGSrB+IQH8WgrSPOuwt0ASmtYl7jKB5v8++4PH/iTRx3i8PmKgfeLX9gJoHabAS6WvnuE/
 js52VHq+r9BJKch4UAGE1p4uNm6SuW7pQUxBaNwwBo8UGy22elf6vgTn47+nzRv8sRanJeV6X
 oqfBfgMKWx13EnsSsS2WYo+DBh8xzP4AC7XiPI5KPKYLzj+pwEZBJdNjikyoWuakAtaJZdV7U
 nCzm4Et
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Fri, 10 Feb 2017, Philip Oakley wrote:

> From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> >
> > On Thu, 9 Feb 2017, Junio C Hamano wrote:
> >
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >
> > > > Almost. While I fixed the performance issues as well as the design
> > > > allowed, I happened to "fix" the problem where an incomplete
> > > > prefix match could be favored over an exact match.
> > >
> > > Hmph.  Would it require too much further work to do what you said
> > > the code does:
> >
> > I was just being overly precise. I *did* fix the problem. But since it
> > was not my intention, I quoted the verb "fix".
> >
> > > > The rebase--helper code (specifically, the patch moving autosquash
> > > > logic into it: https://github.com/dscho/git/commit/7d0831637f) tries
> > > > to match exact onelines first, and falls back to prefix matching only
> > > > after that.
> > >
> > > If the code matches exact onlines and then falls back to prefix, I do
> > > not think incomplete prefix would be mistakenly chosen over an exact
> > > one, so perhaps your code already does the right thing?
> >
> > The code does exactly that. It does even more: as `fixup! <SHA-1>` is
> > allowed (for SHA-1s that have been mentioned in previous `pick` lines), it
> > tries to match that before falling back to the incomplete prefix match.
> 
> Now just the doc update to do.... ;-)

Right. I finally managed to work that in, and will send out v2 (is it only
the second iteration? ... wow...) as soon as the test suite passes on
Windows (which will take a bit over an hour, as you know).

Ciao,
Dscho
