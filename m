Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8B4D2022A
	for <e@80x24.org>; Fri, 28 Oct 2016 11:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755031AbcJ1L7F (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 07:59:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:56258 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752497AbcJ1L7E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 07:59:04 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LeiJ8-1cgW1R0yaM-00qUt1; Fri, 28 Oct 2016 13:58:47
 +0200
Date:   Fri, 28 Oct 2016 13:58:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on
 Windows
In-Reply-To: <CA+P7+xpckfaeHmoEGQBdLD-=Kf7gQ-jOxGFKrKmiFH1SBN7GjA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1610281356310.3264@virtualbox>
References: <20161026215732.16411-1-sbeller@google.com> <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org> <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com> <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org> <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com>
 <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com> <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com> <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org> <xmqqr3716301.fsf@gitster.mtv.corp.google.com> <CAGZ79kY_fZ_pDtVnwJoDkR6PjTNoqDMN5OC70Z8SH_J0Wvkq-w@mail.gmail.com>
 <a2e5acd6-485d-0387-7a85-6042dee702f7@kdbg.org> <CA+P7+xpckfaeHmoEGQBdLD-=Kf7gQ-jOxGFKrKmiFH1SBN7GjA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hvef8zcWFuKcWieO3a30HIpFZBLsfZsg/Z0TPb+b3raJaLfQQxM
 eL/zpLwkqOGGNqZp3QxY6nGlzCjgRG6MCtbXuc4EVjZi7YEyJSfKYp8/7djrWTvCx05cbCI
 7r34Flb972vn1LsSXVMSIe9QTW/8g7837DM2vxViyrI4P6wq0lWOfk0Ee0mFV2cDOhk3Nij
 mqQoUb2LhEtGn8YQLXQXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W/mdfCx5P08=:7bwLvIgBpBXU9pTZ/HzQgr
 F6n5ozQXRu22moqE3wtAFtTL7vVmiiNqeRr9CRSyci1AKMJgRpvS++m4pAzRDECck8y43G3lL
 BLBuIn2O4tsdSiOHq/nWTMZOADdyEbL+AGRITYfYyBB9BgHXX9BUoNjlTCOj1hKMCyiU9KUVg
 IdELUs4cAdmg05mFCNoeg6IhzqOBaCfgeqnlU0B6aE6eHaLpoe6MCFPaUUWHuFrVPysaU9pos
 U+FvN76CgNEszM1NDHz4DHS12kOO5Z6DlYL0hqBjAsy2Razn1FCJ6bc3/boVWKliG6bLTNWXI
 8Rbp3Bzo6rD1mgFNE3HpKzbzcg22f9u577h6Zg3d22tlV3p/iasz/Xzxu5kosGoAPOO4ABT+l
 /MbLm2pq+q9R4csQoHdE6e5ufv+BL9GiVGrBgiRe1b9aF68N7GRlCZNBX9kkvdHb1XL3mGhJC
 7r8hktleAGcvqUsCJzKMsHDvJXmpdrw8DbE1cKxKlu7UHfwpJtEOMOEWNiQIdgCpo2qNRli4M
 uv/PX0+Tgxs8AMwY/dx+YknOPXZhey2wwm44MbW7rsCe9W95ys8XHABzHutUMDUPGB7C9n0aY
 +oo2cUoEDxdVTXKZSaTzP9fsiw8f2wWTdlRY/TZadE2DXv3T6ev/DPfLFO6tDuMLfra7yu9Pa
 uW5P5COVIe04jF0LZh/HdsDCMtZfbhb2gcta7o9UFlGAqAFaAntpYycVSIPvgWcg6VUqw3tn7
 ODKcT53dr9hxinxB2UZ4Z/Zco1GjFUjCNVmQ8Kw61guA9tAWA43FSGI3ym+aAo6LQomFhyBd9
 yOqiiMm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Thu, 27 Oct 2016, Jacob Keller wrote:

> I agree with Stefan that there isn't really a great place to put a
> dynamic initialization.

Ummm. Wait. What???

https://github.com/git/git/blob/v2.10.1/common-main.c#L25-L41

Ciao,
Johannes
