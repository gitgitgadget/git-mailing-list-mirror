Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1E7C3B1BF
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 21:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24CC2072C
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 21:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Obyfa3Y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBPVQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 16:16:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34354 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgBPVQJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Feb 2020 16:16:09 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6DFAA6048E;
        Sun, 16 Feb 2020 21:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581887768;
        bh=UGHbDV20dYoYV+e8AKgOEx8kpEqsibqJs9JvbGWQryc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Obyfa3Y6sZZQ+GqGluSZGkrqYx1EoxCS72N/qgAvbFmgSkw8zOaYy5gmb9aES5KKq
         hXRSO37EStPemxeu+mI7P5umeP6tuWUI2aXOJRT7hZNtgU4J2F+JK/siClNIxinRGE
         4F63EGlYcetr3pUsd2SvLwCpC/RiynRtCp2xXyccOmuzdeVYleSNCPu4Tcm9jXQoH+
         EjYqetMt+8M8s6w5eznkVC+nJsFYuZW4ov4acZNv1EHrP09c68RJ1Nfeh8ABvQPQrf
         chBEubjs+SK6nw7fYnG8+M1MCd1WGSbVq05OhjifT9Ulqaeqyub3wgvFdkXSCahi8f
         P6De/VtDQzxQizRw+1ZRzcSy8dHVn6YNj66P+cvcANOBmDPNvBnlp6yI0ZWFtx3/+b
         3xXHqJKMjvQLVHyRjLxQi/Ob8wYc2rpnhsompupJznzs0TQN6wbd3Dsjcar0r3hGLl
         +TvH8eCdb3NcBZTq6QSZFAbXpvG4z/AaUuRPjhLAY+PxArr85Fa
Date:   Sun, 16 Feb 2020 21:16:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     lyle.ziegelmiller@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: ! [remote rejected] master -> master (unpacker error)
Message-ID: <20200216211604.GE6134@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        lyle.ziegelmiller@gmail.com, git@vger.kernel.org
References: <000001d5e4e3$91ffb0a0$b5ff11e0$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Content-Disposition: inline
In-Reply-To: <000001d5e4e3$91ffb0a0$b5ff11e0$@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-16 at 16:10:12, lyle.ziegelmiller@gmail.com wrote:
> Hi
>=20
> Any updates on this error I emailed a while back?
>=20
> lylez@LJZ-DELLPC ~/python
> $ git push
> Enumerating objects: 5, done.
> Counting objects: 100% (5/5), done.
> Delta compression using up to 4 threads
> Compressing objects: 100% (2/2), done.
> Writing objects: 100% (3/3), 279 bytes | 23.00 KiB/s, done.
> Total 3 (delta 1), reused 0 (delta 0)
> remote: fatal: not a git repository: '.'

This error is telling you that Git doesn't think the remote location is
a Git repository.  It could be because it really isn't one, or it could
be that the permissions are wrong.

It could also be that the repository is mostly there but very slightly
corrupt and therefore can't be detected as one.  For example, it could
be missing its HEAD reference.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5JsRQACgkQv1NdgR9S
9ouP+hAAxQdRGhHBJjSdGiJxigCrTvkDIx91WWDJLGrfic1WJKUNZHFvxqbdaoM1
YNkfonIvpXiazQpXYpJWfcN3aeskt87zDUnY8RZ41NeWK6Fi4tDm6XgLNN1M7g/H
VyzRWlgEfgrVRIE6xeVzqIkImX8M2+VnZuOO+rSIY08jU4GMyj44VzjTLUVOtslL
BLXMtTDfSKdsBWquplh3+P63ZOoU3UdtQAT8ogcrjGqygcRrH3O5p4w1h1iqqv4L
zv38GFYWVgjQFXAJ7xUix+M/dpqBYZ1FNUPTRB21Md6eBx0eovlJm+TIr4ylFKBw
xA0lh4Y7qi0g5VexQke4zmdwPMMVXE0hVVl57TeJJzu+nTqS6LYHlwGRkdZDxnTG
Cvzd7EtgKaDM7sWFZVjjl+8PdpPbNsE/vAhNEQKppyK8U017/0GnbDvZ4epzIfyU
ZNzV7iTWA24p/SAxhgpjmUAjPtuSD0mzTX3gSfQH60VavAMKiAvJDztzAxqtMqq9
Lve41SyJTiTiQcfr4SrKKpJmuV/Alc1BGKzq240u5PIbqoYWk5B+nirceHY4sbUH
zJ1uQHY8l3ImEbg/umh3EXTaOXsn6hT5bPkvB73CYwomOnD40x2xfd+4tcofOMtv
NC42ClQt3NQUiZ3Th2wvDHsgI+bjYVEE3tdTN2QPz3QaofZbXfY=
=4M5/
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
