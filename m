Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EC3C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 03:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC1AC23A1D
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 03:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbgLJDwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 22:52:19 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57278 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730646AbgLJDwO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Dec 2020 22:52:14 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9459160751;
        Thu, 10 Dec 2020 03:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1607572261;
        bh=oWTuOLHLMoA1jimozF4OKTZJfc0DVGeAP7G4R8Y4A8g=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Kg3Va02qHlSubh7hLK61pjUFupKmWDPaNjS9VjoBGlbtVbIfsjfTYPCasmP+znrD0
         m5+52yuuo3LOOo+WQ71QdAQeKuor9FBMkDI9YPLW9oAoXpSfuEWjqfrGcm4Dheqe1A
         dr3AkGTTVVjKLsAElpstzinjAtfM6jzlUqZsMtxYJ3WK1xtlqrtT9j+N/2eeA5CdxB
         AO1t+udw04evB4potBS6dSeHXdVmKyDQup4VEt7/XtiiGOyjGxS++9gpoZ3QQ+UmxQ
         9P83hx4y2zAK9NdtGl3wulTaNTWnk9/Oj7Du9biEzkD/fTAjtIUZ6sExnYeKrjsWCQ
         a4jgasXsgizDM3VaxsOuNHxI29C+O4/Iq4KG/zdvYNl1plOj1FvzyHeUlU3tG4+dMA
         wtIkml25Y/4mgeZ5CMVNQ+JJsnpqvalilZOgpumMzzuS83GDSOylEjdbgPC5P/+DHX
         MrTaI9yVj4K4re5SzduqEOUfJQvbZiZHGoUtElDfadu+xSMumPR
Date:   Thu, 10 Dec 2020 03:50:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 1/2] Add project-wide .vimrc configuration
Message-ID: <X9GbIG9vZbK1pEoi@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Aaron Schrab <aaron@schrab.com>, Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
 <20201209065537.48802-2-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wYkn5fNWbi9ikok+"
Content-Disposition: inline
In-Reply-To: <20201209065537.48802-2-felipe.contreras@gmail.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wYkn5fNWbi9ikok+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-09 at 06:55:36, Felipe Contreras wrote:
> diff --git a/.vimrc b/.vimrc
> new file mode 100644
> index 0000000000..602c746477
> --- /dev/null
> +++ b/.vimrc
> @@ -0,0 +1,22 @@
> +" To make use of these configurations install the git plugin provided in
> +" the contrib section:
> +"
> +"   cp -aT contrib/vim ~/.vim/pack/plugins/start/git
> +"
> +" Then whitelist the location of this directory to your ~/.vimrc:
> +"
> +"   let g:gitvimrc_whitelist =3D [ expand('$HOME') . '/dev/git' ]
> +"
> +" You can add multiple locations, or specify a regexp pattern.
> +"
> +
> +augroup git
> +	au BufRead,BufNewFile */Documentation/*.txt set filetype=3Dasciidoc
> +
> +	au FileType c setl noexpandtab tabstop=3D8 shiftwidth=3D0 cino=3D(s,:0,=
l1,t0
> +	au FileType sh setl noexpandtab tabstop=3D8 shiftwidth=3D0
> +	au FileType perl setl noexpandtab tabstop=3D8 shiftwidth=3D0
> +	au FileType asciidoc setl noexpandtab tabstop=3D8 shiftwidth=3D0 autoin=
dent
> +augroup END

I don't think this should go in this location.  It should go in contrib.
Here's why:

* We should not ship editor-specific files in the main directory of the
  repository.  Even though Vim is very popular, it is one of many
  editors, and it is not even the most popular editor (which is now VS
  Code).  We have editor-independent files, and users can copy this into
  the root of the repository and ignore it if they want it there.
* Whether a user wants to use automatic indentation is a personal
  preference.  I do happen to like it, but there are others who don't
  and prefer to leave it off.  Similarly, whether to use cindent,
  smartindent, or autoindent is a preference, as is which cindent
  options to use (I use different ones).
* These settings affect every file that's loaded in the same editor
  process.  While many people open different editor windows for
  different projects, other people prefer to use the client-server
  functionality to load all of their projects in the same editor.  These
  are not, for example, the editor settings I normally use for non-Git
  AsciiDoc files.

So while I agree that these are common settings, they are not
universally applicable, even for Vim and Neovim users, and we shouldn't
try to claim that all or even most Vim and Neovim users should use them.
In contrast, the .editorconfig file specifies things which are (a)
guaranteed to affect only this repository and (b) are essential parts of
our coding style.  It notably omits things like line endings which are a
matter of user or platform preference.

So I think contrib makes more sense here.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--wYkn5fNWbi9ikok+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX9GbHgAKCRB8DEliiIei
gX8/AQC47P0eDGbR+yqMqDixESx+u2HkoihOqxRAk5YdGZZvVAEA9Ad1RNDVKcC/
S7jqUAQPObyI8DSXZURgDMHqBEjITAg=
=uRn1
-----END PGP SIGNATURE-----

--wYkn5fNWbi9ikok+--
