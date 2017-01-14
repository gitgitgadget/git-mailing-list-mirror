Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7BA920798
	for <e@80x24.org>; Sat, 14 Jan 2017 21:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbdANV5x (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 16:57:53 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53372 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751993AbdANV5v (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Jan 2017 16:57:51 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 05967280AC;
        Sat, 14 Jan 2017 21:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1484431069;
        bh=twiV5zWrC4GwXLvlayKGcCV4pD24TFYtNKjq2FcqCbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D5jJgjQPrfGdTuWvN9l2X0dJyzCOY0s9K1GLAAgtCbt6BiiOdSsUyHmXDWZ1Ip7zi
         ZeADjSS9V+e52HYHfhNv6MJwXIRaqYYrHsRbj6+UOXV2EKWF9v8/9Hhd7D55TkgsSO
         qErp8OW2ANZ6OAXD61KwWn/8WMujIP9v6VoYi/TuqsIx2BR5MeKVEGaNOY/82LzRUQ
         1r7TbQRvMVXKMXD76IKA9cj07HrQFJyHTr00ip3WnwAKN0OK1Ym+dA8FgRvQe2J2di
         7Q5Fht9zyEiPU0wb8ecYFP9TAroLrx+SxuI6xV3lrlVkK1nUcsjkaCxSkqdJaY1adm
         g2lo6tT7VzDnngQ4eHS+g8jR0cO0PqeNjpWUmMOlsublVdw3CdA7vWHKYAcQE8r0jd
         l3bwT8wiu/dRO98CgktgXXjxSaBfXfGJPJzhC/gC9+XjXGKIqXJj/4+apypN8EwJVm
         2+5QNOpp/yVnSYpVp6mt9TbapT/UYVc6lDb11ALYEI8aTEB++Cf
Date:   Sat, 14 Jan 2017 21:57:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Pat Pannuto <pat.pannuto@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
Message-ID: <20170114215743.5igbjup6qpsh3jfg@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Pat Pannuto <pat.pannuto@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
References: <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org>
 <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com>
 <alpine.DEB.2.20.1701121118170.3469@virtualbox>
 <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com>
 <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com>
 <20170113024842.GA20572@starla>
 <xmqq4m12izmd.fsf@gitster.mtv.corp.google.com>
 <20170113185246.GA17441@starla>
 <20170114075408.hyidkb4rzxzmm2je@sigill.intra.peff.net>
 <20170114103134.GA586@untitled>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mcb4s5eo2fr5mzkz"
Content-Disposition: inline
In-Reply-To: <20170114103134.GA586@untitled>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mcb4s5eo2fr5mzkz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 14, 2017 at 10:31:34AM +0000, Eric Wong wrote:
> Jeff King <peff@peff.net> wrote:
> > Just as a devil's advocate, why do we care about warnings in third-party
> > modules? Or more specifically, why do _users_ who are running Git care
> > about them? We cannot fix them in Git. A user may report the error to
> > the module author, but the module author may not be responsive, or even
> > may not be inclined to fix the problem (because they have a particular
> > opinion on that warning).
>=20
> Every user is a potential developer(*).  And I do feel
> we (git developers) should be at least somewhat responsible
> for helping maintain and fix the projects we depend on;
> or moving to alternatives if we can't fix them.
>=20
> There is a chance a newly-introduced warning in a 3rd-party
> module points to a real problem with the way git uses it, too.
> Having that warning would help us fix or workaround the bug
> (either in git or the module).
>=20
> I doubt any module author would be unresponsive to having a
> localized "no warnings" for special cases.  AFAIK, "-w" is
> widespread amongst Perl users (unlike Ruby in my experience).

My experience is that using strict and warnings is so common in Perl
code that absent a compelling documented reason, most Perl developers
would consider it a bug not to use them.  Consequently, using -w, while
a good practice, is unlikely to have any practical effect on external
modules.

What is more likely to occur is that as newer versions of Perl come out,
we'll get warnings about questionable constructs that Perl, in its
extensive flexibility, has permitted for a long time, but should really
be fixed.  Most distributors of Git will have fixed any affected
third-party modules as part of the Perl upgrade,

> I'm not saying we blindly start using '-w' everywhere today.
> But we may at least try it and see if it introduces new
> warnings, first, and only enable '-w' when it it looks quiet
> (and perhaps start working with module authors to fix warnings
>  if not).
>=20
> As a user, I'd rather have some indication of where something
> might be wrong, than no warning at all when something does go
> wrong.

I'm working on patches for USE_ASCIIDOCTOR=3DYes and I found at least two
bugs by enabling warnings.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--mcb4s5eo2fr5mzkz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlh6ntcACgkQv1NdgR9S
9osRYA/7BJ+snpYjG9YLBTgiyQGnVxF3UHAXAPeg7xv4Rv/58ik9wmwMACY7AFEu
G8PBA44M7RFWpn4J8si+fgoGAP3mgqtzQpbttbzpFnwoZAIPoE//+0MAQtUO2CCG
n8gdifzV5udBhlXuMn4eKfmP/5qv8wS/spjMLHXuY2ZKA4R3mtNSt/ok1KCpP3hs
IHOG+IVN+ctqrfASOGHWYdgntSNWN2MTUJXAvs19mNWHIX/9H2b+5kbTCkfrZnar
TiGXKQWqKx4NQca/93p+5brIjxo+AbBxMTY08x2Kl6m6P8R7fm0D/0945z2HWjDs
Q6kb9Dp0o1U63fWyuz2rmsu/t1qzJsehZlloiPt2iqcukxQzhUhmtEhDIsFM39nF
3vYGE9nLSqTeAfn1kO2s4Rv+BpkPEdAr0NhS1j35RQWyYZHAVeYaUelenZdVbW7y
wzwKIKCeaugvmUkBpRLwzihtlBBydBsKNgnmnLOjIRnhZVb+E3Llyz+eZ6toThtM
7Qo7FgRUwJc0+QJWtuTV9W76jIUc51WVu1KsTd8FmQwQnYgUWehKYYArAC42kTNL
pcxh4oll6w34ECUYD4vVy2W/xMRmGZoirQc3dnJD17ckg46AR6WSYB5n1jkoZixj
4VbmQMFPqOeKM2jbCOspJnyVICcXXReS9OAbZAHXZU2X9wNPdSc=
=D5jv
-----END PGP SIGNATURE-----

--mcb4s5eo2fr5mzkz--
