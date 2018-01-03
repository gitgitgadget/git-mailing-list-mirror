Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F591F406
	for <e@80x24.org>; Wed,  3 Jan 2018 23:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbeACX4c (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 18:56:32 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36238 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751538AbeACX4b (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 3 Jan 2018 18:56:31 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2468D60D9A;
        Wed,  3 Jan 2018 23:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1515023790;
        bh=Rg/T5p8XSxTac/tSk3owCeAo55SZsQvOJEGYcRXacAo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZE9HIM7n/ho4VOdhHt4Wh44TVwashFnvQWMzX6Mxoa0lsU3Q19UaQSQ1YRBnaH5hV
         rbzZjPQ0++4XQU3SMSJ+19gBbpNYGNK5H3ZcyIF2VvESZsxBbYRutsxm0mFkwY4vHN
         RQwloB0GdWEkpeDRMXq6EqIidraQWMfsRdevRgyvdICPhjog2uSfY7vIGne6/ligMV
         QNDg+JgA/Y/KBsx0I+lE90EoXbw3Rfdy/jrqjHx37+Odmys//NZLznghFR3W9672Bo
         1oKACp2g32YnBecgaMShfF+H5DokkIvN6Y5w/QBV53PLu8xEZJKYSHKEhVPKIOWYLn
         tgg0ddZfo0QN6aG12T+I1scNdGIlxq4Bd8FAg3U+F4PCrr2n+F/nyz2zEE8tFa1IYK
         5SX+nz4UfIZZUGRIFa1Z0RNSNDoFAQatzCm6xc4iJ1ae8CxCfRISbnH3DQSMM5ULpA
         2qiIhkbJFBLiYfsSjgNOZyxXU13oBTOO1ZmY2Y+TE06lw9GKG2x
Date:   Wed, 3 Jan 2018 23:56:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc/SubmittingPatches: improve text formatting
Message-ID: <20180103235625.GB817655@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20180102153350.11723-1-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <20180102153350.11723-1-tmz@pobox.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.14.0-2-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2018 at 10:33:50AM -0500, Todd Zullinger wrote:
> 049e64aa50 ("Documentation: convert SubmittingPatches to AsciiDoc",
> 2017-11-12) changed the `git blame` and `git shortlog` examples given in
> the section on sending your patches.
>=20
> In order to italicize the `$path` argument the commands are enclosed in
> plus characters as opposed to backticks.  The difference between the
> quoting methods is that backtick enclosed text is not subject to further
> expansion.  This formatting makes reading SubmittingPatches in a git
> clone a little more difficult.  In addition to the underscores around
> `$path` the `--` chars in `git shortlog --no-merges` must be replaced
> with `{litdd}`.
>=20
> Use backticks to quote these commands.  The italicized `$path` is lost
> from the html version but the commands can be read (and copied) more
> easily by users reading the text version.  These readers are more likely
> to use the commands while submitting patches.  Make it easier for them.

I think this change is fine.  I don't have a strong opinion either way
and if others think the change makes the plain text more readable, I'm
all for it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.3 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpNbakACgkQv1NdgR9S
9otgWxAArbNTXZPxH+TUx5iaWXbB849tmizuYmXdfAxi/+SP29cq6DMe187q+MPS
UtdaiwJTKRmLPLg17Mj+4AGCkAI83oh8MUPuQOkK0j2iRfpGD9bJm5wQFJ8ezKDs
b3thXB1pARF/vvbChblRtNJyLYSURxfAA++syisuo+RiNgFydhVYIioQVTT2iAYL
8aOXjF2MqLYQkd248/Tu47GAUIFjB91GnMtHaLyH8wod+iL0oqXzx8+TFOZLkQNY
qYVnLrpNVN2i3RtSh9ZfT4Bdeb7/CAeyr2RdWME9aQZvwqS9JjkD8xuTY/UMA3Y0
yEYFXas15T9zKPuU54JYJ3pjl+1W9VD5fl+8qUeL//iPpdHdd1p8bKSRIdK9Lh0p
4CGLu/fSddht2XfyZtwD/og1nlpSjUSnDT/dFEN3Krzg+1tIAEd/kKhuBS7L3QSm
cOzWIQCuiVw/sYoPJ4mD9JCbK9okDXrmHYFe4BSBFCUf3oLDD58fcxfCBOvLqNAd
EzRDxfymJudojsdS4xG+m2qgKtdd7JEXkldl1gGXr4xsCwgcANXanP57w7fum2ow
VGg1pXFaP9Ihmo86E9Le5YXZ1FsLhwQ4qqFNIGI6JGV2sE2iXJEEBlH2MJkZ90YX
7GQjf8+7UMFWvZKNELijGQMD2c6hbE29bIVdCx6MBddnuABDt9Q=
=CO/z
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
