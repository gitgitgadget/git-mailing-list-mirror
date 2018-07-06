Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22B9B1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 01:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeGFBB6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 21:01:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52320 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753521AbeGFBB5 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Jul 2018 21:01:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:294b:af98:ff6d:ed6])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 756A060102;
        Fri,  6 Jul 2018 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1530838916;
        bh=fGSOjzM+l7ZhRJFlHNgDSs+55kjPJ1T+yY+7MVYz45A=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CcG6EiO1twsV+fK/t3ya5C1JCg2QzgNiZREhrMHCcbo6KL1SPPU97Mc86eNLfjsZ0
         3560/25TFM746O62ax16TEQ7fQi5VjvUogDP1MApwaygGIxNDfuszQsek/54DOErCC
         ZtTYhRTByawJYtAkozBjb9jSlsv0UrlD95ZU0Xh+gIa31sDradWP0jzKLWBmDvdW+m
         0i1U+1/qBLlUGss1Gm462LnQdZEnTImEinUsJdmlQ1WVz/YT/LKcsTJ4HlcWQBhtjN
         kMgJCQJHd1HUuqw4QPRYiNFn48m89ap3v9o9FlqLf59YpjEhG/ZlqnvCLeHqaUG6jp
         jZqSSSgUH6FyqaIBFcuQOfA5Rp1H+UVIg2MfRepVUpBIZZBwF+XH+tvpGivuPSkKNC
         LePB1VpqBv5lSACDdx7SxPNQ3lbVrva972aRwgB31J0rkvRAsqOXkO49cujs+uOW1L
         hYH9pQQm8KwOv0NOilZg4+SqxsEmEKl3Ng8BGSFFyZyyMNriU51
Date:   Fri, 6 Jul 2018 01:01:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Ben Toews <mastahyeti@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/8] gpg-interface: add new config to select how to sign
 a commit
Message-ID: <20180706010148.GA7697@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>, git@vger.kernel.org,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
 <9bb55c019c3bc025d77d9d491818e442233bf8d3.1530616446.git.henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <9bb55c019c3bc025d77d9d491818e442233bf8d3.1530616446.git.henning.schild@siemens.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 02:38:15PM +0200, Henning Schild wrote:
> Add "gpg.format" where the user can specify which type of signature to
> use for commits. At the moment only "PGP" is supported and the value is
> not even used. This commit prepares for a new types of signatures.

We typically prefer to have option values specified in lower case.  I
also think "openpgp" might be better than "PGP", since that's the name
of the specification and it would avoid any potential unhappiness about
compatibility with PGP or trademarks.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAls+v3sACgkQv1NdgR9S
9ovwFQ/+NTDiEOrJl/k28A3vkk4/jQ7Pi+amAhNV6xTh6xeBdYAzsrrT4JaH0qZ5
7+rYpB0H9CktibP4S1YtG8do+Zq6cbDEDXBDLisyyGnrujoEenwSbXJaM+Hn5NfO
nHLyZZKghKGNceMTFRIGOd7D1TVDYX9PPJd9mLta7/J5qV3nurTXDnQFG+wJ/Q1+
J3YlcaIqsW4Lt74sCGpS3sVd5OQvyDjpSr192WywOyVyQ7hsKTAPP0t23cS+Gdy9
yOOqJlkPcwF7Sagg1qmPMnWJ2nPa9D59oxKjEMTWVuvRYJ0Ldrz4rqb/2a65gZrq
DPR1b7xOTCH11TQT5XJBIghlz5y9WY39l3ywkTptztNyrOni4bN9BchTbeFlMkYp
E9qkE44tqt46VZVgx42zGAWUkz7EJI2TeepmWbwesItFz6ZlCNdrFirMD3EdUmVx
d1Rvfetk5pAs6822wWOfhNDKfWjxn8y0X35C/qwrV/yuymKYOds4vihjJ0ws+Eip
lGxz4wxCDnzUK7hPk1pVT85bobpw8QKwwvodndZ2tUy7UC41tgwQPHUug4zEFndk
alxnrqefdU+XNIIEj/4NRiKgEblB3kv4pdEPlzeRBvBwwyyg2K8No2GLl+DAP9oF
jvmmTZm2xG7lfv0zm1f8o4hjOx1s6EBZ6yqX551myVFr/M2ibrc=
=C35z
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
