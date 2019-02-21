Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A092B1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 23:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfBUXzm (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 18:55:42 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34980 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbfBUXzm (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Feb 2019 18:55:42 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A25ED60489;
        Thu, 21 Feb 2019 23:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550793340;
        bh=MdLaOVGUJPJnATdEkBem89+o6UefXqJ5oWPZZw+PzC8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CfM65odq0oOp8xwg6p8qbcJgcpHZw7jJ4a1m9PZWnGt2cdW5HDF9M8F170W+FSonD
         h9em+tmVKRFc38npAYD5/cnYZbdKrYdgKCTIyqdq+nPTb0byifgIaD6VGzNC6P2nj4
         7hIiVtuu5Q+mOM3hGw2W0ECQXPFuUIKsPLIjqOcl1szhiH6z4fKwN9s+8+4kSdHrUo
         d60orX0Ks/6IxmkQPk+llPOo5ZJcq+lHY64YIcZ/pZNjILHc7G1+0GFAT9sDwo/SRJ
         3B6ABGLTCSBz8WmmwdonPOxvpoGJwA0wUNtEWjqqjS4/VoVd+oMtICLgOXsiUJLO+x
         YylRxpx2Fpb32rzTo1vr69MaqEbvf6To3tvtS9VeRp8DDJMpgei911U+hyylNCrxqi
         PNSYhV14of1dpJ4lTVQVUzFig/yTX+rbldxWOQ1cLFt2uh2tDLzVNXPKU5/TtGgZxM
         PO6jDTIwSlg5Wo/ugb5PTlRsoQ/XusmYV276c+YCXrZA15i++J/
Date:   Thu, 21 Feb 2019 23:55:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Git v2.21.0-rc2
Message-ID: <20190221235534.GC488342@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
 <012601d4c8b5$54f1b730$fed52590$@nexbridge.com>
 <xmqqftsiw8l8.fsf@gitster-ct.c.googlers.com>
 <CACsJy8D=-+TqZSf1oyTJs_O+=KAV66OE_As5cTKXxHoXAhzkGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <CACsJy8D=-+TqZSf1oyTJs_O+=KAV66OE_As5cTKXxHoXAhzkGw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2019 at 08:10:00PM +0700, Duy Nguyen wrote:
> On Thu, Feb 21, 2019 at 2:41 AM Junio C Hamano <gitster@pobox.com> wrote:
> > Another mention of /dev/zero appears in t/helper/test-sha1.sh (not
> > to be confused with t/helper/test-sha1.c).  This seems to be run
> > only with an explicit "make -C t/helper check-sha1" request, so
> > perhaps nobody on your platform ran it to get hit by it.  I wonder
> > if anybody runs this on any platform, to be honest, though.
>=20
> I vaguely remember Brian added something to test SHA-512 performance
> but I can't find it. Maybe when he adds something (if it's not there
> already) we can retire this script, or update it to check sha-512 too.

Doing git blame on that script seems to show that it was written mostly
by Junio. I think you may be thinking of test-tool hash-speed, which can
be used to benchmark a hash implementation. That's what I used for most
of my testing.

We may not need both anymore, though.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxvOnYACgkQv1NdgR9S
9osU9hAAlmkjtTYMooKaSmKD246Cc6Zi/Ph8+cnUw7FzvVTdG2v3ohF0UP1iyBTc
/paZKAy4dwNY1dKHG4DyAeFEWd/UM9jjoZBIPYSALIUOt3+CEXAph+b2wu1+0BcJ
1McyER2oUnmKJEpZBvOyPl7KN/jzDcbdfYC3AAARIyxN3Ew1lPvqLNS5LG5olv/u
U7Otqf44Xa/A5w6Zx04azAznPVOxiNrp3vz3RAorZlERQjO0J4NPgtvyLBHZ2i2s
tde1SsZfuSo/oHBhqws/60xIx4Efng1y4fkp+iXzTG5QMsIVufYhIdUB37p4ECxZ
TmMElOGzcc9E4xxneS94DwTBE9lO/WsQ4NmMsujXJXo9To29/GZaqjf+I2BQZaCx
IWdkimGhbTg6t1PXq47fkbam00dqwi0RX6fRreKPb7CWKof4S5xQc/0REE0felFt
39ein/hIGyHAk/pT7RsXhS0q4uou2Mzb6lU6Im7UaeueokOLe1Rur+m/f7j5SCII
UiJr+E6PGa+BDUksvPWDJ79qYGR/Z8h5P3XYnmh5LMb1FxGnRfFXA9AK3oIZy8fV
GjJGcuFf+o0zkHG+LULDmzcFgwUc1nGOgMz/6zACtyq1D6v23TDOu7+eC2Ilrh+b
WAKTyUg3yawJ8kqK1sf9cTY0zzaKonW90bbai99rJ1+DAF81wO8=
=NhzF
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
