Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BC2C433F5
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 21:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbiAWVcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 16:32:07 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:37210 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbiAWVcH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 16:32:07 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 6E9215B227;
        Sun, 23 Jan 2022 21:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1642973526;
        bh=WCgmQ99r+I0FO4MH5f/cBKAllgESRUO3ASY9S5zpIZs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xJOtL8eOB3JBhT8KPZS/ByfBHwC8RTtpOWtJx9MZj62E3Ev8BjS0ZQRh9bryBsCpU
         uSumfZIc3VquUo2yuCeXDvlRPv6X6B1RYDwNUzhZFVPLOqex0+wlM4cRfp/3jI8KsT
         g8I9f5gWU0YlzXWGyxxtxBGGaj3WhTJ9wsk3ehVzJooNDhpN2Kjn8bUNzqH6n0fXHG
         3Fx4PaFSti5BowsufTR9CF34jjtU4bycYxl4wtvAYqh+cEEAdqFE5lgLRxvdNu7MCw
         iPJcHYvcVwkWPc1Pyy7IsaKHJEoA5yhIGQq3cFNCUzmX6m2IAT6P4zMC3sewGTSaFM
         50H0FID+nkK9Wt1SySFWBQ6EZi5kmjICMfWX38q2B9/r5BK+hsF/RTY7DUDyaRnNWT
         uGimDgiqAR3JCgpwGCE4e/dhpIzuPN3djFi2i7LBqwp4zhkALIO/cq4ooBjHzYLeyw
         ExgsOCEmLUQbfGgsWUyAm16lzffVmqxRejVYFP8hFrvb9oeSAUd
Date:   Sun, 23 Jan 2022 21:32:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Contributor doc: more on the proposed log message
Message-ID: <Ye3JVEm77d7zMU5L@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqilua89z5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rZK7J5AN7kal5gcT"
Content-Disposition: inline
In-Reply-To: <xmqqilua89z5.fsf@gitster.g>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rZK7J5AN7kal5gcT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-23 at 20:37:18, Junio C Hamano wrote:
> I have been thinking about making it more clear why we care about
> the log message, and noticed that we have CodingGuidelines and
> SubmittingPatches, both are specifically targetted for the
> contributors of THIS project (not to users contributing to a project
> that happens to use Git).
>=20
> I think the first thing to fix is that we have the "describe your
> changes well" section in the latter, as if it is not part of the
> code that is covered by CodingGuidelines.  You formulate the thought
> on how to explain/sell your changes to others, and you sift the text
> you add to help fellow developers into the ones you leave in in-code
> comments and in the proposed log message, while you code.  I am
> tempted to propose moving the part about proposed log message from
> SubmittingPatches to CodingGuidelines for this reason.
>=20
> Independent of the above, here is a small update I would add to
> clarify the project convention on the log message.
>=20
> Thoughts?

I think this is a good idea, since it differs from the way people
usually discuss things outside of literature, and it's very common for
this to trip people up.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--rZK7J5AN7kal5gcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYe3JUwAKCRB8DEliiIei
gcKeAQCCR/ZDA83IqJs6DGUMwcanX480CMR8CmZpUBkcFNf2FgD9HC8QsvFjiCMr
UwapyVrrjinyhsKK7HRMnCtLwT4CBw0=
=oXzV
-----END PGP SIGNATURE-----

--rZK7J5AN7kal5gcT--
