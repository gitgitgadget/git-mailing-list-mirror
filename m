Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A05CC1F829
	for <e@80x24.org>; Wed,  3 May 2017 15:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbdECP3e (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 11:29:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:62727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751046AbdECP3d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 11:29:33 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCtLD-1dEyVZ0GzT-009ivB; Wed, 03
 May 2017 17:29:26 +0200
Date:   Wed, 3 May 2017 17:29:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 20/21] config.c: handle error on failing to fopen()
In-Reply-To: <20170503101706.9223-21-pclouds@gmail.com>
Message-ID: <alpine.DEB.2.20.1705031727410.3480@virtualbox>
References: <20170420112609.26089-1-pclouds@gmail.com> <20170503101706.9223-1-pclouds@gmail.com> <20170503101706.9223-21-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-681203575-1493825366=:3480"
X-Provags-ID: V03:K0:IHNP0PAB1CbgbGK47gvWrYngxQjNk9g4Oq1HQvUtFlA7gihjnAz
 fWhu0HCaEsJWQq5oxqdMqZh7ozq4P7tqdIAr0x7EG/e32uDmeb+Q4RQDEqceuG8BntrcuGw
 bS19BzThsxPbZI91NTXIQM1V3xxKfmmb5zPz7QiJafZ9nK1125Z2qMC76AZH1eFlMic8lXZ
 5mw+yBR1/foSBj4XC2vXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o4eO7zcsY3k=:GOEgdM877vMD6rQGU+r3Yb
 1BUnq55IH+IgW2DqY+CjqkoZYZYnzX0sGa4qLc5Kkzm6c62IihsZR30VweYg0ybZPj8jPOKOj
 1j63IeW7LyRLdeCzJbLUIsYFlqlJFOi0tE1iqr1O/dnqrJ0xn/ppQfmkuCV/ihZUwaz+8chaC
 bLc3Hlw1Z2wlU8ceLcgrm8l3Z8Zhv2GhexRbeujU6bndJgSAEo7uscRzWGwzSURalsGN61l1z
 E7nUzdaSUbb0/jWEPUc3LUU3uK11O947Hc17Xp6Bh2uRXHu8koZyDGfoYR4gcqXrkoBXeG8lG
 LfUTvabycZc0QEhNWi25LmE/ggoCTbR1yr5mL/7yKnHztQQl5d3MbhgnCsKj+kxZaIFSAQNH1
 gmA74mr3hoXLOkrHroX8Mhk1D/EA7V4XDgwqwtYl0LAn6JdOWRhK7BFxwbZINZeJ0CMaO6z8A
 /kRu7pWN2ZloqHSHmsU1fouV6E+ZC64d3ubp8FdIc7dQd3pSRB9UAfcI2wA0Cjob3N6Ul4nKB
 +6csFdnURWxH+dqfZPh60GNy5wzwqbVg7vN9X1MWI2a2CKW1SMBxcPx0sBtna2OvBlva1bd7c
 TDDQJgDV31W5Hq3sP9fcQ2924yiEUYtdjB4gOvptkV4qiP+43FvtRql/bcRxCxwWnxNyC06Qq
 SxmxX+ab0Jm2mstmr7J+a9WCGcq6/emQfz/QYG3pPjjaGRneHluwt013nxiYDiHbSogVdSbyh
 6ttLnXBhIXzPtbumFwRw0xjM0AnfAWODkbthStmxzakFTe1scQvpwkV8j8v3ZuyekV8hRODUB
 7fHii3p
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-681203575-1493825366=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Wed, 3 May 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> In the first case, we already correctly return -1 if fopen() fails to
> open. But we should report something so people know what's wrong.
>=20
> In the second case, config_file =3D=3D NULL does not necessarily mean "no
> config file". Bail out if needed.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

Again, it seems that your patch series tries to cut at the file boundary,
not at the "logically the same change" boundary, making it a bit more
cumbersome than necessary to follow this patch series.

I highly recommend squashing the first change into the big fopen() ->
fopen_or_warn() patch I hinted at earlier, and let the second change (with
the accompanying test case) stand on its own.

Ciao,
Dscho
--8323329-681203575-1493825366=:3480--
