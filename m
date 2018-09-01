Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 359A81F404
	for <e@80x24.org>; Sat,  1 Sep 2018 15:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeIATpl (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 15:45:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41332 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbeIATpl (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Sep 2018 15:45:41 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5434E60745;
        Sat,  1 Sep 2018 15:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535815993;
        bh=+I0BthhjgUJWEGQDRxYJ0Gd7W6pnTg5xvI2gCLrTCNk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ycou+rBQrgE3W9hUQsDO7REkLzs4Pbe+xOLpRn4gSbQLHd7LeRDyxWAsmSP6IgP25
         uwhwSLGAjig6X2AUQYcfkjK+gsZ0tXAFoeYaWo6KKWIe0U8be5WrJ0RcXz5Oh3/Doq
         niMImcyXYb1ch0C9ihhScNWv1QUx7sXjsjTF9W1B8t31ybYF1ItnLpqHhSK7aAsoFn
         Y5ts5d4arFtKCzDVzoifiTDtWizhDhhlWaqW8RARsh3nl+VrqHc+L8YMnYznSw+zT8
         +xGayRu7QYX984eouuPJDbCEbwj40qiB3sL3aRiEhhOuixVxqxvx1nb9uhaKjmfzRX
         fzw2yt4CFcZkDUrkuaVBIBXqHCITJUHSb5fyD6VUfsP/vbBSfNiiX8b9pYAGyXEIzS
         vD35VuCoRmBq/Jpc3YB0JqysMLc3DClOHyzJRihqDPKKDhqu8w3p0sWyCBwk2DFj2Q
         1qvlPfl822L8vd2YLCJ0TUGJpxrzI4PH3KgYpy/qErhMD38FQEG
Date:   Sat, 1 Sep 2018 15:33:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 05/11] t0027: make hash size independent
Message-ID: <20180901153304.GM432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <20180829005642.980617-1-sandals@crustytoothpaste.net>
 <20180829005642.980617-6-sandals@crustytoothpaste.net>
 <20180831182141.GA9399@tor.lan>
 <CAPig+cSSs9a_RSnc6==zb70Swh1L1Ok4y-DGc8YawPyea0Gm9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iUV/lbBrmPtUT9dM"
Content-Disposition: inline
In-Reply-To: <CAPig+cSSs9a_RSnc6==zb70Swh1L1Ok4y-DGc8YawPyea0Gm9Q@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iUV/lbBrmPtUT9dM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 02:40:12PM -0400, Eric Sunshine wrote:
> On Fri, Aug 31, 2018 at 2:21 PM Torsten B=C3=B6gershausen <tboegi@web.de>=
 wrote:
> > Out of interest: why do we use a "tmp" file here?
> > Would it make more sense  to chain the 'tr' with 'sed' and skip the
> > tmp file ?
> >
> >         tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" |
> >         sed -e "s/0000*/$ZERO_OID/"  >"$exp" &&
> >
> > Yes, we will loose the exit status of 'tr', I think.
> > How important is the exit status ?
>=20
> As far as I understand, it is only Git commands for which we worry
> about losing the exit status upstream in pipes. System utilities, on
> the other hand, are presumed to be bug-free, thus we don't mind having
> them upstream.

If that's the case, that's fine, and I can make that change.  I know
that we do often want to preserve the exit status of a system command,
but presumably the tr and sed here would exit 0, so I'm happy to assume
that for the test.

> A different question is why does this need to run both 'tr' and 'sed'
> when 'sed itself could do the entire job since 'sed' has 'tr'
> functionality built in (see sed's "y" command)?

It doesn't.  I went for a minimal change, but I could switch to using
both s/// and y/// in sed instead.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--iUV/lbBrmPtUT9dM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluKsTAACgkQv1NdgR9S
9ovt6xAApvN9l3wP90KlePZq1EsOY8P91WYHoQskq5KdyuIm4ifStDp9qfhDO7d/
8FlP4tRQU+x5s4dB9glq+BakEI3bA6yVuYRZkCOOefXmfIfxnusC9AWO1pkdpWq1
pSJdKScC+CZpPs0z0M7RGZkaXI8hrRv9jB8LRKs1weolt3tsFUcykX+RwBZ8AKpB
WYYfxnYhFG5LWmRy2Hn/K7tH+NihMdn7lBVIFldQU86W0EiR80YFrxOwDltpri7q
iUY5GPWfu75WbyfwcHhaawvsMH7RaxpEcE2ApJJWFNiqMulonuOnlqYRFI1JMlRo
Xh+cMLfpleNb/5+oAo1Rk23bz/cb8tH0nQ9XMCitSjye8xkWlZybBQgrgtbNoIVZ
8dibXbWYIV+WJR7jnqjzrxcb92GRH0fuRAjhEweNn0puLlf93D3tKUWnY8vXaQkA
GA9Kf4bwNsaN+Ouu5voZxxPUM3WRzHS735aBMULERK5ittIgZEWMZHSa0aF/5wOw
IBHsBgMTCIyf+Z3uHzRf/bOSsOnTQUStskbJIvR25S+Hr8HBGtirZSKY9aBqjiuD
8ldTbfYHQ2aeoRkYXmD48TZKsk7Eqmc37auQ269vnZTKEVOuu7oSzQlC6z+N7/SL
Rob0zy0B8I5htvfETVFwzDnFfnCdqAcsW0LkjIhChfVANXIxjms=
=fuhD
-----END PGP SIGNATURE-----

--iUV/lbBrmPtUT9dM--
