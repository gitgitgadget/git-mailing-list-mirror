Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA9E1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 02:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfBEClE (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 21:41:04 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33732 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbfBEClE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Feb 2019 21:41:04 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c489:9935:372d:73bb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 690F2603C6;
        Tue,  5 Feb 2019 02:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549334460;
        bh=l0NG+IniuNDgucAb323Zl3wdPJqMScMij11S8Gba62U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=WLiYWhkadCtDwTK7UOWLzshH0wfon/+OxOsgd7/UVJo48sHwE4xFY7lvroolV2WbZ
         iD56r8AhBWDcCwrxhyBrxE+n6hIR3eGWhqFo2+dVwnEwRjs3lATxfQ8gKzhja20GpK
         CxVBHEvNPVuDH7aETzzP8Uo0gCPVUUSphSJK4olqmGiNXc9VPJeN5PSF2/K871uciS
         w5T/K5UXo7ZbwoDUyCi+wCN/0ec5rzE20YwdquQKiEoxpm+ascX41oGE0mfVJYxiCo
         J1QjTUaUldVDqyDzO7I9HvAD2tOyciYBuB5dN3H5B1/1cPj+uVPdNgoAmwJ8vAb/Q7
         yfwN3gOFUom9GUiJDOKi3CsslTP09vImZEpKQFWWgFhZczenQ644Bp0OlIPoGXGp5v
         1hqDCO0E8WvEHJUkRNn2j34xp6bhV+pHmiyD2AEwoXiR+a4U5hUyHcPallL6zRx6zY
         B1w8NOF9xr98f8Wy/KhkNCrNw6F1h+SmqDh72udB7xsIE/Gmhzf
Date:   Tue, 5 Feb 2019 02:40:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Larry Martell <larry.martell@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: hook to get info on commit, and include that in a file that is
 part of the commit
Message-ID: <20190205024055.GD527887@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Larry Martell <larry.martell@gmail.com>, git@vger.kernel.org
References: <CACwCsY5xU0pUaPZDJMqWNB0dz7DjTx3_b2Lvrft0NjA6cnPvcg@mail.gmail.com>
 <20190205015506.GB527887@genre.crustytoothpaste.net>
 <CACwCsY4fwr6=2S5CHe5bH7=7Hukq9np+eT1VO+kUDyBtMLKPcA@mail.gmail.com>
 <20190205021513.GC527887@genre.crustytoothpaste.net>
 <CACwCsY7o=ArM4T4n7umun-R9Dip5NmmOEL7Ygd9zEQdCyQa4Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline
In-Reply-To: <CACwCsY7o=ArM4T4n7umun-R9Dip5NmmOEL7Ygd9zEQdCyQa4Og@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 09:18:14PM -0500, Larry Martell wrote:
> On Mon, Feb 4, 2019 at 9:15 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > If you want to generate a file, you can certainly do that in the
> > post-commit hook or using a Makefile target. You just can't check it
> > into the repo. Lots of projects do this as part of their build process.
> >
> > An example of what you could do is "git log --pretty=3D'tformat:%H%n%B'=
 HEAD".
> > That will print the commit hash and commit message to standard output
> > for each commit. If you want just one commit, you can use "-1".
>=20
> Yeah, but I want it part of the repo so it makes it to the target system.

You can create an additional commit for each commit that you put in with
the additional file, or you can serialize it as a note for the commit
(using git notes), which can then be pushed to the remote server by
pushing refs/notes/commits.

I'm not aware of any other way to do what you want.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxY97cACgkQv1NdgR9S
9ovfMxAAgX7DR7Njt1N63eQt6aH13sef1vsLhY46G/mcN5EbZkHa6C5DQU66xENE
/Ndv79JQv5HDZ9E0RmEtH5fru2c6+n+MHXlNEL1k0Ah7QQorw00OTreJWsCOQUMD
5LyhfkqWu7DOsWNWqLUSD9cv9AX0iZR7LaDC+vGs1vr/Uyl2OYx68EqyYiqJQBVf
/ckfTcCWsTS2RmKA0pnzMu3UXeSIyLgYdZVE9cQyPQ4CYmBmOdxpWFO+Xh2urOyo
9+MUOT0O9ZB8HB3K3V29pizlNVOwjUY+zAWlU77ff3z3oIRP+RoT0K8SzMa+qcva
OhztBkp4FtoyOsJQ/AGrUYGEZRnEWc9u81gi7ASbe0YaoUpkf14cbxdZEwOeeU7x
u7g6H44vTRkF+LP4/IBfJ9OO+XXe1XkLQr67PCqTmbQKSHl7MgCNDiznDuF6uzBD
ABvONtFMwm9EuULzvqRr71t8vEsTuIsziE5ROMBanxosa8+q0auLNDbkpmFU+lqY
8BUW4wPHk85uEDMCjvnlCd7MZdaxgPAg7qxP8iwXTz/EucEXguaoeZVUWQxlvPeA
GUwh6JGy2WcKmppsHlemBMEkBXrEZpGU4kr/5kcmHyrDAOjcYS86cka7TqV+Ic0R
5HBvF8bNQdheSG9EW1bXnfLVePou4ePx755yQnvGg2KGQKJEUDU=
=jxEn
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
