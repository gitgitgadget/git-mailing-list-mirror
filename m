Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A47761F404
	for <e@80x24.org>; Fri, 24 Aug 2018 04:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeHXIUY (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 04:20:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60086 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbeHXIUX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Aug 2018 04:20:23 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6F1396073C;
        Fri, 24 Aug 2018 04:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535086046;
        bh=BPYzLFq3wb7JEzhrLX4JjhS+igijb2h1q+8vSnTaDCo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zhF4YEmaxwVLg5O/TtC65mtpfn4178Q7n6BwMt6SKFGIbBIuHwsGn55FqOk8jc2g0
         oMhcfYDHAAQ0v+NntIlx6N4Z2Z37+sEzYION691/EdILD963d40TDiF2ecw4iAJJ0R
         lQ3HynZYMPvB5ap17xmGj/6AkslcQ0dDu13SDX9F3kMOecAjvPNecqSDd5CB07tSdy
         AhR3hgsVW3fJxGj5yuToE9iDyXqUSHF9xc+ORiaW2s6ZO0HogaHR8DTB7iSUsUzj3Y
         mrcocVM8hM9Lj85GyCj482mGWbUXHFKeENOY5e/wqGb9yJnf4aT4tkdl6XnSLXBox7
         BxzzvHhSC/AfnKU00NnpgjtBzymplSs/8dOn00T6ZpZob5MKXhJcolZUk/TOofz5id
         zfzIOYd37+d7Oy3YmKm6yvsjkdvNR31xdVn2iVkUb98QkUddF07Pc0KnFR1iv/q3as
         pzK0xpY3Mm+Spcujs1Yu48Q3WXVFqoOk8A9PyEASYBKEZMyJV7R
Date:   Fri, 24 Aug 2018 04:47:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Questions about the hash function transition
Message-ID: <20180824044720.GG535143@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
References: <878t4xfaes.fsf@evledraar.gmail.com>
 <20180824014007.GF535143@genre.crustytoothpaste.net>
 <20180824015438.GF99542@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z0mFw3+mXTC5ycVe"
Content-Disposition: inline
In-Reply-To: <20180824015438.GF99542@aiede.svl.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Z0mFw3+mXTC5ycVe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2018 at 06:54:38PM -0700, Jonathan Nieder wrote:
> brian m. carlson wrote:
> > I realize I have a lot of code that has not been sent in yet, but I also
> > tend to build on my own series a lot, and I probably need to be a bit
> > better about extracting reusable pieces that can go in independently
> > without waiting for the previous series to land.
>=20
> For what it's worth, even if it all is in one commit with message
> "wip", I think I'd benefit from being able to see this code.  I can
> promise not to critique it, and to only treat it as a rough
> premonition of the future.

It's in my object-id-partn branch at https://github.com/bk2204/git.

It doesn't do protocol v2 yet, but it does do protocol v1.  It is, of
course, subject to change (especially naming) depending on what the list
thinks is most appropriate.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Z0mFw3+mXTC5ycVe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlt/jdgACgkQv1NdgR9S
9otcsw/+MIJdGgFXS5BprKUAL1yFipE28xnpeKxO2oSvZ/bMK8qdNgLZN/xNi+Qd
+Qyh/GDVg9pOLMjQ2VocbbIoXL91msAtSFUk63SsWnsh33N8R8jSdC9Q46dQPui2
PHHFzjc53BleolO4tz3h1042OfxOC9YQpHOT1tN+HwikL2JvRr9Snj5ODg1n/0bP
e3fT8nMsM3QQFsy+WnylhKneLI9fQO/ksEiPyLoIe9e463DZd04iAkyTF/36fams
bNoEPelY4Efo1TEzwYJCci5mawCyquPvtMAJAwxDY6lLi3n1lBo31qtgLST2NDOU
p0Iw6NK2R2vUc557S9ZDHTW3wMcVHrSabz9nAolG5H+6Rk38ww2k8m3T9qeIUhbL
a83QeY+7oA2aikXIm8GQ6T4M63OubH8/DdUKacs4EF8UOkp7XpFVz0Z7QRIYZFuK
rz5M3+y8WWqK6e0FeNVbw50JBsZogH1ijFKBXCKvbzb7lumnWdtvIXJcGydzqJnq
NZaumt6S8Cb3PALZL4Do77B2Ai5XjqpBF5Me+D+TMkPusAlz6RrTqZjbLwZHsWmY
Il4FTfdBHLIZLGtx7q80mpisEGfYPJsYEx8owybVj4B4W+6vSvqu7WNhg6kTlV8u
79fe4a+K/2NtN0T+iZsP3hcZ9+VDZ7+TawClN/NjGU8bI3vZEU0=
=AsRP
-----END PGP SIGNATURE-----

--Z0mFw3+mXTC5ycVe--
