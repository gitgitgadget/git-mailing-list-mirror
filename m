Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DFE5200B9
	for <e@80x24.org>; Tue,  8 May 2018 02:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbeEHCrD (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 22:47:03 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:45477 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753771AbeEHCrC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 22:47:02 -0400
Received: by mail-io0-f175.google.com with SMTP id c9-v6so30277206iob.12
        for <git@vger.kernel.org>; Mon, 07 May 2018 19:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QbvleJFoF/MkWjYi6RkF7BuV3NJ/IQL2u5TKMx3VTAY=;
        b=Xdr/CN9+Pz2huXAiuTsQTnOiEgE06MQMyKJsi9Dzv8eE1wBGtKzksfgWGygInrKR8h
         8jTRo+C2IFMSpJ/3B7pe7sCSGRvY3YnPaNgPkPaAUviAnJDJCwv7ncuzZ5RtAV/4YRVV
         xO0yrvx1CmGvby6YtFQZpJX+vjxJQ5l5sW304=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QbvleJFoF/MkWjYi6RkF7BuV3NJ/IQL2u5TKMx3VTAY=;
        b=r2FULP5gHo9EjreAHUiy4H9zIS0lLbI1s146epNvPqHiphCXv2RROE4HSsKmvMwuLE
         Ev9FUzigmQ1BbjeFOcLzkqzGe9TaH9+rMB/AmMcWltYtLRU1F6sjptyn50a42tuBMpa+
         j9648ZPMerynzYrxn98Z08VDP6xsKkbHy+C90XbAvDIs7Cyaxo3GGZdPPCJgj8J7Ajjw
         YPDF7A3OeU5dmii6ZXZTqSTK1NVhd9oaO60R+BBvPOVZuk7UlvlwL31+vfC+eTpFMgxw
         yKZz8mrouPMwMlwvnPyOcrwedbiihlRFo7gLM2Lhyt9giCNZmoZXFffhX8gSzXUSrupg
         nBIw==
X-Gm-Message-State: ALQs6tCgnJdZBI/SHsMAFSwCji3U/TBBnLgcyK7BSd/maWb16WQk/MCE
        Em6OgAjNegB6ajdkR2LPbbWv8R+kitU=
X-Google-Smtp-Source: AB8JxZolv0iNbfOm1F5mcG98NBL5IX9Wk/H/v8rp71KuJ6wm97N5T3gOVFguInbMUAFx5xw9O0uFIw==
X-Received: by 2002:a6b:9690:: with SMTP id y138-v6mr39058763iod.272.1525747621384;
        Mon, 07 May 2018 19:47:01 -0700 (PDT)
Received: from puremoods ([198.144.156.49])
        by smtp.gmail.com with ESMTPSA id t7-v6sm4751463ite.35.2018.05.07.19.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 19:47:00 -0700 (PDT)
Date:   Mon, 7 May 2018 22:46:58 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
Subject: Re: main url for linking to git source?
Message-ID: <20180508024658.GA4204@puremoods>
References: <20180507063713.GA28961@sigill.intra.peff.net>
 <CAGZ79kZVdiEOO+b_Ygrfw1D9uV1T5TYBS580zPaZeYoMRfNuUQ@mail.gmail.com>
 <20180508015130.GN953644@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20180508015130.GN953644@genre.crustytoothpaste.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 01:51:30AM +0000, brian m. carlson wrote:
> On Mon, May 07, 2018 at 11:15:46AM -0700, Stefan Beller wrote:
> > There I would try to mirror Junios list of "public repositories"
> > https://git-blame.blogspot.com/p/git-public-repositories.html
> > without officially endorsing one over another.
>=20
> I think I would also prefer a list of available repositories over a
> hard-coded choice.  It may be that some places (say, Australia) have
> better bandwidth to one over the other, and users will be able to have a
> better experience with certain mirrors.
>=20
> While I'm sympathetic to the idea of referring to kernel.org because
> it's open-source and non-profit, users outside of North America are
> likely to have a less stellar experience with its mirrors, since they're
> all in North America.

I'm a bit worried that I'll come across as some kind of annoying pedant,
but git.kernel.org is actually 6 different systems available in US,
Europe, Hong Kong, and Australia. :)

We use geodns to map users to the nearest server (I know, GeoDNS is not
the best, but it's what we have for free).

-K


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWvEPiwAKCRC2xBzjVmSZ
bAlZAQDaIzyW77JYhoTlZi75Hf7SDQrRdFeHTq7p9RfrNGdsXgEAhSuvmuv1DD2Z
0m5Yx2sgRKxcmawu4ZG+eFoqNi6mfgI=
=TcFi
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
