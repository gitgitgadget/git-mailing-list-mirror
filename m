Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909081F829
	for <e@80x24.org>; Wed,  3 May 2017 15:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbdECPCz (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 11:02:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:49912 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751511AbdECPCx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 11:02:53 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVeCF-1dZnYv1sRb-00YzPM; Wed, 03
 May 2017 17:02:38 +0200
Date:   Wed, 3 May 2017 17:02:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 02/21] clone: use xfopen() instead of fopen()
In-Reply-To: <20170503101706.9223-3-pclouds@gmail.com>
Message-ID: <alpine.DEB.2.20.1705031701120.3480@virtualbox>
References: <20170420112609.26089-1-pclouds@gmail.com> <20170503101706.9223-1-pclouds@gmail.com> <20170503101706.9223-3-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1926721150-1493823758=:3480"
X-Provags-ID: V03:K0:u+hSQ2xGwLgCwV98mYDN7f15r4Y9bL5GMF0sOXEYvwGkXS5K8aA
 +f4IFYZFQeflcV7lSa0PoK4Ml56kX9t2dmYpmsT30Dic4bj7LRBhRnNLsRknH3MQkdKNc10
 ywTj+YcHPhzCteFCpVquHvCYPWccXEBwMD5peQjBlOTE7FS8rko5p0XycKAs5x2Wi9+hVOe
 SrCSIKRujY9i8K76QjSyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UelRLFRTNPA=:6W184NxMDO3/0DhdPMfKaG
 GXehYXdC593aoYeaUm6n0Xw/VkFC2jI16jX5QwfDNGmsJsSUZxFrPy1DEhCuQ2729l7+NoFO/
 wQD0PxwsPepwjyNtvCniYegYgvaGmq3/d/RM1S94NnMCrJ3JbmXsZF0+qqb73/u6Pdo7gtnR+
 LOeSH/G+cM41sZtyl8immCDz6U7eMjE6uKS9MQzb7NZxKWjRJ4ivagkegw0rOJd1Noizk9WjJ
 fnTKp7OMCxDfPvhLYmWVZKYJIIuDx7nrww6FEWVnWS/IpA6CF9Ctq2ojGHeCmjbA6GNu+6Lz7
 6zbb4sYf3tgbd6JiHJ5DEOJ1WPSD/c6PS2JXNKm8I9MXeSqABq6tknGIjrkEPG5XL+IP8RQUt
 NNK6n3YjJONo+s4qjSuO0vmMPTkLKct3abRA1FTSoBV3JdaZisMqnEnCgnfDvWRVbenyjdMY1
 5e2ayMg72hjqSmmE+bz+MsUZV/24Jwwz69I2pk5ri76x29qtHtI0QJYxAdSmtA9QG/HKKH69w
 rx7bTysCFGbkmJVPQBGmDnvuBm1kwJh2zkihsNvRPiecINsyZPXJgQnfJlv/+eevxiiE3wTnG
 ANa3NVk/V99ZG/Ib4sW55BGJh8UssozdggMc0JqWwofMEj/HtFkhf1V2EDl6ZF8oqv9Lyj4bV
 ylCV6Sd0BD1zvCBE/QnyLlbSU6V5QV1QYRoZYovIdeo/Nq6TUKgO2UaThjHta5v3yAT4daSlU
 AKg+3FSUfAerrqlL28ZS2xQz1+f4MLfHbZisDTxlEFy1GXDFokBebAtFnPAINQAT3+2PltHML
 UhelL/v
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1926721150-1493823758=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Wed, 3 May 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> This code uses the result FILE pointer right away without the NULL
> check. Let's use xfopen() and die if we could not open the file. That's
> still better than crashing,
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

While funny to read, maybe it would be better to spell it out clearly:

=09copy_alternates() called fopen() without handling errors. By
=09switching to xfopen(), this bug is fixed.

Ciao,
Dscho
--8323329-1926721150-1493823758=:3480--
