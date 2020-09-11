Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E40C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 00:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322C02087D
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 00:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgIKAD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 20:03:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57298 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725764AbgIKADy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Sep 2020 20:03:54 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 38F3660489;
        Fri, 11 Sep 2020 00:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599782600;
        bh=rLvyRvGonBlrzUMCbeXoDTuSf4L0ANj0IeW4GKf8pWs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YD6oi0D3J3Gv+dE4mBd01wH+Pt91pKoGt5AwTh69vVdocM2NYDbvqka4JAzFVwwwf
         +F7a3HYJisJ1TkevB+DxvH6yqq00FXQ28nzkuRsyPusgF+oYZMFFBxzLGSEJPlo9xm
         JO678cjss2oTgkMUlQsjDWVYrtK/z5Az7XPCS5qIeiXnpZcPcMj371UH2Bw1mGq9D7
         sl+9lDbhBlsQ8ZeK/Q894Hdiil+Iq6hFeu4jzre5YlZbiwAEkfUP22iedWw77TG9o+
         p/eFx5KfYvrg4lXgi6uEnF8N1H8SvROlyIvZx0a6oMzRZDuHDBNV7OecaHaTmbc6s1
         qCFzrlTYe8k2nXn2T7eeBzaCGkuqr+ZZ0bLNvJCVIMnKy5CUCRc2NTNTLITuX1EYvr
         afTvZgUCAiq+6ei5PYqCBkU2VHEtZU8Nj0++UT6E0UThka9Ko0T5gK5PnQiTPZFRPZ
         A8jlh9BmxBxxmH7H5IyoTXrjdGVfTdDSH/HDXiZg3o6X89PymQp
Date:   Fri, 11 Sep 2020 00:03:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rev-parse: add option for absolute or relative path
 formatting
Message-ID: <20200911000315.GL241078@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200908185017.2005159-1-sandals@crustytoothpaste.net>
 <20200909145114.GE6209@szeder.dev>
 <20200909222333.GH241078@camp.crustytoothpaste.net>
 <20200910151935.GA5265@szeder.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zH41lVBEV8cLJnCl"
Content-Disposition: inline
In-Reply-To: <20200910151935.GA5265@szeder.dev>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zH41lVBEV8cLJnCl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-10 at 15:19:35, SZEDER G=C3=A1bor wrote:
> Well, on first sight it seems nice that scripts have to specify
> '--path-format=3Dabsolute' only once when querying multiple paths at
> once, though on second thought no prudent script would query multiple
> paths at once, because they might contain newlines.

We do that in Git LFS at the cost of not handling paths with newlines
because calling out to Git multiple times is expensive, very especially
on Windows.  Of course, Windows doesn't allow newlines in paths, but it
seems silly to have two different code paths for the same thing,
especially on top of the different paths we have for versions of Git
with and without worktrees (and therefore --git-common-dir).

If you're writing a script, you're not expecting great performance (or
you wouldn't be writing shell), so it's less of a problem and you can
actually afford the cost of being a little more correct.

I think if we wanted to prudently handle paths with newlines, we'd want
to add a -z option to rev-parse (think about the case in shell where the
path ends with a trailing newline).  I may get around to that at some
point, but anyone is welcome to pick it up before me.

> Yeah, I think I found trouble that way, too.  I wonder whether
> '--path-format=3Drelative' is really worth having, though.  Clearly
> there's a need for absolute paths, because getting relative paths
> causes difficulties for some scripts; I described one such use case in
> a2f5a87626 (rev-parse: add '--absolute-git-dir' option, 2017-02-03),
> and you just ran into another with Git LFS.  However, is there really
> a use case that requires relative paths, because an absolute path
> would cause similar difficulties?  I couldn't come with any.

The only case I can come up with is possibly wanting to know if a path
is within another path, or if it's outside, and doing that with relative
paths may be easier.

> So perhaps it would be sufficient to introduce only
> '--path-format=3Dabsolute' (or equivalent) for now, and add a relative
> path variant only when there will be an actual compelling reason to do
> so.  And that would save you from the pain of addressing these bugs
> shown above.

I'll consider it when I do my reroll, which will probably be this
weekend.
--=20
brian m. carlson: Houston, Texas, US

--zH41lVBEV8cLJnCl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX1q+wwAKCRB8DEliiIei
gaCLAQCsFn9FvkMUMNg3airUfdXKjEmbUBq8AaIoHUWGkDQZNwD/TA0T9k/C3+5x
Eb6Y8Bm1p2dBWT34t4eFuIewR3Fe6QM=
=J0A5
-----END PGP SIGNATURE-----

--zH41lVBEV8cLJnCl--
