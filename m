Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732C11F404
	for <e@80x24.org>; Tue, 17 Apr 2018 00:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751172AbeDQAMV (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 20:12:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56174 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751113AbeDQAMT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Apr 2018 20:12:19 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A959960129;
        Tue, 17 Apr 2018 00:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1523923938;
        bh=IB3BiV6YQClWyZIPcHzVsZ7wBo2ZwtHAIJQ37z0WIkI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=pMndui8ykHh2Wjnl1N3DIg42lIuqbH5S5fRKMCdPSLSYCrqND1iXXUZon4gF/TRnB
         4hDOPYka5et97rVWain97SFH7sTMX8SDv5xGfnHgyAZpIEjPdqs3nT4h3ZymmGXZ8y
         Vn3aODrX0cC+uveT93vj9VG9yMv5HqLcxnOFkOrlrDzjiUpp7Hx5PY6QDPr0jPTgsl
         9M1cJBTTyKgI+kRg8p1EdaORb+seDwVkWnX23pO3d2dbRTAbqnasytxMFigyRo6OYa
         5bmcj+i6EqxREJ6hSdihBqrnkrCPYFo7uGbVw/i5CbkMEZqjD6WFlt/E6bf2kX3kOT
         Wo0tHhYYIhgIglj4O571bcdjEdwrVTT1JwAhPjoQ2Y6M054+21xkuPUp66bnAQgN/w
         qP/bpP0z2qEFIFSv/V+w5a55Hud+JT5u8sNkEK0zh5YLn5etzcePHAiHb9+FLzKQWf
         0PumNi++AzCVg2rXEr1tcBvX3MIhMCMI/tUTHuV6UWZlnNwMEVc
Date:   Tue, 17 Apr 2018 00:12:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>, Ben Toews <btoews@github.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
Message-ID: <20180417001212.GC14631@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ben Toews <mastahyeti@gmail.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Ben Toews <btoews@github.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
 <20180409204129.43537-9-mastahyeti@gmail.com>
 <CAPig+cT3AobThgZ15iquyRQG0Qes1ZzQxycXcgHYuwQCuDEDBQ@mail.gmail.com>
 <20180414195954.GB14631@genre.crustytoothpaste.net>
 <xmqqbmejyc4j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <xmqqbmejyc4j.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-trunk-amd64)
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2018 at 02:05:32PM +0900, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > On Tue, Apr 10, 2018 at 04:24:27AM -0400, Eric Sunshine wrote:
> >> How confident are we that _all_ possible signing programs will conform
> >> to the "-----BEGIN %s-----" pattern? If we're not confident, then
> >> perhaps the user should be providing the full string here, not just
> >> the '%s' part?
> >
> > This is not likely to be true of other signing schemes.  In fact, other
> > than OpenPGP, PEM, and CMS (S/MIME), this is probably not true at all.
>=20
> Hmph. =20
>=20
> That argues more strongly that we would regret unless we make the
> end-user configuration to at least the whole string (which later can
> be promoted to "a pattern that matches the whole string"), not just
> the part after mandatory "-----BEGIN ", methinks.

Yeah, I think this patch set is "add gpgsm support", which I can see as
a valuable goal in and of itself, but I'm not sure the attempt to make
it generic is in the right place.  If we want to be truly generic, the
way to do that is to invoke a helper based on signature type (e.g.
git-sign-gpg, git-sign-gpgsm, git-sign-signify) to do the signing and
verification.  We need not ship these helpers ourselves; interested
third-parties can provide them, and we can add configuration to match
against regexes for non-built-in types (which is required for many other
formats).

If we just want to add gpgsm support, that's fine, but we should be
transparent about that fact and try to avoid making an interface which
is at once too generic and not generic enough.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrVO9wACgkQv1NdgR9S
9otQpg/+PkMR4eMnnEDqsnMA+T4RomYtp2oRVAhEo8lXyLmG+EDl5MmlTMWvP/G7
rRMom4nHW+xaRGOKBjeDJAvkSrzmnMMJXM9FLJ3znVm+WDuRJKZk9GRncrArlrPs
asOYFXXontLq2FK2kFZNkOQVvpj0FhiBv/CsuMazisFa/Ap0k1CH13XaYVL+SdvW
poniLKz6UoJEtjRt2cHLY8oS8bu6MGYoX90ootWB4K9lw2x7oDEHgVAIGD/JT4mt
Lufa6pgq+7M192xHUChJXGdN6ydLLlcYa46UzHYBYrRG++oekYy8C0/S8wPE3oU5
J8vph4q/jrzZqeo7ig5BJsAO3RcM4Y/hdI6/x9ow3PTpesDo/wQeHGyWMrkLcWQK
WTHYKnCdNXp/gPKi2XoV02XVodnEbfz4s6QBgz998fAMFVkTcZzW5d4Htoc2s2SM
iETt/pAHbQFt8mapUn0MvvJSKC2M6UfMloVT8RWB0yMHcyKx0EsGE2Q499o4asSM
BZEQI2WUbRStHypw92Yfeu47mQAij2bXI7xMFpBZf5Gs71GgXWywWvMyEAGUTEUA
ki5baHArUMnpSgelB1i0h8ZkmVuydrCotMOGKZ+p2ioalKQyzsnwlzi0+RC/pFK+
9ZW1H5aFBt0aCtgnjEZ4bq6sigBsp2VQX1tEZx6bTGj3VLitqeI=
=rexZ
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
