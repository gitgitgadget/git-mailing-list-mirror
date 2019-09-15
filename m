Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99DF11F463
	for <e@80x24.org>; Sun, 15 Sep 2019 22:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfIOW5l (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 18:57:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58748 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727492AbfIOW5l (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Sep 2019 18:57:41 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:4d4d:a9ce:2c0a:3d66])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 178FE6074C;
        Sun, 15 Sep 2019 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1568588259;
        bh=QYGagjbX0H7XqTLIdLlIl8GX6KosiLdhZJbTBZLH7f4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LMhXN5BlrpXtVmCvhEwb0gX4iyM7/WVnrzSHjD3aelMo2pfAEkbO04vo+y1co1H+r
         Zau7HlwvlLDH4WJ1QhXXzpsg2ViaU5E/m4lkkGD82qw6AO06thyqu97VhpKf0Aup7G
         Qr1h4CPB531wI3sKykhO82GCWIN7pQVorWS3mC+Vsit3TrNubVoXodHHHhbFsxJ6CU
         9XCOpBTRrR7EkJHpy1s0gfS8YFpr8SQIekLNMVx7DxX2rzDtf7fsUt2DE/6oRMdzsn
         0z4pHy6TlOwM8lJmXCxXxJrJVnyD2r4MyVNKy4k+ik2oPzYm9zIxN4E84qnPB3uf0G
         F20HNWPkNqMDPaGGtnHttk+XkTvaly56kJLrdzHrtTz0CzE3ovxu3x1tRF97M79SJH
         AvNGvXvYLm5+3CZDKUYOqy3P+H7bdOlB6RZ9KBHs9Cx9ajNgT8TTBHHGqsj9UScdjt
         6n6su+h1mCLDkCxlWNECt97B/HwwQbnAod16QG4j8oSdDWGQGO4
Date:   Sun, 15 Sep 2019 22:57:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: provide guidance on user.name format
Message-ID: <20190915225733.GX11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190914210219.753136-1-sandals@crustytoothpaste.net>
 <xmqqtv9db3vk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0k4Rxg87Lb8yV0u3"
Content-Disposition: inline
In-Reply-To: <xmqqtv9db3vk.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0k4Rxg87Lb8yV0u3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-15 at 22:18:07, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-comm=
it-tree.txt
> > index 4b90b9c12a..34a8496b0e 100644
> > --- a/Documentation/git-commit-tree.txt
> > +++ b/Documentation/git-commit-tree.txt
> > @@ -92,6 +92,12 @@ if set:
> > =20
> >  (nb "<", ">" and "\n"s are stripped)
> > =20
> > +The author and committer names are by convention some form of a person=
al name,
> > +as opposed to a username, although Git does not enforce or require any
> > +particular form.
>=20
> I have a lot of trouble with 'username' in the context of this
> paragraph.
>=20
> After all, you are describing the name appropriate to be set as the
> value of the user.name configuration, and you are trying to stress
> that the name used there is different from and has nothing to do
> with the name machines use to identify the user.  In the paragraph
> that follows this new paragraph, there is a reference to "system
> user name", which is still not great but probably better than
> "username" above.  Perhaps there is a term that is distinct enough
> from "user name" that is commonly used I am forgetting?  I am almost
> tempted to say "user id", but there must be even better phrases.  I
> dunno.

I wonder if we should just omit that aside, then, since I'm not sure of
a less ambiguous term for "how I identify myself to a computer".  I think
describing the convention as "some form of a personal name" is probably
sufficient to tell people what we suggest they do.

My first draft of that sentence didn't include the part within the
commas at all.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--0k4Rxg87Lb8yV0u3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1+wd0ACgkQv1NdgR9S
9ouNsxAAi7l0bL6bxQ9XDuOu1UHbtMAmATljvD4Jxb49jjE+3FUBbz5Z8sWFlFjL
TMY8AssfMiBylkp3KO0N4bouOPdbCoK6aYDl1cX1vDovm+fMeOz6zsiofmNblO/1
VFPfBuexpQElk4r6I2zZh+Qjo0w+DGQoPR5vasvPiGNi5io4MWpjbt1aua4+lYmj
/uECUqmFnGaOW6MD2Jz0OZN2/CsZiowNa1cDSA0uBNWL/mtn1yBda+1pAHs/FBAs
sBhTH4niQX9RFOVNf15tRXQ6FesJL86hNonfeSGLgn/A1uYcTSMEld5tmvELvccp
BbA6qYp18/2pam0WMC9VFzILF0oU0H028RwPvO9QntVlVunVhLZjI27Sp1wnY+BG
6lxYP8XrAFkZYQRKiBLzjuezvOxaKmggSa3FXjlaqRsSzbMByTkbsPNUOKBnxMhw
dHENONj+sVLdX4icLFCw4WV4Ujeve3uSaBwIFEb4xXNXddA61H8zDP8TRrsXdI8r
fu0JNz58t2WPveLLYM1luJcXPW6ebx+VdtakEN2utRgoxDmMbE6E9dq0MWRZtiih
jzt5O9YHrh0mAZ9nX1QBsvSk1leXY6E7Q/HlfyoyezBdBcswqG8fbOz29ezTQ9/9
KKwBsWTYtateWsYsXki2k2dUqDIFEi6HZvpe/SzlUsDMgjzUiVM=
=gmBW
-----END PGP SIGNATURE-----

--0k4Rxg87Lb8yV0u3--
