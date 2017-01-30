Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 305901FAD5
	for <e@80x24.org>; Mon, 30 Jan 2017 13:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbdA3NCx (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 08:02:53 -0500
Received: from mout.gmx.net ([212.227.17.21]:60108 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753238AbdA3NBl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 08:01:41 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LejNC-1c8QDM1OYg-00qVIM; Mon, 30
 Jan 2017 14:01:14 +0100
Date:   Mon, 30 Jan 2017 14:01:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] checkout: convert post_checkout_hook() to struct
 object_id
In-Reply-To: <b30e5d34-436a-af5f-dbad-b1df464bf303@web.de>
Message-ID: <alpine.DEB.2.20.1701301359500.3469@virtualbox>
References: <b30e5d34-436a-af5f-dbad-b1df464bf303@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1913706495-1485781228=:3469"
Content-ID: <alpine.DEB.2.20.1701301401110.3469@virtualbox>
X-Provags-ID: V03:K0:wk6EX3lPPgtteQzpkKcFQLulhw2UDVFes7kGYgObHD/Eagea1yF
 XpSlWRXnBcCJv6p+KcOIg9uA5GIc8enp+BWs3hIh3Xo77wPjsuT6GsLoFB8HdLV3uUQWpp/
 pboLhkjDnA6Pbhj7jPROt0cCmY+ppbgfshaWya9zVlZlSCjP0xgHCdV/FY4SWw465tjhT3U
 9mGSxexHCX4ZaXun3LucQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZgeUeTs7P7Q=:DFfrhXF5tfYSxM30h3ZCME
 bApkresl+vwljN6OtpD7q2XnwJA/S4TDdgxI/GpNgGmLn9M1AYnAPL3IQBqnZwwsDUAtdzDmU
 sXwWSVekqD5cvP+W8JjMnEM9GtKCKWPJHAe2i4uSkoy9ys1IMtZXPe21op4Y2Ey8SE13yKd6H
 ne9QmOsUZ9yGL0T/s6RDb2kw5OxGx01toQ8a9bKBOgXWreUoBX+szUfEHJREUw59z10z5twmO
 HaQLAb+N3qcIdnpvJkO+9xlLLeRZ5gyUW+CjE7sxgTv9hRP0FK3vL7lwzglFUS8+Qvmyu4650
 Xw/iXonIBFahLyXInpiSMkhjFV+b7x+BmxAset9cEhJtjBd7O9nokVSNcYKB/fI3sDzdfxmgm
 M4x3Oc0eoBKn4hdTgivuEPx/aJNw5tDKQTrEYDmWdGuiAxqGFXwDircib8LxvXh07qsLbEOHU
 IzoF3ABU3BoEzrhbPUcA9zxFm9iskgIXIlU/pLTOYn1PgaufK00HqYc0tl/frI7d4owDi09kU
 hopAWBhXt2q/lSM+G1VhHrdavQFOsxeyZB3EQJQaZAZ4fjuGwu3WgxGCiizpm2ArRQdv/GZND
 ypYm1PMsV0226bM6rcz7tB0nOytMF7PzUMHSUHM24pEbCT2+eo3KxZITLuhPro9Cvae+t6WYn
 qVFSEgHToZ9MPbNG4Jz+hJmybtrcSoe9ykftF9YwscA3jOwlRE2T4oomWTrbg64N8X5aIy5VG
 o4cnpf0H8XP4NaP+ir6+NAGwclT38fJXVPHu1bROMVCmMq3QmSssRlL9mTdS3l92hAncLZt/O
 FfFNYVNzEZn+tNXhBgxGWEaodIOLHqdg7ZeaAUqCDVO57mism1YV9RQ6Ypliib80xbURGR336
 beoQEsjHx2IIo6uuzEB/j0kcqVSmoG2G521CwCgPzLx92/WCN72oSRfx+JQa3qGb2pgxH5pHK
 7sVVuoy3Me3dAe1/9jB5u3lNsiZhbENXlXTkvIMRJqJpELpqBYG/oc+V0bmLJ7/iyy6rHfbh1
 5oBtai1UBSHqufaJXiFj6J2yiLD9ocpeU9h8QgJ6JKyhkhAX2V8pvedCUA7kjtmi0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1913706495-1485781228=:3469
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.20.1701301401111.3469@virtualbox>

Hi Ren=C3=A9,

On Sat, 28 Jan 2017, Ren=C3=A9 Scharfe wrote:

> Signed-off-by: Rene Scharfe <l.s.r@web.de>

These three SHA-1 -> OID patches all appear correct to me.

Ciao,
Dscho
--8323329-1913706495-1485781228=:3469--
