Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64146C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 23:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DAA7610A7
	for <git@archiver.kernel.org>; Thu, 13 May 2021 23:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhEMXjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 19:39:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47168 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230114AbhEMXjq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 May 2021 19:39:46 -0400
Received: from camp.crustytoothpaste.net (unknown [138.237.15.37])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 53D736043F;
        Thu, 13 May 2021 23:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620949084;
        bh=9SOKib3twsbD4rm6Aav4QsyhYehjRL/X97zaGLdPGTs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=09fIFOl6INT6EXNRy2VoyJ+azfGVhTtY9Oea8u69rD35jvcSudnehFUb9PqgLMgOH
         har6Ha5HRlzkpUNlnFjFanLtc0bhrfQTz04C/xoadUHXcs0dA79wCnNBrslOBolrO8
         HX4ZTAmyZC6gf+MW1vPYR1cAWwa6oKzK6NdT9KEUNtNvvizIt2Kw51sA68PYiresYA
         ApY8gJlxpwye/UmYt3RSw5Uu7eGP9By+i/pSr4AJ7xGQtBxCnv/xUFyCbnxzWPyard
         7q3oWPUQUujhn7YCiXPhs9A/3ufwUV9xxG/phgNVR25fgTuln+ej5Ze8zCxJIOnP7L
         PINViBVz4czNlZ/OjmSGPWDphX3jYeJedxUkU5FUUGaH23WP9ZuHDQdLn1AxNDEB7N
         9xNzpS0ZGv3uPtfgKFprgTbHaNYqcjrsMwuA1zf6aCqx7P0PUfba1ja/LzbOXZaOJD
         VxCeN1Lm7NNS8wH/VGPHmptZJeZ9CmyliRJGtU57wA5UgHQRHOw
Date:   Thu, 13 May 2021 23:38:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Message-ID: <YJ24WIpnwE4LBOMt@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <609b5c85b7c61_678ff20848@natae.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZvhGi0exf1conWvW"
Content-Disposition: inline
In-Reply-To: <609b5c85b7c61_678ff20848@natae.notmuch>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZvhGi0exf1conWvW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-12 at 04:41:41, Felipe Contreras wrote:
> brian m. carlson wrote:
> > From: Felipe Contreras <felipe.contreras@gmail.com>
> >=20
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
> > commands easier.  These newer versions of Asciidoctor detect groff and
> > do the right thing in all cases, so the GNU_ROFF option is obsolete in
> > this case.
> >=20
> > We also need to update the code that tells Asciidoctor how to format our
> > linkgit macros so that it can output proper code for man pages.  Be
> > careful to reset the font to the previous after the change.  In order to
> > do so, we must reset to the previous after each font change so the
> > previous state at the end is the state before our inserted text, since
> > troff only remembers one previous font.
> >=20
> > Because Asciidoctor versions before 2.0 had a few problems with man page
> > output, let's default this to off for now,
>=20
> > since some common distros are > still on 1.5.
>=20
> Are "some common distros" namely Debian stable *exclusively*?
>=20
> If so, I would consider flipping the default the other way around,
> espececially since it's only te default shipped by the Debian stable
> packages (easily fixed by `gem install asciidoctor`).

CentOS 7 and Ubuntu 18.04 also ship 1.5.  CentOS 8 does not appear to
ship Asciidoctor at all.

> > If users are using a more modern toolchain or don't care
> > about the rendering issues, they can enable the option.
>=20
> The other way around: if users are using an ancient distribution they
> can disable the option.

Debian stable is not ancient.  It is less than two years old, which for
a Linux distro or any operating system distribution, is not at all
considered even reasonably old.

I am not going to propose or give my approval to a change that causes
problems building Git with the distro packages on Debian stable or the
latest Ubuntu LTS, in any way, shape, or form.  People should be able to
use the distro packages if that's most convenient.

> > Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>=20
> Commit-message-by: brian m. carlson <sandals@crustytoothpaste.net>
>=20
> I certainly would not want to pretend to have written the text above.

I'll reroll with the author reset.

> > diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/as=
ciidoctor-extensions.rb
> > index d906a00803..40fa87b121 100644
> > --- a/Documentation/asciidoctor-extensions.rb
> > +++ b/Documentation/asciidoctor-extensions.rb
> > @@ -15,6 +15,8 @@ module Git
> >            "#{target}(#{attrs[1]})</ulink>"
> >          elsif parent.document.basebackend? 'html'
> >            %(<a href=3D"#{prefix}#{target}.html">#{target}(#{attrs[1]})=
</a>)
> > +        elsif parent.document.basebackend? 'manpage'
> > +          %(\\fB#{target}\\fP\\fR(#{attrs[1]})\\fP)
>=20
> I still prefer my original version, especially since:
>=20
>  1. I suspect most git developers are familiar with printf directives:
>     %s.
>  2. Where is that \\fP coming from? I don't see that with xmlto, nor the
>     publicly genrated man pages[1].

That's coming from my knowledge of troff, having used it extensively
over the years, and my general hesitance to affect global state.

>  3. Doesn't work on my machine without my original \e; I see
>     "\fBgittutorial\fR(7)".

Works just fine on my system using Asciidoctor 2.0.12.  The \e would
insert an additional escape character and shouldn't be needed unless
we're in copy mode (which we should not be here).
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--ZvhGi0exf1conWvW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJ24VwAKCRB8DEliiIei
gYZRAP9prRFGAGLQuwdOtPxjrXvp5sDCoyf2suBSpV3X49owZAD/b1A0WyM8P/cI
8kUgKXo9sMghZlhhoxHiujcTt9wjlgg=
=beTQ
-----END PGP SIGNATURE-----

--ZvhGi0exf1conWvW--
