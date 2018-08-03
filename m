Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 914661F597
	for <e@80x24.org>; Fri,  3 Aug 2018 17:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeHCTnX (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 15:43:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42450 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727362AbeHCTnX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Aug 2018 15:43:23 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b423:857:b27f:2f08])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 426046046D;
        Fri,  3 Aug 2018 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1533318364;
        bh=Dao18hmvH5RDyEgvYdm3HPdLs0SxjGvfgLAIRRvpzlU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Fx6iI2ZQVfkphFMA94lIPi0a+oG1OX09/KeLMP2XSZ/NimcBLV63oC1823KxWkT1L
         828I7Si6y21pdVUpAmUgDGT3g8HMRELTIlQujkxAffhcPk7r70zwss5gcogUgK5BrA
         trVP4FSj9Fm5PsU+KwJLZtxsakimDggeylLDiwdvja9IxQEkgfTIsPMNbrmBgcETjz
         Q+Uyhv7O2P+1s+WkhO/zhamfOqNWDFvTzBOa96tJkVvXa9Z2gLm2VKCcScZqBltPxh
         /3bEJ3QHts2KQFUB+8xY/M/9b/gmX4ILZy+/L+pEAMY2ooWH5F5w5WVGQQ6NoOMeH1
         DG0GxNh3rc4JRHFti0JwTn88TENYoiw2q+ow6r2VmQdiThpEz0thNwr+c6mBQN9zis
         9haEQjJb/hQvfH2b/Dd0MJkkvmkn56/E9ZIptoJEf16tn8ze+7/gyur94F1OXygBL/
         oQDiC3JMko70a2xiANUbZ8e/DN22NgAOwiZjFUdXIoeNuLEv2V9
Date:   Fri, 3 Aug 2018 17:45:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
Subject: Re: [PATCH v2 2/2] doc hash-function-transition: pick SHA-256 as
 NewHash
Message-ID: <20180803174558.GC106068@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
References: <xmqqin53t30d.fsf@gitster-ct.c.googlers.com>
 <20180726134111.17623-1-avarab@gmail.com>
 <20180803072014.GA256410@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <20180803072014.GA256410@aiede.svl.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 03, 2018 at 12:20:14AM -0700, Jonathan Nieder wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >  Object format
> >  ~~~~~~~~~~~~~
> >  The content as a byte sequence of a tag, commit, or tree object named
> > -by sha1 and newhash differ because an object named by newhash-name ref=
ers to
> > +by sha1 and sha256 differ because an object named by sha256-name refer=
s to
>=20
> Not about this patch: this should say SHA-1 and SHA-256, I think.
> Leaving it as is in this patch as you did is the right thing.
>=20
> [...]
> > @@ -255,10 +252,10 @@ network byte order):
> >    up to and not including the table of CRC32 values.
> >  - Zero or more NUL bytes.
> >  - The trailer consists of the following:
> > -  - A copy of the 20-byte NewHash checksum at the end of the
> > +  - A copy of the 20-byte SHA-256 checksum at the end of the
>=20
> Not about this patch: a SHA-256 is 32 bytes.  Leaving that for a
> separate patch as you did is the right thing, though.
>=20
> [...]
> > -  - 20-byte NewHash checksum of all of the above.
> > +  - 20-byte SHA-256 checksum of all of the above.
>=20
> Likewise.

For the record, my code for these does use 32 bytes.  I'm fine with this
being a separate patch, though.

> [...]
> > @@ -351,12 +348,12 @@ the following steps:
> >     (This list only contains objects reachable from the "wants". If the
> >     pack from the server contained additional extraneous objects, then
> >     they will be discarded.)
> > -3. convert to newhash: open a new (newhash) packfile. Read the topolog=
ically
> > +3. convert to sha256: open a new (sha256) packfile. Read the topologic=
ally
>=20
> Not about this patch: this one's more murky, since it's talking about
> the object names instead of the hash function.  I guess "sha256"
> instead of "SHA-256" for this could be right, but I worry it's going
> to take time for me to figure out the exact distinction.  That seems
> like a reason to just call it SHA-256 (but in a separate patch).

My assumption has been that when we are referring to the algorithm,
we'll use SHA-1 and SHA-256, and when we're referring to the input to
Git (in config files or in ^{sha256} notation), we use "sha1" and
"sha256".  I see this as analogous to "Git" and "git".

Otherwise, I'm fine with this document as it is.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltklNYACgkQv1NdgR9S
9ouC0w/+KOzYAhdn3pg3olTDp8rRijaAR1GTQoVX6hy770ELoSvflD3Ez5hV2SOK
fmHzQCQUjmnvQRHoHRsg94CJGyIrowk01iICyqcBDeooaMP3G9gSB2tkseWKrugS
oG9H2V0vVSsmgQ9E2SB3EjaECBEZYmyKQDwjJFn28YVwbo3j0B4e44rUTRixpEFC
IUZIChDGidMIQLVb6fy5mSksl1UOTkeg7N5ydXZzKEKe8MIEjEDnGbmJA4O/pvcZ
/jEbMD0YkkWPaYzLyYo0CDWthhs8BmWBWPp/PAn7fWEq2NH0tjrmsaJuYEbwZ3PS
OL7HDtSccEvZyuxxvrO/yBOPVGq1TwVcc1ppgm1RdwGldND8L5orEEEJxVE0p6sU
Jc3TxCRwDJ5ned/3DptJUel0H9CZ0ds7uiOc4IwsfndAzZevj1BFnglyGrcNr0Dm
SKfpV9ThE93l986uYOtF2UD/BnweUZch3/cJ4JFBcnOKKF2FUT8+fBnMRKn/bgC/
MIlDzVF5kKXEbkeV45B5jsx+Xb2uWm9tcVbioRUltGYDuRNUmxy5BWElTNeC05SX
2qmbLnr+At85EXbxG5YFKNPc5EHW58J9pbcqcAGOhMCEZ/mOQRq8cg22WPs9RTTf
l3uklo2sCxyRinSJFAFmPZ09jK7eZbJW46pWQMZ+J46ENb4IUOI=
=vA69
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
