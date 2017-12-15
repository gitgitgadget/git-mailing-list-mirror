Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C45B1F407
	for <e@80x24.org>; Fri, 15 Dec 2017 12:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755064AbdLOMK7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 07:10:59 -0500
Received: from mout.gmx.net ([212.227.17.20]:65464 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754672AbdLOMK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 07:10:57 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWPOI-1eVsIP1RCk-00XgIM; Fri, 15
 Dec 2017 13:10:55 +0100
Date:   Fri, 15 Dec 2017 13:10:54 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 1/4] travis-ci: use 'set -x' in 'ci/*' scripts for extra
 tracing output
In-Reply-To: <CAM0VKjkv0XqHf8s94Wj2DHsD49gTP0M6HU2AY=36Jj-5SYhS9A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1712151308230.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <20171101115535.15074-1-szeder.dev@gmail.com> <20171211233446.10596-1-szeder.dev@gmail.com> <20171211233446.10596-2-szeder.dev@gmail.com> <9AAC2BCC-AA06-46F9-8E6E-1D99CD959FDD@gmail.com> <CAM0VKjkVw8QeDErDg9aXcQ1sAgY34eBEeA0QJGamvEEBOG8y9w@mail.gmail.com>
 <77E6AE23-44FF-42E0-94FF-C4B35D913D5B@gmail.com> <CAM0VKjkv0XqHf8s94Wj2DHsD49gTP0M6HU2AY=36Jj-5SYhS9A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kV6vWxMq2keArStgrv3+Yo7RcKmrjPbC+DwuPR2qqcMUaZatFUw
 Pb+ZcwNL/tHEHHYw/aUqzoyIuFk/spxheei/IzTu9aD1r7OXnafyLe9JauCIuKW0PI6GWOd
 +zUU5G0qAGffrsPUwgNl3FNvXw8cEabSZaKfqoAS3ujyNP9J5U6QGYt+0A81PypOWbHdaL5
 i48qvQST0bHMfjBvF/pGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pa0gWEUHJ9M=:d/XoEOZF8ZZpj+Ha3Kg5j+
 MNjnDr51v5tWaXMkDWH1THPY6ZXCP/MauLUfi/2SE71sFDcEt8FUAsyTaBv5FijRhEIZFtHP3
 pW5B7+5nrONdpru0CQExKnv5A1ttt6f+Pqq6vGzx95SYU7F2sca18WgM/Tq6xSsTT6M/FjX4u
 9U119bPTXxcJfvVdPtzI9YOWqp0x24CVLIQmsT7Bi3nBnEDRMnoMmc/fEdmIIXkiBZzVoLRc3
 mALODTVi0jBXF1KCnTnZHATIz4EBqV2xMPbfcjHCpF0d2zrfw7c5keH+r6a2aaiLaNS0Ny/BI
 vhecWErVzfhGcCz+KU7tqIKsuZAX6YUgRWApQzHqXxgLW/vtuaZRbswyiHVc8aK4llEisP0Tv
 LXj5pSNsFsqe3q7kfiqz0qOJ9sF+8mbzful9ku8Rki06YwHS1/m9wS8Q5eYmXk9/yfiJ4aKu9
 IzpxcxhGRSy+4il3DBcsMwLMbKZqObaG/tYKyD2h8O6e40RonzSiZliAi9+6AbW+iKrAO/bac
 2tfMyFt+sChz9zb6W+973cOcuF08ReSEYJW1Xb6VS612B8zJ2Dn4B036b8edGiqu4yD4kv1rv
 LQrH/xklQFjHOZ+OivqlUcFw+NVUtohhVIos2s0W0tq6/CWq9rwjDKYjbJepXvkSumB6ijAgS
 bd8VbHX1plYdwVxA2ASkP2h/+flVcuWEU8UivXswvdFt+AOvQhe9dTW4taeS0JbRNAlNxCinE
 EqYPOlkTSRAuX6DYBJoPt5xLFDkbXKHfik7ZXOzoCvkCLxJs49cXj11VDBOr/SLG4IhblsOHF
 yzhbL0DxBNvWUNBcf/MJAinpqvKyPj4wWBlW/nFMbEhpi2LZPk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

> There is a lot going on in 'run-windows-build.sh', so the output of 'set
> -x' might be useful or might be considered too much clutter, I don't
> know.  I put Dscho on Cc, I think it's mainly his call.

Certainly it might be useful.

However, please make sure that the secret token is not leaked that way.
Like, *really* sure. Due to the failure of Git to use a portable and
performant test suite, it does take about 90 minutes to build and test a
revision, therefore it would be very easy to DOS my build system, and I
really, really need it not to be DOSed because I use it in my day job, too.

Ciao,
Dscho
