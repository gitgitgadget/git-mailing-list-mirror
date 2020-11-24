Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488ECC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 01:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F288F20729
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 01:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgKXBIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 20:08:00 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46696 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725952AbgKXBH7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Nov 2020 20:07:59 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 362C760752;
        Tue, 24 Nov 2020 01:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1606180048;
        bh=E9/iqZiRfBy9h59E32bqYmsDsNftO6LQhRikNIQoW4U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0lOTcZE2rti3aeEtusrt+39dQ/gvzTIRSlILEF6aOB+UuaqEcmDipkuoSWJBzhEng
         zCeyzLPzaD7LqQnheH2ZKr5v3KiV8lTcRaj5C9krmJ7RH+8nWLMGjhiiP187uVQzUa
         nLQgcInbODFUdGWXP2sG/S7KDCLR5yI5eYxnx10BvKXs1zkR3JjkKorlU1PRIVNx2T
         KmCv6+MUEJFRmY4Ub7OiApwnS1Vymxoy3k7qcmwx2NoSdIzpCeQNPKlhfAMuS3ZNzd
         iSTtSjxVQpAGK/FSF4i/gRuYPiiA0o75bED/umLGEKNAJjwj9U5HMnMwEQZ+5a6DYg
         srE1Gn32BS/jZRDFlE5aeL7gMNPj0CPpST+rtGtL/U7GlNzMtOjo/OD3vQ7y32kEDH
         BRmukmSepLeq9iglJvTXIoLNqGh8FY7DRoOUjlZVTt4zR95svsPuEvMjxX9Z65rNRP
         /yXB81ppPpNYwoYk3ZP4PXwKfi9h79BucRR1Jq8Ocu0OKQP+laJ
Date:   Tue, 24 Nov 2020 01:07:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mktag: don't check SHA-1 object length under SHA-256
Message-ID: <20201124010710.GI389879@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190826014344.16008-11-sandals@crustytoothpaste.net>
 <20201123120111.13567-1-avarab@gmail.com>
 <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7IgncvKP0CVPV/ZZ"
Content-Disposition: inline
In-Reply-To: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7IgncvKP0CVPV/ZZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-23 at 21:34:21, Jeff King wrote:
> This is how fsck_tag() does it. In fact, it seems like we could just
> reuse fsck_tag() here. It wants to pass an oid to report(), but it would
> be OK to use null_oid here; ultimately it just ends up back in our
> callback error_func().

I would very much appreciate getting rid of this custom code.  It was a
pain during the SHA-256 transition, and even with significant effort, it
appears I missed a few parts.  Also, while I'm for casual language, its
use here is going to be a little hard to understand for non-native
speakers.

Moreover, when we start mapping objects to write the SHA-1 values into
the loose object index (which is a series I'm slowly working on), most
of this custom code is going to have to disappear or be coalesced
anyway.  If we can use an existing, more robust function now, so much
the better.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--7IgncvKP0CVPV/ZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX7xcvgAKCRB8DEliiIei
gdjsAQCVCNq0Eh2r6lIPcWngmZY4TPkjHLXWmc3fteZ4dRK0cAEAwrR+6TIMvBSd
xhu3xPNogG/J6GydX1qPyCAohDWmMgI=
=mZFX
-----END PGP SIGNATURE-----

--7IgncvKP0CVPV/ZZ--
