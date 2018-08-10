Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA8351F404
	for <e@80x24.org>; Fri, 10 Aug 2018 21:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbeHJXiv (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 19:38:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:39339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbeHJXiv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 19:38:51 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwaMR-1fy8aJ2Dmx-018O09; Fri, 10
 Aug 2018 23:07:16 +0200
Date:   Fri, 10 Aug 2018 23:07:19 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 20/21] range-diff: make --dual-color the default
 mode
In-Reply-To: <20180729213325.GC9955@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1808102307010.71@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <b370468e71af2b8c7ffa0e31f3a3910d15897ab4.1532210683.git.gitgitgadget@gmail.com> <20180729213325.GC9955@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TO1lyGCqWllSScdKlSb7zGfmH0ec20WnMb8DzJCNXrds7xQWP56
 hi++YagKSk18v3nF0bBBgHkj+CYepHoac+nWW/OG2om8JPaMh3sI9EE8etrtzrzU1yxFRTN
 x9mavIMR6xzvGZelYRMdZ8mFqu3itLIOIG9QXO65t6N7z3V7udxscr9TgYkBvN2EYuR7otr
 lIYzSpJyFhadDEjPNfzjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sDUsuoFZ07A=:5bnlf5W6ABWMNbD+1yyY9G
 NwxexMfv7vvK1ThNxuXluzIqSXBOv1z7WzemC+aDt/gLL2zG6FIbwZun+IdElYkjDEiJjKm36
 qo3ME+Rlke68om/u+Q3FpQTO5iaM31jtof14E6jTAADc0SXUNK5EhuW64inOUwy6h5lOhlNWG
 KhY/Z4hInc3acp8iui0ygdbTWAUzStWfO/+G4yfXszXz7UFRS8Q+IJwQJqG06zRZmK3AoNTkm
 IXqWor36RejGFGyy4QGFOq543/QUApUa5Xr4xxJX2xjqNu5qDzQIzXFT4ZNEGe3+9vQ8GdW5f
 Ovd2D3SzxPsy+QiIy4i60jSAADLwcslB0MlBgwU8Sur/rubs1YAZTaV2tEmmwPFrlue4AYxqD
 qK3przV1BNFqvoRVpxzsrWTOxv2ISJ1hndI56RwJ69x+Z7QDKHyI8LiGLcknG/yK2xuSo8YoE
 +Q/kwM26lH4ub19QpHft1yYVYxlNyNovEhwPNE69VLcHwyYL+XZZU7ZGvDfLqbeFb8J6e1/CZ
 eTN1xqJvsr/Sn6QAUouBWE4LQlaBEWoEMx5xNZLothLrZ3GFYUGYtlAfzJwhRPRl8PQaZxHgz
 RBRPr2N3yj3ojsolWWJqALIgy1uwsHa8pVrkRIYSCbgUgBX/6wGhjEnV8BKDloRSZqTkC/acV
 Thpcvj2zh4HyZF6ND86wzgGVXN1zQYnJc83x68vacZioAV9RqnjBuUKYAr2HCkaL7v7R6pNsY
 Ud/Ejl0Swcg1noB3NEAcFAosDreYrukGKMKxmupF9lDxKHpL7SHBVV9ldkZRgb7BmBPF6eizB
 VwPueh+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Sun, 29 Jul 2018, Thomas Gummerer wrote:

> On 07/21, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > After using this command extensively for the last two months, this
> > developer came to the conclusion that even if the dual color mode still
> > leaves a lot of room for confusion about what was actually changed, the
> > non-dual color mode is substantially worse in that regard.
> > 
> > Therefore, we really want to make the dual color mode the default.
> 
> Ah and here we're making it default, so I wouldn't need a
> `rangeDiff.dualColor` config variable anymore.  Even better!

... except if you want to switch it off ;-)

Ciao,
Dscho
