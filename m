Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AA0C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 23:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 495336143C
	for <git@archiver.kernel.org>; Thu, 13 May 2021 23:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhEMXzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 19:55:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47174 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230363AbhEMXzv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 May 2021 19:55:51 -0400
Received: from camp.crustytoothpaste.net (unknown [138.237.15.37])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 33EE76043F;
        Thu, 13 May 2021 23:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620950080;
        bh=o7ch7ZdoUMIjzSlrzwrwZiy+wbh6AH5shXUMSOwHLKI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=znMpxu2X9oO9xgHllxXGvSnAVjObdQBn17jwYLMu7xqXwwCesk+so4770XQhQA5LE
         TH4acw91bc+N7o/g9zKOjW1ZEN++MwL+eHBtUggTJ5tb5Ru2ZyfXUC6uB39Z6O5pi+
         NhUYS4WIXjmIXFulmIqzOxle/eo2fNu7ZmY6VSfhR1wcitX713NT7nNNnRcZwJDexa
         qavdAMkqInCzPSEcqT6CftMJLyGYagZw4yd64XPRfp3Ne16ErdLHIEiDdgh3by20nH
         nwAdr5caWfp3bS9o1/QGKSkcAmQyHjHOGQc1RExMVqb0gjhj0rsw9sIzRf78iVVYqm
         PXmXKV3ItmBU67AlW+l9Pdth3COdz7SdxLYkfzjaTtG1hCy+tU/CLmAqVW82N8IQlr
         OOLEHmRO4KL4gE/y0GrSf85ebHCG+ZVEdlLDh7upIPv8OpfNYUBzro6EiYlXPF6uvj
         +Ro/xrpJEyRWyUF2dWex0f3uQR74MiPleMCFsm0sCI/GdeXsgJd
Date:   Thu, 13 May 2021 23:54:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Message-ID: <YJ28O7kBwyo4ucOC@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <117a0b3b-ae7a-ffe7-feee-ae659c588920@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ONYYSy6w/qXhNUZK"
Content-Disposition: inline
In-Reply-To: <117a0b3b-ae7a-ffe7-feee-ae659c588920@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ONYYSy6w/qXhNUZK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-12 at 04:43:14, Bagas Sanjaya wrote:
> It is customary for multi-patches patch series to have a cover letter.
> For example, when I send a patch that add corrections to an existing
> patch series, I can add permalink of that series' cover letter to be
> clear that my patch is applied on top of another patch series.

I often send one, but I didn't think one was necessary in this case.
I'll send one for v2, since I need to reroll.

> > diff --git a/Makefile b/Makefile
> > index 93664d6714..cb75dec314 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -285,6 +285,9 @@ all::
> >   # Define USE_ASCIIDOCTOR to use Asciidoctor instead of AsciiDoc to bu=
ild the
> >   # documentation.
> >   #
> > +# Define USE_ASCIIDOCTOR_MANPAGE to use Asciidoctor's manual page back=
end
> > +# instead of building manual pages from DocBook.
> > +#
>=20
> Does USE_ASCIIDOCTOR_MANPAGE imply USE_ASCIIDOCTOR?

It does not, any more than ASCIIDOCTOR_EXTENSIONS_LAB implies that.  I
will update the documentation.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--ONYYSy6w/qXhNUZK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJ28OgAKCRB8DEliiIei
gUocAP0WlDezC+d8qToCQV7V1dnUtPk6q6kY+k5DO3CPqBwQjAEA9uNWAtyuLF6m
GmHVGh05I9SyxAcN1/tupuxxjGSYIw8=
=fhqH
-----END PGP SIGNATURE-----

--ONYYSy6w/qXhNUZK--
