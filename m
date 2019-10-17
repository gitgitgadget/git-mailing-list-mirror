Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBB781F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 22:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438120AbfJQWzg (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 18:55:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46142 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389846AbfJQWzf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Oct 2019 18:55:35 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E04F360459;
        Thu, 17 Oct 2019 22:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1571352934;
        bh=gwDdVO1Lr/qZ50BKhGFrpLR0+2bTpWkl2E+SMC+cdSQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ig0CgEX0mxpqCodxQQOR5ciVuFM9cbc6AXS/LX8RZkrekBqQ6Nwo0ccRBoPstQedY
         +IXPfV3fhDQq6zIEdhyTzpDOtVxhBYYQZG5AbyhzwVHOIFquc2DLtQ8aFcAvy3ZuEs
         w+/YFcmpGxND3rhQjt/TNuemacWxyVctrad1lyqzzsQ66ASFexeE5CW2jnRLi8KiJN
         KNseK1pY+6I7N7/2jE3OjjsOiGy4w2YBBZVzCUWQRJo9Q+ULsqbYVNAWMJRBVaeSOP
         3aeFE9ipb5JrUUVcbV0ZzmVKu8moj5nbEnON1YtJFyHoGFE6XO2roulyJ/vlWHOHvj
         OVYigkTDSB+Kg8DNsD/Oq4zG1PV3DYrdOKtnXOdCawYa6FKC15MbZkRixGBIZJmZI7
         gTt8VWG8fzI/glaPA22I8Kb8Dcz+uTFC3NPRaPFdubC0TitXe1Ox/WQ2SM7sTJCMhO
         8G9nJpmLvLXTHlWlOHK7W0YR7GlWMYxRyoEK/PtP0bUzGlsXfYT
Date:   Thu, 17 Oct 2019 22:55:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ralph Ewig <ralph.phd@protonmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: git smart http + apache mod_auth_openidc
Message-ID: <20191017225529.sg37cxvyssbaitfw@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ralph Ewig <ralph.phd@protonmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
References: <4eb22ffc-77a1-4cd7-2277-bdc57d31186b@protonmail.com>
 <20191016233319.3rhmekasi5csytyl@camp.crustytoothpaste.net>
 <1320f616-ddcc-0eed-22f2-e28eb0abf039@protonmail.com>
 <20191017060322.GA10373@sigill.intra.peff.net>
 <5a2cc6f5-a8d0-356b-ff4e-a716aa5675b1@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y724fijyu7q4opnb"
Content-Disposition: inline
In-Reply-To: <5a2cc6f5-a8d0-356b-ff4e-a716aa5675b1@protonmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-trunk-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--y724fijyu7q4opnb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-17 at 14:33:38, Ralph Ewig wrote:
> Quick follow up question: can the git client pass
> a token read from a cookie with a request? That
> would enable users to sign-in via a browser, store
> the cookie, and then use that as the access token
> to authenticate a git request.

Git has an option, http.cookieFile, that can read a cookie from a file,
yes.  That does, of course, require that you're able to put the cookie
in a file from a web browser.  I'm not aware of any web browsers that
easily provide an option to dump cookies into a file.

Also, just as a note, this approach definitely won't work for automated
systems you have, such as CI systems.  That's why I suggested Kerberos:
because you can have services that have principals and you can use those
credentials in your CI systems to access code and run jobs.

Clearly you know your infrastructure and users better than I do, but I
don't recommend having a web-based sign-on as your only form of
authentication for a Git server.  It's going to cause a lot of pain and
inconvenience on all sides.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--y724fijyu7q4opnb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2o8WEACgkQv1NdgR9S
9osG3xAA0BQmoDvNasg02PK7Onx88NOzNPMEmSH64XeYiXQrxwfnxMBsU+JkLLhK
gYjEhtLqwN1grULj5/mv/t0ZaNn+G8ehIULG2NoSBBh4myhSItrr5N6bfsUTNfn+
GPn6GzUAl0RBtDjcUwE21IcT4TbonY4nQv0GGgZBI9e9Vq7ShlgT7/njnVXYObzH
FOWmHrhl3CQMlL3LsDe/Z73YJFXwRwF3AqkG82ePwql4WdijeY/4rx8qOOpKXO0m
nTKYGBIPA1j2IoVo60s20c1U8hbdmsJ0sLUXjvwruOh6YkDYiyZMkD/Buc693eQ+
t4kZws5zvZrpcVe4rnHjf32MaxhQ5vQXLtVH2Gof2dvtWFMjVMCcIa9pl/12b5iO
eVSEkqzgU7DX76ic4GZxtL8lqeR9LmyunlJDuHQv44qXVrMQ8YX036hA8O8LCb80
+ksN7imlg5HQOhn6osaxIi07Wxqk5ExDKbAnYvC6fZ6Zzfr8BBBaRoAzDQoAgd2a
PrD21LyYvjhAsbHtv3GXi4iHQ7piO79UA3wUWXelkUYl6wLTwr7s8aABElHmFu/O
emCwASBPw6a/YtEjb3eG5k7NnW3zVeZek+UA0TuH3suMHnsHqtEFsGEEsEwnMs1N
WjkQ9wtcjzde99xvGRrNqsAQrAybXF0TIICL+jfhj/6BgwH5Oyk=
=6K6h
-----END PGP SIGNATURE-----

--y724fijyu7q4opnb--
