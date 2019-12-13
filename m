Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3374C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E0E2073D
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fG0Of17m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbfLMA61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:58:27 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34886 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731160AbfLMA61 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Dec 2019 19:58:27 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 23F6060458;
        Fri, 13 Dec 2019 00:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576198705;
        bh=vfIIUFLD8Lxhu0x9wfEqoB2FFFFKAwL0d9cqWtw0XKw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fG0Of17mFGBNJY4r2S4AOzPTN9kw3ZioIy7Qg6V5DsMuD6tQzsnby0fmw2RQPwgMK
         BzovV5Ob4t4TCucJoUa6emsv9EKVRCkYCktd6Zdr0vdt6Nc0YmZbf74AGpLMsYi2yO
         aNtG8Uq81CVkR/aLbq4FYhCDCb477ERyEwQPJjKUQM8v49lPPjrQjDjgqiLs6M8NgR
         CqYy3nlEJqT8RyFuZyeA/S4Nm+eO/+ROtHlUOIVRxHpQPLFztHhq8WvW1akYx/gFjY
         QNaTlGlFyH5KEyqGxdikdlWRCXX5t3ScV9pUi1pGiM1VROI/G+j7Y2yl2bA7DCV6Af
         1VGhGhcY/I6ISoAvSZBVYlrQmWscyqWPg/qS15K0jH0ncrzm2NfeUOGYmSWvs9KkXb
         Rtntj8HnSIHyBpCRuRfyMt3tdD29c6ETFcXOHB1VCIU0xN+dZ9OdDHNStXiOuhd6+i
         B1jXTrRhJN9h3n+bm16YNj2Vc/xj2nophWvZf81bdhcLMASb5Kj
Date:   Fri, 13 Dec 2019 00:58:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        KOLANICH <kolan_n@mail.ru>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: Could /Documentation/technical/commit-graph.txt be relicensed
 under a permissive license?
Message-ID: <20191213005820.GD1334263@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, KOLANICH <kolan_n@mail.ru>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <E2770343-BB39-458C-835E-04F0753783C3@mail.ru>
 <xmqqimmoq6vw.fsf@gitster-ct.c.googlers.com>
 <70575b23-6adb-a29b-8df8-f9099f86eb0e@gmail.com>
 <20191210205056.GA14079@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline
In-Reply-To: <20191210205056.GA14079@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-2-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-10 at 20:50:56, Jeff King wrote:
> On Tue, Dec 10, 2019 at 03:38:35PM -0500, Derrick Stolee wrote:
>=20
> > (Insert "I am not a lawyer" warning.)
> >=20
> > I think this is the correct interpretation. One can interact with
> > binary files as you want. In fact, there are likely privately
> > licensed products that interact with Git's pack-files even though
> > their format documentation is under GPL.
> >=20
> > What _could_ be problematic is repeating the documentation directly
> > in another permissive-licensed repository.
>=20
> That's my understanding as well. That said, I would not be opposed to
> some kind of statement in the documentation making our view explicit.

This is consistent with my interpretation as well.  I view the
documentation as a specification, and implementers are free to license
their software as they see fit.  They need only comply with the GPL if
they wish to copy, modify, or distribute the documentation itself (or
other parts of Git).

I see this exactly as the situation with RFCs (e.g., TCP): they are
documentation licensed under non-free terms, but there are multiple
independent implementations of those RFCs under different terms (Linux,
FreeBSD, and Windows, for example).  The license terms of the RFCs apply
only to those documents, not the implementations.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3y4iwACgkQv1NdgR9S
9ouUjA/+P/TZtDQ/c0EsEUihhkMI4gZPc2tK4MQuroF0Rj2SZZOzMv/vUHdGqClJ
qo0hSLOAJQbTSTMrD4XgOHMhgvGf+NqwX2SgZJa7MYODNbqdfV/Fif7bsdAb5sP5
fQRy+xtgrDQI3AgKcKCPgvv5x8EJuayObZpICSSSkjpm+6aZLrVP9+RF4/0GdHUy
b2A44/JMoL5OoawdNcVYxngxEB7ceWglQCeMn6LkoQ5pWMy3vLF8fLznJLcO32r7
3R1MymnIFQny63EHsK73dBHFCfWqowa+jEjpOerRDpM6fjiH0gBDLBJnNSFSJMe/
CzLvhI65YB/c2nfXk0o9RxZFud4wFHtQl5ZSZuPnJrYmppu98MopmK7kTrBbSMxo
JLG/1CnLofqXKeYWw5U0LKNhBcq9TjvLs9qQydHTRQ1+48CN2+YPO6kA5zDCZu3A
EM0lH4SDaVP652IAA1LvzkSVDxgrsokGsRrFwGbSCSXCADp7ram60gXWPTkmE4wU
6HDmX9IVdGoiT2MZzpyNKB1cV8lLfN7ddvR89X5TDBptf+nUf1SQl4A7PGlZFD9g
aAfC3VUq7QFe7hQm1/+otQyLNkQzEvGlLqb3R1tg1iMpnlw+PSB0sPlwOeNcpTdT
ligWzrvMo3qhHaCdEzgaWfPrwXH2JT31+D36c750+zcId5brqYE=
=HP9v
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--
