Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B6F8208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 18:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeG2Tlb (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 15:41:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39350 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726493AbeG2Tlb (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Jul 2018 15:41:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e88b:d3b1:c008:ba22])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6BDC56073B;
        Sun, 29 Jul 2018 18:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532887812;
        bh=j3iz3xOZlpCXxtdgf+8eECQMZCl69Y5b7W7JX33QrmY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HQDa39HOTWU4yuc4DvA8UprP61ADoCabDaugZ0RXOURfeo+kzmHNK9chgXZjPaEqP
         /LGfPYKCC/jjNjXcWm3qkDLrsiT/TdfFX9MdufJv7m6CNA1fWaFUmPoJ64tNZ4Lu61
         abaz/7UWBxG/AXrb4ME+ALBe+5AKyoRQ7vZGXBJyJapr9KLm2+ypcgfnHzdy88wfu9
         x/cdnU8L3upuMegqES1AQ8DMj4J98es5zgbeWQi8lr9FaX3EFe5vpDS/XcitxXDQdA
         GvKkCkOi7Z2DVeMQbByn/1/Nx2D3ZfExiFvWePuhOgDvy/VEz0Wp/qVTeGBlcQMePm
         4bjPRy8ntZkN3ayWt+FzZo2FxhTXoNN9xdaL1dC26UDe/s43FaK63WD1dbcBGhV6Pf
         r9QeqF9/TGMrMN/uOR1ri7hyg65TAwaiQkG6q4gtSgjmVU7jRRz6Ax9DJNkCoSXDih
         jtg8JynsZyDU9ldH+XV31zGUu4AuvYCvsE7E8MfKzEjIwo5QJvF
Date:   Sun, 29 Jul 2018 18:10:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michael <aixtools@felt.demon.nl>
Cc:     git@vger.kernel.org
Subject: Re: git broken for AIX somewhere between 2.13.2 and 2.13.3
Message-ID: <20180729181006.GC945730@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael <aixtools@felt.demon.nl>, git@vger.kernel.org
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 29, 2018 at 06:44:26PM +0200, Michael wrote:
> root@x066:[/tmp/xxx]git --version
> git version 2.13.3
> root@x066:[/tmp/xxx]git clone git@github.com:aixtools/hello-world.git
> Cloning into 'hello-world'...
> remote: Counting objects: 3, done.
> remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 3
> Receiving objects: 100% (3/3), done.
> fatal: pack is corrupted (SHA1 mismatch)
> fatal: index-pack failed
>=20
> p.s. - what surprises me re: git-2.13.2 - no messages about 'Cloning into
> ...', which version 2.13.1 did give.
>=20
> I guess a bisect is the next step - between version 2.13.2 and 2.13.3. Ot=
her
> suggestions welcome!

Are you using SHA1DC on that system, and does compiling with another
SHA-1 implementation help?  There was a change to the SHA1DC code big
endian detection in that commit, which might be the cause of your
problems if you're using a POWER or PowerPC system.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlteAv0ACgkQv1NdgR9S
9osNyA/+IqfqvAHu1CTrH5ESMRvTq+PdO+VECNuqDJ+zr1DbsQfSEpDq5QKKnZVn
ARzhvdxTna7TAa3+VR0nCCRiFsRl8lZEUcmbzr/uH+rOpmFvK49fnNnf+Ugpc4Xm
kes4XghQRzxwM5eGSYFBtsiPLl4blOhdJ/rvbTCgnvhEJDVn05pHHIj87NvG6eox
jU2fr6xh508XlkaBar8J0nZH28tu2vcudkFrkNkBKNOzWDtmY4CYAbH5vlhXJg93
g8m6xGvnhSbQ6U7j65ltoLzKiEMvsn2QS4AYjoecsw0WHLaCe4egK9VXVFbA2ORR
hVgcXa9hYPYfGJ7VKPs8lM7LeAQ3aWz8OIHLe8+BrDQjgMpnffxEmQJG26ssvQna
MTLnxt7/chTYn8/rIZx4WYaMxzG7GIknUUX+fHquDq06Xu3hksYSgjrmDz+9ieop
1ZHDBMQVyhEtY4nxT6MvpJZMynIQmMfJRYUKLkU3fm9nL3Jubpu4WIJyWLOUVZWj
7QNNBztdjc1+/Lw6SD1drC8BWAac8K5UIb4TOtlDYF06CAa9rXFNmBYy0Q044yOx
FmETD5gVXgOF3yvxutMLxyAylRx9yn3KKXaB+p1EITSTg6jC5uUjdBbTZ19W43sH
X20PXz/SEzzn8llhp2riUeA6241g75c5haTeZRwCnj05mw/1o7g=
=IKWQ
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
