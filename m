Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A436C433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 23:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C84206F0
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 23:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IXc9aUNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgIAXie (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 19:38:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51772 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbgIAXia (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Sep 2020 19:38:30 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8E5EA60129;
        Tue,  1 Sep 2020 23:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599003478;
        bh=cdpYkdCKvUsWlz3Ybvou2YgoCrxU8hyvEuhM9Kafjgs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=IXc9aUNoigVgXLQXCO5/poLudullmLE4VoBSbEYsKG+UyHdkCmgniMTUmawxr6FPv
         M7OZud2NBzb3aNBt1BRHryfZgoouUy8jFLIsjZcRrmkrbpZ2v7w2gcUCGcgxnqETgz
         uhHvL49xg/k5Kh1ELuP7DCVilmb36DkVJPpjR5cx+0CDvxa/AhOSzqmKdJ8Ya3oNjW
         nZclTfdcj1aFeY+lL0FZ8KG2mhPJW2Jr9EbBI2rZPvN8icJhXONnBwZ/cRhGiWB6y0
         reLQauELMQz7N0uKJ3K4aDftKS61qFxvXuIVuoy0cnqN5cc7GCz/kHGAbNm5p+BfWA
         sOesT5hP9GBTzfPqfYFroe6zfU9f0480t34sHZRJwF6NZPH3AK3U7DxPw8cFLVtMbn
         xrlJ4lHN+26xot8dFkDIWAw/aYtiX2chl6UWOvV+D5N7nGpzHldPqdI7BKxHMHQjoj
         CrySSTUnhTh6kAwxwuClceG0JXADCPkEzUrSpvnAdwOnvG7PccQ
Date:   Tue, 1 Sep 2020 23:37:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: Re: [PATCH] core.abbrev <off|false|no> disables abbreviations
Message-ID: <20200901233752.GC241078@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
References: <20200901074355.GA4498@dcvr>
 <9c00f29b-45e4-ccdf-6d81-5eabd58c875b@gmail.com>
 <xmqqblipebto.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
In-Reply-To: <xmqqblipebto.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-01 at 15:49:55, Junio C Hamano wrote:
> I was in the vicinity of this code recently for reviewing another
> topic, but IIRC, 0 came from the UI level does get rounded up to the
> minimum accepted and never reach "default_abbrev", but if you manage
> to place 0 or -1 in default_abbrev here (e.g. with additional code,
> like the above part with the right hand side of the assignment
> updated), I think the value will propagate throughout the codepath
> and causes the downstream code to do the right thing.  0 will give
> you no-abbreviation (i.e. full length depending on the length of the
> hash) and -1 will give you the "scale as appropriate for the size of
> the object store".
>=20
> I have mild preference for using 0 over hardcoded single "full
> length" here.  Even though we currently do not plan to allow
> multiple hashes in use simultaneously in a single invocation of Git,
> if that ever happens, we will regret hardcoding the_hash_algo->hexsz
> on the right hand side of the assignment here, like this patch does.

I think we have some commands that accept --abbrev=3D0 as a value meaning
"no abbreviation", because I've touched that code as part of the SHA-256
work.  So as far as the option value is concerned, I think it may make
sense to use 0 for that meaning and just document it.
--=20
brian m. carlson: Houston, Texas, US

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX07bUAAKCRB8DEliiIei
geXbAP9kK2hEAzfbcWx1wYZLDL1YrahFNBZPb03qzbUbKjxVggD+LALK8T0UuMYt
B/qHMWxQHK4BS3v5HrCBQcN9rIz2PQg=
=3sLg
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
