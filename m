Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E99C2D0A3
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 03:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5CE520867
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 03:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgKEDUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 22:20:46 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34862 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728511AbgKEDUq (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Nov 2020 22:20:46 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DF74E6044F;
        Thu,  5 Nov 2020 03:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1604546445;
        bh=/H8I/2W5KSfMetOF7KLhyphhDSFhBNzRYEqbG/yN0RI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Pj0hsXiQjmeQ0rc4bWkFrm0iWBExZ0M7OGf6TDEKcwFtMeJwtlqwBcGR133+tL57z
         jzKEhmZid2CPuHG5jOLMTNkxVjeyzWHoow+keiissMz/2JQjT3gPYvxt2kkMf1fWXi
         EYgsx6RJEFYuMfuUAzHo3ZAi+CvSsxUKXeeOJ1KGDRWuq4Qql6x4YQnOZM8caEYaoB
         8hPHc8VlCosyq71apVHuE3rafMVhvJeYLbTiDrZAOtf8v3HbNmsWgdxScGLA4l1RuZ
         pCQIDd0U5qO/DcO1vzfcO4gXEBCJf3eNWxIqp67hXdaPP+w96Fwp5H5wlX4Kz+wbXM
         EbYaIR9M7ditthmfZkDnF/SMApt3tpxkS8NxxH/b6LeXbaVYMoicYAlCsO6jj7/aq8
         iw+9CwTprrqw0KfFUCUawLOQKp37V8T9rEGiClupWP9ES4/iFKroaCzrgkqP1rwKmA
         1SIti7eDS9cd3n5eA6HOAlQvE4zTFrj63Jl5+koQn7vavYuTPZZ
Date:   Thu, 5 Nov 2020 03:20:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 0/2] rev-parse options for absolute or relative paths
Message-ID: <20201105032040.GB1332931@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
References: <20201009191511.267461-1-sandals@crustytoothpaste.net>
 <20201104230157.GH2774782@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <20201104230157.GH2774782@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-04 at 23:01:57, Emily Shaffer wrote:
> Hiya, we took a look in the review club, but I'll try to keep it simple.
>=20
> On Fri, Oct 09, 2020 at 07:15:09PM +0000, brian m. carlson wrote:
> >=20
> > There are a bunch of different situations in which one would like to
> > have an absolute and canonical or a relative path from Git.
>=20
> I think specifically you are interested in this situation:
> https://github.com/git-lfs/git-lfs/issues/4012

Yes, that's the case I'm interested in.

> I think this would have been useful to see in the cover letter :) There
> was a lot of "but why" during the review club meeting.

Sorry about that.  When I'm sending patches to Git that benefit Git LFS,
I want to be careful to build features that are generally applicable and
don't just try to shove in features that benefit the project I maintain,
so I'm often a little hesitant to mention my particular use case and try
to let the patch stand on its own.  I know that there are several
competing projects in this space, and I want to be sensitive to not
privileging my own just because I'm a frequent contributor.

I'll try to strike a better balance here in the future.

> Also, there was some brief wondering: if this option is useful in 'git
> rev-parse', would it be useful in other commands too? I thought maybe it
> would be more useful as an arg to 'git' itself, but on inspection, not
> really - because you wouldn't be able to switch the format in the middle
> of a bunch of args, like you can now. The way it's written here,
> though, should mean a smooth transition to something like OPT__VERBOSE
> or OPT__QUIET if we discover lots of folks would find use.

Yeah, I think this could be a thing we add in the future, but I'm
generally comfortable with this being just in rev-parse, since that's
the command that folks tend to use when scripting, but we'll see if
other folks think differently.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX6NviAAKCRB8DEliiIei
gWvgAQCeZ56A9xsP08vNyJOy5TybW210auJALmJ9kGwc/I3JvgEA1WFk6LtbttMu
OWI+djyCXQE8rCjuuAOQgMG9qDpDpQc=
=yE2K
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
