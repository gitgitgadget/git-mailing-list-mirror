Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4D321F404
	for <e@80x24.org>; Tue, 28 Aug 2018 00:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbeH1ErO (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 00:47:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36068 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725198AbeH1ErO (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Aug 2018 00:47:14 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7DBA960428;
        Tue, 28 Aug 2018 00:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535417888;
        bh=Ti4msb6cBeIOgeO4CaQ5N/eT6uqwM7AjbWjVNH3KkNM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EBuJ5hK/UMWUhXmxqbrWRBq35FP3NRCxSJBXFeTFx312A0Vru9vqJ10jX9gCMl6Wo
         i3mL6VR47obEQBhbvDFM+ZR9SqL37bqv5dO42XWuwup9VrSiq5ePDj7v2/q+E3Gmr1
         IBCoFd2twslmaQYRSmiOYf43D0/ufjXRLuZ9RtHOwFGmHAoOkx0Lc8m5JJnHrhI9hZ
         zLf07kayqfIor8hAqpdGl1OowI6lzTza0K0tzHhLUkpOJE8VzBgilM3ZNDlezcUFKR
         Mq7wYQMx9rMIHjyNslmjI59qiZZUm7Iq7Jcu3MRSm5Sg4SrUMxITPF+KK2gH59L2+7
         tUsMIpGvfNXeNrm2w8WvreIE8X14tGbMnXUZ7Lm/p7/dPOhEHocfJxVVAakgXwL7oR
         Zu95Qhaak0sjt3IGQ1OPgxcEcFQOB0Hx2h83bRK2MPFSS8dYkJGd/mwTEKwHlndzg1
         0yaQqwh+2RHi4yShvNY2JeSKh/m7husZvUK6G6whgYt/Cy5XI7S
Date:   Tue, 28 Aug 2018 00:58:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Brennan Conroy <brecon@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git clean removing tracked files semi-regularly
Message-ID: <20180828005803.GB432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brennan Conroy <brecon@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <MWHPR21MB0701CD1D9653E82116E482ECD60B0@MWHPR21MB0701.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <MWHPR21MB0701CD1D9653E82116E482ECD60B0@MWHPR21MB0701.namprd21.prod.outlook.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2018 at 07:06:59PM +0000, Brennan Conroy wrote:
> Hello, I work on a project that uses git. "git clean -xdf" is a common
> command to run to clean up the environment, however sometimes this
> command deletes the entire contents of two of the folders and all the
> files it deletes are being tracked which according to the
> documentation should not be deleted.
>=20
> The project is located at https://github.com/aspnet/SignalR and the two f=
olders it likes to delete are https://github.com/aspnet/SignalR/tree/releas=
e/2.2/clients/ts/signalr-protocol-msgpack and https://github.com/aspnet/Sig=
nalR/tree/release/2.2/clients/ts/signalr
>=20
> If you need me to collect git logs etc. please don't hesitate to ask!

It would be helpful to know more about your environment.  Is this only
reproducible on certain operating systems (e.g. case-insensitive ones)?
What version of Git are you using?  What does "git status" say before
you run git clean?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluEnhsACgkQv1NdgR9S
9otmaxAAztuuN+T2e7+sOtQpdmxtG23im1Nl0/N/gHJO0hcDCVfXAc96+mlFLLhN
q+nY3zZ+jQ0KvigawQ574YqXajZiqHUuWXg8a1uC+WLgC9S0PoRrmDEXA3FzYq5f
8Tw4KofVVxzIGXlfWlpAqEcrDo6FYzies1yNOS0RZ4TQ8yBENgVI61Q73ynuk2I+
i78gAc3MrM0X60kgSEiXaXnfZVxJqAHDPm2CxOoarMfiNtYp4zvKVLBKc0cD5Rra
2qIpcNnAPEelwP78H7XiEo8jeGC0p6r6hMl6erZaB7OH9gdBSoTXoASkmtk3lP+f
xDBvH0Qpvt9A5A9Pbg37Wv3pQ8G164Xr9OUdqaM250sru1HdsjkSVhOM/qKhZTNi
WzJ5wcukTOBsfujrIANZnlmeulJ/6PDtq73LuWgxXm9n3lO7pzqos01zj6odzMfR
iKTeS9sXzyeyRrUMbWVq1/bvgVDaCsAdcoFOqhU2FxwXxCxXsE3M9Mx+t0Q1fodf
vxy4YaUGHapVnMHUksz0cB+LdkFBFpFRUIe/UfbU92PHPbGqXOy1s/zC+2c2C7X7
zBJGK7ZibuMc0LgB77Kt9fPXnc6k9ROQzLfHwazyndo8IKBkwjM09XdgyOZg46PO
0sCk5FKFPzbaiUQK4o7ElNynpm8RjqW6YbFykXgV/DpwwSkikFE=
=TzoJ
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
