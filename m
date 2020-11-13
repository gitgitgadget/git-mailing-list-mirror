Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D374C5519F
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 01:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A75520B80
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 01:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgKMBBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 20:01:16 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39820 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgKMBBP (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Nov 2020 20:01:15 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E867C60756;
        Fri, 13 Nov 2020 01:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1605229272;
        bh=F03QmCYK45Tye/HIAbWXK511ZMDYwYB0p3KPjKzYvUQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ESMOcYmvjSXxKtP9cYTGNrxJWJHe9RIi187auXdMGJB5OBGANAf+R5f19yKPuY3pU
         vsji4KsgNE9a1NF73VINBp0mORsunQbOMWUiSNZzh2N0JJIjsUjK9AHGc/prt/2u6a
         32IdsQ93SpX9p7rHWMqmnWnrW4cb4OdRvnFzgaajqDNxJ+le14pIu5e7R7mOpDARXL
         RiYWAINwcQ5s9PJOnXgKP39EO0+Su2gggeY00owpr1gwJR+7Ek8Ldw99akepjHezdN
         hpOgaVvPCUHBhDz1PSV3dXupGyozu9NLjZqx8dMb8T6xKQ6KqrxjcNUoDS1NpGc8nt
         Je/z7TFK7LKocG2cfAYEoDtJCKNDrtmePjFpploYCqp0E9WXjU6TTCXYqy9A8C9o0H
         bVJUwJub6/i+rYzF3NMTTm479z0kDGJj6znC3BYcY9NKZJ+z61vibeADJwiVwFxCht
         SYiFrdX2yXrJq1JRIIiqQBixLUTMLNIXgudloXoqGx7BX+QNhum
Date:   Fri, 13 Nov 2020 01:01:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo
 fiasco
Message-ID: <20201113010107.GL6252@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7vAdt9JsdkkzRPKN"
Content-Disposition: inline
In-Reply-To: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7vAdt9JsdkkzRPKN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-13 at 00:04:23, Felipe Contreras wrote:
> *If* we are going to rename the master branch, it should be with a
> good reason, after discussing it appropriately, in a major release
> (i.e. Git 3.0), after a period of deprecation, and a big warning to
> invite users to provide feedback about the important upcoming change.
> We can hedge these types of changes with a "core.mode=3Dnext"
> configuration, as I argued back in 2013. [3]

When the original email that proposed this change came up, I did suggest
that this would be suitable for a Git 3.0.  I think such a version
number bump would be valuable, but I know that Git doesn't follow
semantic versioning and I'm happy for Junio to make the call.  Git has
made incompatible changes in the past in non-major versions, so there is
precedent for this, although I agree it has the potential to be
surprising.  Again, I defer to Junio's judgment here.

I should point out that there is an option to test or set this already,
with init.defaultBranch.  I have used this feature for testing in the
past, and I use the feature now to set default branches.  It's also
possible to use the template functionality to set a default branch name
for new repositories and I've tested support for this back to at least
Git 2.0 (but I believe it goes back even farther).  And, of course,
either of these options can be used for developers to choose the branch
name which meets the needs of the project best.

As for consultation with users, there was a discussion about this on the
list a few months back and we did get a lot of input from various
parties.  Some of that feedback was hostile and inappropriate and some
even violated our code of conduct in my view, as is all too common with
potentially controversial topics, and I'm not eager to repeat such a
discussion, since I don't think it's going to result in a productive,
positive outcome.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--7vAdt9JsdkkzRPKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX63a0gAKCRB8DEliiIei
gW4tAQCSP0NOzT1KNga1QYx8CvxDvKKGnjo1oYi5i0krg8OlEQD7BE6t6Pbe3O0K
6xBTUObPu0wpcR7cGJh7fNLJkYOSzQA=
=Fa1a
-----END PGP SIGNATURE-----

--7vAdt9JsdkkzRPKN--
