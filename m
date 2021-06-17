Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C84CC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 23:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59842613BA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 23:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhFRAAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:00:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51016 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhFRAAh (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Jun 2021 20:00:37 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 95BD060459;
        Thu, 17 Jun 2021 23:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1623974308;
        bh=r5B6ivD+t49OIZQR6ttBb7kh77zPqu2vJcYxTo2luAE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yx1vH9ok/i/kL6TO3F5rpq8nt0Yud8gdaN0ht0Qhm/xO1ClHnMsa3KvtZCT1RP45B
         KGnvQkM9KdfRu5jBP2cGbagesyF4hNZ7NMAMM1gWOkV8pLaX4EUM4j2H7oBlPo2hSe
         gODLDOJQRyXwto4ZWMlXPxCfw8HzTsLLxZKb6UefTyDcpcjKzfWwHwN3d4rLSnItjQ
         ru/lD0v7qsA1lGyfE/mlNVIH3B4ivsjpctmkvNThfD7U+TkG/H7NF8Q08SDFTextdb
         FITakfDo+O29GVST8sZTog1Eo+At+jn1QTXrtX3SFi1rGa3/r2V6dVwdG4tB5SoObb
         qgGzSv4ILGDQ+eA+SRuMF2xHvOuDZ4UnuDrPj91IybwPBYqxV6aLklwOapsHe/OoOQ
         PJcRU3FIjx2qOUsLk6c51Jb6Vdj42GBCtm5joc81ngBbfN48ujuH24BhbaVYHhGLCV
         hfXBcfv46jaPWksOoGQqtKOSnVKSOmnSEtCm5HdTJ73/EvyaxbW
Date:   Thu, 17 Jun 2021 23:58:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2021, #06; Thu, 17)
Message-ID: <YMvhoXVBoO08ziI1@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqr1h1mc81.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8ulAMv3OVYmFxGf+"
Content-Disposition: inline
In-Reply-To: <xmqqr1h1mc81.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8ulAMv3OVYmFxGf+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-17 at 02:55:26, Junio C Hamano wrote:
> * bc/doc-asciidoctor-to-man-wo-xmlto (2021-05-14) 2 commits
>  - doc: remove GNU_ROFF option
>  - doc: add an option to have Asciidoctor build man pages directly
>=20
>  An option to render the manual pages via AsciiDoctor bypassing
>  xmlto has been introduced.
>=20
>  What is the status of this one?

Probably best to drop it.  I think Felipe didn't want his sign-off on
it, and I don't think there's a good way to produce an equivalent patch
without incorporating his changes.  We don't seem to see eye to eye on
an appropriate solution to the problem, and I don't feel like arguing
about it further.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--8ulAMv3OVYmFxGf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYMvhoQAKCRB8DEliiIei
gahjAP9ZoDtb+brMrwDdvlru4ve+z9+mc81YuCh0CdG2vg8a7QD/WtK+XhLXGuj8
FphhuKD78eWfMS5THjrPjQO7COfgbg8=
=xYUz
-----END PGP SIGNATURE-----

--8ulAMv3OVYmFxGf+--
