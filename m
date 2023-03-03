Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0921C6FA8E
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 01:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjCCBbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 20:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCCBbN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 20:31:13 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E558043450
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 17:31:07 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 121A35A1DD;
        Fri,  3 Mar 2023 01:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1677807067;
        bh=WcX2vb22VxShRa5lv1tffVcBwQzk6IPJpqPnR3NZh7E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xLgWqyQILK237cgiBGOrZw8Rv5oCCxcJzNCf5/cHQHOPjUdafDPcQUNb+R+qNc1dO
         v6iGVXeDHwRTOp+rGLJoTSRXCzNgig3Pcb6h0Xh8IwJ8G9axLMt2RzgoD/gyP0kdrx
         ktcyidhLg9DWY6xBsuOAdydrmWj2LPQ4r+UUTvJQtmd6enBEASBZAEfyjwNHSZlbt0
         nl0gJG9Rbsy8mrF6Hindo0zTbQr2223FPPv2koAe7lLofAu28Aku+9XTN+jYeOKtAg
         /EM8KGnIcCuY9CkPePG28rOoRnna6mdbaDpfijzvt/3kyl5AHl70YqYiOJQry+IRnr
         rr5NuEzB2wDnmqluvzDxGjkzBbN44WqzsBfV5Btf4ATDwGJUeDggz7u+R0FYT1NQoU
         zlbouc3vTzMbguX/vUgW7GkuiiE7T5cfgq7prygYfzrtFAHMYnSvBd0vpmmznIglU8
         JW++vEtMRUZXqBpOlBEbDRA/R+vT0j9aRk0lHT0kJuB7wSKOtOG
Date:   Fri, 3 Mar 2023 01:31:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dinesh Dharmawardena <dinesh_dh@outlook.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Let us not call it git blame
Message-ID: <ZAFN2ZoOQzUC/nHo@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Dinesh Dharmawardena <dinesh_dh@outlook.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <SY6P282MB3782FD975E6F39951C5A43DA92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
 <SY6P282MB378273980F5BC9084EEF74EF92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
 <ZAEgRDelTlNZRJ5J@tapette.crustytoothpaste.net>
 <xmqqfsamiul2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yk423/BqZQj9J/jp"
Content-Disposition: inline
In-Reply-To: <xmqqfsamiul2.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yk423/BqZQj9J/jp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-03-02 at 23:47:53, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > On 2023-03-02 at 22:00:59, Dinesh Dharmawardena wrote:
> >>=20
> >> I am writing to you to request that the term blame in git blame
> >> be replaced with something that does not sound so blameful. I=E2=80=99m
> >> an SRE and we actively try promote a blameless culture as such
> >> industry tooling should also follow suit imo. Progressively
> >> phasing this term out with a better alias would be great.
>=20
> I actually do not think "git blame" is incompatible with blameless
> culture at all, unless you blindly say "this word is bad, that word
> is not" without thinking.  Blameless culture is about not blaming
> the _person_ who made an earlier mistake, but "git blame" is not
> about finding a person who contributed the badness to the codebase.
>=20
> It is all about which _commit_ contributed badness to the current
> codebase (i.e. "these commits are to be blamed for the current
> breakage that made us lose $XM") and it is up to the users how to
> interpret the story behind these found commits.  It often would not
> be the "fault" of the author alone, and striving for blameless
> culture is to find out what led to the mistakes in these commits.

I don't even think it's that all the time.  Sometimes I've used git
blame to find the author of a commit to ask them questions about a
comment or change later on, or to find a commit message or pull request
to understand why a change was made.

I'm almost always more interested in learning more about the rationale
or reasoning for a commit than blaming a particular user.  I have used
git blame in the past to find the _team_ that introduced a regression
for assigning bugs in triage when the cause is clear (since they'd have
the relevant context to understand the necessary change better), but
it's very uncommon that I actually use it in anger to blame to a
particular person.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--yk423/BqZQj9J/jp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZAFN2QAKCRB8DEliiIei
gTNGAP4nBOFeDBWI/dyxALNfm4SAlptNdKX/inqfTchtr85YfgEA6nbo3kMH5R+o
aP3a7lbAmhVoOnRGFYW3xa3y/IRfJwk=
=1S86
-----END PGP SIGNATURE-----

--yk423/BqZQj9J/jp--
