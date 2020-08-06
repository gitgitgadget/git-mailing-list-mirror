Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3B1C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 02:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D0C21744
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 02:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KmmZDAIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHFCEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:04:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41368 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725999AbgHFCEo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Aug 2020 22:04:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2A26560799;
        Thu,  6 Aug 2020 02:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596679453;
        bh=nTgjOmXm9U6X8S5d3cYt32zDK4EV7WzhSnwvTmavXCM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KmmZDAIeXx8Gm68MS8JKq0lff+Vn497jEhYi8Z99TyP7WC9h17ir7JnuLX9NUxXtx
         VLkYqf7D77dSrgE+GbBfxE/sVNmm6dmvS4Dw5Gs0Iwd/TOSwwRcyhzSh8ZP1lhXWsG
         nF7pPYX/uyPlVirMRhm1En5iIuhBaIh7pbECSbQkYMwMnoW9TUnl9rC646mqRCbqo+
         dZbim+hdgLDOJBIpcX5thHxr38XUdzTKj97tS9xGDp28u+mUS7XdPl3LYYYDHRZMbO
         NkiArf0TFRFpLdvRNEW7mkvqRvvujbDpJ44MJB6s8Gk3gXTUqCO+LnHab9mYK7AwQ4
         JdH1a3xUQt78Kfs1GaDDXNf8RHJIPd5WecxMoQ1XwZj3hqjO/awMNbGePVQfHD8SfC
         ZR//5fLnHXazGURqrHk5AWpwadPUbpjWhNnczRXRM+/rOVKx/h9LqZqZes66uJ0G84
         48JfNjazUdsH/y2I/0KjriycqGKLllzg8mCOZ/38DTwHfDgllXl
Date:   Thu, 6 Aug 2020 02:04:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "KADOTA, Kyohei" <lufia@lufia.org>
Subject: Re: [PATCH 3/4] Fit to Plan 9's ANSI/POSIX compatibility layer
Message-ID: <20200806020407.GR6540@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "lufia via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "KADOTA, Kyohei" <lufia@lufia.org>
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
 <d15ed626de65c51ef2ba31020eeb2111fb8e091f.1596675905.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="THYEXwetZJOK3OLY"
Content-Disposition: inline
In-Reply-To: <d15ed626de65c51ef2ba31020eeb2111fb8e091f.1596675905.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--THYEXwetZJOK3OLY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-06 at 01:05:03, lufia via GitGitGadget wrote:
> From: lufia <lufia@lufia.org>
>=20
> That haven't any commands: cut, expr and printf.

Is this ANSI/POSIX environment the one mentioned at [0]?  That page
describes it as supporting POSIX 1003.1-1990, which is a bit dated.  I
think we generally assume one has the 2001 edition or later, so you'll
have your work cut out for you.

> And its sed(1)'s label is limited to maximum seven characters.
> Therefore I replaced some labels to drop a character.
>=20
> * close -> cl
> * continue -> cont (cnt is used for count)
> * line -> ln
> * hered -> hdoc
> * shell -> sh
> * string -> str
>=20
> Signed-off-by: lufia <lufia@lufia.org>

I will note that usually the project prefers to have a human's personal
name here and in the commit metadata instead of a username.  Junio may
chime in here with an opinion.

>  command_list () {
> -	eval "grep -ve '^#' $exclude_programs" <"$1"
> +	eval "grep -v -e '^#' $exclude_programs" <"$1"

Is it really the case that Plan 9's grep cannot deal with bundled short
options?  That seems to be a significant departure from POSIX and Unix
behavior.  Regardless, this should be explained in the commit message.

>  get_categories () {
> -	tr ' ' '\n'|
> +	tr ' ' '\012'|

Okay, I guess.  Is this something we need to handle elsewhere as well?
The commit message should tell us why this is necessary, and what Plan 9
does and doesn't support.

>  	grep -v '^$' |
>  	sort |
>  	uniq
> @@ -18,13 +18,13 @@ get_categories () {
> =20
>  category_list () {
>  	command_list "$1" |
> -	cut -c 40- |
> +	awk '{ print substr($0, 40) }' |

I can tell that you haven't gotten the test suite working because I've
added a large number of cut invocations there.  I suspect you're going
to need to provide a portability wrapper there that implements it using
awk, sed, or perl.

> +if test -z "$(echo -n)"
> +then
> +	alias print=3D'echo -n'
> +else
> +	alias print=3D'printf %s'
> +fi

Let's avoid an alias here (especially with a common builtin name) and
instead use a shell function.  Maybe like this (not tab-indented):

  print_nonl () {
    if command -v printf >/dev/null 2>&1
    then
      printf "%s" "$@"
    else
      echo -n "$@"
    fi
  }

Notice also that we prefer the standard form and fall back to the
nonstandard form if the system is less capable.  I don't know if Plan 9
supports "command -v"; "type" may be preferable, but isn't supported by
some other shells (e.g., posh).  For portability reasons, we may need to
try to run printf and see if it fails.

This is also going to need some patching in the testsuite, since we use
printf extensively (more than 1300 times).  I do hope you have perl
available.

[0] http://doc.cat-v.org/plan_9/4th_edition/papers/ape
--=20
brian m. carlson: Houston, Texas, US

--THYEXwetZJOK3OLY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXytlFwAKCRB8DEliiIei
gTw1AP9fJWCz9h/8SS9v0zL6JOT8Au4nANBpuEcV6sYrMX6jIgEAyfeYBcaBKj2r
cADIRG9C36oCDBXa+5BRsyzPMi9KIw4=
=F+L7
-----END PGP SIGNATURE-----

--THYEXwetZJOK3OLY--
