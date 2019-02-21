Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6931F453
	for <e@80x24.org>; Thu, 21 Feb 2019 01:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBUBJU (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 20:09:20 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34960 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbfBUBJU (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Feb 2019 20:09:20 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 746C7603C6;
        Thu, 21 Feb 2019 01:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550711354;
        bh=LBMRXzgFAvTEgtHUsbQBqa77reCpJklAsqiyu6zza3E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uUNiwkY+SdfdyXuyeEGZZrkD6gACDXX+esdDc3qWS6tP+rv7dId8/BW+Y+jy7DSeG
         Fxru7caqhlUkeZg3yothW8oc7Gqk/pPGSSJ7BJd5CnHhGwmZxrpQQ9oVakD86qP21N
         1vOtoJpCt3n1egEgGE0Yh8UnR/EpkwltooASXhqxHUVCRVHda32fQkJO/aC6BEcNwm
         It/mOvQiJvsfF/f8F05TAeDZsA89gS59Tn6EY6130TVGEkYyCFstPueUmINNgv634p
         eBiM/swqf3fJ1iZaG+P1sysJxgAq815TQUN99uF4WnUZ8ToyB9Kcl2nZwNiOZQnaEu
         A6nXacHV6OKx9ytglJAnLiFV2de6ppWNUlRKIVAL1WUW6ldTbs/guZw2zJ+Gt28M5j
         RGFr93yk+UgifJ51r2eJK/I+4ngzunduNwj6y5/8R5qxaRkE+32bEhD7YF5au8fEvW
         rOCd5yIuA5iCgqfNbOAmF5UkeeKMMRx7qSQzPQkWBP8dgxT4iPR
Date:   Thu, 21 Feb 2019 01:09:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [WIP RFC 2/5] Documentation: add Packfile URIs design doc
Message-ID: <20190221010909.GA488342@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1543879256.git.jonathantanmy@google.com>
 <0461b362569362c6d0e73951469c547a03a1b59d.1543879256.git.jonathantanmy@google.com>
 <20181204015446.GX890086@genre.crustytoothpaste.net>
 <87lg2b6gg0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <87lg2b6gg0.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 02:44:31PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
>=20
> On Tue, Dec 04 2018, brian m. carlson wrote:
> > First, I'd like to see a section (and a bit in the implementation)
> > requiring HTTPS if the original protocol is secure (SSH or HTTPS).
> > Allowing the server to downgrade to HTTP, even by accident, would be a
> > security problem.
>=20
> Maybe I've misunderstood the design (I'm writing some other follow-up
> E-Mails in this thread which might clarify things for me), but I don't
> see why.
>=20
> We get the ref advertisement from the server. We don't need to trust the
> CDN server or the transport layer. We just download whatever we get from
> there, validate the packfile with SHA-1 (and in the future SHA-256). It
> doesn't matter if the CDN transport is insecure.
>=20
> You can do this offline with git today, you don't need to trust me to
> trust that my copy of git.git I give you on a sketchy USB stick is
> genuine. Just unpack it, then compare the SHA-1s you get with:
>=20
>     git ls-remote https://github.com/git/git.git
>=20
> So this is a case similar to Debian's where they distribute packages
> over http, but manifests over https: https://whydoesaptnotusehttps.com

This assumes that integrity of the data is the only reason you'd want to
use HTTPS. There's also confidentiality. Perhaps a user is downloading
data that will help them circumvent the Great Firewall of China. A
downgrade to HTTP could result in a long prison sentence.

Furthermore, some ISPs tamper with headers to allow tracking, and some
environments (e.g. schools and libraries) perform opportunistic
filtering on HTTP connections to filter certain content (and a lot of
this filtering is really simplistic).

Moreover, Google is planning on using this and filters in place of Git
LFS for large objects. I expect that if this approach becomes viable, it
may actually grow authentication functionality, or, depending on how the
series uses the existing code, it may already have it. In such a case,
we should not allow authentication to go over a plaintext connection
when the user thinks that the connection they're using is encrypted
(since they used an SSH or HTTPS URL to clone or fetch).

Downgrades from HTTPS to HTTP are generally considered CVE-worthy. We
need to make sure that we refuse to allow a downgrade on the client
side, even if the server ignores our request for a secure protocol.

> > Second, this feature likely should be opt-in for SSH. One issue I've
> > seen repeatedly is that people don't want to use HTTPS to fetch things
> > when they're using SSH for Git. Many people in corporate environments
> > have proxies that break HTTP for non-browser use cases[0], and using SSH
> > is the only way that they can make a functional Git connection.
>=20
> Yeah, there should definitely be accommodations for such clients, per my
> reading clients can always ignore the CDN and proceed with a normal
> negotiation. Isn't that enough, or is something extra needed?

I think at least a config option and a command line flag are needed to
be able to turn CDN usage off. There needs to be an easy way for people
in broken environments to circumvent the breakage.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxt+jQACgkQv1NdgR9S
9ovFcRAAzu5/9EzgN+Zy6ju4gGN3FplEXrvDJ0wBa0CvA6wjKLMF+nu9+gMbplCP
Uvj+PA9s+XECpcVwFgXXfZfrhLdPTfbsI1uqvM9VH0l3IhiKSlvVqBLX9nH8LJyZ
O7d1vl3DnUb4M/qqRNG8c6wD0Bk8kVxDu9mvWjcIHlxUqhd0iSKL3Jvy2e3IYBmV
aVprXPTYizzE5KXUVTGuMfU4Pd1RRvsjFP84TAVnoSP30hiOyKURFZbzYUviqLvq
AUkR65LYmsN1HYTOg+LHaJjcLDc3u4tz46AnmDWRrkQUZt9ggencfqHvrAnzYAbA
G1byiij/GFu4GMs9QM6Yz+8vLzAXia5S4IaMFE8iqcOYuR7rhA9oaHu/cVT6mWot
OFxrHKGIy0+Amq6YjSdoWXDMnJuo+2x98LKKKTYVxZCoPtOzuW6RxaOo9TZMCvpH
dHQAA5xJUqdJ717B77/E1dvxYJ+Phz5FHBk3oh78SlG0NYoUCkIDrHZTsBi23s06
nnqeCyeXETljEzMLeFygiTB/6v3vG2ADQrOKjavja3aiv5cT16qvylsPrXivvhJh
r0J7ndW/368Vn8X5SAzB4qknjuGCyRxCFE9G/5jD9HzGlaKQnYNVkfDOIh0xRv0B
ODx4XULjMJIxkvV0ky6n/qiW3Y4/o0S6sc8wpqRPHhbFs13IURI=
=xEUJ
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
