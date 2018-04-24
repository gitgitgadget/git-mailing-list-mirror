Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16EF41F404
	for <e@80x24.org>; Tue, 24 Apr 2018 11:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756631AbeDXLad (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 07:30:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:59137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756376AbeDXLab (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 07:30:31 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MP0LT-1f4alN344d-006MZR; Tue, 24
 Apr 2018 13:30:22 +0200
Date:   Tue, 24 Apr 2018 13:30:20 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 1/2] merge: setup `opts` later in
 `checkout_fast_forward()`
In-Reply-To: <CAN0heSqo43YkHa-1e7jaZqxktenonj3HZFrF=AKYR4+3ciZ2Sg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804241329310.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <ec58f482-ffde-1959-ff4a-9b128905ccb0@talktalk.net> <cover.1524545557.git.martin.agren@gmail.com> <f140d2795b9dce8b805cd2ebaf076742978ab8ae.1524545557.git.martin.agren@gmail.com> <CA+P7+xqP8b1i4-C242de2_P9dFsZ03pcRGo45scyfK2ohd-ykw@mail.gmail.com>
 <CAN0heSqo43YkHa-1e7jaZqxktenonj3HZFrF=AKYR4+3ciZ2Sg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-525505034-1524569422=:64"
X-Provags-ID: V03:K1:hMOPlrfyCZ0ODTWbeeA41cfK9sMNoPgMcbBI38aDAwnGwNHnCJ4
 OzX6Zp74+GEJoJnhl61pnJeLOhWn4tX0D187zL7rRA1DPWNcWLPNjx6/ARixAhcMSf3UoDC
 ZEhKzG6aQEc3CeArt0mkP6XpOW6nPC23l5ESgbedwaidj4oErhYJGXrXjQfRnYD+E8Bquu+
 /gUDrdZZ53rJIChzs8/zw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D7qZlL5jZw0=:M9CgjO2EC1W/8CRlqv0bsN
 qtaNCYRbjlJImU5tWyhS4tISTBhaP9r8BzQeMJwBKxtBHWVag9vR1oLIlbbLrEPYCRCyQI4sh
 wkJ2taJxjTV0EYPZBXF8df26h0aqdbkJ8aNRIBodajLBwvRfzdgp/8zfw34pRpAw79p0melSS
 2HWe+VMwiGmSbY+W7D+PYgJHmMy7s7qOrsK1hwGxLgTU9UrvK9TuBtuIsB1YPvM9buJWAW+MQ
 7XBlZAs7KRrkFXDINdarhoQ3evzabJWaMM3zUjhMYecoMPMIJsInnHmlqDWOaFAM/L44YQBAe
 YEaL6sZT0FkcjN/IIW4MfPmmUculcNsiCn9TwltU9TlGCxpgqkeB/gefuUdyuVRdaUl9A1mJR
 lZBoK3sNPHvEpuvT9GzTJoBb7Be1bwJn/Q3i7rXvHL57p0QLHx+sXH4im02273wUmlDb9nrvV
 3iRD9znQaL8r+IlmyUeFmstlZ3kH0xtMCHX9eIbwW7Gbiaifi0e2LiDZjNa+ez9ESH9XcLb3p
 3aPYBcebtGd+lzQZi5VLWpxOhwsk8evh4Ee1meXgm7lIIq8aLnqXqeelbvV6lSh+gjk0S+gPK
 URUPX72ENAeIiaB4j4x9RvezDFALIBteueIFowxRLLxDs0dNpl1XgSzmn0lUmz4JdSU8IHCce
 ZexYNhtVJtz19Q2y6hYTGQ+H7Gmc9RGM1I5sNNPAkMCN6qzcQ+fLSKfwd+7yXFqsSQObbZpPo
 5H+l6kgxS6tvnYrDi9iFM6UGZAa+bwGapGU/EW/R3Vrh7reI/N4kIEw7Xksk7RnljaVWhsnPx
 7avfJ9Jp9WpI/Nl2whWmK068kuxFCoSCUY0/lH2M/wMG+UMgEc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-525505034-1524569422=:64
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Martin,

On Tue, 24 Apr 2018, Martin =C3=85gren wrote:

> On 24 April 2018 at 08:20, Jacob Keller <jacob.keller@gmail.com> wrote:
> > I'm guessing the diff algorithm simply found that this was a more
> > compact representation of the change? It's a bit confusing when your
> > description indicates you "moved" some code down, but it looks like
> > you moved code up.
>=20
> Agreed. I'll play with --anchored and other magic stuff to see if I can
> improve this. Or I could instead try to sell this patch as "move some
> other stuff out of the way" ;-) That seems a bit less direct though.

Or you could add a remark to the commit message along the lines "best
viewed with `--anchored=3D...`". This is what I would do ;-)

Ciao,
Dscho
--8323329-525505034-1524569422=:64--
