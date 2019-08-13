Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 512A61F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 22:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfHMWtA (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 18:49:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57548 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727248AbfHMWtA (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Aug 2019 18:49:00 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DF8FE60737;
        Tue, 13 Aug 2019 22:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565736535;
        bh=vy1lx6qxRnzxi8SHZJxZENIwrMnGkNPZJ9JfoJp9m+8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TGLzRyubaGA4/e6aAzS9DJ3UpHYgH16rudRzwQT0ZAML66atkmmrunKbXu0areKNd
         hOebdJfBtrq09Vnih0LNwVuLRk8DDKQ0eOF7iEMEPUUHTz42AKqLOBbcOQAT7Iwtv2
         QR6dL++qACkvhbzs+3aEKyWlwgB+OzgEF3JgFQ+M+CqY19efCW7I6srKUUKFWsnmT/
         ORtTwNi0jlA8xf9Oo9fj2MbyXmSd3yUOHw2ugcDcGWZGJRP+zVAc4GPZekyFm0Zhxv
         VfFBnfYPUcpr8eAbKPE6/arSD2LHovcWk9sRZVqCUpyMuJiSxrMcYSp8x9/iVc6MHm
         kPNsobZS6Pw6XdHCWfjUvw9Fr021ZeMj5g28VtXpnvLyMjo1sa+HlSWe4gMNb6Hbr4
         7netKhH5tx1t0tf0eeCfn6wmm5cJh2A9q+SkoGz2y59pXr/CRNQehnx/e6T4WX6YXa
         FFA6iJ3/W7YVgegrj740sc5QdrAjgPGtce/BKjj3ABKERwgWATS
Date:   Tue, 13 Aug 2019 22:48:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] apply: reload .gitattributes after patching it
Message-ID: <20190813224834.GB229582@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190813024307.705016-1-sandals@crustytoothpaste.net>
 <20190813024307.705016-3-sandals@crustytoothpaste.net>
 <xmqq36i47ku3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <xmqq36i47ku3.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.2.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-13 at 22:37:56, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > +test_expect_success 'rebase --am and .gitattributes' '
> > +	test_create_repo attributes &&
> > +	(
> > +		cd attributes &&
> > +		test_commit init &&
> > +		test_config filter.test.clean "sed -e '\''s/smudged/clean/g'\''" &&
> > +		test_config filter.test.smudge "sed -e '\''s/clean/smudged/g'\''" &&
>=20
> These eventually invokes test-when-finished for cleaning things up,
> that cannot be called inside a subshell.  The "attributes" test
> repository is a throw-away reopsitory, so we should be able to just
> use "git config" to set the variables locally in it, no?

Yup, that's safe. I'll reroll with that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1TPkIACgkQv1NdgR9S
9os39A//dywFD6OEhU4N2If0TeMiKbMq9+mKjUGtGFEsJeOqCb3BkCO799l92h7a
VHdw6hFLZL02p3Aine1nuYpOPkXhCdHiAJ9JBk6w8MGENrAX6GHC6A9EEHQH0Lk/
ZurYL7FTuOMhon/jsUAtB/X6OOcpEXb/RZJmNhbwvfDD8y7HKPhvK6QqY737Gm6W
tQXaeilPNZ2TWc1eTim24GXZ8IH7P2Zt0fyUDGgPO6EAJFWkFdsdsqVHYv2C3rEZ
Q0lqcM15gbYx/oQ/+oeIVI1ZXfbr36GfLaShJ+79wCpVJ7I8Mu/8oz43HCXbCpAZ
y8qWFU2cp4h3IoCEROG4py2XBovWktbrrbjrvQLWcPShmYHF1pKymJgs/qwWEz2p
ZGRyEHu8u5rVleRKgWd0I+MoOtC/DQK0J3H366+KRZc8XqPCHMpmgLGz1Mm78PEc
vkwBzT1vVkYvs2C/+4ARgZEHaEaik+KXZy3oVjULzMbI1JjJrFmmmakKYa+CtQUw
fqSYrGxjb8rPnw5UOX151kJkWZF+HJCgN4+8sUU70M/15R3WNrAJLfkIGgzNGdDZ
DLsr5t6VB2eHg6By6p9S0hjFOKmh/e9+Zo1uvCxCenOgJmOfCtCnf1H9nxtkNhPh
PUWRfheUQUZCmiFwqpE9vky6w0HMOZMFW7qFd+aq4odGmPuby1E=
=QtPN
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
