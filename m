Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F111F45C
	for <e@80x24.org>; Mon, 12 Aug 2019 22:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfHLWk2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 18:40:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57498 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726568AbfHLWk2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Aug 2019 18:40:28 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D2F0060737;
        Mon, 12 Aug 2019 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565649626;
        bh=sykKDiR8pYNvlfsYvxVy6Br852DbDy1gNnARo8vxt6w=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ASOJtZapxb4cyvVUogLhaikA+VymyuRMkbhqNvo0hXUp6xXDUbnZFMDrAwhxFv/Zg
         s5IElcViG86cM/n2ZSddup3WWhxNaAmaR1RkWjNr7vmf4up+88H5ck0e3Z6GFxWrer
         XQOn97qgk0PnZJLnlPchEfLwXFTAoCXnMWoA9uvu2BfMPO9sLM27zIgu4dVtuu+L06
         n5L5OUhnrlhLVH3fCJmaUdIVeSiYOSTxka5F9guXtkPStDjW7WvhevsNeaaJKWg0SK
         PCGgi0vZWnCgH/D/WYuIO0+JtdHuAztjrsG5Nlg2D6L/mrN8o22sf2GoPpfbfv+WWo
         XppYVSbNoKmlK01+vIfv6aIDUS4Gx74v9g4Rm8DU3NJSVXO29ywbFXEyG26vVyMfZ0
         jmAaZGgwznHPcxSqhbRyNODLPY+wpEYDSEG+rihdw0w9Ru/n/Kw2RJHYPhvTyf4qOz
         42QeU9tbI5Buvj8k1coe5iK5Y6VJqGoVZ92lGmWu7kqSznAKXqp
Date:   Mon, 12 Aug 2019 22:40:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] path: add a function to check for path suffix
Message-ID: <20190812224021.GA229582@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190811174748.33552-1-sandals@crustytoothpaste.net>
 <20190811174748.33552-2-sandals@crustytoothpaste.net>
 <xmqq1rxrcjfp.fsf@gitster-ct.c.googlers.com>
 <20190812011054.GA9180@genre.crustytoothpaste.net>
 <xmqq7e7iba7j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <xmqq7e7iba7j.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.2.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-12 at 16:49:20, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > On 2019-08-12 at 00:32:26, Junio C Hamano wrote:
> >> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >> > +static ssize_t stripped_path_suffix_offset(const char *path, const =
char *suffix)
> >>=20
> >> Perhaps
> >>=20
> >>     static ssize_t last_path_component_offset(const char *path, const =
char *name)
> >>=20
> >> I am tempted to also call the second parameter to this function
> >> "basename", as we know from the proposed log message that you wish
> >> "basename" were usable for this purpose, but basename itself has
> >> another confusing factor (i.e. "are we stripping ".exe" extension?",
> >> to which the answer is no in the context of these functions).
> >>=20
> >> If we agree with the "last path component" phrasing, has_path_suffix()
> >> would become something like:
> >>=20
> >>     int last_path_component_equals(const char *path, const char *name);
> >
> > Except this is not necessarily the last path component. It could match
> > one or more path components with the way the function is written.
>=20
> That's fair.  Is the feature that allows the function called
> ends_with_component*S* like Szeder suggests designed one, i.e. with
> an explicit purpose of supporting callers that pass "foo/bar" as the
> "suffix" to it, or is it merely that the implementation happens to
> work that way, even though the expected use that is supported is to
> pass only one level component but the implementation did not even
> bother asserting that the "suffix" does not have a slash in it?

Well, I split it out from a function that handles multiple path
components, mostly so that I could leverage existing work (and not have
to worry about getting it wrong). It wasn't explicitly intended that it
support multiple components, since I don't require that for my
implementation, but I could see future users taking advantage of that.

I think "ends_with_path_components" might be the way forward, unless
you think something else would be better.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1R6tUACgkQv1NdgR9S
9ouZSBAApKn407dM8q0buxhWHdfQFIOd1IgD/CGmoQ7E0Nd0Mk9cM+q6D+rY500N
28Te+0RM10t+DD3R9jL0cPpAlWUpkqw793RBFJNcWVNN1ADL7mRTy0TW2C2BnSv9
bEqUdjuLJKDSr93DHNTslIMM2OPJIFcspGpK7S9cRlG7ZQ7W9iMH2/IvapqK3yBW
5h8AApflQ9IVMtFq9EcjAslH4mj4Fy5Ysy0k5AkArf42BxYaIvkOOIUppWHYlToR
2BJm+X20RK1L5qd+sX6THTCDp4dEVxmA40vJtdAvafAUtAaXkPrpy+GsdN4yebRv
u1H9R7SW1WeH5yq+Mjio/RjBOx2D5fP84fpcHfKF9b+YfT7gPpBTFvXbWuDX+D4G
ivjErVhSP0wsyGPsxqkE9mngAiEpvf9nOPqKDUIlD81YakJl/ofKefL9bMCxjiWH
gScxGBK4yy0DKo7i8L67/i/diqGudZG6T0RXCk2/Q8LR05U4NaT29r0tGYbGJa/I
ym33NqLVbKQd6qdJOvnEDBq4qIosjUoVaztejKt5gughXyc27WCOzRNuhU/zFSAj
GJzfCuuBTOtk7xuC4+qPV8bD4RN6bs9K4Xpqrl/MfatleC28mz+JQJ8N9YclUqcI
IBaDV/+B22GFybSzpmsCuktErgYZoMSQ0B1VS1rbQiK7bAXWObo=
=/BvR
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
