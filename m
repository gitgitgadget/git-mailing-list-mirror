Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEC871F428
	for <e@80x24.org>; Fri,  5 Jan 2018 21:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753005AbeAEVY2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 16:24:28 -0500
Received: from mout.gmx.net ([212.227.15.19]:61622 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752261AbeAEVYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 16:24:25 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.20]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Mdr7l-1eGjRz0jVd-00Pd1s; Fri, 05 Jan 2018 22:24:22 +0100
Date:   Fri, 5 Jan 2018 22:24:21 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@johannes-schindelin.gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     gitster@pobox.com, git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 1/3] Tighten and correct a few testcases for merging and
 cherry-picking
In-Reply-To: <20180105202001.24218-2-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801052223130.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <20180105202001.24218-1-newren@gmail.com> <20180105202001.24218-2-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:byPmjBKiHiY2LxlZChOsuByrljnGq+NHnX3/8il1ETvfqwra6Mb
 C74UV9INp3WDU2TNVet5kdrpDOb/Pj/FxYZdubZUKywdW5OcvwVWgOGX19RYomSq1pBUGb3
 GmEp5ww3Z7v//SLOl2yUHr4IHzDqO+KqjgUEnAyTvBVEHDllQM2wmzRpBoIsL7Y4szGtZid
 jMg7v+e4QD9qgaE2PxNFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0U/RuNZ94yY=:lLZh/Y7sCEYFEVryaZM3vN
 ChlV2gMNONJIHIqI0ExGG+SzVqM0FcwPkLvy8F2FcGGcpNaUwjKjPcXF2WlKOj+27wAUcCNix
 gwZWq/KLj00gnWUKN6CCfAe7OVeq1rqBKQvVo4YCxAKeWDNUpwop8fIDwUKi66OdCykrMwows
 PmJDciAgVPVqfpqAwi08wtcJEksvMD8TjvyovDQNP9h+kBRYN9iWwkjxHYer4xInp8qvrKMQ6
 UCRSiT2ashYpmUQblp+QupM69K+T6t58Mj8lzaTuGCK4J+y4NzXxTOrkG8q64HZ89JAuEBlup
 icu0m4KNXGe7w6PoWw4JkYE8sBm8AoT1RGa2GOocEHVc4PrPxiCYNEulYDGjYDsfYJGWE9Guk
 LMaEWbZHJ3aAPcVNFIi20fq/88QCquybx42Rjkmahv0SRsrsagjQRHfPeliL0LSbjXLA8Cx3R
 km44x99nyRCmhcG/Rnx6BfUmt4MD8MM7Qd/oDFR+5wSVK8WoBmnX5Otr2Z22Ma7kNP2FeP3aG
 dICb44b4P1Kvlf2RM0+a53vKFXNiAteX3hHDBF2VrgBg0+uXGNgy19bP+CTTZI5vbVpmnEgXL
 ByGQ8t+hsslh5SBSLRMVy2ZJElUDVHcaziVtx5NGPYiML5cQCT/aGuLK179hRVHPEY+4uWHFm
 tJ98fjYW/D4B6JoJtCmu8CpXiHBhGRi0PhoYMOa+gLogUHzsQGtst+EGiDarGHyyUBpQJh45e
 Tpn0v//n3pwsWEXb+d3wKn/AahcwSeOnoNiIgl92JTBDOw82kd0qibLVjS+O52/VUByQbOXgy
 XkkRw7R80Ptzgzx4nWefA9OyoXsX5VBepcmh5j3LzwwFtwSYWefUqcUwer/Po+idinFuSFw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 5 Jan 2018, Elijah Newren wrote:

> t3501 had a testcase originally added in 05f2dfb965 (cherry-pick:
> demonstrate a segmentation fault, 2016-11-26) to ensure cherry-pick
> wouldn't segfault when working with a dirty file involved in a rename.
>
> While the segfault was fixed, there was another problem this test
> demonstrated: namely, that git would overwrite a dirty file involved in a
> rename.  Further, the test encoded a "successful merge" and overwriting of
> this file as correct behavior.

Whoops. Sorry about that. Thanks for the patch, looks obviously good (I
haven't read 3/3 yet, but figure that the error message stems from the
changes introduced in that patch).

Ciao,
Dscho
