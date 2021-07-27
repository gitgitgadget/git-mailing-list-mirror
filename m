Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDE3C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 01:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC8C60F6B
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 01:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhG0A5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 20:57:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40488 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229575AbhG0A5b (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Jul 2021 20:57:31 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A124E6042E;
        Tue, 27 Jul 2021 01:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1627349848;
        bh=/HDgSOnieMOJfA1aB4fnJEDrL2PCI8VmIwekwuiWxZM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XpBDhtLCC0GYQEU9lFZUtcDvA/n3TNXFlI+6MMX2yq6IEfD2+jqqowpRvFapDmmnm
         DFEe1BnYK6sY56zpKt9rCqPL7Z0lOEvzS9dv6lhgKHmlSjl7NqduhbucFxCWAvVBEV
         KzbuH+gLLU5fZR9v7YEg+ULrmwCvITpBJp63L+oHGzbL3MIwuKN+YQuoiIHp3Dl6nT
         oJ8P9Ak6Drpvp6qMdgbq5BLjX+/aXDW4XiREiAFSIwYsk2alYuKoYoWhGiQpPe2cv4
         CKVynClQndwi95dOaVFJtgCkqwzxXjzNUvHXirIc1ut+lWQkX1Kav6YMGEz8EGD6+z
         9sHsaESP+zCTn/EQ+nDQ9PDtVR64L/t6zI3aqNBQHuHqVvZBd6oiK5IBnSqRl8vbQc
         SNv6dLygA/dN9bpyOds8oyJlK/vZQsZFAHdtNPpAG/OXGgiHOeaN7rdy6SxfMhDuY+
         aynErJ/TOeaqCvSD+urcCUdd+u63YoS4XqkSfA1pDqOprUkj7jX
Date:   Tue, 27 Jul 2021 01:37:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Evan Miller <emmiller@gmail.com>, git@vger.kernel.org
Subject: Re: Exit code 255 after large clone (32-bit PowerPC)
Message-ID: <YP9jU194U7S1PFxS@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Evan Miller <emmiller@gmail.com>, git@vger.kernel.org
References: <D3C1583B-8CC8-434B-8AF5-B9827A7FD037@gmail.com>
 <YP8ykvsZie4mPE5o@camp.crustytoothpaste.net>
 <874kcgsh94.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9QscZgoBGRoMGaoz"
Content-Disposition: inline
In-Reply-To: <874kcgsh94.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9QscZgoBGRoMGaoz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-07-27 at 00:51:05, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Mon, Jul 26 2021, brian m. carlson wrote:
>=20
> > [[PGP Signed Part:Undecided]]
> > On 2021-07-26 at 17:54:07, Evan Miller wrote:
> >> What did you do before the bug happened? (Steps to reproduce your issu=
e)
> >>=20
> >> $ git clone -v git@github.com:macports/macports-ports.git
> >> Cloning into 'macports-ports'...
> >> remote: Enumerating objects: 1223319, done.
> >> remote: Counting objects: 100% (685/685), done.
> >> remote: Compressing objects: 100% (341/341), done.
> >> remote: Total 1223319 (delta 289), reused 608 (delta 252), pack-reused=
 1222634
> >> Receiving objects: 100% (1223319/1223319), 244.46 MiB | 1.09 MiB/s, do=
ne.
> >> Connection to github.com closed by remote host.
> >
> > This message is the relevant detail here.  This means that the
> > connection was reset, which could be due to the remote host (GitHub),
> > but is more likely due to a network issue of some sort.  You'll have to
> > do normal network troubleshooting to see why that might be.
> >
> > It could very well be related to the fact that you're running a nearly
> > 14-year old operating system, but I just can't say for certain.  It's
> > not a bug in Git, however.
>=20
> I'm not so sure it's not, I think the "Connection to github.com closed
> by remote host" message is emitted by the C library, not Git itself (we
> don't seem to have that exact wording anywhere, but maybe I missed
> it).

That message comes from OpenSSH.  I've seen it quite frequently in
various other (non-Git) cases.  I think it's fair for us to exit
unsuccessfully if OpenSSH exits unsuccessfully in this case.  For
example, an attacker could try to tamper with the connection and send
additional data, which OpenSSH would detect and exit unsuccessfully for.
We also in general need to detect truncation attacks, which OpenSSH will
do for us here.

It's possible that if there's an older version of OpenSSH being used,
that the problem happens to be related to a bug of some sort.  There
were some versions which had various bugs that could be triggered by a
rekey, which, if the threshold is set low enough, could be the cause of
this particular problem.

I think the fact that it's not being seen with HTTPS is the ultimate
clue here.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--9QscZgoBGRoMGaoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYP9jUgAKCRB8DEliiIei
gfSbAQDugS1aHfrM/HaqHElbUDqvtiIGfL3lDFza9bB0UGlxPAEA4N1gju6O+nwU
g+mppInpNg17os3fEZgObrHJ/JzL5wA=
=Z+Ii
-----END PGP SIGNATURE-----

--9QscZgoBGRoMGaoz--
