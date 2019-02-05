Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267151F453
	for <e@80x24.org>; Tue,  5 Feb 2019 11:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfBELlO (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 06:41:14 -0500
Received: from mout.gmx.net ([212.227.17.20]:49053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfBELlO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 06:41:14 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1FAK-1h6SeS3JEm-00tChi; Tue, 05
 Feb 2019 12:41:08 +0100
Date:   Tue, 5 Feb 2019 12:41:11 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: make the OSX build jobs' 'brew update' more
 quiet
In-Reply-To: <20190204193823.GA4511@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1902051240080.41@tvgsbejvaqbjf.bet>
References: <20190202163421.19686-1-szeder.dev@gmail.com> <xmqqk1ifv296.fsf@gitster-ct.c.googlers.com> <20190204193823.GA4511@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1391330865-1549366872=:41"
X-Provags-ID: V03:K1:MjjhAZw6Yq913WCd+eIhS1/BglQwznUn85Pi4u0BN3UKO7ywwkg
 T9x0TACOiDw6XUU4quO8ZLuGfdMRuwdhtH2N7bOqrf6K3wK69VBcMoP6XdHRFeWVulbRkQF
 IaZLCjziwYyrTCsNc7PsPx+93tIpSndpPpfx4jjzEkFQZdqk46jc2yee+PlFgSF4P79Sv5V
 zVJ90YCigX5pfCSOsYy8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g7p3SBYPbh8=:dtbBYlPBomnDR14jO6OxmD
 2lcV8eF7Ny+1uJ7/RL7cObGTmh/GKb+o2WvY48RrAtOO+gz4OaJCSEQWTczFQ+y1YK8kBfzGR
 +xiax1K1oZum2HUik7wBkYz2qwh+lp8vS2YmoeBa6G2h5Dc/riI+W0m1hJMNBryaJ9z6tdG84
 hTAv6YCc0oja/3ONBpBtyQfHsoOCyfFIjO+N0V2I9aTIDCXnGS6Lm9nn1FTNVlGbwe1jFAAw0
 tXSLgkhpZb4nN3cjzH3NV/HphxLujY3hg+JJvdhluK8EDoSRd277TAbZBKztvZwpgslDkw/TB
 NTgLOliWb8Ah3c5DGxUQiyjQQK6MO/S+t919QBmM8cVb5utomL3GyOBINNgIieQBsgd64NQ5d
 /rEap4Cbnvr2SKlVF4SlCMoJkm3mcRBidCgTGMaXwRmvcFUscSxYqHieHN2SKqqUbI2oDR462
 M01HnUYGst3wGMuK/6JbDHZ5XK7hl5Yoj81ZiLOtHulbRS6JDBX+XTDfCupdtjkOd9FAiI6ng
 c70XBszgW0CyAZMnCRpLIqvXBFvCJio9tb9napNB9rox2WxuF4pcRTNNoiCam9jGRaxo35vWY
 iPfU/IMrsmxcrU/2pC2WSJMuvHk1lfsEzEMLRUkguX5/Gf140Ai1NL9Rg+Pw6DWv5EHwlcLdW
 iAwBYbrZRxe8SnUU6YLQIZHOC6H8xGsGXJRliuqebFslMJSwveJq25/vDEZ/fk/D2oOzsWPkd
 J4jX0MOUhFL1p8ZuyXq0TEbNmRsgVjrPOcr5g5KHRUN6DgKGwgasCuh2IoOmY9f2YhQtpO0r+
 3AuL5RI3Kmtkl5PL2o6TxG5RBIJ/Es7YJLCT8EqDIO2fyn4xf6iQBMoIJ0/gplCjWrASfyxS5
 trkdGgMpgdfNLncJEsW+mkYOs7KS3m9Vdip7PJUeNjLdQt8AsuCY3J2nw0ukZJJSq0VOAL7fN
 jKA6qvbissQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1391330865-1549366872=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Mon, 4 Feb 2019, SZEDER Gábor wrote:

> Under Dscho's bugreport it looks like they already merged a one-liner
> fix, but how long will it take to tickle down to Travis CI, I have no
> idea.

Since the fix affected a Homebrew package, it was not so much about
trickling down to Travis, but about trickling down into the public
Homebrew repositories. And it seems that that trickling is complete now.

Ciao,
Dscho
--8323328-1391330865-1549366872=:41--
