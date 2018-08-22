Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99DEB1F97E
	for <e@80x24.org>; Wed, 22 Aug 2018 00:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeHVEKu (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 00:10:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57672 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726152AbeHVEKu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Aug 2018 00:10:50 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 274FF60745;
        Wed, 22 Aug 2018 00:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1534898901;
        bh=+a/v7wbXXcD/YiCaC7liTWPBujhuGkYRLOWKRZHwj9c=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=SOHQHSATGHtkIcInbIKcSzQhUg2peXEEky1qDveuH91NXSyI3pxa1Q8JO3q9eY3tU
         byNMyIC/0uGOwttaNDbco7w75z3IvU5O+obyKQ19XpMBb0STc28/q3bL0wR7n4aE/b
         SY8iIaPpIlmIDuXKB1vg6kKC+NurFEai4WLyuca2Y6iWXvn6N9/BOA4qy3hnyId13E
         Fi+cIOHWd2A4c1UesSjds/X7KNxw8Iz8ll7gZ+iUr/njTQmthj0zBfewdav12layXK
         yRltu9w8rosfuy2osZgYRrpVudZM3qrqGy+WJTKyr5OFKFDo+Jo9FC+Cp3VkASfme8
         swP780MqOcW1IS5MAwLK9ELHMZyzfK2FnevRekkKEfqn69l3/01x+8Rdjj0PzaLLwu
         6c4IWps1xfIe7mb85wWRmEHwhhDgm6j3NArAevnm6mR6pGDOq7CfsNfqpJWhy9H9Xr
         DXnHqygimV+815MUH3MmNpZihVmNsOUa4M15foc1qADPXITu6JE
Date:   Wed, 22 Aug 2018 00:48:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180822004815.GA535143@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20180821212923.GB24431@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 05:29:24PM -0400, Jeff King wrote:
> 0001.2: rev-list --all --objects  37.07(36.62+0.45)   39.11(38.58+0.51) +=
5.5%
>=20
> Less change, but my overall times were smaller, too, so clearly our
> hardware or exact repos are a little bit different. Those numbers seem
> pretty consistent in further runs.
>=20
> It bisects to 509f6f62a4 (cache: update object ID functions for
> the_hash_algo, 2018-07-16). Which make sense. An "--objects" traversal
> spends a huge amount of time checking each tree entry to see if we've
> processed that object yet, which ends up as hashcmp() in the hash table.
> I expect that a fixed 20-byte memcmp() can be optimized a lot more than
> one with an arbitrary value.
>=20
> Even if _we_ know the value can only take on one of a few values, I
> don't know that we have an easy way to tell the compiler that. Possibly
> we could improve things by jumping directly to an optimized code path.
> Sort of a poor-man's JIT. ;)
>=20
> Doing this:
>=20
> diff --git a/cache.h b/cache.h
> index b1fd3d58ab..9c004a26c9 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1023,7 +1023,10 @@ extern const struct object_id null_oid;
> =20
>  static inline int hashcmp(const unsigned char *sha1, const unsigned char=
 *sha2)
>  {
> -	return memcmp(sha1, sha2, the_hash_algo->rawsz);
> +	if (the_hash_algo->rawsz =3D=3D 20)
> +		return memcmp(sha1, sha2, 20);
> +	else
> +		return memcmp(sha1, sha1, the_hash_algo->rawsz);
>  }
> =20
>  static inline int oidcmp(const struct object_id *oid1, const struct obje=
ct_id *oid2)
> on top of v2.19-rc0 seems to give me about a 3% speedup (though I might
> be imaging it, as there's a bit of noise). A function pointer in
> the_hash_algo might make even more sense.

It's possible that might be a better solution.  I looked into a GCC
assertion that the value was either 20 or 32, and that in itself didn't
seem to help, at least in the generated code.  Your solution is likely
better in that regard.

We could wire it up to be either 20 or 32 and let people experimenting
with other sizes of algorithms just add another branch.  I haven't
tested how that performs, though.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlt8ss8ACgkQv1NdgR9S
9otZLg//Svzcu9Pw4cLaz5g52vRa8q4Ywx54JwPYuabmD6WybKRvhTKhejXZ4x4B
Lde6HFJ0IfFMLEMXafB3pOyYTtXhcmVPRzj/2kfh+YRjwcj9lQflUMGu21iidvUM
c6dLNlsijT7ix4ERsSPAolEqeeYvqaERNsmQ+q08OJuA6E9ckQ65kFo+Ukt+D6NP
PB2Q33o3Fa+EVOEzpI3q7RAvTKxOE8k8h3CmZNIsD2rkdyO26vZgy1ZT+kTEoVNM
luVWh/g+tbqC1zLIGGniygOMrK5kXVRP2qUeMIB5W9IaUoRN+bBBDOa5JluYt7fC
GSTcbDr8Kle6ZwSFfl6Q5QjdTcBvGa8iw5TlxyvrzeruTWD4GN3/uQVBTThnEM8q
MWRt+7KBaYh1UORUlB0idw/PC+SH1lDev9ZOEIgLczqqmBbVMQX6xtTMJSvunLR3
VNvn2/qtj819JF1Mb315AJ5jVENYFlSFQsZA+xd7Q2SzCHabAOtEzWSLU/4VWdkm
x4MRPBdm3Lgk4YFNEi5HkXpnu9zdbHAKBPpUaAiDhgiPR7NpNqvCu0zjiaSs/iIj
yAgV6ulMgrqdbAanidhRjT4ozFcygDpIOdHX8DnxBAhZVlzLXMjEhBpHAXsx1E7g
5xNg6arC8JcVLEwSj/MFFkmux0Zha3jRe7ISDdvzFGfJ+9dqyog=
=4s0t
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
