Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA52F1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfA3Jop (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:44:45 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33632 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbfA3Jop (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 04:44:45 -0500
Received: from genre.crustytoothpaste.net (host-85-27-49-13.dynamic.voo.be [85.27.49.13])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D722B60737;
        Wed, 30 Jan 2019 09:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1548841483;
        bh=DhEJJmqju4LFoghNu35854BPUMoMesRBejkKiYeJei4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sqTX2w3WR+4oHE7Fzr3lEb3+yPPCRnVR5inBVu8yItx9a1rLu2JWA/MrBDv5nImJ+
         P6XaxzLSV+LHE0TPMkGdMRUxiME1n2HNEy6ifWiCo+0R4ARj1XCR3eEkAcUGHVEqYz
         rBUEh+FfCeurWTPIMLLwc23F1DrI+kW769VQV2eizQQEYoY79h71aWpzP/814W2AcL
         YCnSXRT3PHoDsqwGLTBtzuq29nJOMnurrEXck0vSRMjuL9/LaDkjm6fom6fylWUC32
         MF4pVGWxmUupaQ7+3HBGsAtWBzgT8RgbGtz9YmiuyITmNVZeRoJjNgDe+1xeQcvJ4F
         U1i5DUbJBcedQiwfVrqPCfhRw2Mt0c4e1VnVTTwXS7bKDU56+7k/+GliJMmoB8DCGK
         8oo0PLDtINFNlOTTMw7fWB2Ytg/WllMXv5Pb4j6ZEE9npoOTvWT3E/5KyYnh4VkTlE
         TmhQXVSY9AGN5aO6idEcFPp32TYQmmrtvyC65kWVXrU/IbM/grR
Date:   Wed, 30 Jan 2019 09:44:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 12/13] Enable support for Xcode.app-bundled
 gitconfig
Message-ID: <20190130094437.GB24387@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jeremy Huddleston Sequoia <jeremyhu@apple.com>, git@vger.kernel.org,
        peff@peff.net
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-13-jeremyhu@apple.com>
 <xmqqo97z5ac9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <xmqqo97z5ac9.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2019 at 03:10:30PM -0800, Junio C Hamano wrote:
> Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:
>=20
> > Useful for setting up osxkeychain in Xcode.app's gitconfig
> >
> > Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> > ---
>=20
> A concern shared with 13/13 is this.
>=20
> While it may not hurt too much to look at one extra location even on
> non-Apple platform, it probably is a mistake to have this xcode
> specific change in generic part of the system like config.c or
> attr.c.  For that matter, would it make sense to force Apple uses to
> look at one extra location in the first place?  In other words, we
> already have "system wide" location (i.e. system_path(ETC_GITCONFIG))
> defined so system owners can give reasonable default to its users.
> The value of not using that facility and instead adding yet another
> place is dubious.

I think it's relevant in this case if I point out what the gitconfig and
gitattributes files contain on macOS. The gitconfig file sets up the
default credential helper, and the gitattributes file sets up default
diff helpers for Objective C and Swift.

To my knowledge, I believe what other distributors (including Homebrew)
do is they provide the system configuration file with default options if
one is missing, allowing the user to retain or delete these options as
the administrator sees fit. Apple may or may not want to do that, but I
believe that's probably the way that we'll choose to support.

While distributors will of course customize Git in whatever way seems
most appropriate, I think it's better if those customizations are
editable by the user, since that makes it easier to write per-user
configuration files that are consistent across platforms. For a tool
like Git, that can be quite helpful.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxRcgUACgkQv1NdgR9S
9ovv1Q/8DZzwzu/hdL4rxU1AGiUiUnTSPQOzngsLbff1FvXDcxt5erQZWF5Ithuf
F+8G/F4cFITHudk/oAOSXJ6lnRR7LjoHZj5BOKQxivlZIauPpN42qcghFQ1DhE2A
IaGhOuLlkGq/vDZHrlict51P7lptnW6tMeuu2ZhyEt/OQb7zGBTxMP1HBcHZrfHi
uOOO8h8hND9OSVmpBFMqoELqR25/U45KZ5nuO4oND8KNalNYlPgZxbRy3EXi5+ea
xnDt/W2Ale3dxeBYrPqmykBwkLI06sEjIsgvulNmHiP7grF1mMEFw3Y9YY0Gs1x6
b7SniTb5NVHgoyQg5o2bIP3l62OGdTZG7q/eW37bBOrbTbwA1fpTzjfkXecUlCgk
ae3dgbyoi6d87DDj0FkPhsWfHNKW7yLxDk5Cwg8a+/sUSDHT0nhZR9mt0RrVRpdl
sGhA2dtJCeEyI152yqSFwcOyJNlf/pqVJVNV3B55IOw6GKynQ2L39uKWC3/mSSrK
KE5eyaLslQ9xN88z8Id2Ott9pfyID1S6p0So4GDatX0T77gQzPCFTUBpKMD7fE5e
X+R6jgat++L2y1SGhZYZ2chBeiOfeIYw6YuIYLE/8f74rFncQF7T/nbCsSfAfC4b
AJXjq57XsBlGD9KBjJw2KW6j0GUw0UJ8fOaZR5f7tEXWGHNYQmM=
=HuFv
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
