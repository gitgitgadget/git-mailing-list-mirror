Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A95591F405
	for <e@80x24.org>; Thu, 20 Dec 2018 03:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbeLTDqK (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 22:46:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57818 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728061AbeLTDqJ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Dec 2018 22:46:09 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b469:672:eccb:defe])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A786760100;
        Thu, 20 Dec 2018 03:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545277568;
        bh=N5G7ghozgMFOdFrTMm6PVeL3Kyv9Wod+Fg53znc7Sd4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NHEhLEWuSPCPtOOJ66BwTJGoSOFEbes1orZGKh3ZTbN12NY9kTM/2fiEAYeE/XBCQ
         Pc0hL6scjmSvUDg+656zlAHdADxSePi3VWvLc5a0mPzP8A24YTqg070pSv8fTUL3hF
         qfvLsgzfc+1iPfJqJSKUZ1U+bT902BkUnzYT9CBsUSwlDDRj8KfVTnw7JQq2hbld5y
         I4gMQ1rnFlRldCVgBUmHkAmipZ1jTD3qlRhc/blZMltTGSpH1kBDB6LonaVGA6CUIF
         PevfCgces2J7kLerFr0HCg9jxA6WfnGB60it7w/FoBxVOtHHoZsaSslgFuzNvuqtZo
         kb/Vip+j3gnmpnDtFboPy0pE8paSpAiGxIKtDIpOMMnkfO/zJr1au/mQgVwqJnVUVH
         ShKiIQF2rRpfDWF/Pvgv7r15lSv8Zt+shIzgdWFqqbt9wqCDBidY8zS5H98aLx0inv
         iTgk8rO7xTyhkFG5iarf5vmfUvhe0eSJ6Z6RTxlr/iHoQYlQEtd
Date:   Thu, 20 Dec 2018 03:45:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] setup: drop return value from
 `read_repository_format()`
Message-ID: <20181220034555.GC35965@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <20181218072528.3870492-1-martin.agren@gmail.com>
 <20181218072528.3870492-2-martin.agren@gmail.com>
 <20181219152735.GA14802@sigill.intra.peff.net>
 <20181220001752.GA35965@genre.crustytoothpaste.net>
 <20181220025211.GB24002@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <20181220025211.GB24002@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2018 at 09:52:12PM -0500, Jeff King wrote:
> On Thu, Dec 20, 2018 at 12:17:53AM +0000, brian m. carlson wrote:
>=20
> > On Wed, Dec 19, 2018 at 10:27:35AM -0500, Jeff King wrote:
> > > I dunno. This is one of those dark corners of the code where we appear
> > > to do the wrong thing, but nobody seems to have noticed or cared much,
> > > and changing it runs the risk of breaking some obscure cases. I'm not
> > > sure if we should bite the bullet and try to address that, or just ba=
ck
> > > away slowly and pretend we never looked at it. ;)
> >=20
> > I will point out that with the SHA-256 work, reading the config file
> > becomes essential for SHA-256 repositories, because we need to know the
> > object format. Removing the config file leads to things blowing up in a
> > bad way (what specific bad way I don't remember).
> >=20
> > That may influence the direction we want to take in this work, or not.
>=20
> Wouldn't we just treat that the same way we do now? I.e., assume the
> default of sha1, just like we assume repositoryformatversion=3D=3D0?

Yeah, we'll default to SHA-1, but the repository will be broken. HEAD
can't be read. Trying to run git status dies with "fatal: Unknown index
entry format". And so on. We've written data with 64-character object
IDs, which can't be read by Git in SHA-1 mode.

My point is essentially that in an SHA-256 repository, the config file
isn't optional anymore. We probably need to consider that and error out
in more situations (e.g. unreadable file or I/O error) instead of
silently falling back to the defaults, since failing loudly in a visible
way is better than having the user try to figure out why the index is
suddenly "corrupt".
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwbEHMACgkQv1NdgR9S
9os+QhAAy6mBUFDkR9xHrMDOxrlhdo9Lfshi9wmeguZMN1XDo5GLzvwGgzsqMNkc
0i2MUnps99iy6NTw+7SFIWhPRT/5uDugbwYa4UheSIg/QBCnfqzmES/7kUfU7mQt
8/PR/7wKvmmND7G91P1XbPG2qZu1aspe2vFvf8aKVQDAVKoiEYDYQWdEGg9VVual
an6NGvWTwLo6+gvk/q/8cellAr/8bvBrWFzTL30os9dtEEnwhmCyEauOoee/3Vr3
w9ilA4QHluznHkFJdMBPk0fZrWjuCh0ne8fjER94ie9eMEUA6GdR7iOpn/oXQCXZ
mYt5tMCoWugHhh+4jdbvOF4NYzOKW33uXyH0PubfuOAuUAdtwZp+6HHtwevo0Tws
VzuAXgmtB+Tm+1xZSvmBJd0pV0T5Ms3rBPGfOaaMxyR0kHg480BEEe1NbrQCya5Y
MTwNGy8TcEXFKVP525dbQArsjXxzm1ICwDKDFruIEdNQMgxDZHOhP2FZMA3J7Uv4
g8abj0r/9qN/q6D07FzNGT1wGlgVoKtCpfJVTCgMKA6aM1Qbr58HnuzNlaAalccO
cKd0Rn1ff9Ca1o5/75IgysZvkpKOBS+fPDtVFr2zFYoIekLFRSTW0MS51tTILxWr
DWXeXKTAUyOpIkwEfcV+McnMf7qyL/KR4hqPz4PjzOgNZ5XqrSk=
=xpbF
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
