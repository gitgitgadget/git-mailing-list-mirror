Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CDA21F424
	for <e@80x24.org>; Wed,  9 May 2018 21:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965214AbeEIVnk (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 17:43:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:38105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935325AbeEIVnj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 17:43:39 -0400
Received: from [10.92.140.17] ([167.220.148.17]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOjMY-1fChO64A8U-0066tI; Wed, 09
 May 2018 23:43:33 +0200
Date:   Wed, 9 May 2018 17:43:30 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-export: avoid NULL pointer arithmetic
In-Reply-To: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de>
Message-ID: <nycvar.QRO.7.76.6.1805091743080.77@tvgsbejvaqbjf.bet>
References: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-159547254-1525902213=:77"
X-Provags-ID: V03:K1:7RDmjw8lIeVVfl1w+4jANJ5G9qrxpAzAJW+KUOr5NjfXTcGe5vu
 6Lu6TxWn9+OWutnzt7IOeI2qsHknKjdR1XI2uErqiFJwUCVhinAi6fglZS/ZT8ZCjZUEMt0
 mgiTEV4O5g2jVdNNCljkJDpkI08Ww5S3/GN6vxqZ34A9lOOEbyQq/j5uOqNQuZLbJJL4Rj3
 SfXVZS1JDcU+H07BE8x0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9vU5BnMQr7c=:m3U+MAafSADwqg+4GAxM2P
 FSfqP0APJBxTdTmLP1216rvVz2KoM1YKo+hFw4t3/U/2tkolvszH88OcgKh4ZZPqBLWsSthab
 8HrF0WuZS3ZD2F4xVMtYCn7TjaPbGYN+00hAOorBlrDiyfawl4+82b/tn39SNpFj0yBtWivbv
 OgU5bsOjOEddTbXPI3UY1uTGLmLjKrvVzJyVj72vN+H3d+ZEQ7xIYkl3CEs9tD9HVB3le+l0f
 vntYKeqJq8M/JS4ey3gVmMn3LxMNOnXqskm0di7PocAJTavT+JqXXHlwD+GGs6mVUibuArWZM
 qQEWGFOBLX5XEjk/CvVhAiuEsP9RfkDzr7GGt5iLLLY3B+d/Em7WQFfpMurOwlpOhL1oU1M1f
 uiZnUxILz/mo6MJYDfF15LG4dfy6eBZnNM4ozw+R3dLnurJKV7E/iPZqp3G0uRPzEp4nMVZPI
 pU5l+FmItILReSVWHOjtQ+pv3voETzES3ImOLJSuYGJeaSqqkihoEWvi5oV30I/4aLxXxQMGc
 BH9WS9J7zuwY2ZI6cOE+1wUnw59PT6wzgIbTjOOns50i3jyCbTI9Y2hcWJSv3BzSKQY8RB0LH
 rYVX5AFWnp3IB159N3gtK5o1WIPEKKS5I98jJWq+Rleh+7zf1+rbB/yH9/NKPqyNmuT8rqmZf
 w9dT79UB5TTkBnAdY/V3OveRAKhQe0I9FMzravv66sB8NaYwcXgHjQEonjlwe2jKltx5jh+ly
 ZSha0ofuFdKuhWV/cp/xl6dPcwixXxX4wLmLs4lJEwgJUuHMEK2uZVmw5dGFRoBXRfS1/iP2/
 FE+iUXp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-159547254-1525902213=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Wed, 9 May 2018, Ren=C3=A9 Scharfe wrote:

> Clang 6 reports the following warning, which is turned into an error in a
> DEVELOPER build:
>=20
> =09builtin/fast-export.c:162:28: error: performing pointer arithmetic on =
a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
> =09=09return ((uint32_t *)NULL) + mark;
> =09=09       ~~~~~~~~~~~~~~~~~~ ^
> =091 error generated.
>=20
> The compiler is correct, and the error message speaks for itself.  There
> is no need for any undefined operation -- just cast mark to void * or
> uint32_t after an intermediate cast to uintptr_t.  That encodes the
> integer value into a pointer and later decodes it as intended.
>=20
> While at it remove an outdated comment -- intptr_t has been used since
> ffe659f94d (parse-options: make some arguments optional, add callbacks),
> committed in October 2007.

ACK.

Thanks,
Dscho
--8323328-159547254-1525902213=:77--
