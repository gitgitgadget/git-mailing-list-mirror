Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C73A201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 23:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934002AbdBVXfq (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 18:35:46 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40238 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932906AbdBVXfp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Feb 2017 18:35:45 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CA1A5280AD;
        Wed, 22 Feb 2017 23:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487806462;
        bh=JBUfQK9iiuB0l75XSlOKu4R7q2rv4xZfcXtb+mVrJFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=flCY4wZFgnUiYG06HK6jS9DUfKtxdbNXw9kF9bELXRiJEpK97MqF0h2Fmwpq8oh4d
         19CxylTWIsIm0q232JAqMpZA4KShgIgRxTkzLUSy4FJUkV6uqJDLYiPD+/0INxtHzK
         fs8N8pEJBoCm4oMwJT+MhrZtlLLiR2FGh+7xzV3VNnaT7SGeeI8NilQcW7giJOe6t7
         5o0iJhuN8rdhoemeZjL+WMPRTB7F+hEQmg3F7AsP4zXGxgKrH5qeCH4xzy6i0xgwkM
         C5lhMBWSaWLHtcKdM12dPZ8fL9253Awt5fNqJlcBIGfG61Fv+QVs0Znv5NcZ/NXQ01
         oJiZ5pqX7UcvI65n9vh2ADbpS46V5PX/jX2YarFbBkjlhNgsObcI5u94lxXpkLwLai
         9IwIrWZW3VAyN7c1+b+RWsduiotv0ViJYQlkhIMjq6W1j/tX8DIdfg93/N60hfvUwz
         z5iEW3nCxTZSHE7I7QBXuURwRWMbXceWR5DaHg34fWyiyLOYAHN
Date:   Wed, 22 Feb 2017 23:34:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
Message-ID: <20170222233419.q3fxqmrscosumbjm@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Turner <David.Turner@twosigma.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>
References: <20170222173936.25016-1-dturner@twosigma.com>
 <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
 <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4udwhupbswj2wpru"
Content-Disposition: inline
In-Reply-To: <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4udwhupbswj2wpru
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2017 at 09:04:14PM +0000, David Turner wrote:
> > -----Original Message-----
> > From: Junio C Hamano [mailto:jch2355@gmail.com] On Behalf Of Junio C
> > Hamano
> > Sent: Wednesday, February 22, 2017 3:20 PM
> > To: David Turner <David.Turner@twosigma.com>
> > Cc: git@vger.kernel.org; sandals@crustytoothpaste.net; Johannes Schinde=
lin
> > <johannes.schindelin@gmx.de>; Eric Sunshine
> > <sunshine@sunshineco.com>; Jeff King <peff@peff.net>
> > Subject: Re: [PATCH] http(s): automatically try NTLM authentication fir=
st
> >=20
> >=20
> > Some other possible worries we may have had I can think of are:
> >=20
> >  - With this enabled unconditionally, would we leak some information?
>=20
> I think "NTLM" is actually a misnomer here (I just copied Johannes's=20
> commit message). The mechanism is actually SPNEGO, if I understand this=
=20
> correctly. It seems to me that this is probably secure, since it is appar=
ently
> widely implemented in browsers.

This is SPNEGO.  It will work with NTLM as well as Kerberos.

Browsers usually disable this feature by default, as it basically will
attempt to authenticate to any site that sends a 401.  For Kerberos
against a malicious site, the user will either not have a valid ticket
for that domain, or the user's Kerberos server will refuse to provide a
ticket to pass to the server, so there's no security risk involved.

I'm unclear how SPNEGO works with NTLM, so I can't speak for the
security of it.  From what I understand of NTLM and from RFC 4559, it
consists of a shared secret.  I'm unsure what security measures are in
place to not send that to an untrusted server.

As far as Kerberos, this is a desirable feature to have enabled, with
little downside.  I just don't know about the security of the NTLM part,
and I don't think we should take this patch unless we're sure we know
the consequences of it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--4udwhupbswj2wpru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAliuH/oACgkQv1NdgR9S
9ou70w//TUu5etrmp3WcLk3kieQepi5jZ3xDDwAv4QAuDdOb0i+FObha35nEAAIy
Miba6lNmXOnhz7gAHrVS5gnw/NsnYYdYTLyfxLLtvyFTc6sjlalw5no7vIPQvjeO
qBJUdssbur778Pcm0HdUUUTmOiWXSCo6wFnYcgc+fDyULdS7WnzAXrIOyw4h5cAD
vTB4aclZEPEHyXcMQpG9+RaufQ29yuV+PW0okU/3BeaE139pGOb+WaEX5WDqrNCL
8z7syocq8/di0I91bCAuORv5ZxsUgWqq3lGvcNlj4TJYJp0x5d0GYcxs55H0/HJX
Mgqa9padluWdSIPnrMi9JBlxGdv7rY4c4uqXGENvqa1dMC7eFBD8XK2ZvUjvXzea
6icgjTfcUqpm1b0ZCTSdFNG7tqD0IMqljZBTfLsNqJSNYscHKSVmEE17aP5pdUym
MXDnshUatHEAQ4V7II+ERjGjt3aGv2tMW0cVXA9O24FgaiffBp1qa14GUxJBp0Mu
gAJwjf+l8CV3DY6WWG71PoXuRBah8yx2e4qNVd+LyXzrfU3TCG8NGgR5zKO+y22+
kfKKpo52JKzsfohfIfGZQUGnXkT0FdrjyGPEEkCwZBqCTjwAX1MkccMJp4r6BYUX
5+C/mrfEh9P/Z2HaMTrrfAiKs0zf9gGaYygnhn9EYf2O8KpzLrc=
=nmHA
-----END PGP SIGNATURE-----

--4udwhupbswj2wpru--
