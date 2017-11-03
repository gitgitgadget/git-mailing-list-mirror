Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD03D20450
	for <e@80x24.org>; Fri,  3 Nov 2017 12:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbdKCMgv (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 08:36:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:52398 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbdKCMgu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 08:36:50 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVvB2-1ddWXG11Z2-00X4Mc; Fri, 03
 Nov 2017 13:36:46 +0100
Date:   Fri, 3 Nov 2017 13:36:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Andrew Baumann <Andrew.Baumann@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH] setup.c: don't try to access '//HEAD' during repo
 discovery
In-Reply-To: <20171103010645.25499-1-szeder.dev@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711031334000.6482@virtualbox>
References: <MWHPR21MB0159089DB91A30E5E5CFCB479E5C0@MWHPR21MB0159.namprd21.prod.outlook.com> <20171103010645.25499-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-404204253-1509712606=:6482"
X-Provags-ID: V03:K0:yJ/YGLfZ6IrRnkfuMT0182quNd/nZe5iN9j/cOD4K6rN0Umgsxp
 0JYdRzT6UGBr/rznxP37+GF2c9SOXJ+u8zzvyflSsbioalA8QQcehZHrpRlXIxdZfHYaWHZ
 A7jiF19lI5KHAAC1jZ6IBGvPKuyzMA7Xnke26rzd3tSaCkxgUeaJuVSx4XRdS05FvtQFOMO
 s19PYJVEH3XFqdW11TrMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bm+rFKUla7A=:t+dryzJO7fj4041xA/qP8X
 KaRWGOkRWMTk3zo7YY44EbDjk9wcQ51yUAyF86TgvOhJj3fgGk8RBigOOop21kA1wCFi1SEZ5
 FNWsSeZEut0xMQGBi3BkJguEaVJRp2EgPl13xRUgCyZt8wLO6qW2gRQUgKFTqqEJFDmoyY86F
 lrC4P6dCxiQoHqnbBcmWY2RZHhmS2auLx9jXc9uqNyNYx4QLeh09jtz53CbsytPKmDWCI+Yal
 jfjlQs0DFtSs2Kq+zkcYZ6b3NjgGa1Q+HSrh5p7v80dKNLaXH4bvR6ZATursKAz2BZcrHbSGl
 QbqA+tlGsI4wSYRgOn6l8VxzE7N/YEYBGjAeBOBRqNTMEtveyvfhKGpnNE7qn8WB1KNzHt67m
 4yK4qqmxwj0rJ9ueDj93sQlosZou5JGqhTcZrn2ZhPyztSLaq7b7E9/X6ElUvULNDgToIeArY
 Ot8HspywBuiaaSlYYJPv1ZsMur5t+FSceowryDPWX7n03gS4D6Br6Pe11wUFFI3cnjXnZwLKp
 frQ1lVHsihoPTd3BD7K0G//eRbRnwYrgR7Ux4MAEha3T8rrQRwlU/MxVlImf8KRcfHA25GhcU
 oyDxfB5P2BOh2tnFc3zulbFNfCMIVYNUUh6zCIqgBsELT16GcqLzjyckyF5e0jIk6ZGCM/s5i
 XWL+8D0RitVSwdsTvx0Lv6DnKNi0WYFD59b9ToMt9g7WZ6j1zBa7Q+KYWSN1fASbSxDtosG6d
 X/OKmlizIbNQ6JEN4q6rK+tjv/BX5/3aLT8NUiMst9Undr9vyN9zb4RcNYAS36I2XyhcyohKH
 MfUvRDH9H3yGdz2Ua5X96CFAzPpdhruMbsKcZXjHazggJgJ/bc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-404204253-1509712606=:6482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Fri, 3 Nov 2017, SZEDER G=C3=A1bor wrote:

> Commit ce9b8aab5 (setup_git_directory_1(): avoid changing global state,
> 2017-03-13) changed how the git directory is discovered, and as a side
> effect when the discovery reaches the root directory Git tries to
> access paths like '//HEAD' and '//objects'.  This interacts badly with
> Cygwin, which interprets it as a UNC file share, and so demand-loads a
> bunch of extra DLLs and attempts to resolve/contact the server named
> HEAD.  This obviously doesn't work too well, especially over a slow
> network link.
>=20
> Special case the root directory in is_git_directory() to prevent
> accessing paths with leading double slashes.

I would rather not special-case the (Unix) root directory. The underlying
problem, as Peff pointed out, is that an extra slash is appended if the
directory. And as `is_git_directory()` is not marked as static, we must
assume that there are other callers that may pass in directory paths
ending in a slash already.

Ciao,
Dscho
--8323329-404204253-1509712606=:6482--
