Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69D2F1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeG3RWu (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:22:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:52329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbeG3RWu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:22:50 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M24Vr-1fyxBD3NMp-00txSg; Mon, 30
 Jul 2018 17:47:04 +0200
Date:   Mon, 30 Jul 2018 17:47:01 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, phillip.wood@talktalk.net,
        knu@idaemons.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] fix "rebase -i --root" corrupting root commit
In-Reply-To: <CAPig+cSYPEqapdQ=7zjW-RsM6XxCw2vPzZzV32uh_SgO4cQSog@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807301746190.10478@tvgsbejvaqbjf.bet>
References: <20180730092929.71114-1-sunshine@sunshineco.com> <CAPig+cSYPEqapdQ=7zjW-RsM6XxCw2vPzZzV32uh_SgO4cQSog@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zG3f8y7L+ta79nffzOtWk7MxL61w11NRrdzEGGZHgCJYLDVmRc+
 qeuQQZnJscAelXe0K1hkqRsNMiF5HolJwOgeLvkAFowRwd5QunpvRXYyQMXQhmO6TYjkvVv
 XRmczBvBhLRi7YjZ366tP6H7hkUHtwSz2ACx61xKv6XufRwv+FfAL762CHQQSWhQEpinE8W
 HBR3i/m57eCb44GAEwUUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dQKPmeSJOjk=:7fRKUNpvnF1lQhYnI3aEvY
 HyAvUfWxuz5TT9epzI0YruTLjOxRLtvUn23X+qbiSXbi1SlaxAUEt4vw4KnYuwjOphs0RjdkT
 13oPgDjVI0OXUUX950ag3eb3ydo9JuiND7CQKChdeqqooGvizqb77zqzjXAwRKQkOwOFYThvK
 9pOVR3kc5JC1yVIlFZL4aWlA3Ni+BDgoPubqtOv2ziyp6V1hz0U/fO2MWvwgfx6y7m5BkjYQA
 k1kG0letruZFkq3Mfht92mssE3HRjp0HvXG/j78tduLRt5ZRtIKEHtKKI0+tjsQxQe9hkvLSd
 jlob7EHyNbYeKxYZD5LRQb8/tTKkBU0mQIuE8AeZP2I9a+MxF8BCOTwCXX9gwmzyzhYRhC3h2
 YndiO/dgfGMpoIoqZT5xxZioICoTkV6LHv/rRBSMmwBghREAZT9nLqfCqfMT+PLJs3Zl57FOR
 ddYvKow6u1JsXTrKH+E0UlVAJBz4JKNbE+0A+7BtffKJ6phakMPnG7x0U6NL3V7v7Y5+feWvm
 rWqAwUZWTJHEdj007YGaERgtFaZq/rgWONK8rB7vm0AtwKllOAYrCrsMMuC+Uo7Z4xyZJKbeE
 LJbIDxXJ6y8IsTOeHk6zKbUyvus+pxtQ4SdfTuyL76enVp4aYJ70V6Q4k9uw3h+Fp45viVClI
 waZN3hLXsnpg2yvImtL0sMhi/vaku0obe6XGuSj5thG5sOGV16zd/RAQDmm7bFdbTsLpi11ot
 11mEAwKmAAniElkT33oMQP6iL0H72y7aljYZpWFXch/Y0UF2Yz6Rp0dLLsVwiAdb5HnrmDrc7
 eog6PBq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 30 Jul 2018, Eric Sunshine wrote:

> On Mon, Jul 30, 2018 at 5:30 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > This series fixes bugs causing corruption of the root commit when
> > "rebase -i --root" is used to swap in a new root commit. In particular,
> > the "author" header has trailing garbage. Some tools handle the
> > corruption somewhat gracefully by showing a bogus date, but others barf
> > on it (gitk, for instance). git-fsck correctly identifies the
> > corruption. I discovered this after git-rebase corrupted one of my own
> > projects.
> 
> Unfortunately, after sending this series, I see that there is
> additional corruption that needs to be addressed. In particular, the
> "author" header time is incorrectly prefixed with "@", so this series
> is going to need a re-roll to fix that, as well.

AFAIR the `@` was not an oversight, but required so that we could pass in
the Unix epoch.

Ciao,
Dscho
