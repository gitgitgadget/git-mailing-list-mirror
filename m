Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 950E520437
	for <e@80x24.org>; Thu, 12 Oct 2017 10:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbdJLKW2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 06:22:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54932 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751544AbdJLKW1 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Oct 2017 06:22:27 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AECE46042F;
        Thu, 12 Oct 2017 10:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1507803745;
        bh=SO6Wv7MsMKlpZHSxBjM+nMp0ogibCCmQZLs2ISppi0Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uRLIPYWyH+WlV4DUsaQ7WvgRcR2nbDLSUZEOYyEgjjq1Xaay2GU0LHdONiuT2gByQ
         HLFW4rn63ZoL7TR2uRYgcU9xjbPJDTZiJHmejxUM/Wepucg/iC2Bu8LJIE93cVkg0p
         6R2oK/7MzHfmRoAJkVkEXaPz+7hlJu3+IZ01pUA4fNGJoAV5NFtmcDv90FR+j7aTvl
         d8K+9B39SlSLY3XTgry/VCJHB7J7OrAVchJSaCOIaxPCACJc1kkOaeP6/p716QN12S
         S6YFrxRA9ctlCKvrHFJymknY7vZC8TKUYCwIVGLy8S8J8yshWZgdRA3CnXAEbvz4s9
         YYwQO/JP+qLA/7JW9rlFZ8+jqd9nap/cFgMQ/IJ3wkxdqstrGVDM3Cx5Wi68MFuOcQ
         zZOaxnL5wzAtlW0Zr+rvLGvMpdhcsZDL8rv8DW/8RTimeyQUl/ped+/mKgJmzIvHc7
         +Wcxac62oQgrwnwGSLvbOGg25wYLoJFzEUTlCpN1oAiLvzuhJaX
Date:   Thu, 12 Oct 2017 10:22:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 00/24] object_id part 10
Message-ID: <20171012102220.zfrsg3hgtmiahwow@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <9e44abcf-abcb-4868-d1cd-2326ea8df3ed@alum.mit.edu>
 <20171012084610.slrweolcgwnfgvu6@genre.crustytoothpaste.net>
 <xmqqo9pcznza.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tghlbu7thotf3mlh"
Content-Disposition: inline
In-Reply-To: <xmqqo9pcznza.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tghlbu7thotf3mlh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2017 at 06:58:49PM +0900, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > In the course of that, I'll rebase on top of master so that Junio can
> > avoid as much conflict resolution as possible.
>=20
> I actually do not mind either way, but by rebasing on top of a more
> recent codebase you can lose a large part of 07/24 IIRC, which would
> be a big plus ;-)

Yes, I just noticed that.  The patch used to be bigger still, but as I
mentioned in the original cover letter, a lot of it went away due to
previous work in that area.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--tghlbu7thotf3mlh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlnfQlwACgkQv1NdgR9S
9ouL5Q//eSFsVonb/YK8m/N42lM9f4GWiOCDStYrbMaCnPeaoAdetBMkjszgbttd
w+ziXHNM+JYfbdetsNhBrgYXdu7MpOQf9eALcrEMP6SY3DpNwLIENt1NvTbZ7mCF
7HkovjbHRs4M4EO1B6xWJjmGLPmLQpyRywS12iisD4iTbiqOBqkgWXmSPnPJ6J90
ybbNmtuqf36fSPQD6RbT9OMAtFsA45DBWGez7KRQJ5xKviay2iwRcxoIkw0L+22s
fvvfmm5bBH8JPulAAS+LYsctM7SPpAEXYEX/WWLU0LJSzfLAipe6KR2Rw19F+TbT
A0tqZJnkHi0AO3rWeQNT50BaR3o1icpnPHhV/d0c3WdxeZzXi9ko/QTPW7tE9yyi
5HW4TY93edlKs0LiJrnM7dUf3SlANTbM/wgm3/v/xWW1AH9yCMGBONaY2DdYIHBR
p4z2ArnDhr+58yYr4TKCzA7x5UJRKN8Q4nip2ic1I6LOYu5EjAfl+WafoFPBFGAp
BzPUoZC8Vke69b/nRo4onwWGSENaeIbd7F+IM5hdkuQldSE0zAEPEAW7ym9iHy/n
2MCkoA9k9b9G74M7ix4QsEcjT/oJrljX4STQ5pjE7sTZm+R55eNHzbY5Yp4fKqZv
CgaoFkaMuuriBXVp/w4Hm+XVOuFYAorIMf+BqvbsRw3A9j76mgc=
=kdCa
-----END PGP SIGNATURE-----

--tghlbu7thotf3mlh--
