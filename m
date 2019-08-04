Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08A841F731
	for <e@80x24.org>; Sun,  4 Aug 2019 00:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbfHDADS (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 20:03:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57276 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbfHDADR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 3 Aug 2019 20:03:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:49db:b3cb:1703:1c9a])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 31B7C6047B;
        Sun,  4 Aug 2019 00:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1564876995;
        bh=UGEGDnNOjNHzzJgs0GQUZYBhUSvNFSilwFrBZV/vQvQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=r1JhYV8PFB0uFAQRRiMstITatRnM395IFXFDzmbhPNV1LenBKpNer2jGozKjljziv
         EBHsmMsdD38nKKzbRiQ07Dp5/9KrL/19QP/9cw7iMPdAL63kJ5tZOAZNrcUwxyKmwh
         6uwsKG6FWkbIipojiM1STOheNwe8+mylKFg6OyI8sHur7bY2lCE+PXDFQSp6OfFwwK
         mzfTQ6c9Z69q9CegZnSMRPuP8iC3AwMbR1XySfpnR7pc/7uZ0AtGA7wdjXKjVKXB+R
         clNEsNi7AUzabNtnx5JDwD0KW7US/Nevjunz1dbIuWn8S/7gqAJ/d8OmY+yP0pkz3l
         C+rrrz2FteY3qtqmy3Q73XyqnZhkT9i+Uc3ltSk7LZhUChcIYiORfDSipwPS1Eq5EH
         tscKloOZ+NlcYlTMgynJd1sSwd+6TpcFXtNyIWi++kAQ/wLqkriKe8UcNH5S4kHOlL
         9LHCatWbRwYhQPsU3hvTFKqRQagb/L9KAM2VVDzIqAkuiJdChcS
Date:   Sun, 4 Aug 2019 00:03:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     lufia via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        lufia <lufia@lufia.org>
Subject: Re: [PATCH 5/6] Add plan9/wrap.c
Message-ID: <20190804000310.GD118825@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        lufia via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        lufia <lufia@lufia.org>
References: <pull.305.git.gitgitgadget@gmail.com>
 <d00bbdce0d5104f1793b7fa0dce14f678e9fb331.1564876327.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline
In-Reply-To: <d00bbdce0d5104f1793b7fa0dce14f678e9fb331.1564876327.git.gitgitgadget@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-03 at 23:52:12, lufia via GitGitGadget wrote:
> From: lufia <lufia@lufia.org>
>=20
> Plan 9 has bind(1) instead of ln(1), but bind isn't persisted to the disk.
> However it isn't efficient to copy git to git- subcommands such as git-ad=
d.
> Therefore Plan 9 needs wrap.c to switch behavior by executable name.

Does Plan 9 have symbolic links? The INSTALL_SYMLINKS option uses
symlinks instead, which should avoid the need for hard links.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1GIL0ACgkQv1NdgR9S
9ouWMA/5AQ+7/o7VuHiP4tJOxf61/4nCn/viYplEx8XG+BhFSMOhCTimDseE5TUX
sbU9Muvu/h0joxPeqLYTYV9ia5ZODyEYA1E3ZMwwh4O59mOzFfkwK6ELuf59bexl
6a+4M571cj7pi1/sqFI2zrZuffDZHfLeSNneXZOYhXskfWvcNGapIvh1DylYXkX3
J/7MKheDl1Z3pqQa7T0rXZGVDpNdkTFgfGU3/zeDEJ6TxXIwPn9yiF3MfSIySqW9
voUqWIl7xPdWHDphu1z8DXXEtrVM2goSpBZuFdWr31QSmaInEMPhy2Ot3OjHXiaG
ml6t0lJArj1BQlYH81fkg7YNonewmU1NVmMoeBZoLl20bFVSyouCsEMxRdubyQgr
SanRmk92sW9uWPXqSIWj0mkLK1mLWvuriRMK4SDv5rUfpBQCwBE1OLDxQaz07YpM
7Dzv0sZ2OVFf14eAgYIsCKRvLHGQYgRmxW+/vvRt2btYOzTKg6GgSGW7GllAC4cw
NIDdUqohvj+ToGh+lLfnQGcw7FgpFm+1SS6hhC5NBtHKQzCHB6GwimwvjnBw8J6X
P/geTr0fMTQSbFXGUly9rCiIKdYcI+uWo5XZHzo7uSeceLyS4KO1EFJAHds1ZD+k
8ECfracFu9qXHxXfnO7E+Oi71CayyD7ubaFSb5DQFdE5tF5ljlI=
=hr2p
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--
