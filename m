Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 458D11F461
	for <e@80x24.org>; Mon,  2 Sep 2019 20:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfIBUMj (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 16:12:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58494 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727204AbfIBUMj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Sep 2019 16:12:39 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6959:e43b:5cf6:a465])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3BC1F60459;
        Mon,  2 Sep 2019 20:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1567455156;
        bh=muyOUxd/+g6SB4TcSqXF09b2eWxZIlMk6u6SDzp3hwU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lGDYvYzd2EPxBv9F9khNZd4NTJf/c28hl5V3V9Fjf9ynIVr0eeQiLvCJr0jEr7QAb
         exmQOa+eRUIBKsJLjehtZNlm2MHRPXOVz5cOGxHH9jug6xctUWJVAG6euWiuCGhGKz
         /Bol7Z0fScNPI/bMtHDCcWkdaN1ZbmjHDSaA2csDYPsem7yoA2Zxw8Ai5VdW6cdVNj
         vaaCt5H7krxss/HJrr28dS7LangdByI67/X0Pf/rsreKkTcX5J574IdjiBpYVy5GLy
         6stQsOyHIQHRG+04ZhvRBRdWlknfCMSuRDu3eEJgPFP5bVdtgzCvBoo+TyQ5lL57/a
         iu8Wf+Q6WHLDCl0OJOyFq91p/FUrFf6u0aBsksSRNNaSgBWsT6EQGj8Bd0liFgdPHy
         ukJ2Nikd9Fg2nTvfe6cY2bW0lawdVq6LRQ31wu/TKhxuJ9AORYXWAPHkOTDBoRFly7
         O4fCcmFkyQFRCntMyQLIhg1zZxzvqOw6NTyfJ8uFFjfe4Vdzj7Y
Date:   Mon, 2 Sep 2019 20:12:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Matt R via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Matt R <mattr94@gmail.com>
Subject: Re: [PATCH 1/1] rebase -r: let `label` generate safer labels
Message-ID: <20190902201230.GG11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Matt R via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Matt R <mattr94@gmail.com>
References: <pull.327.git.gitgitgadget@gmail.com>
 <4a02c38442dd8a4c0381adc8db0dce81c253da09.1567432900.git.gitgitgadget@gmail.com>
 <444f3ec4-abdf-1aa9-e8a8-8b5346b939e8@gmail.com>
 <xmqq5zmav9ej.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iAL9S67WQOXgEPD9"
Content-Disposition: inline
In-Reply-To: <xmqq5zmav9ej.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iAL9S67WQOXgEPD9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-02 at 18:29:56, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>=20
> > Being picking I'll point out that ':' is not a valid in refs
> > either. Looking at
> > https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file I
> > think only " and | are not allowed on NTFS/FAT but are valid in refs
> > (see the man page for git check-ref-format for all the details). So
> > the main limitation is actually what git allows in refs.
>=20
> Yeah, trying to use the contents of the log message without
> sufficient sanitization is looking for trouble.
>=20
> >>   		for (p1 =3D label.buf; *p1; p1++)
> >> -			if (isspace(*p1))
> >> +			if (!(*p1 & 0x80) && !isalnum(*p1))
> >>   				*(char *)p1 =3D '-';

While we're thinking of things that could go wrong, note that it's also
possible for the commit message to contain non-UTF-8 characters (if the
user is using a non-UTF-8 encoding), which will cause sadness on Windows
and macOS.  Non-Mac Unix systems aren't a problem here, but then again,
they aren't the reason for this patch.

> > I'm sightly concerned that this opens the possibility for unexpected
> > effects if two different labels get sanitized to the same string. I
> > suspect it's unlikely to happen in practice but doing something like
> > percent encoding non-alphanumeric characters would avoid the problem
> > entirely.
>=20
> I see there are "lets make sure it is unique by suffixing "-%d" in
> other codepaths; would that help if this piece of code yields a
> label that is not unique?

I was thinking the same thing.  Since we're being much less lenient on
what's allowed (which is fine), we're at increased risk for collision.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--iAL9S67WQOXgEPD9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1td64ACgkQv1NdgR9S
9ou1DQ/8DQhclZ2jTFXa0pUQNvLKDxfBfR7DGNL+qQ7gLIVWvQNQk+zzOmET+1O/
cwoYufnIqK/D4u5fStRjMStT7TRDKe9wB1aqhcI61WV5xuWhZgunrHx68rnM7Vff
7vxs5BTCc2c4xGSabovbfaipggQj4zD2ngA4G76GETYSBBHx2Y8/EvWOVZ2c8nP0
RhnZT8vKDB+wWYli+JhCjEj1n796KWR+6v2d8YOwqrH0vGuujultRaGnf6n5qY5h
QwJ9rthtFRtivqMV2mo2YWYFcMDUpr9Z0DNDSYV2cz3RtEeDwHIZaTMjRKvv+VtJ
MshbBsQdeEO+oU2TwpCkszzDzgoIPnAKS8PxrGv2cLiODWMNhfE1TavuBTq9RaMe
V56gqtXIZZ5S0YN2dOwIyizR2FBx/rbOXr58e0MpiAsBZCeci0BTNWMXPDohCjbO
oufS3K/Tf4WbrMKsj90A6986VVtcJfDRVJSRZ0VqMPqpzvqT6nwk6VKn1qSMBD58
TDvjZORDs1FjcsWyJkBI4etMpSpS+psrNH3nPNykj7XIu8qFgo9ebsSbJKdaUU2t
nZMPDe123SkVSHYUXjcEhXb5/yIfpIinSZF/qck1nlmDpKqEA3PQhYFe7azwyfE9
7gQhGSUuC8i7gQfaH7joUueZDwGCgGcj5d8n3zq3h/V6d564kRs=
=+cdp
-----END PGP SIGNATURE-----

--iAL9S67WQOXgEPD9--
