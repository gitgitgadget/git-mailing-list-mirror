Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDD171F461
	for <e@80x24.org>; Tue, 14 May 2019 02:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfENCEW (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 22:04:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36512 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbfENCEW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 May 2019 22:04:22 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 23AE460443;
        Tue, 14 May 2019 02:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557799461;
        bh=63IfnK+hlqw5xx/31KEZMbRKev/JPlHmrP1FGpgs/No=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=aqc+PfBqw7cPRsPtQnWeKF6l0FYFzTfG+hPlXHy9a6Pcn/yH2kgIIIpJvUFgsBI3E
         iXBPxTT11RYBgTjFxR4LkF14UlG7jIQ7qnRuPs2NLjzFdjiNdTF/QIexhRdKGSjmC+
         fSnE51JivKB5QebpJwx1TTVGkdocYYTTPJyshNPuok+bSirf0mT44GLo5ghRxWLjaI
         Mqxx5D8kmUKIlGkz+FadPA3Y5/cVpmEjyZNYlWV3FjIwcBA+zFCBB11jfHWZKdszom
         v8QGjWlluO0FiXgooZsWtEV1lvIAOC5KRyKwUlUEIxKdDn9oCUk9B+3ycD8J/aZcJc
         15J0cREzBP93ycf03g2nE9U1tNW6PBm4XvgUinhJGK4NlURZX7V7xrHBwN7WwKYWWO
         +sNuha8wbeBtsInwSZ4KfdLsaJ0iw50/coyvA2/Im3+0BSbN2tCoJX2/ZK5QMqsa25
         qSYaIa2E0iXQFQT0Rkt7w/vmQh0XGFYE8u+C1BOVhEKhr8YMVOf
Date:   Tue, 14 May 2019 02:04:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>,
        Git <git@vger.kernel.org>, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] status: add an empty line when there is no hint
Message-ID: <20190514020416.GH7458@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>,
        Git <git@vger.kernel.org>, phillip.wood@dunelm.org.uk
References: <20190430060210.79610-1-johnlinp@gmail.com>
 <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
 <20190501234512.GD202237@genre.crustytoothpaste.net>
 <CAKO26MvXmOMHgqWSoVrmdwyDFyqDrChkMOHq6iuJAX8pvHzZoA@mail.gmail.com>
 <20190502231537.GE202237@genre.crustytoothpaste.net>
 <CAKO26MuisScMPp0SxRo896y7waEgR3HjU3A8+VM73eS0xgU8RQ@mail.gmail.com>
 <CAKO26Mtn+KDnkHWsKf8mAyTmeaCYK0gjdNad5bxJe-qxjKs=xw@mail.gmail.com>
 <xmqqh89ydhqu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9jHkwA2TBA/ec6v+"
Content-Disposition: inline
In-Reply-To: <xmqqh89ydhqu.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9jHkwA2TBA/ec6v+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2019 at 02:51:37PM +0900, Junio C Hamano wrote:
> If the difference between "status" and "commit" bothers you so much,
> i.e.
>=20
>     When typing "git status", there is an empty line between the
>     "Changes not staged for commit:" block and the list of changed
>     files. However, when typing "git commit" with no files added,
>     there are no empty lines between them.
>=20
> it may not be a bad idea to try making them consistent by removing
> the blank line that is given after the advice messages, perhaps?

I personally think the extra blank line aids readability, especially on
screens with small text, but I'll defer to your decision on this.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--9jHkwA2TBA/ec6v+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzaIiAACgkQv1NdgR9S
9oui1g//V9B5sEOLpzaCLH6Mfe0T9mD0sdKgF9IKDU2VpH6h2X22MXK2uXWtnued
Dyt1v6I1uZ2fTYQj0tOoqOzxFN8QB5CDcvM6EpUasig5PZKEDN3qiDq7HSWRvwvp
npP/R4w+58HYLRDvQJbcoiiJyUl17/oVtiMznWXXkQManqtbEwkMq3v+Sbtrmbmn
ElmripIZ4WO6yzleiVlMzY5rCjtO2tjTcwYHOki2AONbkPR9LqEhpuXG3GCSPDEK
/tWOPkEOYx/kaM/i3/KJeNxKSryX96StZPyvUdZumyy4n4SOQWQxQ1qAj1XsinBr
5b/9p3Dn0tB+Ku4H3/Jr6RLGYbyEKjjvPiJdUg+A8DKyVLSAo+lM3v0anNoB/vA8
ZdeN0KZ2OMGcOigkAv8tcBeOJrtJeN7+v5NS5JBEL2302aYE6J71st3oVS11AQhM
Uc84ttwLfmddXUp0IYs+7JK3CC/C1HSLOHtXLSd3Bm+OMDS4q7rsN/kFODrjT4Dy
8kaVJqEUx62YZdpSgzmUQ2/jlI70SaQhUqVBPKkiL7pwPieZNjya0J4i6MSlDiDq
XDYkbDh+ILJvapAR9kavJZOcNWS67o2+cUN6LBVlnIUrKQNlFHTM1sBupRA2SRXb
OVZkmXgBv6z9MnZAeCRZySgdL/duBZ9gVdw5Q0TyGsWNt34tykE=
=w1p4
-----END PGP SIGNATURE-----

--9jHkwA2TBA/ec6v+--
