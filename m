Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7571F597
	for <e@80x24.org>; Wed, 18 Jul 2018 12:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeGRM4u (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 08:56:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:44993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbeGRM4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 08:56:50 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LaFmY-1gK1ud0sJy-00m3BB; Wed, 18
 Jul 2018 14:19:01 +0200
Date:   Wed, 18 Jul 2018 14:18:44 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org, paul@mad-scientist.net, dnj@google.com
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
In-Reply-To: <20180714205132.GH1042117@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1807181418120.71@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet> <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net> <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet> <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
 <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net> <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet> <20180709195822.GA9000@sigill.intra.peff.net> <20180710035635.GA13459@sigill.intra.peff.net> <5b445ca6.TkV9Dj8T2KFinxZP%perryh@pluto.rain.com>
 <20180710140310.GA9246@sigill.intra.peff.net> <20180714205132.GH1042117@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3+Xt4T2/k6vFmC7tGvOvZ/Y8w9Lm7zZ0Nw1+HfDQTb26Z0eOvd2
 ek1uBLu438uTMD1ttl/I+51/ldjn23mqsK015WTUyCgMNAhlNaeG/et6Lchixl7tMdNWR9x
 2QULT4wdUiF/qUhthoWET0Rhq1EK26EL7JrtSDoWGXy6gDvLPh1ADpAzj9whayGVHLt9VA0
 aIeLbUbWAHmZ6dcP64SoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v+HUQmnD03g=:EZd2yLMt5AVvhyldswl5wY
 NKTXV5vtObYVm/APRhxPxR9ovyEl3bzsLIcLFDLrxFaezJUZaY5k1uQFcyBR5njiisiSrC+lf
 P9tTUL7qAMW+g8yCdYQ61wGLF5nbwtTSjxN01uho052Z77AgxwpP12cTHYSIwUkPbTRkEtZU3
 P7OrchSQbXYIbXoEbyrP+Cqiqh8UqMU3IgvdZbnzWf3+vCKzE38ZZlLv03b9nnNnFPAtAaKDs
 wcsxrpld16spGtJwl/sz4Kg85heT9vzEVVaeUV1AQc9TCkyQI5kjGfDPKiOF3bSt6X0oz1uCc
 2WdZTdzmn82yf+0w+jWKfjtlKy8kiMw8iYeCmOpONQMLRfrbtZn125Z8qCff7SedY4EwaHmlU
 TrcUNZynTKjAPsi4K53MpeP2kMcrkA8RUvFaOP6mNmLlYpHf4ZeNBcRqmJ0O/zBSqPTvbGg0F
 pNhKVWqrWraOVGI1G5wrqbvDbRaFuZPRkr67w1BgjwiRl7m+wY7yKlsI+2LwQqZHB/TC7cyKn
 YCxcESgngo+3jLpX5eTDl/sk53xHFXdH8Y2iGIzWwil1LDQcvb3Ayaj1qycxHew6iC/DIGAGG
 zx4k43TmXn3yS6Ktw4J43IZ+9Q8XBDPG9MmF3BZ6aOJr+DJw8d8umhjRSXFhq5fmiyd+woG93
 dksEJ6X3d2ubEkwVIE/j94j6f2deFl1DBWSS1G8tyLorw967zlnrMgmiEBHl0GTaefMeY94vB
 f2E2uTb/TxBvXI9KRP1+T9qQ/mxAymWcd5APhcY/wG94aM4rZr/V10Hv+Zm5LZTd/OTuFUngO
 S9U0ZVY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

[dropping Perry's non-working email address again]

On Sat, 14 Jul 2018, brian m. carlson wrote:

> On Tue, Jul 10, 2018 at 10:03:10AM -0400, Jeff King wrote:
> > My point is that aside from RUNTIME_PREFIX, we don't need /proc. So
> > somebody who currently builds Git with a static path like
> > "/usr/libexec/git-core" and runs it inside a chroot will be just fine as
> > long as /usr/libexec/git-core is available at that name inside the
> > chroot. But if the build starts relying on RUNTIME_PREFIX, it's going to
> > regress their case.
> 
> I will say that at cPanel, we have a configuration where end users can
> end up inside a mount namespace without /proc (depending on the
> preferences of the administrator).  However, it's easy enough for us to
> simply build without RUNTIME_PREFIX if necessary.
> 
> If we turn it on by default, it would be nice if we documented (maybe in
> the Makefile) that it requires /proc on Linux for the benefit of other
> people who might be in a similar situation.

Is there *really* no other way on Linux to figure out the absolute path of
the current executable than to open a pseudo file in the `/proc` file
system?

Ciao,
Johannes
