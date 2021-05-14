Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1287FC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 20:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB08761354
	for <git@archiver.kernel.org>; Fri, 14 May 2021 20:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhENUSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 16:18:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47240 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229701AbhENUST (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 May 2021 16:18:19 -0400
Received: from camp.crustytoothpaste.net (unknown [138.237.15.37])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E1C3C60456;
        Fri, 14 May 2021 20:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621023427;
        bh=ZEiq1TFoC3bnGYQJoyB1aoXGNlICp0/ojkEdy1DMYNw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=IvoKB0eQ3e/QU6WV37t4gYD3m1ECBbfKWv8U5l+qBR37KsfU9nCiqS1d+NrYHYr4Q
         EFZTRMxWbuBeJwO6GuHiuqBP0UQdaATKBkTZe6SfKuPprkUH99iAc+cUCEXtAd5gTC
         XC5iMNMW0hhDXPRo1IbqPPvmpPW8WLcTVvttm2IPxjFypaTinWG3vOk7x7VqkpJian
         5H4dIuL0OfOD56SVq2TQYv78MxL+zlZtZHgQ1/drcXLXXFVPWtcEFrSntCEofVp75i
         mB5nVp7f1vJh5eayKPgf9i8L5WBLZ0dW24uM7CWdBKwc2V1zoe14WOz9cLUGBrVaYk
         THvPpir0yYa+Ena1JOUl2NZDiin+Q3DJvaqjOBb1x3Tp5T8JgUJtuO8PRGZAws4rG0
         kphiedgWWOwIqVu9A/gdMieD1HF439dBohyEl/Vnh4V8lLzE/Fvfko1F8fBwQDyBC3
         cFb0BpoeIuyZyD6SV8zoFrxCIDe5v1ZER8Ji7F/hQdHczvbE9Na
Date:   Fri, 14 May 2021 20:17:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Message-ID: <YJ7avgek24eu+HHM@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210514003104.94644-1-sandals@crustytoothpaste.net>
 <20210514003104.94644-2-sandals@crustytoothpaste.net>
 <609ed529e2306_431272087@natae.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t7yS66q256PiNi7i"
Content-Disposition: inline
In-Reply-To: <609ed529e2306_431272087@natae.notmuch>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--t7yS66q256PiNi7i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-14 at 19:53:13, Felipe Contreras wrote:
> brian m. carlson wrote:
> > Asciidoctor contains a converter to generate man pages.  In some
> > environments, where building only the manual pages and not the other
> > documentation is desired, installing a toolchain for building
> > DocBook-based manual pages may be burdensome, and using Asciidoctor
> > directly may be easier, so let's add an option to build manual pages
> > using Asciidoctor without the DocBook toolchain.
> >=20
> > We generally require Asciidoctor 1.5, but versions before 1.5.3 didn't
> > contain proper handling of the apostrophe, which is controlled normally
> > by the GNU_ROFF option.  This option for the DocBook toolchain, as well
> > as newer versions of Asciidoctor, makes groff output an ASCII apostrophe
> > instead of a Unicode apostrophe in text, so as to make copy and pasting
> > commands easier.  These newer versions of Asciidoctor (1.5.3 and above)
> > detect groff and do the right thing in all cases, so the GNU_ROFF option
> > is obsolete in this case.
>=20
> I don't see what that paragraph has to do with the patch below.

It's relevant because it explains why it's acceptable to discount that
feature that we're not supporting as part of the patch.

> > We also need to update the code that tells Asciidoctor how to format our
> > linkgit macros so that it can output proper code for man pages.
>=20
> Yes, but why shove it in this patch? Now this is is doing *two*
> logically-independent changes.

This is one logical change: implementing Asciidoctor native support for
man pages.

> > Be careful to reset the font to the previous after the change.
>=20
> This is a third change, since the current man pages already don't do
> this:
>=20
>   % zcat /usr/share/man/man1/git-add.1.gz | grep '\fB'
>   you must use the \fBadd\fR command

As explained downthread, we don't know in the manual pages what font
styling we're in.  troff has font-change commands, not nesting begin-end
pairs, for italics and bold.  If the linkgit macro appears in the middle
of a passage in italics, by not using \fP, we'll force the rest of the
text which is to be italicized into roman.

The toolchain, whether Asciidoctor or the XSLT stylesheets, _does_ have
this context and therefore can explicitly move between bold and roman,
but our extensions do not.

> > We insert \e before each font-change backslash so Asciidoctor doesn't
> > convert them into \*(rs, the reverse solidus character, and instead
> > leaves them as we wanted them.
>=20
> Right. So my patch was correct: it is neecessary.

Yes, I agree that it's necessary.  As I stated downthread, it appears my
branch was in a broken state.

> > Additionally, we don't want to use XML-style escapes for the litdd and
> > plus macros, so let's only use the XML-style escapes in HTML and XML and
> > use something different for our man pages.
>=20
> That's a fourth change now, and one that complicates the Makefile even
> more, when I've been trying to simplify it.

I'm sorry that this complicates work you'd like to do, but
unfortunately, the other option is broken rendering.

> > If users are using a more modern toolchain or don't care
> > about the rendering issues, they can enable the option.
>=20
> What rendering issues?

They were mentioned upthread.

> Also, the many should not suffer because of the few.
>=20
> If a few people doing USE_ASCIIDOCTOR=3DYesPlease have issues (because of
> ancient packages in their distribution, and their reluctance to type
> `gem install`), then *they* can disable USE_ASCIIDOCTOR_MANPAGE (or just
> disable USE_ASCIIDOCTOR altogether). Most people doing
> USE_ASCIIDOCTOR=3DYesPlease should not suffer because of a
> minority.

I don't believe we're going to agree on this.  I believe we should
choose defaults that work with the most popular Linux distributions, and
you don't.  I think your approach is unnecessarily hostile to ordinary
users and developers and understates the value that people derive from
distributions.

> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>=20
> I most definitely do not sign off this.

This sign-off is not an approval of the patch.  This is the statement
that this patch is based on your work which is subject to the license
specified in the file and that you agreed that your original
contribution (now modified) could be distributed with your sign-off.  In
no portion of the DCO does it state that a sign-off means you think the
patch is a good idea or that you approve of it in any way.

I do want to be clear that I'm aware you don't approve of this patch and
that's why I submitted a counterproposal: because I don't approve of
your patch and you seem unwilling to make changes to it.  I would love
nothing more than to remove your name from it entirely, but
unfortunately, that's not possible with the DCO.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--t7yS66q256PiNi7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJ7avgAKCRB8DEliiIei
gZW+AQDwvVCIqlCgbRgUiipLyVvDw49RxKu8l2CvnqWU9isNegD+PH+TrhpyNUO4
oAVcIsWPVx4ki8Gt/OGZ9jtlFbmeagM=
=ZdbZ
-----END PGP SIGNATURE-----

--t7yS66q256PiNi7i--
