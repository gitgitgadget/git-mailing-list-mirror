Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 318541F453
	for <e@80x24.org>; Fri,  1 Feb 2019 07:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfBAHjJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 02:39:09 -0500
Received: from mout.gmx.net ([212.227.15.19]:45897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbfBAHjI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 02:39:08 -0500
Received: from [10.10.1.35] ([195.130.156.138]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lz3nU-1hBDKU1pg0-014C9o; Fri, 01
 Feb 2019 08:38:58 +0100
Date:   Fri, 1 Feb 2019 08:38:56 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        phillip.wood@dunelm.org.uk, Michal Nowak <mnowak@startmail.com>,
        git@vger.kernel.org
Subject: Re: Broken interactive rebase text after some UTF-8 characters
In-Reply-To: <xmqqimy41pdu.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902010835210.41@tvgsbejvaqbjf.bet>
References: <a50734d9-4d30-5847-b5df-67a8458a36cb@startmail.com> <339d4dbd-b1bd-cf88-12b0-2af42f35ded7@talktalk.net> <23c60f2f-43ff-94ec-6100-861c655ec80b@startmail.com> <8c43e31b-01d8-a1c5-d19c-8efd0e5c1714@talktalk.net> <505c2e2e-c9bc-aa57-c498-2acced0b8afa@gmail.com>
 <2cbb5818-643d-bafd-6721-91e0d291a5fd@talktalk.net> <xmqqimy41pdu.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5Io1oGqWPW++f980gZgH6dOeeCehHCV01ht1pr12H0y+XZ5Bo0X
 9lZ+/hVmhgwQoj9lpAo3hZIwr1KpdYP8ksK6yWp4uyIdzawj5Xdw+PQhg/67tD6UdBj9LA9
 g6hg5RIZgbmXB5g5kDbH2iGjYG6+bTX7lKa6NiZphUUo8Jwz5i3COjUbWLRy4Eh/xhPinnu
 iHEQtTJP9EGyBnkq7AN4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j6AjNklp19o=:TK8Em86IYkTgrnw9xLEaWx
 ImG0z0MGX7Pr3nblahtJ9sUB2ebd/Ud3e9hCPZEfe9mMRU/n9wAtyhtBEbSSB7MCqYE0aEVs7
 +EJH9xvTesrc/RSpQYCS1C2W7dbyyzsxxIm1SLKuDR2EwTStsI4KRlJTmiWSmcsQb7X4/LR+E
 u0aiUdpVWp2jtmH3V4MUbkgVthv+SpO/DaZSCgvUYIQn20skVsNTHzyW1/IT3jcbGNgnAwtDZ
 L/wJ9+A84L6xOQCRCi0cEF4fWX7c5mDg68/4fm82ilMpGkPEpRyqEiPk0H143o+e7C65+OyGZ
 u+pzuQqvtWTANdTgIffs0BaG9XZuTSZkbf7awHK4chzvn8kDt8V6PL4vvSUtdwkTyusg164v2
 SLjotwL7N8YXT7kMduvdujIHD5XFjv3lWIw6lDonLI7Qt9Dh+zP5lHJph1rcsOA7kDTokSRlb
 ZkpQ+sA/aFv2WV8uj1WtzD7RMhMUzGbEq817j0N2pDbcTXtrwtPDTVAiFBMbKd6ZBMkEF+eJJ
 Jrq1hgpDrC659QYdC93VmsRR7GMRf1w/MFpjAxDIY7M+hKWJOVynN0ZhzTHmEVtPZdxIqx6p3
 +tnYlUXPl0Zqvc9diw4em/877GqDcW0TbproZxU8ivOoc8jAgKCHRnkQe61umtR3pMohh/E33
 lmBmVx0xCmB6pvAZRTbXMC9W2SlN6qK+U1reafaX1oJ6RXV03XJKZcExTxofoX0kLgNzk0Lpl
 0MI48gVDz0Sy1pFJH7ib6YiTXkeVunNCjfK9+v9fo6CaMRJbBorqrMr79bqBM6LmS/yNBnfN1
 VqI2bIN4VNGUZY+Kr+Fiqv2Q59cxUpqmianCt4lPKaLftF5KZBK5oAD6J5PTTvIUzZSgYeTKU
 o9peSsKpk9IVlB8wrvcxYT4K974gdtWpsX+lcq9ZMZKz2h4x06g2yxXy2jl1PqAIE7Yx9dnZd
 41bJs6OYhLQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 31 Jan 2019, Junio C Hamano wrote:

> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
> >> Are we misusing C formats?
> >
> > The C standard and POSIX both say that the * refers to the maximum
> > number of bytes to print but it looks like it is being treated as the
> > maximum number of characters on OpenIndiana.
> >
> > Johannes - Perhaps we should change it to use fwrite() unless printf()
> > gets fixed and we're sure no other operating systems are affected?
> 
> Avoid such a rewrite, as "%*.s" that takes (int, char *) are used in
> many other places in our codebase, if you can.

Yes, this would be painful in particular in cases like

	master:advice.c:101:           fprintf(stderr, _("%shint: %.*s%s\n"),

where we want to write more than just a variable-length buffer.

I am curious: is libintl (gettext) used on OpenIndiana? I ask because
AFAIR fprintf() is overridden in that case, and the bug might be a lot
easier to fix if it is in libintl rather than in libc.

Of course, it might *still* be a bug in libc by virtue of handing '%.*s'
through to libc's implementation.

Alban, can you test this with NO_GETTEXT?

Thanks,
Johannes
