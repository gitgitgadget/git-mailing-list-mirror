Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42D3920193
	for <e@80x24.org>; Sun,  4 Sep 2016 07:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752797AbcIDHz1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 03:55:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:53549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbcIDHzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 03:55:25 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MXI5V-1bcpi13K9F-00WCK3; Sun, 04 Sep 2016 09:49:20
 +0200
Date:   Sun, 4 Sep 2016 09:49:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] introduce hex2chr() for converting two hexadecimal digits
 to a character
In-Reply-To: <ac454d89-e1cc-083e-5cea-fc9751de9a0f@web.de>
Message-ID: <alpine.DEB.2.20.1609040947211.129229@virtualbox>
References: <ac454d89-e1cc-083e-5cea-fc9751de9a0f@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1559298214-1472975360=:129229"
X-Provags-ID: V03:K0:DkhBrc3sbVV+SQc4ofabcrwYI65Q2qleARW4xfdFKlIwFy3s5Er
 ubTgcJe/4Gco0079S8ILPi7gvboRko29o09s8lUM+cqDRKNtJ880fckGBPRPw+d2WX0z5Ul
 39yWOdPVL5EqVYazMwU8y1vfoNZ7FPYNnbyojZeCQd81Lx64twLeALMmBd6ZeQqaLOsVT56
 I8W31MYKh/TrL9n0You3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2s62ZmXXQ0o=:cWs9klTwPWRdeSTjNmoiTs
 ktHsvt/hwXNiPQw/s2U1fRz717uVJpl5QYsovoE4A5jksSQdOfm1LPu/4E9fqZyyQ3UOWiYo+
 5uFVNySMDtUVdStUr1kotTFrFSw2GStaHcnYEEN7rrclZStIrkNczAcIDPkR/qzcyMBN/f1iJ
 D62eMZt1GZt94Nu2uUeDILazSTPcpcvosumLA998cZsGTMgWE+qIG3tBct1C3rk6fE3OSDFMi
 rmqg2TPU4hQ2WwveJSD114ntlHvEGNQP6uO83OHgyFY8EwpanoI+O+BLyG9G5Izm25xWYz8kP
 vp3Eb2BIIEWjjLnlsuPiimK1NAKWoQRb52QAexQUg3+JGEs1ENaxHiRz+hXGcUsrDwLiF+ws3
 gZE2n6bqMcchZwFUZoAqQ5MKuYikwdiDSkq9XPJhU9liDM5Z6WXj3JTBc8066TgeWUyGjnxAz
 z2qblDAiQSHdnN5u9MATQTN8FeOykzHPBup3AnSEd94vfMdb+Z8nOryyK+jjOT73hxcR+IH+1
 sTJwJheoFk9VqS0yPULtlHpg+255zom4+qJADruA0PaGEiHUAEzteSSup/SM8lmBS9wK4tF2M
 SAPrD0acbv0umYIZLRIn6K9f9auK4UaWzUCuM4AOlcestkrK4IjRExQY+PomoR0nzaRpH5RQg
 iBrC3rhiyhMpccei9rTSPESlLY1RekYRNLuLC1jNxV8BR3dN0SclY4TgDw/do5YO5OpRqZNhs
 dXuJVqEnsbRyWrKaNGJyxyeSDu9XC7zjl37HH1kgpCMlyz0Fg7YnSq98UUMpe2t13bLN0yCWh
 YbwCRB3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1559298214-1472975360=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Sat, 3 Sep 2016, Ren=C3=A9 Scharfe wrote:

> Add and use a helper function that decodes the char value of two
> hexadecimal digits.  It returns a negative number on error, avoids
> running over the end of the given string and doesn't shift negative
> values.

I like it! Maybe stress a little bit why this is a good change? Like, DRY
up code, makes the code safer (bt avoiding shifting negative values)?

>  6 files changed, 21 insertions(+), 78 deletions(-)

Very, very nice!

Thanks,
Dscho
--8323329-1559298214-1472975360=:129229--
