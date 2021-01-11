Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F336C433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 01:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A352253A
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 01:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbhAKBxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 20:53:55 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50616 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726110AbhAKBxz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jan 2021 20:53:55 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C21EB60781;
        Mon, 11 Jan 2021 01:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610329994;
        bh=W83q3f+aNHfm8gJZtesrH6FWpo203VWKufa6QkFJrSU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XlpxDQ0aaBewUZ3bRHPMFSjSV2s23Q3raZ2eSgXva29IIQdIblBbLN9FxMURxK4jM
         KMiwp90WwIPQwSYN0TWFVmF2Dyscl/vmjkuDYtpeRgDRlz2EA15zQEvnGekCyMpsJt
         ZVJtNiMQximkvE92fJ1GZdIaUAdaCXV+TZFGc9KMKSomMkoa7dd28MSld3vwHQArpP
         PF4JNLcH/ISZEUXV9PGpsIPI+FQ4F3MZHXrcsY09QOYteOSF46CY3wayX/xNC7MzG1
         WP3apVgccb6OsJnuN9BtgjOxw1YODMw9Q0PA7QVIuKINRbKNndTpSw/i3bkCGFFVJP
         siISoXqF+kiL3ySc696eyyVQuzGoy3oFRkm4QeYtOy1KlbYoYXFE4m+7lUMdlf0Uq5
         zj/ft79Od+Yc84N4lJJNia612QWNAZNj9cHFHyt7QDK+bdjjBid2b1THS7jFRNEucy
         vxLRzz7Jz0yKxrl8jBkMlcEYgVK9l1v6Mmess3dghkrrIHHOKnb
Date:   Mon, 11 Jan 2021 01:53:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
Message-ID: <X/uvhc5Hpu792qA/@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
 <871reu752k.fsf@evledraar.gmail.com>
 <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
 <X/oosXBJlyt/IrOr@camp.crustytoothpaste.net>
 <xmqq4kjpelza.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="djM5IriLqm98jWtm"
Content-Disposition: inline
In-Reply-To: <xmqq4kjpelza.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--djM5IriLqm98jWtm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-09 at 23:20:25, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > On 2021-01-09 at 21:28:58, Junio C Hamano wrote:
> >> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >> > FWIW there was since a re-roll on 2021-01-03, but the discussion is
> >> > sort-of outstanding, so maybe that's intentional...
> >>=20
> >> I had an impression that those 4 or 5 patches haven't gained
> >> concensus that they are good as-is.
> >
> > There will be another reroll.  I'm hoping to get to it this weekend.
>=20
> Thanks.

Having read =C3=86var's latest comment, I've decided instead to drop this, =
so
feel free to do so whenever it's convenient.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--djM5IriLqm98jWtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX/uvhAAKCRB8DEliiIei
gQ+BAQDFzWK8bQLS0RRJBVeKCYTz2mkDhI9pWeg9dgk3ZGCUcQD9EEqTZUY4hQTn
Fi16rxy15IK2UYIJDafdzOCMErndZw4=
=LH6L
-----END PGP SIGNATURE-----

--djM5IriLqm98jWtm--
