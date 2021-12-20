Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E213C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 12:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhLTM3l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 07:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhLTM3k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 07:29:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B1CC061574;
        Mon, 20 Dec 2021 04:29:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1431160FEB;
        Mon, 20 Dec 2021 12:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9040BC36AE7;
        Mon, 20 Dec 2021 12:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640003379;
        bh=eX35oRmAncIULZ2kEvf5XCJfEwH+LmoHf7MrVq1dOik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHIkxK5FbHM9LjEzWYtvbrzuNuq3JjUnIa2gKzwyNEGq1mGJbxb0d0Mcr2/uGp93m
         wC3h6+qRefO/4Z3CNloxi2BXB5E40IbXQu+xMf8TOrCLYVtx2meRZxU4m3D4caI+B8
         ZDK7SsEm2Hvre0DyEkBJ5arIA/cxA9VTKinjn+fPGi82PxPr0S1+jYYT3Z2eTf6qfF
         4npg0j0FQ1D1TkEIvjuHtOLCk7Sa2J9ePctE7LH0ogH9dIDylcH4toF7dc6/5dim6z
         IKbSxPevfS420s3wIdKzbukTWDnpznGGGPa7i8C4eQLGuvXoAzAO9D4vP6qJVyB/Q/
         gTrx3KpGA5H4Q==
Date:   Mon, 20 Dec 2021 12:29:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, jonathantanmy@google.com, steadmon@google.com,
        chooglen@google.com, calvinwan@google.com,
        workflows@vger.kernel.org
Subject: Re: Review process improvements
Message-ID: <YcB3LtxkItDVa2zd@sirena.org.uk>
References: <YbvBvch8JcHED+A9@google.com>
 <20211217183942.npvkb3ajnx6p5cbp@meerkat.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dYWJ2OP/dGcleliY"
Content-Disposition: inline
In-Reply-To: <20211217183942.npvkb3ajnx6p5cbp@meerkat.local>
X-Cookie: Christ was born in 4 B.C.
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dYWJ2OP/dGcleliY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 17, 2021 at 01:39:42PM -0500, Konstantin Ryabitsev wrote:

> 2. b4 submit --send: will generate a patch series from any commits created
>    from the topical branch fork point and use the cover letter from the
>    previous step. It will be able to send the patches using the traditional
>    SMTP way, OR it will allow using a web-based submission service I'm setting
>    up at kernel.org:

One thing my equivalent of this does (I might've used patman but I don't
think I was aware of it at the time) is to tag each revision as it's
published, might be worth considering.

--dYWJ2OP/dGcleliY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHAdy0ACgkQJNaLcl1U
h9A4swf/edhslz8jQyg2lBtZ5ItZXItwIkWDR9t6aCVv8umcJHYAj3YV1v7ZIDDp
ad+L57it4R0BXLPN6sEt0PIWRzL6nKTRedH+1ebNqN4y56s9kcqX8dJAj35JLiQ3
bnI+019f7gxqcm4/9bB0YzGdNlPRH+e/sBmRCtp9YdNAYkZxB8V8ZMtC60l9H8qY
Pi5jqUI5YlPv2pTdzMc1Wacvv9PjhzYiyYUeDDoT6Ou/EJvfI9AmtUUN96TtPKim
qic9zEI3zJGlQptB9vGCClI7QAR6oI8Cq0TbORxvOaET6rfJ2xRZZ0WVUS769D8f
ymjX3Nx6uQ26Wq8LUrMtUl43LqCROg==
=nldj
-----END PGP SIGNATURE-----

--dYWJ2OP/dGcleliY--
