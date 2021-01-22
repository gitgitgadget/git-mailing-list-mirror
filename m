Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652E4C433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 23:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8F723B52
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 23:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbhAVX0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 18:26:55 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58728 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728310AbhAVX0v (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Jan 2021 18:26:51 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 73E4C60781;
        Fri, 22 Jan 2021 23:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1611357938;
        bh=aZVR7+zh3QQ8vT9iGMaSH5dQaZFxaF//xQCEgiGgWi4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Jne8LFO0MMD4HOtDr/x1QrNoI5edumZmPNWhReJOOQZFG8iTmXCknixLhFkPX0/2h
         Y/ddA8IQJza9NaXcODO9C2jIMdp178QtMliYOKf27VGM/QrQQSjWozu9oTFspBuWbY
         iNRqxbzKjmxYgz9eCFrss7MnKbNwHZCPu2JvRf9Xk1OubrfhP/DR7OFpzSmTGAyY5Q
         LauHCzvnGjsPNorgUwd3zzNH28FGTbYw5mKH7p2zPJtHd4AuZtq6eITtWPp3RxW63S
         7/dEcQL6ryjF5n+0ZnUvoUAv6qGYB6l0w2E573S0TN13yag/L0opsJ+sD1+yinfnyT
         B8cVZWOmVqNQYBD8vYZ9Pfk8+hVvdFsJnqu9fUfq3QKkcuTZitQpvvLGsPhWg2Metw
         TzojiQ2BRqlaVnpDJenBSxPoMXMaXk/SDRs0BKsA5ESynfUD+OE9fUZizaX5aw4t7p
         IshVvj0zDn/ZTH5VIsVBt8N8FG6KJ5VcZwmAW+VqyvIgkh78TjU
Date:   Fri, 22 Jan 2021 23:25:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: Re* [PATCH v2] fixup! mergetool: add automerge configuration
Message-ID: <YAte7ixZYdz1AOMX@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
 <20210109224236.50363-1-davvid@gmail.com>
 <20210109225400.GA156779@ellen>
 <xmqqmtxhd1zx.fsf@gitster.c.googlers.com>
 <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com>
 <20210110072902.GA247325@ellen>
 <xmqqh7np9gqn.fsf@gitster.c.googlers.com>
 <20210116042454.GA4913@ellen>
 <YAo9aTkZBCSGLYTT@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2101221728410.52@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4cQYWiW2Q29SjAL4"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2101221728410.52@tvgsbejvaqbjf.bet>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4cQYWiW2Q29SjAL4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-22 at 16:29:46, Johannes Schindelin wrote:
> Hi brian,
>=20
> On Fri, 22 Jan 2021, brian m. carlson wrote:
>=20
> > On 2021-01-16 at 04:24:54, Seth House wrote:
> > > The autocrlf test is breaking because the sed that ships with some mi=
ngw
> > > versions (and also some minsys and cygwin versions) will *automatical=
ly*
> > > remove carriage returns:
> > >
> > > $ printf 'foo\r\nbar\r\n' | sed -e '/bar/d' | cat -A
> > > foo$
> > >
> > > $ printf 'foo\r\nbar\r\n' | sed -b -e '/bar/d' | cat -A
> > > foo^M$
> > >
> > > (Note: the -b flag above is just for comparison. We can't use it here.
> > > It's not in POSIX and is not present in sed for busybox or OSX.)
> >
> > Can you report this as a bug?  This behavior isn't compliant with POSIX
> > and it makes it really hard for folks to write portable code if these
> > versions implement POSIX utilities in a nonstandard way.  As a
> > non-Windows user, I have no hope of writing code that works on Windows
> > if we can't rely on our standard utilities working properly.
>=20
> I fear that the Windows-based tools do the correct thing, though: they are
> meant to process _text_, and newlines are supposed to be
> platform-dependent in text.

Ah, but POSIX gives a very specific meaning to "newline", and it refers
to a single byte.  If you want tools that process CRLF line endings like
that, then that should be opt-in as either different tools or additional
options, not the default behavior of a POSIX tool.  This behavior is not
conforming to POSIX and it is therefore a defect.

> From that perspective, it sounds to me as if we're trying to ask `sed` to
> do something it was not designed to do: binary editing.

Most Windows tools are perfectly capable of handling LF line endings.
Even the famously incapable Notepad can now handle LF without CR.  With
the advent of WSL, handling LF line endings is now pretty much required.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--4cQYWiW2Q29SjAL4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYAte7AAKCRB8DEliiIei
gfWMAP41zMSd3v7mGVvPg0no1L/9cONoxg0i4Exnjorc8vVJuwEA7ogZNMMIOoKt
NUOyIL70J5EMyovRjRwHgK2aXLEDGAE=
=eaqG
-----END PGP SIGNATURE-----

--4cQYWiW2Q29SjAL4--
