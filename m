Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC12EC00528
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 21:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjGaVC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 17:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjGaVCv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 17:02:51 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7384F1BC8
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 14:02:49 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 2F1035B01B;
        Mon, 31 Jul 2023 21:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1690837368;
        bh=BBj1eD2BemLYPEJwuSh6LP1q6IcUs1n2qPEvnhtDiOE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rPT4p49/sFP1/4moeItd4GSlg2vFUwRzJI9MoCDbpLXX2v4ijRoUQAsg46OOBZxeh
         GMnnWBFRe4lJ+0AgsZkcH7Iy5DzBdVDz5mgTv/JRliVrdEddrERcDmJU8InPbXIx2W
         idFHQID6ggjuq2p034BKwWjX32r/rh9rybRh2F59dY5jnpP9WwyO24LYjMhoF7nrML
         Xn9EzOrIdPMfP4wVa8Z5vXBlzEzbnKgB9/HBIy9ptif7tl7mYqtV1IsSTqPjz2um4q
         haXXOjdmZx6q4s+uTW4Me0KBYEp8yEQSyiJSJuCReKay4ZkWzNNZn7TRTufX0gzUCj
         lIO08+6W2HQ5Q6fB0e1gABCVwgURIzUkOco97/lmnKErtjJEgdMxhGiSpQLrRtYLcZ
         5xTL0rHbFeYgjjCjhHDb74jhxFMjU39Pt3FRF5qQN9v+Sp9fepU6ODNXOt5+tMyL3T
         NkZp4ZhHe9Yub0d1xqjIZXCkLyZRajA8MTRNCmbCteWiQF+4yfa
Date:   Mon, 31 Jul 2023 21:02:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Thomas J. Faughnan Jr." <thomas@faughnan.net>,
        Jeff King <peff@peff.net>, "Daniel P." <danpltile@gmail.com>,
        git@vger.kernel.org
Subject: Re: Git is removing . from the last part of user.name
Message-ID: <ZMghdgIaQB4L88WR@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        "Thomas J. Faughnan Jr." <thomas@faughnan.net>,
        Jeff King <peff@peff.net>, "Daniel P." <danpltile@gmail.com>,
        git@vger.kernel.org
References: <CAL-s8C7makcRT_ufsv4THSrKeDkXfhFoAXSBKSiK5w0anMvZag@mail.gmail.com>
 <YSJuS1OoYsqgpF3j@camp.crustytoothpaste.net>
 <YSKleNynVrWWyyML@coredump.intra.peff.net>
 <CUFTY8BW9NHM.132KSE56BDE8Q@badwolf>
 <xmqq351413dy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N9SGwCKNJ9jK+5GO"
Content-Disposition: inline
In-Reply-To: <xmqq351413dy.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--N9SGwCKNJ9jK+5GO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-07-31 at 15:56:09, Junio C Hamano wrote:
> "Thomas J. Faughnan Jr." <thomas@faughnan.net> writes:
>=20
> >> On a somewhat lesser note, I'm tempted to say that "." probably was
> >> never that useful (compared to say, comma, which is the gecos
> >> separator), and we could probably just drop it from the crud list.
> >
> > Would this change still be considered? Or alternatively a git config
> > option to ignore "." when checking if a character is crud?
>=20
> That is certainly a blast from the past ;-)
>=20
> I actually was wondering the opposite should be done, i.e. be
> consistent and remove '.'  just like '<' and '>' even from the
> middle of names.  '.' in the human-readable name part anywhere on
> To: and Cc: lines, not just at the end, causes mailers to barf,
> unless such name is quoted.

For obvious reasons, I think that's a terrible idea.  I don't think we
should have such a config option, and should instead just drop "." from
the crud list.  I would welcome such a change.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--N9SGwCKNJ9jK+5GO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZMghdgAKCRB8DEliiIei
gf4fAQDjJo/nNxxBqAm7Vc8bZuyTB0lhoiCXREJKlI61g32rDAEA9G3fCuZF8Ad2
oP7WnBjbpoz53nyCQ32c9J1nUnBuGgQ=
=bC4v
-----END PGP SIGNATURE-----

--N9SGwCKNJ9jK+5GO--
