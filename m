Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6608B1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 01:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeBHBrn (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 20:47:43 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58756 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750987AbeBHBrm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Feb 2018 20:47:42 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BA5406042C;
        Thu,  8 Feb 2018 01:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1518054461;
        bh=f7VlCkFKFHhf8lM7VpIJC26IZTuRi21SzNzuJcWAMQo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uo+LZrnWVeNgXqn82+u8Pemvg2UonlHPz0pT1POfH/7MPWsLTJIxYXKYQn/8fGJFn
         JIdBsy2L2dkodB8W4RKs/e0GJQ10HVcXswWlV5+sEE/I+iWpJm++Q1h4K8v1z9Dw43
         8bBD2KTyQF/vD3jX7fDsKoD3LYKm4SM+wiPlx8I/tciq7Dd0JV7U84lIK3X/wdFVmX
         4aoqMY/YSYU9iRnjtLP/PDl2n1BYpkk1nFcifAFxWoUXDtMo1S8JrP0iQlMT44I7IM
         3Ypcajpb7HNQS3+uBTrqyZ69nyekXj+utBWLG/601ynv421jSSk9i3G0E8W+lK2yd5
         AtlAGjFov3tfnrR0t5vbIC3OO3jUjJ5d9RpWPnpaUcvEnhew6eB5XfSfFjD5ywotKA
         5MGe7L4xirRB+dCXD8Ll86/8JsfY35rx6okuadigLzHaBpqKchT2mDc/1G+V7yDXZG
         MLu6QyrZwULh80a3FMnzpsAc1cJc/DKwaLkbj7Hb5Y+vqoMTd3/
Date:   Thu, 8 Feb 2018 01:47:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 025/194] object-store: allow prepare_alt_odb to handle
 arbitrary repositories
Message-ID: <20180208014735.GC785098@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-5-sbeller@google.com>
 <20180206011940.GD7904@genre.crustytoothpaste.net>
 <CAGZ79kYAjs17RvRyo4rErR+ymkKfyORZ7xBSCDm_q0b-E6BqiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <CAGZ79kYAjs17RvRyo4rErR+ymkKfyORZ7xBSCDm_q0b-E6BqiA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2018 at 09:48:56AM -0800, Stefan Beller wrote:
> On Mon, Feb 5, 2018 at 5:19 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On Mon, Feb 05, 2018 at 03:54:46PM -0800, Stefan Beller wrote:
> >> @@ -434,12 +433,12 @@ static int link_alt_odb_entry_the_repository(con=
st char *entry,
> >>       ent =3D alloc_alt_odb(pathbuf.buf);
> >>
> >>       /* add the alternate entry */
> >> -     *the_repository->objects.alt_odb_tail =3D ent;
> >> -     the_repository->objects.alt_odb_tail =3D &(ent->next);
> >> +     *r->objects.alt_odb_tail =3D ent;
> >> +     r->objects.alt_odb_tail =3D &(ent->next);
> >>       ent->next =3D NULL;
> >
> > I'm sure I'm missing something obvious, but it's not clear to me that
> > this transformation is correct.  Could you perhaps say a few words about
> > why it is?
>=20
> This is a pretty open ended question, so I'll give it a try:

I apologize.  My question was about the use of ent and ent->next, but it
appears I merely misread the patch as converting from ent to
&(ent->next), but that's not the case.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlp7rDcACgkQv1NdgR9S
9otnvRAArBeVfz0JBUUHfUNKdbG8hrJcL32UG9QDe4vc+0dMk1mN7181CnKxBsTD
FCSfnahNGhfkhKFYZJ9uAJS8FWbtb8m+jMMCJKlPR6ojWus0fDdstoI1dHNjKEVn
fBlDAREm6RK6w3TkUWYXGbC9CkF4FmYUuh1oQAiqCG81oByw0EslSIq8DvKtjpMZ
X9kRfxmPH8LcnulpADGOJ8pm45cwUpBoyBx701c4WCQHY8rrZPt66FafErBoZ8Wo
HcS4ZDP8cbKlJl9PG/IslW7RtGHhp7HzRJwrDVn/iegX8Mw3Fo/A50godNgeETtR
S4n7AFHlOTEjnuVZLTdzMYzoLc1tNEUEYW2Dz/EPWlDc+JhcZK7EWEukhuysYlmw
Yp+RXuh39p2VsmGM2XxkfwhBdcqDPAC2kCA1ViSyQQNYelg0i29FjD+yjVLvLud6
ovbjvftwa6q2ev2paRh+73Lbowckypgh+MOAqVagIXYYqZjaU+Nzmfd+R7dfyKdN
htE5eyxH6/h6iSslrB+EZUGEKBPSkvNJAFCS3qoNLlJY+TQk3lP++UuOOgxWLFP9
Yq3l1nYSOSsBtcQpQsP4q8lTRo7oOegEEJ6x4ArhDr27889N5cHH7vZZ5qyiBg1j
/7h0AfTXNsTt/jAqXVv2gJ45cAtPV7jb0ZzBfzKgTC/DvO+4qfY=
=E9bg
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
