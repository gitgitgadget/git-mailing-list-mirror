Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B73D320196
	for <e@80x24.org>; Thu, 14 Jul 2016 15:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbcGNPxS (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 11:53:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:56220 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbcGNPxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 11:53:16 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M5cMq-1bCeDb3mTg-00xYrn; Thu, 14 Jul 2016 17:53:08
 +0200
Date:	Thu, 14 Jul 2016 17:53:06 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, sschuberth@gmail.com,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4] config: add conditional include
In-Reply-To: <20160714153311.2166-1-pclouds@gmail.com>
Message-ID: <alpine.DEB.2.20.1607141750190.6426@virtualbox>
References: <20160712164216.24072-1-pclouds@gmail.com> <20160714153311.2166-1-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2099261904-1468511587=:6426"
X-Provags-ID: V03:K0:2PB965R6EqqIb/sPJX4vSGkHbmSAWvf+4BRqD0qKzNUaWzjgwa5
 Sp/BOiseksC3I4WortITwWMmgkTpO21SgXi8lOTCH5eZRp7eiU2Qrpz5Gh2DmIra4D4MHM3
 eE3RIwnc6lhFCkHKJbWDa6nF7eTm2slmy5iND7bCIY1eQw4EMe6zf82z8/fWQB1aMjXdmBY
 /31l688+CRo3MT/ysOxYA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:xuBlyKsGmKQ=:y0wSE8bhZwELzfNG1FnZvN
 dUZt5EAFjxgmjDbcJC2faTpV8SBD97C35LcSA0/6vXaDkGxsahIXxzqmuZOk7em0qBmEPCcr2
 vsRYwkrzWCpSvwwsgpaLCxexs352NWvalHnNkqwUxr5qSXqv3S8aOfcon7TUdTOEhAz6CkHDt
 uHwq7tJKDzQX2QnGKbJS+MUDdy86hVr+mWFZ7oZ83QB+T/RsaL87U2i+HXuMe4r90I8aBGx7T
 OrbtX34HxnNDX6YorWNal6Jp59M4j4/azaqdG6DgCAJrRzfzONKOUa+uo9kd24Vc9ZklCNAcL
 hCoJgGzWAX6BedXXFuIarKnxuw5AYYMoIITt80JHtzhiioB1YCGUTuD0NKeBhTReQXhU6dB9B
 T9f0BnZlV3LS7bBSvy58qo1aQA3kZ3LogQEpCHN2vETH+NyFkjUVCOaoKNIpbKplX6I3VJAa3
 jCipXUYHDVz+jycG2jg1voDCyEKV8OpT7v1n3A5+0iFX7r6m+GQwnXkxwOYPvi0tFPNy0KYFq
 EnhLOU8aIqvEEgmMQxqFCVnlAnLpiN6pwBsdn2/ZWYKOsl3rkpeWWIYuX4lE9z1HCw2LyLlFr
 h68eCGatR886jnSmrjSdUI73BHl6ilGkUXvDBbyGyh1Ld4hFVO5cENEVPh64l67S1XHD+m4Qj
 n/ns2i4J/w1m/DwXMdAHm9PwR/NwlS1qNV1sRoWHJbSavHjbZCdR8oxlEKwJmnl842FpqCbmn
 2zr0UF2+3+NBuSxB/raJ/P0HgVXmklTpqsUEQoEkMYM2ombgy7YVMRoQ0NsrBxp5ygptKt0uq
 +dSEODn
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2099261904-1468511587=:6426
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Thu, 14 Jul 2016, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Helped-by: Jeff King <peff@peff.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

This commit message is quite a bit short on details. I still fail to see
what use case this would benefit, and I already start to suspect that the
change would open a can of worms that might not be desired.

> +=09; include if $GIT_DIR is /path/to/foo/.git
> +=09[include "gitdir:/path/to/foo/.git"]
> +=09=09path =3D /path/to/foo.inc

I find this way to specify a conditional unintuitive. Reading
"gitdir:/path/to/foo/.git" suggests to me that the Git dir is *re-set*,
not that this is a condition.

I would have expected something like

=09[include "if-gitdir-is:/path/to/foo/.git"]

instead.

Ciao,
Dscho
--8323329-2099261904-1468511587=:6426--
