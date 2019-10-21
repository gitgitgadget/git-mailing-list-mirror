Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3DDA1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 22:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfJUWFr (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 18:05:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:39717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfJUWFq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 18:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571695541;
        bh=mb4uvaYWxD+n+wfSu6XCT5pu4A7BLL3/giphn4DEokY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FYgBKHEwtXedcfPZAErENmV4Tcclw5Mp0kWZiDm+91X+FFvdIJM+oM9DSGgpQ4FKn
         UL9yqvGKGMH0HZ3Tyk0zObNK5atZlikZWDf/n0xvW5D3ERETS/jparqWzM4nUwMAIC
         kXm+6V7Vu/umQYI7F6TbjlNPaLcwfemjmlH5a79w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQe5u-1ih6tn1xtW-00Nfa8; Tue, 22
 Oct 2019 00:05:41 +0200
Date:   Tue, 22 Oct 2019 00:05:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Git for Windows v2.24.0-rc0, was Re: [ANNOUNCE] Git v2.24.0-rc0
In-Reply-To: <xmqq4l065zx5.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910220004190.46@tvgsbejvaqbjf.bet>
References: <xmqq4l065zx5.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1E9WpF/r9p5wdnAymRclGnIBrW41nntvATOJMc2j/OoKG8ixzK5
 ISKKOde/AhpR5sqJw/a+7fUubiPXgj6lCcnBT4Z0VdA3eMHivf7/imPSD1KC4YAsSaDNcN/
 BKoJCSM04yOQL52EJYdZ7rD86JAsq/UTEgsBCBHaFbYb4e37bsDw+kWdFIL/M9HKInhY0f+
 M/6opfla0sr3AoL+Ui69Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wQvTt5/AW4s=:a/M/Ws+gTmtrbImDl50EWM
 BInIE3jS+Y1Be//6WDM/obqwgJh3MRbsd1hjWoJVk/IcIY6pcA+clLOOA2DQ9Y/q7VdRKO8kL
 lJrxTOQtwrf6QKM2NJBWKLpLNc179VQpfW9RrxqQsLn4xqQlQFAKRkQwW2/O4e2/7MYfGuIq/
 vKqFVm2j++xiwOm1BsU/2X9UubSwjQ/Akv1gTzyLWSra1gkI3xNf14lKKyLXXFOZFTeeo18Co
 Sg5VVypUolF6S0pCgZkxh9v9NTCHfVFejK+EEFZd0jkDkfsk3CuMLLkOqFXEXClkUrS7t0tSp
 LES7Op2hF4zBwFqDMXVghDoAWnPlK34F9nv2GtmL9gdb4pDzara5e0qvd40gfkcKxSQpzaY3a
 511+0HBWuGJKQ8Y7rsR9JiF9+NQIMRORA2PTeRkggSCeFY2zSRBWLWaUXaQ1e5RnWawe4pyjk
 pFSIpY2NU7HLEF9hqN2gxyqBaWJIXdLGFPp8izsFiwQvM/fC+7CerPp16Md2Q1zV3sLUV6oy9
 BcPP7E98MQCIG2y0N3hoK5POiPqgiFFCM2k4HrLqEVpmigyZ9QHWNm8+oMtxPIxwug5h0bmD9
 v5BRU21iivy9zxt8Desy/1KM+jVAqwiTX0azXkTC+Y+OTltqBlHrZeyKqdk65pT0FnYCA7qRW
 LgOlVcA33Wq15hPiaoXF2myZKcI7jJaSGmGAn++A34TFBqvFv9NtY0zB1OgZ771Zj/YmZVXOv
 i6tH7YKh5hRa8zGPZ7Szyj5ic3kDDTJVUTTV5xvnpywPRY1k/a9DoTgInF//SKcLErOJL2tDl
 t9fVFU0j0Uzl+IkD57NEtvTT/sBX/D49miTgBbx1Arxdt2B+RtLJSHho/8IgDXatXzrnDhvqO
 D+BvW0BaUR6W5Say/w4pTPmzZVsgJiaBPVJzhGZe4OV+Jv+MZpNlH3NI55xpPViakkksyUzRn
 3I5A43WD5G1H8SKhejhqKqJwltk2ul7tDZYbC+BdzzFds7IZ6ab6ShI5HrRlcVPOpiofja5ey
 bb87pJwgroGPZly1uLsC6/lDeHLXVWUPNWPyABs2fsY4F3DZtSuj/EH8LaE1Bqnvd5D7NefpJ
 mTrBId/HAi9wd7MP2+QB+ciUle43BDNiOjsZgeO8bKQKpfOZBu55GZhTIQ2oOmnoB9V8M3GHL
 oT+wOf2ArUd22yWNnyhpDMj0Mzt2tTl5sLNhIhQrk926f6EeY2At5YTJLARvqBc3FJUoCc7WH
 DliRJ0ySM6QL3jaqbPqdDaBzW1LNsrZE2K3fSD8CyzzBvvDKkoYNRld+74e8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

a couple of days later than I wanted, but at least it is now here:
https://github.com/git-for-windows/git/releases/tag/v2.24.0-rc0.windows.1

Please test...

Thank you,
Johannes


