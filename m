Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A7C1FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 15:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932375AbdA3Pjz (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 10:39:55 -0500
Received: from mout.gmx.net ([212.227.17.21]:62129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932342AbdA3Pjw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 10:39:52 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0La2Xx-1c4PfV1I1l-00locJ; Mon, 30
 Jan 2017 16:39:40 +0100
Date:   Mon, 30 Jan 2017 16:39:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] add SWAP macro
In-Reply-To: <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
Message-ID: <alpine.DEB.2.20.1701301637570.3469@virtualbox>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de> <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1182186010-1485790780=:3469"
X-Provags-ID: V03:K0:LbK9DoQciK1AoZ2ge8+oVBv1D2J+lz20pDk4yTGzP74lGawuhGQ
 /l7dl/WfHdJZgUI2E81RN+D6iWaONPmTqAOrmMQ/kqTU0C6AeD2gpCk2No86kb+IhvQVtwS
 VOmWsUD6gjZGrduuA9ioZGpi3XnyBU18T+jHVoFmvmpdvPceyclQKQn9jrvNhLmsTawEB/m
 bZSpttNsphUMueVviSvFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ps+MS2wYocw=:7uUxwPK3y8+LLIMb12mHd9
 rtEAPqnH0T52PY3wx03I+245XYo8zuQUpGOI8cRBJMd3jVtLLClSsXZR5JEiRPc74AIQ2jyY1
 svMKU5byvu0+eXED97uQ26ggYZLXuWoAatasWFOFXdWTaopTgAlfe9Z98MjFSv5mpXr/XHBiX
 yTOCkyX0dQGn08yUTJjYrnv2xOre8Rh+hXk+HyNUpAE0ZkMIIIfFsXt4vC0A6qyDY4ubw2dyU
 ViOVKj1Yq80pKopaiWF5GW8wzqd0XnvTQEOJRcM18U0+wA2ySCeR7ouubZamiBDQJtZZcKLn6
 8INGalREYLC0rmUOwy9GlFyk2ZPYrRkqBPhaq7RQLizzaQAEK9vgm716kLoc6vXhQM6kCwJOb
 qyD1NxBz582u38h9EwYfjDSIRbsZNuR4PXtCKZmqcbsB8cuAOA7adwic0ZKCdTkGZFA/KOksr
 jaAeH1P82b56cbFmGr1SdQGC0iQ7s2p0eB/BX66xuiNDFvhvS6i0dt48I+V2zzZcJgNsHvJB7
 V29fyKimdub0bn/YxwFqGKlkuEKG3M/IdbsmZ0HoD61owhiTtFAZm5J9TxyWkrlhbBU8V9RV7
 TWiaITCMCzEZsh2ShZ067iq477pr/uonZjxaFy4/n0m+8mJ7yUAyiK+rRGZSTECdAYrcWfI1L
 6ie8HQvgNLIR3xpjZEPlAu6dQyHu9cTMk12QjQnIOqrxS8gheethz1MTCbI3+TCw27qPsqHvV
 eeYdfBMfLXbYUtnEB93krCe8GIjE6X1V2vS2HFPtE7F1iN15uEbExN7hSHbzxMEFh+/qw0+P0
 UDovuS6DTwS4so6z+bIUJmNjMy7cOkAtUYl32Ll3bdpISMoWbXjQqG/6nk79F6s1x/27eyffB
 9+HGZjlDrA5pniB/wAaImBIY2VdUKiUdhEeDbysOZnK1yNM6rVcIqdGQo5u3dH30H5QWXN4Af
 3XKyHOicL3sqLCLjbyKNThCt2QcuR8GC5Rg6fQJGAVu/sKMEfGFe4xCMFqvDsOV/adKPFi1Fs
 i4tPEgl9/qJfo/3RsFbKUra8POkymy9rtfZetEqYBamdR9nV8LT8dtkasiIY3h69mw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1182186010-1485790780=:3469
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Sat, 28 Jan 2017, Ren=C3=A9 Scharfe wrote:

> Add a macro for exchanging the values of variables.  It allows users to
> avoid repetition and takes care of the temporary variable for them.  It
> also makes sure that the storage sizes of its two parameters are the
> same.  Its memcpy(1) calls are optimized away by current compilers.

How certain are we that "current compilers" optimize that away? And about
which "current compilers" are we talking? GCC? GCC 6? Clang? Clang 3?
Clang 3.8.*? Visual C 2005+?

Ciao,
Dscho
--8323329-1182186010-1485790780=:3469--
