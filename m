Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F5631F405
	for <e@80x24.org>; Fri, 10 Aug 2018 02:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725754AbeHJEzj (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 00:55:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46360 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725724AbeHJEzj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Aug 2018 00:55:39 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1154:872:78d7:2211])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7AE676073B;
        Fri, 10 Aug 2018 02:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1533868075;
        bh=4eAVWdLki8WvPapWkqgYBkbZlgE6JUuZI/XhjlGyFcY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=m2xDNKzwQxqxIqrDKzsNQIDY4C6M8bGa5z7ySlEJi1TEkgqVsLY+MFrb4fMJlnx8y
         jmtFls5RNWDLGLuqfgvefY8nG6z8woXddLUfC1UUsj7jMEhzfRRmWW2zm9AJFx45M4
         +umSKNF9H8+r4ZDWsoudDLhKm2/7VPqls1/svYBLJ8XZHEI2JPEv2Ds7zj/PVxPgkF
         NBdQ16ybLxsfk6ckr8iaMD8MhipTJrmyumjdN44hQfhEYoHIKpNRuMNnkY/uV1NLN5
         JODjMXORJgfY95ZOSz53+5qG2dO69EEvGRvxXrgWCcfW3yVz974Fb8eZxBwt9HjT0M
         MJFyZvT2t3LBpIpO6FpINZQki8neut3FO5nZe3/CjXdJinxQKcYG7cfgd0B89a9chH
         pvuVcoNkPr+qoTO4JDWy5rfNBD27u95bpSPlWjh29YudAkYoBJoLlSAlY3yvGUdcQc
         G71TRRs8NihvmWxlvQIB9ZwFTJJ3U2iu1iAs98E3BUH/AuMyWUG
Date:   Fri, 10 Aug 2018 02:27:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>,
        Santiago Torres <santiago@nyu.edu>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully
 when signature is not trusted
Message-ID: <20180810022749.GA70480@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>,
        Santiago Torres <santiago@nyu.edu>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
References: <20180803160634.GA19944@sigill.intra.peff.net>
 <20180804084346.fhte5wusbfb5baem@cynerd-laptop>
 <20180808230456.GA21882@sigill.intra.peff.net>
 <20180808231226.GA34639@genre.crustytoothpaste.net>
 <xmqqzhxwcq2o.fsf@gitster-ct.c.googlers.com>
 <20180809014302.GB34639@genre.crustytoothpaste.net>
 <20180809143010.GD1439@sigill.intra.peff.net>
 <xmqqtvo3d0by.fsf@gitster-ct.c.googlers.com>
 <20180809171219.GF1439@sigill.intra.peff.net>
 <xmqqy3dfbcys.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <xmqqy3dfbcys.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 11:40:27AM -0700, Junio C Hamano wrote:
> -- >8 --
> Subject: [PATCH] gpg-interface: propagate exit status from gpg back to th=
e callers
>=20
> When gpg-interface API unified support for signature verification
> codepaths for signed tags and signed commits in mid 2015 at around
> v2.6.0-rc0~114, we accidentally loosened the GPG signature
> verification.
>=20
> Before that change, signed commits were verified by looking for
> "G"ood signature from GPG, while ignoring the exit status of "gpg
> --verify" process, while signed tags were verified by simply passing
> the exit status of "gpg --verify" through.  The unified code we
> currently have ignores the exit status of "gpg --verify" and returns
> successful verification when the signature matches an unexpired key
> regardless of the trust placed on the key (i.e. in addition to "G"ood
> ones, we accept "U"ntrusted ones).
>=20
> Make these commands signal failure with their exit status when
> underlying "gpg --verify" (or the custom command specified by
> "gpg.program" configuration variable) does so.  This essentially
> changes their behaviour in a backward incompatible way to reject
> signatures that have been made with untrusted keys even if they
> correctly verify, as that is how "gpg --verify" behaves.
>=20
> Note that the code still overrides a zero exit status obtained from
> "gpg" (or gpg.program) if the output does not say the signature is
> good or computes correctly but made with untrusted keys, to catch
> a poorly written wrapper around "gpg" the user may give us.
>=20
> We could exclude "U"ntrusted support from this fallback code, but
> that would be making two backward incompatible changes in a single
> commit, so let's avoid that for now.  A follow-up change could do so
> if desired.

This looks great to me.  Thanks.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlts+CUACgkQv1NdgR9S
9ote4xAAy6HHX2mdw07KHdarVpXo14fh3a070jXcqvu5amR2KGVstM0/AtjXwfOl
QcXMYSU+8nL9tZBZFLG/JfqvpZ66WU5XvEUelZhbc+sCOvY+A9xVX42/MoNSZ7xj
Z6H4Gk5dZNpnn4XZaKDxFAAM12slU4Hyn1/gsidImtEg0+R6+B+DFoWWjt3OAQ+p
4rESkuB/Lyua0RyPCA9Hh+sh1gwXDiq1TT3sdhBgEb2mLmsiieociH0kaaPprxJs
Qx2W/hVyMa1Px1RrqOP8dGy0PFNPkA5kFGZYRCAJF+D2H2Jwuo/obQ+7OFh1ZQ9n
fdi3BIwB8m/9UNG2PpYdKpUcnqCVvEyAG0o+iJjqS1FE91HPaxYgn7u4q8vmMUhq
YMoUw6K4pUxGnSKiInfD/SC5yjlgtgP0pqD2ADaVOABv9fjwk2VYfVayTMNAkkdZ
nlOQv5t+VyaZx1JJ1tLGBTZs24ztXboOeFqQiOk1N6mg4z4eXbOo9SHHDYQ1P8H3
O4h5MIWL4PyehBu7QVxzGSr2ryPQee9qS9VG/Sby7KHzmNgqyyGGRJZRl0vL1a5g
8iwn3jAJN1hqUF695HhMwnUWqXowlKa2WNxdIztW2M1dPU7qjVAUjv51b+tUwijl
TRrxh90Ss1GyMvz7UTZoV1iWHKUlt7vQZGal27aJVbY0cjleOK0=
=m00s
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
