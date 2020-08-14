Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5D4C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 00:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D735720838
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 00:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CAJLpfYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHNAv6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 20:51:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41500 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbgHNAv6 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Aug 2020 20:51:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 03C9960129;
        Fri, 14 Aug 2020 00:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1597366317;
        bh=ZsRd7W++g+HWP2KBcq6g70qBVyYImBAV/0mb89qfA3g=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CAJLpfYdvuJ3y/p64E74eSzv5tG17Ty5sYyVP9GMVK+8A6dCZWAwkXj5gTTUlIZE9
         CMlBQQ+E0plGq4p2gaP8BtRDByinJLE76U+f6ZMUgzRL4aFm5YL3tNmWMzIO6XLsbN
         4wElupusO3p8bIauKuOIevQuPvkVEkHKIMP9Qlcz+TDqtvTHDgkrBnrl+2nPrg91OK
         hWoE7Sbsv4bDmoPegfe0JUO6mq8+awkz9r0isbAHHJlHhkkpxKph9FIX3Sjyx5HCUP
         RFVFw3vNXe1w3Oe5pOeuNfc07JUDbEE8roOcDVE0kivrwbB+EkmJOE8RiXGNNSx08Y
         I8eXJkUWS60WNIzL3Sk0ZWc0gwn+YHHBt0P7TEY5F+DmXtS79jF2/FB8vZ/MD1i2Ru
         dSIdMYuehvZv6CJeGvepBmp4G4JT+0fwhj1Omu+GO2PJ9MU5v9WrDqCFjYM5pWQMVS
         EPite9SUENgehAIopVu7+nBYqTpcZ4ap1/BoDrgjH8N043+JLPP
Date:   Fri, 14 Aug 2020 00:51:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation: mark `--object-format=sha256` as
 experimental
Message-ID: <20200814005151.GI8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200806202358.2265705-1-martin.agren@gmail.com>
 <20200806230837.GA8085@camp.crustytoothpaste.net>
 <CAN0heSptiJL9d86ZeNPMUaZeTA68juwTyf3K-uWR=K-vt=1Hrg@mail.gmail.com>
 <xmqqr1sifaeu.fsf@gitster.c.googlers.com>
 <CAN0heSqyBzW_+vWSAxV9O1XAJKmQgrhCms7mSa+hFFx35uU05w@mail.gmail.com>
 <xmqqmu2y1e0t.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YrQNB5Deg1WGKZi3"
Content-Disposition: inline
In-Reply-To: <xmqqmu2y1e0t.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YrQNB5Deg1WGKZi3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-13 at 20:34:10, Junio C Hamano wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>=20
> >> IOW, you question "if we go a few releases without any major issues"
> >> part?  I tend to agree that for a large change like this, a few
> >> releases may not be sufficiently long time for a feature that is
> >> marked as experimental in big flashing red letters to get exercised
> >> enough to get major issues noticed.
> >
> > Yeah, thanks for summarizing what I failed to express using so many
> > words.
> >
> > I'm fully open to the idea that some people want to leave SHA-1 behind
> > and that they can do it today, in some "local" sense. If those people
> > are fully aware that they are guinea pigs, it might actually be ok for
> > us to subject them to a few rounds of "oops, Git v2.32.0 produces data
> > that v2.34.0 and later will barf on". Or at least it would be on our
> > table whether we wanted to be that cavalier.
> >
> > Once SHA-256 repos as such are no longer experimental, I fear that we
> > can only buy ourselves that leeway by introducing fiftyeleven different
> > config flags for "please produce auxiliary files X even if you don't
> > actually use them", "please do use X, and I'm fully expecting to trip on
> > them if you decide to tweak them in backwards-incompatible ways", and so
> > on. The alternative to buying such leeway might be to establish, pretty
> > early on, a respectable set of things we support "for compatibility
> > reasons".
>=20
> OK, so can we resolve this one way or the other and move on?
>=20
> For now, I'd vote for applying this warning patch, but with or
> without such warning, it is more important to iron out those details
> we fear might have to change.

I'm fine with applying this patch.

As for changes, I don't think there's any changes we need to make for a
stage 4 implementation.  It works and it passes the testsuite.  I've
verified the block and gcrypt SHA-256 implementations produce identical
results, which was my major worry.  Other than the philosophical
disagreement over whether index v1 and v2 should support SHA-256, I
don't think there's any points of contention.

When we add support for SHA-1 interoperability, then we'll need pack
index v3, proper multi-pack index support, and the loose object index.
Those are being written at the moment, and I think it's fine to add a
tool to generate the necessary files once that code is in place (which,
it's looking like, can just be a shell script that pipes every loose
object to git hash-object and rebuilds the pack indexes).  Support for
interoperability is an additional extension, so we don't have any
compatibility concerns and we can generate all of those files based on
that option.

I don't plan to enable support for extensions.compatObjectFormat without
all of the required pieces in place.  There won't be any incremental
steps there.
--=20
brian m. carlson: Houston, Texas, US

--YrQNB5Deg1WGKZi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXzXgJwAKCRB8DEliiIei
gY2DAP9nQ35kdidQDDdS4bk/SwMShxS0f7CNGFiMMMQyGmCW2QEAgb4Z0D+7dLDA
PCyR1IvGs39EkFK15iFi7WMWpzj6zgk=
=SYfP
-----END PGP SIGNATURE-----

--YrQNB5Deg1WGKZi3--
