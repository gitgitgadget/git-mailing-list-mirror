Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98D5C32767
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 04:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C80521D7D
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 04:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0AraNsb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgADEIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 23:08:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58350 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgADEIK (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Jan 2020 23:08:10 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 554F260433;
        Sat,  4 Jan 2020 04:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578110889;
        bh=a1h2qCvVAsfGov9mdsvyHYU+nDQasGdg/siIGMQVxPs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0AraNsb87gk2tW3PAhGAu4sbiheXuZRyYXhboMojqiQmFWAGN7ubvQZPXGKe1NeeW
         foqyjgNQLRbpK+wmiuhZq8FSiQFgBLxpJ1q2AbEhJBLZKOFLB/sLbwyFY8zzdzOTiN
         dR73MAqjjK2dXYivKCRglownqcNNUd6d4nt7uXxZW8mhA/iiFZVY5POYl+OWeBgJrW
         W4s0auJKjUq7GBYJCdvbWv7ww8zFcaZVD2l3LF01B3b+eMd+iplrWcBKIwQz0CPL3H
         hbBCxw67aztUKhyhsEYUj1FA07S59hxfWCSfhp79BvQfSNdSyYXmZfsgKAr7S1hHln
         IWd9j/wjKq80EEnI+MbPBByFXJJz6rUKSTPi7dnHzoLj80t/S199reY0kxGv5asF20
         6+GxRJDuH0ktytOPhpEK/s0xJ3gAAOGIPWv1r76XZpcOKlSpt0SqOF9BJSLFpntP4a
         7XYqiBEV9SLsfGkteLmsinhYzRzywYzc06fzFQM6R8BfL+GnJpa
Date:   Sat, 4 Jan 2020 04:08:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Cc:     git@vger.kernel.org
Subject: Re: What the meaning of two commit ID in a merge commit's log
Message-ID: <20200104040804.GD6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, git@vger.kernel.org
References: <56365810.1196c.16f6e224802.Coremail.wuzhouhui14@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline
In-Reply-To: <56365810.1196c.16f6e224802.Coremail.wuzhouhui14@mails.ucas.ac.cn>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-04 at 01:18:58, wuzhouhui wrote:
> Hi,
>=20
> When I use "git log" to display commit log, I see there are
> two commit IDs in a merge commit, e.g.
>=20
>     commit 2187f215ebaac73ddbd814696d7c7fa34f0c3de0
>     Merge: 2d3145f8d280 fbd542971aa1
>     Author: Linus Torvalds <torvalds@linux-foundation.org>
>     Date:   Tue Dec 17 13:27:02 2019 -0800
>=20
>         Merge tag 'for-5.5-rc2-tag' of git://git.kernel.org/pub/scm/linux=
/kernel/git/kdave/linux
>=20
> In the previous example, we can see two commit IDs: 2d3145f8d280 and
> fbd542971aa1. So, what's the meaning of them, precisely.

Non-merge commits have a single parent commit that they're based on
(unless they're a root commit).  Merge commits, since they merge two (or
more) separate lines of development, contain multiple parent commits
(usually, but not always, two).  So the two commit IDs here are the two
parent commits of this merge.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4QD6MACgkQv1NdgR9S
9ovJdQ/+IHtJBJJFaIoxl83F1NrJmevH4dPKO7NSF1Y6hskBKYbpg7MgzoxyilZw
/g1xjEfft+49iYLeQVIEadFeBnwtgq3Jw4dWuE5JNRDsDTMI+TviUiSW6nDcsvEk
uRpWGH0913VbXi8QYARSkWxyIIwwYWa9/AsGLcLjPgYjYD7s1nzwAjIMpj1mVFzy
l/bPkFt3h5jLx+KFAueSnlRUcDOtsPFDtsMmREelbdGnr+KC70AEpnhUm2N6/scc
7+PsFPV21Ny+PQyvqYpcXI+NaQhmWm3iPhhGL95eNQ99Utgptm7X8TYMymsA1/EV
sF6xPQ6hpDWyxTNaoH7FWvWcKpcHPZ0XtnOftNIh4Ez1Z7tGhc2BpY5NT4o+F4X9
pVnCGmsSkedAc4MeZZJzdNtoNGgOBWlkGBcxsxVQWzF8lkFDC5aiTv/vWJEGtL+m
aL+IhPGSQ8rbhlOani6tqtQh+57JnpEL0G0qQisMDNOtyaYBvA2XYZK5YExmhi0t
Gg3kWVXz27B953WTG2ObaFIGkarJR38KRJl4VVYJzU1RIkWhK52k3onTPeTPVn8y
TtgH/e08I08fkhTr0c1CWo5afphGT77unSh4mDY8grJmOuijXozTM/L30cJQPh8Q
NpDwPASxDtSXOt3+8B+ZqKBDsZ7MQHerzSHx5nK1wf4KFzKS0j0=
=uLWV
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--
