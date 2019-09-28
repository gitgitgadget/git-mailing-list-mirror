Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C941F463
	for <e@80x24.org>; Sat, 28 Sep 2019 23:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfI1Xfr (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 19:35:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59002 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728666AbfI1Xfq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Sep 2019 19:35:46 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 194E662052;
        Sat, 28 Sep 2019 23:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1569713745;
        bh=bat+LIahQVC1WbBs10kYefcjOJlGDl0YaMVEOY+RXvA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iaiD1JBVrQ305RnPN64P7Tn09C37bR7ufcyH+TOArD8bWfcT8145oqVTTTv8LiOw/
         xP+8jf+quKqAZCCZhRADuO+aWNl4YdPm0tiQgOcvXXrZNiiVdj51CKQBv8/2VNBNV6
         js3ubh2KsP1hLVbS9RcIsjCK6U6iRpXECEz6KfOvJwCrrw6aIkuBgxZsyQwVRENlep
         tE4sPQIPe5nahPqBm6Z5wFof8UZiLTGgWqARq41QkRh7sQwSC/2UDNihJeSOkqF9PN
         nGmMzZ/VDVz9pQchm9DIAfSgZQOdp+5FayiP5T2TWW/c7Te9yZSVVaNM2L3EFhr54b
         pghKZNK/L3mo0QFEhsiX9LQKNT0kNrJh6Nck1QhLUTlNT7vtRalZqKvOjt8KLsqiXF
         VgjUgieNPsod5JBkpjR5KPkvOkP5Htfg33Oxp8g877gJ8hYh64xxuCNAW18EOI44kd
         anFp2arSg9j+sawOFVFBEBhdnNFKeEaypAdJgwag7ORbHSS1AoZ
Date:   Sat, 28 Sep 2019 23:35:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2019, #01; Sat, 7)
Message-ID: <20190928233540.vsxhrik2vvgu4ahz@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
 <20190909234715.GO11334@genre.crustytoothpaste.net>
 <xmqq36ggj8ve.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="phcxtyk76qc4l3o4"
Content-Disposition: inline
In-Reply-To: <xmqq36ggj8ve.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-rc5-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--phcxtyk76qc4l3o4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-28 at 23:31:33, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > On 2019-09-07 at 17:26:53, Junio C Hamano wrote:
> >> * bc/object-id-part17 (2019-08-19) 26 commits
> >> ...
> >>  - builtin/replace: make hash size independent
> >>=20
> >>  Preparation for SHA-256 upgrade continues.
> >>=20
> >>  Looked mostly OK, with a possible update.
> >>  cf. <20190820223606.GJ365197@genre.crustytoothpaste.net>
> >
> > Just to update on the status of this, I wasn't planning on a reroll,
> > although I'm happy to do so if folks have feedback.  Opinions for or
> > against the current state are welcome.
>=20
> I've already said that this looked mostly OK, and I think you and
> RR=C3=A9ne's "maybe adopt the use of oid_to_hex()s without using our own
> buffer" can come after the dust settles, so let's move this forward
> as-is.

That sounds like a fine way forward.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--phcxtyk76qc4l3o4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2P7kwACgkQv1NdgR9S
9ovD6BAAiwdGn+8bzZ+jxfbNti7qLFCPD2R49SBKbGMABF+0Y/PZCLNdn2BJUWOh
Tvv3mQ5I6rhwlQ5PyH+ABe5HiSMSWl6DZ8KaSXbji+mEFXiPPpJ5ZS3CD8x1cufb
9H9jXouHdfKJikA1EZN/hveSBzz1Ttu/WXFDM11B0tY1mpQpgL0P+/stcoBTDmse
NZvNeo0DRl4DrBT83qBu1YfnBw0vmXV9ejEFoevOt6Rl4X4f8cQSrpsr/YtIrudS
/Yp2uh210s2Mmsh1b1CuRMWydpk/+K96XgJXun6kxS4QXqCqtRZqeVhSsxVYbYUV
pZgRP1AboBVqM4GL8BF6a3sqf3myxnML3AGa2lGuIjzOJGa7YKZer9rMTQFCT8Eg
iw0VERzmtner9u+QNgbAlyI7Agzbikjzpf5rTCw1SQ/Xt7B2sy8+m0jiFIaKQIrE
QN698V5NoS8r5f1IMWMXu9ZskURDZGMtl5NDdcgzlEHsc9iZYh5Jgw2Qe7FXTwdG
7vF+im72D4xBHpbgvWa3rgiEMNQJo4DB0H+FOo3iIyYho7xjAa6Km0Qe/krS0Aaw
hk6ZIpBKeHZldDFvRBX1bp9oIlwZToYFURKBuHNJq2MXfDO1JR1v/+e7MzNRAFEF
abrECqxGPh0jCZw0M7Q1rojvKbuAMdnRAKwZKvhD/8rrnAKia0s=
=JsMo
-----END PGP SIGNATURE-----

--phcxtyk76qc4l3o4--
