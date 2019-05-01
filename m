Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CA701F453
	for <e@80x24.org>; Wed,  1 May 2019 23:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfEAXpT (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 19:45:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35804 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbfEAXpT (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 May 2019 19:45:19 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7433960443;
        Wed,  1 May 2019 23:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556754317;
        bh=d/tMP/YZnKQIkbhCBFN2ZwKbRyRNix7bGA32uJUmTpM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Gj89h5xIr/2KPL5qqb3rhFkK9y7rCONvb4b9kx9ebUMd2Hr7xaQQrdU7B5zjjpb5n
         22V4RpACpT39gFRxqyG3hpB48sXrzRhLAguLszGUTSnp2rGsRJgpcxHYq8Z0kd4ddm
         Dob1Ds4GUAGBbs7X3AX5GysU6/9WaQCQozWf2pp6QO3DMvWo0bXkOchZ4ThdLNFDA1
         i1mn8rtsH13QTZr7x3HzwRrqe7lpo3GcPYp0V4xt4T9l1tRw9zdRx06zblxEcxqMVF
         wbY8s96RUaM4w9mgnBZCuL9iTm6jBNHOcfgy+QzML8naHx2qqVyKX/oG9LdNYPU4pc
         mdb4lX4zXOH85cXMtdrjlnfsLiy27kPNkdd7oGMDoxGkBqQu0c0GKuB2RgERlLKcL8
         c+jbTMYoZOFq9clukhbqw02vkEJy4PWHsgshh8peB/VvoNFmhsD8g/9BJtFRS8ptZy
         H03XNM+ll2X18nG3tx+nalTyMQKB0eaEghtgdZVxuX6AE50HqHo
Date:   Wed, 1 May 2019 23:45:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     phillip.wood@dunelm.org.uk
Cc:     John Lin <johnlinp@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] status: add an empty line when there is no hint
Message-ID: <20190501234512.GD202237@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        phillip.wood@dunelm.org.uk, John Lin <johnlinp@gmail.com>,
        git@vger.kernel.org
References: <20190430060210.79610-1-johnlinp@gmail.com>
 <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2019 at 12:15:37PM +0100, Phillip Wood wrote:
> Hi John
>=20
> On 30/04/2019 07:02, John Lin wrote:
> > When typing "git status", there is an empty line between
> > the "Changes not staged for commit:" block and the list
> > of changed files.
>=20
> I'm a bit confused by this as you change a status test below by inserting
> these blank lines into the expected output, implying they are not there n=
ow.
> I think maybe the blank line is only shown when status prints advice.
>=20
> > However, when typing "git commit" with
> > no files added, there are no empty lines between them.
>=20
> I have to say looking at the changes to the output I prefer the original,
> the lists are nicely indented so there is no need for a blank line to
> separate the header from the list and having the header immediately before
> the list means the blank line at the end of the block makes the extent of
> the block clear. It also saves screen space which is useful for small lap=
top
> screens. I can see why one might want a blank line to separate the advice
> and list of changes (though even there the indention of the list and advi=
ce
> is different) but for a one line header I think it is better to start the
> list on the next line.

I actually was going to submit an equivalent patch eventually. The
inconsistency between status and commit is bothersome to me and I think
that adding the whitespace improves readability.

I'd love to see this picked up.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzKL4gACgkQv1NdgR9S
9ovMxg/9Fr4v0vDay88/kS8ywf+nY/0uvzGlWULV2rvXnOfORuq4gKdCMIHT35Yu
PovmfFyPtlwPSlX8/dqipPDTJPN39R/MoGVgY5DnhEGmn9NIYiT0WO5lhfFYoqSF
Ilf45r5q5YBpHFy5IBBp3dEJudJnmYR+/EvDlan+xmWuT/cGFpzytzFjlUkOshsQ
G6v2rcmTP6dnhp2s3AKq9ERkgTvUA1knW0jm+x2SqTmFOE0RTgafbd6ytdCPnvSc
cEmIFb3L/52GM/yPTi3ENs9ipPWtACiD2bNMUhyH+J//0qOV2EDt3Ug6WnNXt5/z
ycMFV0u7mxUN3ZrbAaeMcAcxyiILSNdiq+N8Tj7rNQuDhuFsRfjr7NQfVzbc8ghd
qy1lNT4yOTBzhY5jqb8AflS+CtwscwOnqgBUmrdUA1XiTfo2Lp+LLe/xfu8aSbZG
cjegdydSYxqyrqwyfWWcNn+aDSvIRsd3IM8WKkTrol7PMqnAnaJUWAxB5iusjMeK
ZzyMpeByf8zLm/HaMqpN34l/4HfSRZSaq4jTPJsTAv6NMZpiosgbmXSnmRPn64c5
PFHlvBqNmgYxcJz0crcG3pT6JOgAjqs4f7zzpmNagF6sl++rgKPCSGWOtUaSHDPw
01NTlz/DXDvh6APMWkpwHHlOglpJNPCniyAGOnHrk94RKpI2qs8=
=7fWd
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
