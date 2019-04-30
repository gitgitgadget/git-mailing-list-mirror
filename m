Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381A21F453
	for <e@80x24.org>; Tue, 30 Apr 2019 23:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfD3XVx (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 19:21:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:60497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfD3XVx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 19:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556666503;
        bh=KEn/3a34Hsk0DbKxqsMcGOtgqYyYe2aGteiMja28BV0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cAwRdHSLWtXY0etd3epbvkEHh87PGcEf3ejcQHgwFmMW6XeUUce5A4L/fcoqvuCw+
         9pXklA1iuJvKsFGLYvs/M9g5NP3gNq8XG25cdWdCecDnl8NOgC+CvkRtmoM/gPG5v1
         u3oWByfrOSKmxF4rTTptarBA2vEnC5bKTnxIwqic=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQjH-1hY09C1uE1-00GmB5; Wed, 01
 May 2019 01:21:43 +0200
Date:   Tue, 30 Apr 2019 19:21:40 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 0/4] remove extern from function declarations
In-Reply-To: <20190425120758.GD8695@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
References: <cover.1555352526.git.liu.denton@gmail.com> <cover.1555487380.git.liu.denton@gmail.com> <20190422214901.GA14528@sigill.intra.peff.net> <20190425120758.GD8695@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1024177324-1556666503=:45"
X-Provags-ID: V03:K1:8nEX26NcSuV1dB1cBs0YCNPKno2pAQz14NDxBnmOPeWN5iJc/TF
 DMyrrXwC4Q1Gc9MiZOJ9kjbKBOg2LTXAdAX58E13E9l+xb4yOBihXWON4/PKKXxsSFuUalS
 1RCL3bfUDUKanPHrV03NSR+eHqvnWHJR0GIcCSgbI5qgxFXpbVi57/HKzjGih7JTPObOGBu
 cEwhYQ3+WqcP0OTNYfbOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PMUnWeWE/FU=:RMYn+RQpwS/8jcCnXEjB4x
 54W0M+lOlwuX8o9UJpDGH5Wen8GC5V4EKe+z6et4WYzCDWkkadd0matAHo8ZigR8DeO2uJE9s
 6FdtiqgwYNWXIPN/OomXs3BdzMGP9GnB//ZGScbGTXpteK2DXma2m2Sy9yNk9cRFmaCaQrRdd
 ywbpIFJ64o5m2Yaz19CXKeCzvUO/9zC0DOBUKGDvHeKrh4R6o/UW0rJjnazk3ZpMI0znD5xhx
 D0CfAieJKHSIxVtkwOE3YWt0pxfHW14qwkXqPStqgo76V8ydUMQj15tVfl/M21raRgLwatyY9
 GaAIh4EMz0dffL+/5dCYIi6UQWZOXnaFPBErB+d0VN8VRvubIPyqxk7G1+GbJQJaL5kksugEM
 +U0TfgCdqquMv3Zk2f6LwXIH2BHs7kMcnbyl+kDG/zZdXe1KR+uytD9ARiXDMte0Yy3p7GxL3
 RYMf2tYq9xKw9cbbRulCxz6RjbGWHX9ZwYJ3hSfpkXsbFQRl8TTPe+wsj2SUUVAy/YT+xdsxK
 yi0QhYufhxv9yZeJwO4xT+VjBqmKp4+IJRL6iLrChDkHy3btHCJWdE6gJr/c8dxR/XcJA80Ap
 bCUVQxV2W6to/gs1+ZETe3O7RazZoKL4W8CKryK8bQil81v3EW1f5Lk0/UMAwe0G0YJWDfzuV
 T/tfCy8W4yFFduxp4vus4Ax7hwYkJu28qLztS+t+nioQijxKKIVXR8kt6w0pSSJZ89hxOeDCd
 /21idSmx0w/hnnGPbiSprd5Zl27M/BXHeER2rB8NUogVpbscNi/M2KjauTvLTI8t52uRsYURE
 Gs/54L2pMDN8KtvUveAvonBDDp++sHj9Wtcjs/HlxZkMKM51tFLKqE8sJNWGkyrBzmPxUAwoI
 YRSJokqN+pux6WfC4UZIopsAby/dntzHH9TkwpRpm7eyU9UOk20dC/OJ78zGHOtK2sYxe9e0Z
 +DuTGRkU80g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1024177324-1556666503=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 25 Apr 2019, SZEDER G=C3=A1bor wrote:

> On Mon, Apr 22, 2019 at 05:49:01PM -0400, Jeff King wrote:
> > On Wed, Apr 17, 2019 at 12:58:31AM -0700, Denton Liu wrote:
>
> > >  compat/mingw.c                    |   2 +-
> > >  compat/mingw.h                    |   6 +-
> > >  compat/nedmalloc/malloc.c.h       |   6 +-
> > >  compat/obstack.h                  |  14 +-
> > >  compat/poll/poll.h                |   2 +-
> > >  compat/regex/regex.h              |  66 ++---
> > >  compat/win32/pthread.h            |   8 +-
> >
> > We sometimes avoid touching compat/ code for style issues because it's
> > copied from elsewhere. And diverging from upstream is more evil than a
> > pure style issue. So potentially we could drop these hunks (though I
> > think maybe mingw is our own thing?).
> >
> > >  contrib/coccinelle/noextern.cocci |   6 +
> >
> > I have mixed feelings on this cocci script.
>
> I have actual bad experience with this :)
>
> v4 of this patch series excluded 'compat/' from the conversion, but
> the semantic patch is applied to 'compat/' all the same, resulting in
> failed CI builds because of the four 'extern's in 'compat/obstack.h',
> and will continue to do so.

Is it not possible to exclude certain directories for certain semantic
patches?

I guess we could also simply declare that *all* Coccinelle patches should
leave `compat/` alone, on the basis that those files are likely coming
from some sort of upstream. But then, `compat/mingw.c` and `compat/win32/`
seem not to fall into that category...

Ciao,
Dscho

--8323328-1024177324-1556666503=:45--
