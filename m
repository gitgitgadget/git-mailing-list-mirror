Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92BB41F829
	for <e@80x24.org>; Wed,  3 May 2017 15:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbdECPMQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 11:12:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:58123 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751781AbdECPMO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 11:12:14 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LyVpm-1eBK9j36ve-015qvJ; Wed, 03
 May 2017 17:12:05 +0200
Date:   Wed, 3 May 2017 17:12:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 08/21] bisect: report on fopen() error
In-Reply-To: <20170503101706.9223-9-pclouds@gmail.com>
Message-ID: <alpine.DEB.2.20.1705031710500.3480@virtualbox>
References: <20170420112609.26089-1-pclouds@gmail.com> <20170503101706.9223-1-pclouds@gmail.com> <20170503101706.9223-9-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1174249189-1493824325=:3480"
X-Provags-ID: V03:K0:CZ9Kx2CnV/qs7y9bVIEq7zEMZoXFfhHZPvkYZtwKQ0JJVqLfVIV
 GhooYa228Iw++t4AeTMoyUWJsYtUGbxmIGScyLA6QUfoh1EI4QWAHqNsiEbLkQyD5kDoQBD
 xROnkar1CF6+5KuEPc3mBwJuF8Gz8hapgBYIakxRwax2DYxvys8P1ljTdNNJnFOwpBY7St3
 cuYfI78rZzneAYJV/wrOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SIdW5KgdTXc=:Kvkgd2qCS8Px5F/sXe/oW7
 hyk21kQlrKUt0UUL5QcSqd1etBdfjqhU9anLA605OmMq/qYmWAwqau6zhw0aah6T7CGNRhPNN
 cJwVUlqK9qZY/UNyrOsR994VLZmK80qVDO1BLX/Uayl55d0Z52tJnYrRg3UVtZGW0PidC6RS8
 5QcVex8PbGtUzOQTksHY0/ztNiNueQ89FaE+UIhpKLVnWXzI96zQ0kD/pHiuxleCxtdOdmCi9
 k7OkPBKpZ3xTD2n6HdgTnbR18U2OMZeukKLgrKYDF1yf3gNMJyz9REU0snLW7o0OgXvC0xCyG
 Ui99HUsEeqkIJwasV/+LkzcLCU2hRE7Sil4SzQm38XEeVwPlmgtnA+p/zGgXHnZ4kLyOaq68v
 PPnL0fke8YUrWiHQ4uqtXLgEnZ7CFrg3kHi087lJX83TQ6Qa9y9k6PLunBGhQqeZu8MGd0VhH
 NXpMJxS4jQMhXcKZDcOyuntSCt4mZk1+xL9JymTTa3eIeU/4g8MuEEOP4ngXDQ3K0KAqnJlrh
 kkEwu6RiPY7DRi/3/RTNppq3UiPXrCoj7vnllxwQFILuqLrErr3XqTJpLn2BHzhFft6buWI5W
 +l78L0v1dzQA0kcq7O8uVrMSwsPyfAlLNtB7CqKOQjshpBzQr1WNTpMdZh162HRdZsfoY4FUr
 F8AxUx1xxaYkoXKrfWTnRHmERZnH+mljSVxzY+7qlbCy4SBGfrYDFsJxGpQ1QlJ3vu3V+ejTT
 oBczZ7LdVdqjoKeXJrDu/sL9feOPKGQkU7TdeHQ3mppaPRNKHWCKG0st1uppPNmRB9J+dloU4
 6mrmNVH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1174249189-1493824325=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Wed, 3 May 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> The main thing to catch here is when fopen() is called on a
> directory. It's safe even without this change because a few lines
> earlier we do check if "filename" is a regular file.
>=20
> Regardless, let's stay on the safe side in case somebody changes those
> lines. Unconditionally printing to stderr by warn_on_inaccessible()
> should be fine, because the caller does unconditional fprintf(stderr,
> too, no checking for quiet option or anything.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

I appreciate that you mention specifically the use case that triggered my
complaint that in turn prodded you into starting working on this.

However, I think this should be a mere side note in a single commit that
introduces and uses fopen_or_warn().

Ciao,
Dscho
--8323329-1174249189-1493824325=:3480--
