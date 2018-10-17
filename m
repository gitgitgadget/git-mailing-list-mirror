Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1CFD1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 23:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeJRHrT (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 03:47:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51298 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727019AbeJRHrT (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Oct 2018 03:47:19 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 750A861B72;
        Wed, 17 Oct 2018 23:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539820149;
        bh=3/ovKDce/ICyRW5tPJKnfyGoBnVRG10mtM+C4jc1bLk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vMrEWspTpPKpZSN4oEmMn/bLE3ZfsXBviYgaJW0Xl6ZuypwAXGRwcMs3/JFJdTfLZ
         ola6MYmvIZULV1yOc+RF7fhWoz4IntrdhytkLr74AqGH9KCPsyFcTYuGKty8joRiM2
         gbUo86PCDHE4pA2SFWoJbWZ9QjMYeUyPOz+zAtoucDwhgYg2/hTqwiisf1VoSgSZYH
         oAlO342NXkUwSOdJib7ubcDVkf7x4dsDA2q1blAdFXrLMtDQzK0ndSfFVkXOVhIT6z
         pbDyFtmpn2WjzeM48KnqvlG53XvYKi9pfYRXmX91nJ4dKdfuq9sDfjh0CpEcNGYP9E
         p+PjTtnQ11BQKZYmjc2pKzMdnTo7wkaUhEhUpF3LexsJ3lbifb5LMJRKW6xgWwUOKT
         xxaJHcsIVOQ74wxFo/rUraXCwS7R8YzodnDPTbEQwVCAbvbnMv5orG4Fqk3aKEY9ty
         45yqg2RNTh7KdkG2OeVrerkJDfakMOjrAs9O+Dqbk4XMEuc0Pdj
Date:   Wed, 17 Oct 2018 23:49:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 03/13] hex: introduce functions to print arbitrary
 hashes
Message-ID: <20181017234904.GL432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-4-sandals@crustytoothpaste.net>
 <xmqqo9bu4pww.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fcn+O7u6afXSKWdN"
Content-Disposition: inline
In-Reply-To: <xmqqo9bu4pww.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Fcn+O7u6afXSKWdN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 10:54:23AM +0900, Junio C Hamano wrote:
> Even though in hex.c I see mixture of *_algo and *_algop helper
> functions, I see only "algo" variants above.  Is it our official
> stance to use primarily the integer index into the algo array when
> specifying the hash, and when a caller into 'multi-hash' API happens
> to have other things, it should use functions in 2/13 to convert it
> to the canonical "int algo" beforehand?

That was my intention, yes.

> I am not saying it is bad or good to choose the index into the algo
> array as the primary way to specify the algorithm.  I think it is a
> good idea to pick one and stick to it, and I wanted to make sure
> that the choice we made here is clearly communicated to any future
> developer who read this code.

Yeah, that was my feeling as well.  I wanted to pick something fixed and
stick to it.

> Having said the above, seeing the use of hash_algo_by_ptr() here
> makes me suspect if it makes more sense to use the algop as the
> primary way to specify which algorithm the caller wants to use.
> IOW, making the set of helpers in 02/13 to allow quering by name,
> format-id, or the integer index and have them all return a pointer
> to "const struct git_hash_algo".  Two immediate downsides I can see
> is that it exposes the actual structure to the callers (but is it
> really a problem?  Outside callers learn hash sizes etc. by accessing
> its fields anyway without treating the algo struct as opaque.), and
> passing an 8-byte pointer may be more costly than passing a small
> integer index that ranges between 0 and 1 at most (assuming that
> we'd only use SHA-1 and "the current NewHash" in the code).

I thought about this.  The one downside to this is that we can't use
those values anywhere we need an integer constant expression, like a
switch.  I suppose that just means we need hash_algo_by_ptr in those
cases, and not everywhere else, which would make the code cleaner.

Let me reroll with that change, and we'll see if we like it better.  If
we don't, I can pull the old version out of history.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Fcn+O7u6afXSKWdN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvHynAACgkQv1NdgR9S
9ovx2RAAvKYhlk8RczNJEqlPP0a2104O8V9BrmFMtUqXJ87sPFHU7gUwvlQT0Wnc
kN94kz9q6sOhr4BeIZweppvmNiA86HxASrOz7OLH7OYgHDrkjfePzhf9+RcybKxo
cENuBoKrk2a8O3uvbHmb6FGslA/sAkmsdo8BlFnj0esY3iZ7l0BAPhIzdxuSLOWT
fmUyMlpmU/T7jyw6lY+a2zRv11o5nyjbU7VCoQqqSxjoFzbVDfb9PfpSOHT7dwIt
hh6IjmU4XdymCshl2f1GTizijlKIaFWEVEl//KEH4ZVxsFhALU7sNrmuH+ptei3O
jKdBAXDQKrc5giawqsbMUqF03ldRA42d+QMdvFih3swH4dTVPsAzarZGacZU6mR1
M/bsIplnFUdNkYY75jyNG4+uQ2QQv96w3GwTunTgvV4Bf1or7aYZoyN36kHnmhNO
UoDOGCcLTBeNudSFxF3t6ZhqTNXYmM/D8FPq8R6M0msssk+pzg0vntf4/6/jR7qy
XW5yVv0NS5k3+mrMEJdFE0JhJbSeHpuZy9oJYpqwdG4ImdyLNoQY2qEHT55HgjxT
D8rV+pXC0/3WgpIae3NLHUziTHCros8czPYBE87rOcpeXeMJwmzm/xCXWGyBEshd
oQYAsR/RcgFWdFnqj1MH7jOfDx8B3ZAbKh00sakE4THZ2QSNRj0=
=I9Rj
-----END PGP SIGNATURE-----

--Fcn+O7u6afXSKWdN--
