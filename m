Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C381F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 01:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbeGKBpo (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 21:45:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55712 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732332AbeGKBpn (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Jul 2018 21:45:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1B0C66047B;
        Wed, 11 Jul 2018 01:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531273432;
        bh=eA4E3/RYtxNgM5r9LgL+WGKKlGMXyOn/J1HqkxuMDIM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EW53YhVw1mVZ+RvBRRq51iY4+IPm/ZpoyK+xfhHXDQfsyXPJpBWHoipcF1lwRlFda
         y9+yH6UMhdIaJDkb20ACdG6br2aH7Nncsso3qRVJyS+JlBHZ0JwY+5ykPyrWd4yR9S
         BcK4dFmR8EZ+DoFZBqDh4Yjz9gpsCjq1VcmMIMQIH8PC4G/GajL2EWJmG315Z7DMgu
         380gLCl4xSanfCMI89vQhkRKMjc2ejKF/HUtGDw3KGpUEsrKt3cfTMUjoKO+T7XiwV
         uZ8R0o6SLFOKSnwkf9xDTlPU0xFvyt09OT1B8k5HOSFy6cncvT0Rio30hZz2SecI6m
         ZmnCGx9r43evcn6YMSgEJL2yNQDkqbaEIyQZYZDZg9mHBRk5Ldi6LUR5+ydFy57LFb
         HcAmp/wxZX/hzvGenkXvOgnuk21TM1Wi/1CCNbnDVtgjaw+GHoQjdsNSbiioAE5lwY
         9+59NTw17bQgYdM79WYmIobm3cdpGmcB1Zr21sh+BqQE73wsxLX
Date:   Wed, 11 Jul 2018 01:43:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/17] commit: increase commit message buffer size
Message-ID: <20180711014346.GA888464@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
 <20180708233638.520172-8-sandals@crustytoothpaste.net>
 <4eb44f33-ac9c-7ce2-0e53-ec6fcb4560fd@gmail.com>
 <xmqqva9oe20y.fsf@gitster-ct.c.googlers.com>
 <20180709233952.GB535220@genre.crustytoothpaste.net>
 <02c0682a-8cc9-be49-b646-00cbdb5783f3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <02c0682a-8cc9-be49-b646-00cbdb5783f3@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2018 at 02:08:28PM -0400, Ben Peart wrote:
>=20
>=20
> On 7/9/2018 7:39 PM, brian m. carlson wrote:
> > On Mon, Jul 09, 2018 at 10:45:33AM -0700, Junio C Hamano wrote:
> > > As Brandon alludes to downthread, we probably should use strbuf for
> > > things like this these days, so a preliminary clean-up to do so is
> > > probably a welcome change to sneak in and rebase this series on top
> > > of.
> >=20
> > Sure, I agree that would be a better change, and I'm happy to reroll
> > with that.
> >=20
>=20
> I've put together a patch to update log_ref_write_fd() to use strbuf and
> will submit it shortly.

Excellent.  I'll drop this patch in that case.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltFYNIACgkQv1NdgR9S
9oucCg/9F6t5ONFezRW2kGlc99fFFwtQODCToCyb82e4hrX8B23SS7ixfbbbslF1
9mKHQUQOXHE8Miu01JmI3leQz14A6no+Ar+GniADUD+YEQ/4fxdFx8WN1daY3WYq
iuqgAPeLcNwpwBhogdAHxA3SWgRoKAF17EG5NOt5M4SXB51uLa7n+zLqduUDx/8z
jKRxRdMwd1YVo8VHImOnimkfxktj6G4r5PGJ3dCmH8LEARohjS1YAcfrGIArM/jW
jPim7pT4YJ8p26v7YuStheJWzOLtbuGAnI60gpNFeThwir1hvi199X5JNl03Vjpt
rgcsX1NTNibuGSz6NPfthARmq/o+sKNRdzY5ELnpzaknG+AdpesBPfDJ5SzQfeMl
WKSF9utb6sSeBREpp27xTErbbHsbFmcXs2P2Rmawzy9wW/6maG712tX+Ovgvgbss
1nJwdoPbme6uqrFckk1GP0RLEN39XtQIlmruhKTfk/g0pCRuWc8IJiE7XSJwyN2Q
qj4afPwguwik6SZXc7Bwe6RjDVFJP8rdjj8pFxeT7qC9rcLGRRnFU+h7lyhLmBnd
Mdu8irOUpo7D3nowzh7mcZT+eg44SImQiDKduuPR9b0g1/DCfEWRSUnZVDq0/+mV
fJaExcp5A1oKgh+qP/dZcd34pZxA3cRi5MUG4nxH7K23jBgRsK0=
=7foG
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
