Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E22C02022A
	for <e@80x24.org>; Fri, 28 Oct 2016 08:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964911AbcJ1Ivp (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 04:51:45 -0400
Received: from mout.gmx.net ([212.227.17.22]:64442 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752045AbcJ1Ivn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 04:51:43 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LiDHj-1ccyPL1IUl-00nUmc; Fri, 28 Oct 2016 10:51:28
 +0200
Date:   Fri, 28 Oct 2016 10:51:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] valgrind: support test helpers
In-Reply-To: <71c3d13a-fa29-75d3-50ac-81978c08f552@web.de>
Message-ID: <alpine.DEB.2.20.1610281050220.3264@virtualbox>
References: <71c3d13a-fa29-75d3-50ac-81978c08f552@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-661660102-1477644688=:3264"
X-Provags-ID: V03:K0:SnABqjBAaEb6kuAnIPvjuv5PilU/8Ds7A2+VMlJ8jFIAkFGrCNd
 tXyBUoLquNi08U1ur73hzwPaaHp0DhkbsfnJP1zblGGdDhSos6gBFTgqsyDoh+q6ZCrD9Dp
 sfAb5pb+kPHsk/i201gCCNvRqFZPofi0uPCTJXvzcsD1H8ecue5MlVpuqaC1CmSlqWroH5R
 N7ZYkgoXociRpYYD91ISQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GMZjwVwer5o=:2zl1vbPXGAbK4RRUIzO3WL
 vcrwiH2ScekP6oMf27T6DRuElATu3z9CRX4+lsJSapJS1FCoWrcvO93ocAbdAkDkYT2/o69Q1
 9o2GV4Zp7FmuQwD4YSAlxEdpBWT4bAb2Bwe7XaBojo/VW13A/snm8EV1RB6yOuz9Wlvp/LMmG
 htCWmWLeQiaTk0THutggNIjQDv9V/pSq7qhVCz/c4U6PGcH4wT1M0or2Lu5gM0caWEKbCDimK
 JoPPrtPBQD4nAsZRymWwju0H1UDmsR2mH94wnuktYJjKy1vBKpReBp2PDuiZWzTp+2SG4ZNwb
 dp/zZhIGNa4fNEC2edmRab3NqAmpsLPvGtdQjN3XGklvnGwQCa/rAJWAA1d2Hejz3s//cLvR3
 UZMKWe5qQkZ7RrshsoItPKqZ+Wst4mdCERYdaTkONaCBQiksQcXnRg8pgP1TmDX/5wtCWOtgN
 Ny7Tc+znNnhG6W1Q1dWrdUP20A8SjnKWUcHdMLRCEvqJCczppn7vx6K95fcM5Tgb3C2ZZehGc
 i6E4qZ4+EnQwWApT/DZ0zSAtbXgEClEG5ilLHhzdgvyU033pf00HpR6zOGD43Oqb1G7ItNvyX
 Q9CEKdAM43vfv4VSomN6WAc3Wxm1KNc3CIEKVvQnlsT0I5wl853yDd27atV3vVbBjJK4MR2yX
 n838Cj2LA5biyJwOZ2/5rPX3xrXYXCowyY7telnGoN18J4gr0tjsl9fSQFlt7Dk8isFFavuoX
 AezrbPfZ2pXxqOo1ib3TfvarxnYWRUBmJnbOJOWhhHZaxcT8GnpBVsCi7EAHsBCZqxo+/6HLz
 0gjTJ9n
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-661660102-1477644688=:3264
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Fri, 28 Oct 2016, Ren=C3=A9 Scharfe wrote:

> Tests run with --valgrind call git commands through a wrapper script
> that invokes valgrind on them.  This script (valgrind.sh) is in turn
> invoked through symlinks created for each command in t/valgrind/bin/.
>=20
> Since e6e7530d (test helpers: move test-* to t/helper/ subdirectory)
> these symlinks have been broken for test helpers -- they point to the
> old locations in the root of the build directory.  Fix that by teaching
> the code for creating the links about the new location of the binaries,
> and do the same in the wrapper script to allow it to find its payload.
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>

Apart from the missing accent ("=C3=A9") in your SOB: ACK.

Ciao,
Dscho
--8323329-661660102-1477644688=:3264--
