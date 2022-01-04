Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4708C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 13:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiADNxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 08:53:54 -0500
Received: from mout.gmx.net ([212.227.15.15]:45009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233894AbiADNxv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 08:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641304409;
        bh=Fpm9HAX4DA+2NXlirYQ92fBAQ0KJKlt7qYhEDGNTL9I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HiDh240TGGWCynQ5v7nYwwDw8VGkxTJ97xH/ZoPIdfeiBNCHOi7+Bsr8Xa71KBxU2
         9V0ca43hR7zGfj/RFVvhkWYKj1YJ5Po1z4c4+ERzH76QljgcrcOHSu9MbSgzpS+rpO
         nkBFrIjJFsaGfrBT5Hgd7p8/PgnIeHIsLY2PLJmg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.212.167]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXyP-1mtQu62p7H-00Yvvj; Tue, 04
 Jan 2022 14:53:29 +0100
Date:   Tue, 4 Jan 2022 14:53:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 0/3] Additional FAQ entries
In-Reply-To: <CAPig+cTWwmVFggD2UL=Ddd3rc007zRWcRs7nQtEHSS5kgjx4og@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201041450180.7076@tvgsbejvaqbjf.bet>
References: <20211107225525.431138-1-sandals@crustytoothpaste.net> <CAPig+cTWwmVFggD2UL=Ddd3rc007zRWcRs7nQtEHSS5kgjx4og@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:T4IkYnPgrbLYGUOJsebasK7oaZLIToy/KaLhxYtV1jgn+wfiZUn
 ey/Lb2vNCtPN+k1875nf148aT/QroVGlkiN8+Auqb7rrUrM+f8NmUy0giOwjy7DfV9Dphhf
 D2EUx+rbRkHS5wP8Y/QsHVCfWMEOeYwLK/POpeFbtWBod/vQxXsoXnR5fePX46SezGCbo0W
 j/0mo/hNZY9VdpMvMXaAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CBXlFro47Yk=:NTV+0AO0xGrzsXXMMD+d+v
 qPOqvUsPrQwLvQLgLuwB1GxmHWsZxmbfq+v9hW2tXX6xBUkGfDdNpApLmfLfCrfORY9OdoRNx
 aY8MlC4ZhUuBsm2rwYHxXM4JjljBbSDItnaIOlmgheFs88RwHKt/BLgsXdETHyRfw7L0vBA2/
 Csi8eJRSNEkG5oip2mt/hAZjcxSRDO1Ra9qh/pgybWqqMdnxf71KTvdAoFCqC84VnPeMgZb+g
 JzhZVPaLNsuaWG+8eOY35XQuKynBV+lkHpLvK7eAUBE9sZdssRM09y4tsMD7O2GimENRfJ8sF
 dx3/UqWgBKIFYn4PAVWy7oDE7/23dU12py13mS0fGdmSykHaEYSkuuQyF1116z01MUyysPrlF
 +A/SxQkTzQ0jjEIHklcNuI2XWGXDIc4h7j13yaixA/kIjqLW9ozl0hf5YAOSSS0aaB5lC57s3
 x4pb9LRbFj9BE9ysIyEr5mO+dAO2IQr3Enr69p7pLBQhDSBnqxLxigKqxNjEn5MoQ+zqzIdqO
 FvZ59z93JMZrVPfLJFyKGpm0f7tb1Gy8o12KDkojkXcsBRGm8Smh66jsAppMng+Tfz2yobVgb
 NZTffcFRD3NP062Xh3W8JztZPA7UJ7KSMh/aT4Z7r0nX51hdCXd2Z6TQEI4NNxZK1xunReqhB
 WeZdf1CgNq4UXbJElTFwqb5T2A6hPnLILm+8uJZlyIZ0C3Yy6A/+kEQAV7D2A0Nu7EqM/YlG1
 JvEH5hAH12P2ZVAk6Jt7I8AQost6sQg4jogd71DN+VrvaGgsIggA8YKR/SEwjj6qHRxxYMQHN
 GRdMfyBTJZzD/JPqW231W7Dto0/wfwEPlDKjD41YqIgf5z1KSmhij4ti4cM4w3nDNPyDcli2W
 oMfhWU6d2HzLGLMmVGTh7gPr/IrhqJkjhIwDQ1HAGW4WFFadZazdHxDw4SDqmMg53BLw3ZzvS
 RUw04ZrO+USXImSbHHtnhrapP5CPpLOqsrO+Zyxq0dkBz21F3wREKFCFy6yYomoBox2u62set
 8jZ9DQs42xj77nd0cn8awbC5U6ft8cIZfOizufESr1GkSuz10ST7xED1Sgyv2tlwG53Q6ZqWg
 bcnS1xEFia1KlQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sun, 7 Nov 2021, Eric Sunshine wrote:

> On Sun, Nov 7, 2021 at 5:55 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > This series introduces some additional Git FAQ entries on various
> > topics.  They are all things I've seen in my professional life or on
> > Stack Overflow, so I've written documentation.
> >
> > Changes from v1:
> > * Drop the monorepo patch for now; I want to revise it further.
> > * Reorder the working tree patch to place more warnings up front.
> > * Mention core.gitproxy and socat.
> > * Rephrase text in the EOL entry to read correctly and be easier to
> >   understand.
> > * Improve the commit message for the working tree FAQ entry to make it
> >   clearer that users wish to transfer uncommitted changes.
>
> Thanks for re-rolling. FAQ entries are, of course, bikeshedding
> fodder,

That is one possible perspective. Another possible perspective is that FAQ
entries are the first thing users in distress might turn to, so the more
helpful they are, the better. Maybe it would make sense to focus on that
a bit more. As in your suggestion to name cloud sync providers by name, to
make the FAQ entry eminently more "findable". To me, that did not at all
feel like pointless bike-shedding, but more like a really valuable
improvement that users will appreciate (even if they will be oblivious of
the fact that they appreciate it, of course).

Ciao,
Dscho
