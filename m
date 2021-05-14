Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B63EC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 19:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FEA761490
	for <git@archiver.kernel.org>; Fri, 14 May 2021 19:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhENT5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 15:57:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47220 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232197AbhENT5C (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 May 2021 15:57:02 -0400
Received: from camp.crustytoothpaste.net (unknown [138.237.15.37])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 98CC360456;
        Fri, 14 May 2021 19:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621022149;
        bh=xsz1/+IailAzJnNB6ajYZuatLeSk1/itIJZKatSQdQs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=VU0ZHq5hRPtvyVf/iHABw7VJWU6MAVDlSWoQcXf7bjp8r6uAEzVI1h9cxPElWk0JY
         1nrtQKp4ND7NChoPueUmw6eihqyErpCpJOYl/SWPKXj48uI61xibSCg9/W6lobm/mh
         m2gvq9LZNJsKAaUqujW+u0VzLXBeyMRAVbChTBOuk1K/Y205SRdFls1PVbu8wH+Njj
         Lzue1zTWwoYA9WgXk7AjXvt/2D1b13EaasNxyJI5NbBiRzdPwl3gXeUS2t3hHpB7ii
         lhDoruY0B9jLcDU85r8osEMtg2PRwi+OpLZeyD8lP5/VmBBt4Qq/hFuKMPVmVb3Xdk
         wZO83JxKK1T4Jn6A+HsAJuaXQHZjuZSG7clrtKgzNp5ZB6gXqbJXGAtEenupPkd6bs
         No4D0H6e/4pje4wL173lVj7mSfrJX8O8uHBm8666/yxxewHSeXv1Vx1HtDD9jjKpHc
         RcH3j0l19dTEBYDJ17eSJzWgPOuErrVkbPAenZ7S9r9BV99F1Hm
Date:   Fri, 14 May 2021 19:55:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Message-ID: <YJ7VwbELmik+RVCu@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210514003104.94644-1-sandals@crustytoothpaste.net>
 <20210514003104.94644-2-sandals@crustytoothpaste.net>
 <xmqqbl9e7yqz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bqMAjQeSnseo+e3g"
Content-Disposition: inline
In-Reply-To: <xmqqbl9e7yqz.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bqMAjQeSnseo+e3g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-14 at 03:58:12, Junio C Hamano wrote:
> It is curious that {plus} for Asciidoctor is deffined only for
> manpages and HTML/XML side lacks the definition.  Intended?

Yes, that's intended, because the behavior is already correct there.

> It seems that the latter has several more "attributes" defined that
> we do not replicate in the Makefile---I wonder if that is a sign
> that we can get rid of entries for asterisk, caret, startsb,
> etc. from asciidoc.conf?

I can't speak to the Python implementation, but maybe someone else can.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--bqMAjQeSnseo+e3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJ7VwQAKCRB8DEliiIei
gfSXAQCPwxGVHrl2lb0ExZrrhjBiVdQ5d0helwU3sPh4G4tlSAD/Xli/LSOEfL7n
/TIRZPeP2ib0/D1uG1EHHog40O9Z7gU=
=ytrb
-----END PGP SIGNATURE-----

--bqMAjQeSnseo+e3g--
