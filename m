Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD8DC4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 23:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6CC2076C
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 23:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="M3mVfp0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgCSXbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:31:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57614 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgCSXbn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Mar 2020 19:31:43 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8257960797;
        Thu, 19 Mar 2020 23:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584660702;
        bh=MQdqiA7LG4CqA32UkFSTtOnm823SJM+i4xVPSHoPYvY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=M3mVfp0GIQWS7ld5XKGgR0jmnBxW5DfN5Exm85+FoaOGf0C3T6ZFNbVNETFrBBbSP
         wL2boyXKQqdH786J7nOXhEsbg9eZoXDNuaQpmdzkO3pvXyRtdlzP68ngZAGrYBboHn
         4U0BYT7+tNAtznywKhBTF0F6fLvhxZ/ZQznCEE7j98w/ozya6q5sW9lpEm0JFHb2uF
         Z9/UfL/DDVR/P8iJraslUPiRadCcnxK9HlEKlChxKZo/83Z9eAEaqXAN/K+Z5fevrq
         oJtSmU4IfuJBEAbwOQBUhTpvbhBYZsuFI5lalxw3VMsZ+Jbkvzmr98II4VOO33JQwz
         ZNq+KrDky7l77w9Nv2L+X5gs5u/K62dx4+9y0FDmoyggGCH9SNV898PewZg5v9XS4s
         JsOnmgmpTDGBJsc1tb1L/973R7P7Hdqz1R7mz1hEu5wv6uCONTEJXitJnS2N74KYSx
         nrElArfbEyytDiPODcfFHrlF0r9+SeaNZVdsuSAImwt5qN3xzKy
Date:   Thu, 19 Mar 2020 23:31:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, emilyshaffer@google.com,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] docs: add a FAQ
Message-ID: <20200319233138.GE366567@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Johannes.Schindelin@gmx.de, emilyshaffer@google.com,
        git@vger.kernel.org
References: <20200315223923.170371-2-sandals@crustytoothpaste.net>
 <20200319170204.5291-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
Content-Disposition: inline
In-Reply-To: <20200319170204.5291-1-shouryashukla.oo@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-19 at 17:02:04, Shourya Shukla wrote:
> This seems like a really good idea! There are tons of redundant questions=
 on StackOverflow
> regarding Git in fact. One thing I want to ask, is that will this FAQ cov=
er questions of the type:
>=20
> "How do I change the remote of my repository?"
> "What is the difference between a git merge and a git pull?"
> "Git is tracking the files mentioned in .gitignore, what to do?"
> "When do I rebase and when do I merge?"
>=20
> And stuff like that. Basically questions which are more of a help to some=
one. Or are we focusing
> only on the FAQs to kind of guide the user in Git, aiming to answer the f=
undamental questions and
> not the general problems faced by a user?

I think these kinds of questions are good things to add.  I do see the
tracked-file-in-.gitignore question a lot in particular.

Part of my goal here is to address these kinds of questions in Git's
documentation itself.  If many people are asking the same question on
Stack Overflow, clearly there's confusion and we should address that by
making our documentation clearer and easier to find.

My hope is that folks will start linking to the FAQ once we have it up
on the website and it will become a good starting point for people to
find answers when they're unsure of something.

> Also, I had some FAQs in mind, can I add some into this?

I had always planned this patch as a start.  I fully expect that we'll
add more to it in the future, so I'd love to see additional
contributions.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXnQA2QAKCRB8DEliiIei
gQbSAP94aKV20lEwwuUIMWU8MkeKZVXzEdxvHbYkJJgyPFB4xAD+OMCoBzO9jmqu
xYZezbWbsz96cKa6ij68oK5HswcbkQI=
=XEHX
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--
