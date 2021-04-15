Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39716C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 00:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D3E61074
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 00:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhDOAf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 20:35:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33370 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229738AbhDOAf0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Apr 2021 20:35:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1AA8160744;
        Thu, 15 Apr 2021 00:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618446873;
        bh=96f7nXuClm83feMm1tuPGg+f4ARW6DvgfwfFK096fmQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hWnG6UbOoupysJKYJ+SMoR9ETvsgg2/ErZEWqFDw3DlKlQ+6kRGZ1fK8Zw63fJweJ
         H2JuCitNA93TXrTLmm+w44nqiDp+14/VOjmA9nO1zQigE/SjHukdFR58YvgEho/LkH
         RzS14mZWoshXZyxi5UtBMAZ8BcvUHaD1bwyh5HMZkOGB3xFMEkFnje6sbS8OMy8X9M
         0gYZv2Xnr9lBOyfw5ri4Ffshr4Gf4X8R+14MaUjiXv1oIcWX6lMBqE+szeZ8ZNvGI8
         aF451oOAGJhyLZ9HKHFCUqpU5TiIZLa14Li8QkJJXjkfw8/Xq3iT1rg+5fr41IdFur
         /rY8eV2/MBvPaimK/vZ2aNQbZfUmAOdNtgvaotDl7JGwT9YoQTFYjTAgQVDGTdqpDu
         Ig/MX0NYlMAYFvw01dapdpzEM7qTEAkFd2caSg4jZCBH6pLNC6PQKqD529KOWYV6ET
         efNbvKg3fy/lZf3wcnzrL5I1ZN8w391c8TeRxj8SMukzGmPEgHF
Date:   Thu, 15 Apr 2021 00:34:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: What's cooking (draft for #4's issue this month)
Message-ID: <YHeKFILFySGRo2Dc@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
References: <xmqqmtu1zn3o.fsf@gitster.g>
 <xmqqim4owixg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oGDBz9SK83wHKuQ0"
Content-Disposition: inline
In-Reply-To: <xmqqim4owixg.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oGDBz9SK83wHKuQ0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-14 at 23:22:19, Junio C Hamano wrote:
> Here is the (local) test status near the tip of 'seen', relative to
> the integration result last night.
>=20
>  * hn/reftable has a preparatory change to use oidread() instead of
>    hashcpy() in places queued at its tip.  This is essentially a
>    no-op in the codebase without bc/hash-transition-interop-part-1
>    and would be a bugfix with that topic.  Please squash it into an
>    appropriate step in the series when updating the topic in the
>    future.
>=20
>  * ab/unexpected-object-type topic has an assertion to catch
>    semantic conflicts with topics in-flight queued at its tip.  It
>    would probably be safe to carry it until the topioc is merged to
>    'master' and then remove it after the dust settles.  Please
>    squash it into an appropriate step in the series when updating
>    the topic in the future.
>=20
>  * The tip of 'seen' passes all the tests locally, except that t5540
>    fails when compiled with CC=3Dclang (http-push exits with signal
>    11).  bc/hash-transition-interop-part-1, which is at the tip of
>    'seen', seems to have this issue standalone.  FYI, here is what
>    "clang --version" gives me:
>=20
>     Debian clang version 11.0.1-2
>     Target: x86_64-pc-linux-gnu
>     Thread model: posix
>     InstalledDir: /usr/bin

You should expect a reroll, so feel free to drop this if it breaks
things for now and I'll figure out where things are going wrong.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--oGDBz9SK83wHKuQ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHeKEwAKCRB8DEliiIei
gW3RAQDOGEsn/tMfANP02z7e8IYtpd2o93dWEMO4e4x9gSZQCQD/YqBZHpSNLdiT
R+15Om9MvqnqLFooG39XaL7guERxag4=
=JBnN
-----END PGP SIGNATURE-----

--oGDBz9SK83wHKuQ0--
