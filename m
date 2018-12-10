Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 194BE20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 00:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeLJAm7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 19:42:59 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57656 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbeLJAm7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Dec 2018 19:42:59 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:34d2:59b6:3b53:e993])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0FA9360425;
        Mon, 10 Dec 2018 00:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1544402577;
        bh=utcoka+a9DjRZ3bB7zQ3DgpjaqvHFEB1KqDqukKAOXU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=c2PHbS9hf5np6MieFv3JGrUpXtu7ONMLjcE4oBrrvg2Ns9D1SI26m+BicCtZI6tC1
         xj45hmWTYGZPIbMrGwoA291dUR8pR6e20wGxSFSIjSi4wwfCKhdX38wWu3DvtBmf8x
         /mxDFoS1DumuWaL3VXGghOxeZGpf39cGtbMNVRcS6QXZFxYnY1Ub/BHPQGdNjRd7p2
         j7iycEMae0eSb09qgDhXMJ9qI1LyrXd2FvFelspAye1nfZmNEPPacvlIwk77nqVZbX
         fJPBEibJAp+6ejpqiwEBp4mwM8Ej4X2h4TWMNytVVforlpgjNfxzAiHTIlIDAim7Wl
         nACkYyRjDc0sbYZXLVOTFq+k+ToA5rS5do8oC/19hU/wQrh9PFBGTqBsuLV14MocdX
         FbIZ3B/7u1R1Fddpv/wI+4sDbE8CM5oEEWAoLBOhpwzsQydTD9X374hNa7R8BH4BcM
         GM1pa7JHW6oBz2NqHrTcuyOIGOKZfHsYLUNjlu7AIuHns6iRrtQ
Date:   Mon, 10 Dec 2018 00:42:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, pcre-dev@exim.org
Subject: Re: [RFC PATCH 1/2] grep: fallback to interpreter if JIT fails with
 pcre1
Message-ID: <20181210004252.GK890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, pcre-dev@exim.org
References: <20181209230024.43444-1-carenas@gmail.com>
 <20181209230024.43444-2-carenas@gmail.com>
 <87r2eqxnru.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xFawzEZLoq+g1Byu"
Content-Disposition: inline
In-Reply-To: <87r2eqxnru.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xFawzEZLoq+g1Byu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 12:51:01AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> Obviously this & what you have in 2/2 needs to be fixed in some way.
>=20
> Is the issue on SELinux, OpenBSD, NetBSD etc. *how* PCRE is creating the
> the JIT'd code? I.e. presumably Google Chrome's JIT engine, Java JIT and
> the like work on those setup, or not? I.e. is this something upstream
> can/is likely to fix eventually?

=46rom the cover letter (but without testing), it seems like it would
probably be fine to first map the pages read-write to write the code and
then, once that's done, to map them read-executable. I know JIT
compilation does work on the BSDs, so presumably that's the technique to
make it do so.

Both versions of PCRE map pages both write and executable at the same
time, which is presumably where things go wrong. I assume it can be
fixed, but whether that's easy in the context of PCRE, I wouldn't know.

> Are we mixing a condition where one some OS's or OS versions this just
> won't work at all, and thus maybe should be something turned on in
> config.mak.uname, v.s. e.g. SELinux where presumably it'll dynamically
> change.

Considering that some Linux users use PaX kernels with standard
distributions and that most BSD kernels can be custom-compiled with a
variety of options enabled or disabled, I think this is something we
should detect dynamically.

> I'm inclined to suggest that we should have another ifdef here for "if
> JIT fails I'd like it to die", so that e.g. packages I build (for
> internal use) don't silently slow down in the future, only for me to
> find some months later that someone enabled an overzealous SELinux
> policy and we swept this under the rug.

My view is that JIT is a nice performance optimization, but it's
optional. I honestly don't think it should even be exposed through the
API: if it works, then things are faster, and if it doesn't, then
they're not. I don't see the value in an option for causing things to be
broken if someone improves the security of the system.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--xFawzEZLoq+g1Byu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.11 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwNtowACgkQv1NdgR9S
9ovCOxAAnB9SRxp88OjHen7cZrxKdoFLbMg+dADNzoyF17btXsBx9Y9zBBqH0HFT
isgUWzf3ceKaVzUfA0XJztGXHpHfC8iqtAy0+zFZ35dncygsxC1DgFEqwYRTrivi
6EawbkzvNoqwVKtkFrxYe0Q+v1aVLFWe3rL1bnZrs4fJo5Cddf+UPb7jmS2tFJ8w
q6kFQjaZWWDyTmlMsSmXN0Efx7BpDFqT0AECmticrLWOZuSoP7kJN5Z2oKZgrl2D
RfZcbguVoD50KcdwcDe9ewGwARK2f27P23MFFQ5ZOeDWgCT5VCTnNL/WyLT5RZHB
TMEZNNodkiN/yXvZZ5jmLdAjm07UYXWZ7jv9ZvQ5I8QGikLZIKYR+xDsWf/N9Ytq
ufExgHRQdmfztnLdVWLzraSbXxFysZhxCLyHWYd1IS0xn0TKzUNJi8POssDIpb4r
hqg0XQcnhs8ypSCCkLY2G46eQDxsHN/XlcCt3htfkrGar/upCCTUgCuoR7KOc+Hb
S7OIHTPo9WPDqKtpdmour5HTr9kLbTJ3n7E6+/dPYXk5j6qxlhjiQsOTfoq6dgs6
wiV4AiKNCRmEC5yERpIykhS3z9oizH+Tli4TzAA9AeIe+vzRw8vdhHT2yQ/DaOjX
ortAdocOha3Tw6BuKKi46nDOo+k2tPT1aI8Z5HTvRGlxhH1iSzA=
=RIFj
-----END PGP SIGNATURE-----

--xFawzEZLoq+g1Byu--
