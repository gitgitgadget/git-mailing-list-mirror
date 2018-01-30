Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DE6A1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 03:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeA3DJe (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 22:09:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58997 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752076AbeA3DJe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 22:09:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85152B8903;
        Mon, 29 Jan 2018 22:09:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=iIHLXHS6v+0x3VVn7XdCGtHhtEs=; b=C+54eRG
        yM9PTuj015NToHv1y+B0UoEnhSQgthBhfQdAEn1BFWdNR2CbIaq4ZLgXbkO47dpq
        0rHGUuPrSOtzdFL4+hpkYGtb8Gne+7pLmy4U6WedvdyFtHDOeEiKNfmZDFhZb9aT
        SKGf96NyxWuoTmBzy/1meySj2aZQqtn5I6JA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=XQyQujpqFV0EGhuvB0C251HjBkKn301/4
        fvqIujCGM+kewvZKLzbA70HKkyu52172JHlpumvga/0xo36cTaT81IZrQkxrw2TD
        25YZ7nPWl5ZQ4CRI/TfEzE5OlBLtMm7v5WjkX18x/MDsyUWwfvRtAbVRsw86NKrT
        yRaINE2wvQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DC6BB8901;
        Mon, 29 Jan 2018 22:09:33 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1747FB88FD;
        Mon, 29 Jan 2018 22:09:33 -0500 (EST)
Date:   Mon, 29 Jan 2018 22:09:31 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>
Subject: Re: t9128 failing randomly with svn 1.9?
Message-ID: <20180130030931.GK1427@zaya.teonanacatl.net>
References: <20180129015134.GN431130@genre.crustytoothpaste.net>
 <20180129025812.GD1427@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eT+isKliMkztK06K"
Content-Disposition: inline
In-Reply-To: <20180129025812.GD1427@zaya.teonanacatl.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Pobox-Relay-ID: FEA0E3FA-056A-11E8-A509-D3940C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--eT+isKliMkztK06K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I wrote:
> The 'git svn' tests are not run in Travis because the perl
> subversion bindings are not installed.  I haven't made time
> to try installing them and running the tests in Travis to
> see if the failures occur there, but I suspect they would.

Before anyone spends time wondering about this, I was
apparently looking at the MacOS build logs rather than the
Linux logs.  The git svn tests are indeed run in Travis, as
long as you look at the right build logs. :/

Sadly (or amusingly), I think I looked at this before and
made the same mistake, realized it, and then did it again
today.  Hopefully if I make the same mistake again I'll
realize it before I post it to the list. ;)

Anyway, the Travis Linux container uses Ubuntu Trusty, which
has subversion 1.8.8.  I suppose that's why these random
failures haven't turned up there.

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I got stopped by a cop the other day.  He said, "Why'd you run that
stop sign?"  I said, "Because I don't believe everything I read."
    -- Stephen Wright


--eT+isKliMkztK06K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQFEBAEBCAAuBQJab+HoJxhodHRwczovL3d3dy5wb2JveC5jb20vfnRtei9wZ3Av
dG16LmFzYwAKCRBDJZOLvq8M43c2CACuGN6ljmL+P4YpsPdXayfX39FqYKLEUkbJ
+3+3C7g4eSfnxtfYnd0ObUT23b5uVzBXbtp5aZxvjZA8Hmiokq3vCbWsqnhrZ1pt
2JbEGhe+V+2nt7o7a01+EClBNbyE0JGMnfqGSGeIFRVz5HBFFBiwpZKLlMEDaGfa
CngDV7t6EEC30hIQFSIwh/hZjqinKusWSI9jlPmZoegAYuFAU5ne7vPonlbto7x0
VjwI2LHmP00aaTfiDvMBw/KpbBksdLyJXvo5523nh+atE4ig3f1BHCZbWmD6In2M
oqUfR3JL0rdIi+rUucrNXgdjyCyTTQaVrRotQtc3IjAmPvrP4C62
=dfdO
-----END PGP SIGNATURE-----

--eT+isKliMkztK06K--
