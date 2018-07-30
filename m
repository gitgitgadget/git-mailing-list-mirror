Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 767A71F597
	for <e@80x24.org>; Mon, 30 Jul 2018 16:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbeG3SGr (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 14:06:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:44443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbeG3SGr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 14:06:47 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mb8MV-1fPcBX2Wip-00KeoO; Mon, 30
 Jul 2018 18:30:56 +0200
Date:   Mon, 30 Jul 2018 18:30:55 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v4 11/21] range-diff: add tests
In-Reply-To: <CAPig+cRd2V_hN0BVCcevXhu1v_QpL76mhqTGQmWPLK7sAD4Ytw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807301830330.10478@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <2b8d09020fff0ac220c1878c65b47290c5245cb9.1532210683.git.gitgitgadget@gmail.com> <CAPig+cRd2V_hN0BVCcevXhu1v_QpL76mhqTGQmWPLK7sAD4Ytw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:l0xgfUWBDyhdsKOM4DJsQBKKnjCMlUpe4i0URjYrfSAAAnQnp6P
 Gyg5JzQOjmfY769en41e8wBYWNnKm3EiKAmPBWEwHfIT0Z2PWHDHelHfM0+mX8HcbPgbEvT
 5iQg9gND+s+vX7vL6S2h6mugeM8/k4jn0n+gAB3DnM+p74cXoFmXcZ4kwGVgjVSVo7a1hGg
 1s3qezq1pNg+bKw6jQNrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v2JFsxtuHxg=:ak9w/ObO0y90bCW8UrZ6G8
 rR87fV/8L9+7cYEs6i2d3ywZ2NgUbGTMz5PE3h6qC1kw17uqRw80Xueq/z3A1OYtqI4UXlegD
 9Yli0mQGIGrbHCE28TbW+9+2jb1liCRSOiZjb0uze5QdQYz7F3Gb7AW3+OZf2V31p9X8KoVc7
 HjuauWl7c6HoWK+du1kjabP7QuA89LIkYvmjeTnOKSK1Fw8pchj1HGvRz4pGy9YZBpZWmbxSQ
 mixhWwZLEYLQ9EQEooYbkKGAYM6hGfm1qX+zKI8zFW/dvNZLOQMK9Fj7gzWllvf03sa7G04hp
 4J8dMPmqlms1usfKurdkgkuOfl+kOGAQd3RnmsZfk0urt37nSum/9U7lAWFvapTYnoZeZ+53W
 m+I3ldTZziUKTSpJWJbdsbmvc/ULUId0x91hCfhe9FN3eEn/ClJP2uYB5AzFlv3KR0r6s+6gq
 BM2FQ7mtLy26uhNoMMmoLMe36m3LP++nxkE+rv4U57z6Qwn70W05vc1sr2pOpmf2b5jID8CS5
 4h0NXAcw62EHCkcNWMyDjF8PZDXbEy1uWApRFCBSPMZbHtdmXfwq/nA7bE6M8BKdOKeOuYf4F
 EnwFuZ1sufJnTSacRQAUAIOhFgBZ2JbTgyiYX+BCeXOhn8pImz0rYasiph2EdyUnx/D2tYiog
 geK/nEWE7xNVeWbALo9nuwjsWK9dYwBtA+S9WCWJJ92g8J67R/+thrwFza4ayq6yFmQ1NBe9C
 BKF18oUUk3nkSrprxWky5qzADweTPFggEJpVg/y4tYL1WiiSMtizYD9n9LGP/J1KugpT3B0+J
 2Sx1dM5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sun, 22 Jul 2018, Eric Sunshine wrote:

> On Sat, Jul 21, 2018 at 6:05 PM Thomas Rast via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > These are essentially lifted from https://github.com/trast/tbdiff, with
> > light touch-ups to account for the command now being names `git
> 
> s/names/named/

Thanks.

I already pushed an update to https://github.com/gitgitgadget/git/pull/1.

Ciao,
Dscho

> 
> > range-diff`.
> >
> > Apart from renaming `tbdiff` to `range-diff`, only one test case needed
> > to be adjusted: 11 - 'changed message'.
> >
> > The underlying reason it had to be adjusted is that diff generation is
> > sometimes ambiguous. In this case, a comment line and an empty line are
> > added, but it is ambiguous whether they were added after the existing
> > empty line, or whether an empty line and the comment line are added
> > *before* the existing empty line. And apparently xdiff picks a different
> > option here than Python's difflib.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
