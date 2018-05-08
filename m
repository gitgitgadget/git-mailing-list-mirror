Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0969200B9
	for <e@80x24.org>; Tue,  8 May 2018 01:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbeEHBOA (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 21:14:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42048 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753422AbeEHBN7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 May 2018 21:13:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 39BDC60444;
        Tue,  8 May 2018 01:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525742038;
        bh=AIFEMmFM712KCWPvDhTjEQjPb+P3zu9kaRtaxpnz6K8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=MNnHG7l3S42gkuMyUCJuPtNC68grdSTelJFfBHbdtq9OMJB/diIoQBua0W1DLCxFG
         /ySyReSU092eFMuKjbPvaz9gnKBjvt4rDvEUx7ScpNEY8kyPdc3/BYhQOeGjvqH7Ck
         7ZO9X5G6iaPcO+7/iidg4zxe++je1hsfgMI8D7eVz7lnvTJ3pce/iZGsS8DiBo9m6B
         RViet9qkG6kWW5hjs8AwU7oMTAS6nO3DQUXEFZl2+XrJZ8W+1bnDtZBly/sQijxiSd
         u+nYtl39L7PgEuTCopOfAVQhyIpG5KWP/ChhUprTRNRw9LV4elk9tfcNrHbpbXN83M
         kwwgtzkgBToTMFp/rT6p99rfpsuJPkg617LRCJ2AauQKHAcmzgySKLN7ZGynjeCsMO
         w6+TC+n4fZaZqE8RoCANmOzAllxrAPBlkKR0MkFpxNzGv+mmBBQLevgCJKExUmieif
         zY6Ln5r+e5cnzqtr0bkxXraVgRftUlGb5XCPBJmEtumDGDW+vax
Date:   Tue, 8 May 2018 01:13:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation: render revisions correctly under
 Asciidoctor
Message-ID: <20180508011352.GM953644@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20180504015202.GP13217@genre.crustytoothpaste.net>
 <20180506204226.955739-1-sandals@crustytoothpaste.net>
 <20180506204226.955739-2-sandals@crustytoothpaste.net>
 <CAN0heSrth+ZheEsHuVdyUv9fcnP07O=YvK6y+=rmaGqZf7X3_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4OpS+d6oOtUQaRm1"
Content-Disposition: inline
In-Reply-To: <CAN0heSrth+ZheEsHuVdyUv9fcnP07O=YvK6y+=rmaGqZf7X3_w@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4OpS+d6oOtUQaRm1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 06:11:43AM +0200, Martin =C3=85gren wrote:
> On 6 May 2018 at 22:42, brian m. carlson <sandals@crustytoothpaste.net> w=
rote:
> > When creating a literal block from an indented block without any sort of
> > delimiters, Asciidoctor strips off all leading whitespace, resulting in
> > a misrendered chart.  Use an explicit literal block to indicate to
> > Asciidoctor that we want to keep the leading whitespace.
>=20
> Excellent. These two patches fix my original problem and seem like the
> obviously correct approach (in hindsight ;-) ). I wonder if the diagrams
> earlier in the file should be tackled also. Right now, one has a huge
> number of dots instead of the four you added; the other has none. They
> do render fine though, so that'd only be about consistency in the
> original .txt-file.

Yeah, the number of dots has to be at least four, but can be any
matching number.

Since this patch fixes the present issue, I'd like to leave it as it is
and run through a cleanup series a bit later that catches all the
literal indented blocks and marks them explicitly to avoid this issue in
the future.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--4OpS+d6oOtUQaRm1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrw+c8ACgkQv1NdgR9S
9otelg/8DJjnnCmQ5VmRjWBOgLEhZgKqe5NeVpNy8nShLI+7jHGxMWZNAn7DOONi
dfXPTQodi2PEyZWQzkjoLa4/N6Z8H+SIeabksApw6I+Kt0VeoUuJKNfSRZSGspFB
ou8Opq8uu6mZ8yItuesY+NeEjLX3snemrRbCW7NlIjs+EzH579dMBb4WnxDIvU1a
QIOLLu4HCaghclNrv2MyJyGiaJ8S+1UcD4A/yjyyFPsGGIFATVYcr8ISKtU+a2vd
W7K2wSXOT3+WgRKtp05pXMkrQ/5TKLwlaVpNhnHSZjMR4plEjIKBF85KVaE1/yRI
nKhwKVxdITlppfkeSsIvwkLEfjXdATqAjRtIc25SPl+hWWXGWlwrcHKewTIEsrzc
ado8afpEKnFRg8r51aGguwA25Vi6bfCQsAm9WcJ7SkiemzaN2b7NiYZ4tofLUPt+
/EmirSGD/4ASOBAZ0fbI0zOZHspihsKXvhBSHgCPfS6gXuoXI34gy2kvyzQ//bqm
e/Y/ovT1LwuLD3goCrP6L5tccFKltjvv5qrj8VYrl2IOyaEwm1tv0GU0zIs1ruhA
+HyG0vDaLxoG5PXGyr2JwAqF325P12U7sb1CDuVCbME1KGq60fdUdFj914PIm7Ff
6FC22q/MJ43Yo0I/HkMsqu24huhWB/4Calgk9LplMbzGDphQOFA=
=oBzR
-----END PGP SIGNATURE-----

--4OpS+d6oOtUQaRm1--
