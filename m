Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903CE1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 23:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936173AbeF1XOP (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 19:14:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47996 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936152AbeF1XOO (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 28 Jun 2018 19:14:14 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc1e:cd98:6cd:4087])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D3A346048F;
        Thu, 28 Jun 2018 23:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1530227653;
        bh=Qad9gaGC0Ungc+8xo/SpsARyaNBr+dA/bOwHzIhfgk8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vhU/lvjpl1RmTVc3ZChKFK+tiGX4uP6fDyzxNBw5BmSbb6qQm3+EAdP5C0lFHWxxi
         b79W+LMKnb8X61DogtknGodqWcrM6WZkqL5IVd5ZgeIYUQ4sUZCbu8JJfun6WC/Xti
         7kMg2thGfrCPL6WmT721owEeqVJjegyoCkzZ/sOovrAaQYzLrcYS1EohzH8A2LgI14
         mK5uERx57cNlJ8+nkYi3FekngpL3v40vev7stkBrPw2INpvGh5iTYYCPPU/m4PT3X8
         LKhEBeW/hehr4CeE3gvtQUJ6x+r4NrxE0ATrhIfPclHua6dXWosv9Atk/cHlk6Jljl
         OoeZaznC2KkymY90DqlhLT1Ui3W1VbRfMxHyArZE+h8HMcA1onWdyzONpeRq8qRBTN
         d/7o9IwfqfGDFFwC1qAiXVpFurpEKqRdmggs1WV8M/q5Cz1qiVpxuvaVRkBseaANWc
         gO6pRUbx2dUD8KTVzZbhILpoMtMgkB3kwzLmbNq3Ts30kGABIxJ
Date:   Thu, 28 Jun 2018 23:14:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] Makefile: fix the "built from commit" code
Message-ID: <20180628231408.GG644867@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.7.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X+8siUETKMkW99st"
Content-Disposition: inline
In-Reply-To: <pull.7.git.gitgitgadget@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--X+8siUETKMkW99st
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2018 at 12:53:15PM +0000, Johannes Schindelin via GitGitGad=
get wrote:
> Let's fix that quoting, and while at it, also suppress the unhelpful
> message
>=20
> fatal: not a git repository (or any of the parent directories): .git
>=20
> that gets printed to stderr if no current commit could be determined,
> and might scare the occasional developer who simply tries to build Git
> from scratch.

I saw that building Git 2.18.0 for $DAYJOB.  Thanks for fixing it.

The series looked good to me, too.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--X+8siUETKMkW99st
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAls1a8AACgkQv1NdgR9S
9ovxbhAAiAxb4Ycw1s3o557f/d79awxi/4Jnah4Bf1vRg1QaSKEcLrU5nMdlA59q
1PFtk4MaktUkpNKbJWB2/qr0wCzQhucRjZ3eVRWjMtH/DBpgFs3LBXA+4k63Ap8M
fPL8kT0XxMIpbBNsu+BG3+muudWeQL//WkIPpYtvo+CVjiYAz/MqWfYctOAFu2yP
IYIvpbSdMa/wRieeAgv3mmpXcN1I4Whj/FarEPCskYeoRj8z5Y4BU8bjTHyTyoac
GdsTk9XfbUxqxWwkw2O47f1Vn+/GAAcld/+g1bQVghA1no4jQa4M13qo9XZlxf4K
lwnEn7/2Jd6XQnRPhFppbNC360LfHTRXdTU6x6WRgQ0PHjdilaH5k82J9NaqLQ0s
vEP2geYKeZkcXNInnUyqaU0PTuKacjStT+7EQwA22nusYwpVnJ87IxARGo1KtD3D
lxLemddeAsEySk9IhPbfRIJFIyZftQVs92uUFPxCKn0BX/pVb+OJf06v2eBUKXBd
jIUp2WmobQx0V6DBW0zbVYNlPAp0aueikfpWwbdQd3GYgi2rFb70VExRaFqXxCYO
yrgyUSrbhUV+LztjURRSazCyhEanpl3PHUq2IGIFF6qn/2Q3Cj91li2SBZ9m7yfO
DVxK/6ABIhCfclrAl9atHs+BMvRPcQFaG6H4M84T+xBiB4H8RF4=
=PDF5
-----END PGP SIGNATURE-----

--X+8siUETKMkW99st--
