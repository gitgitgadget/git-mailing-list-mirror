Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 254731F453
	for <e@80x24.org>; Tue, 23 Apr 2019 23:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfDWXzf (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 19:55:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35580 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726325AbfDWXzf (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Apr 2019 19:55:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BF8BD60FF7;
        Tue, 23 Apr 2019 23:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556063732;
        bh=szsWkj1GcuzkyZljUkv9KwrlcmKbijOvGe2gI3aZfz0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=DGpQBAVRrfWYuHr6A4eNACYoBF7r5O02htAGndhIsRk4jjZ1vOOXpm0VJ96SBqfy+
         dSkp74quAeOfpe7Nm6p0Y27v6wTmVWEwd95NZOCEZxytUJBHVmjtS/It1cvn06Ai5E
         gDQv8B7OXkeFoULnq8i6sALZKTkuGEZGQwZmwNKv8ycIDJ3vryQ84rgH07AVnyzMEJ
         iC2/HquKMnQeVcgjAPpznsaZdK4mUYjYhGt4m+VPTBT9JXp9OMWdwXs3AMQdZtoJuY
         HhQyXBZmaywqExPEGsSYmHGZrZyrL4BFqofYwNNV5uWLGvi0aLoWQsTbPhJWC/EVld
         B0L6PZco2z3ABi6N3siGlFz/B7i/S9fuY+nmTgPvLvpdQ6pIfr3KPAuriFZEM77HdA
         Uo+gPpRidZ82kkCDx5sLURpH6bdDSz3g3vHEu/6TBvcZXofkUjHxaCXBp4uNpg2Lw8
         L9zsjpBXta7nD85zPjWKASft9zbBfmEZtNJk6I+yJzTTcg9D3uH
Date:   Tue, 23 Apr 2019 23:55:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "CHIGOT, CLEMENT" <clement.chigot@atos.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-compat-util: work around for access(X_OK) under root
Message-ID: <20190423235526.GF6316@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "CHIGOT, CLEMENT" <clement.chigot@atos.net>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <AM6PR02MB4950BB0152893633FF95DC99EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
 <xmqq4l6p57x6.fsf@gitster-ct.c.googlers.com>
 <AM6PR02MB495010DED643EC262D116DD0EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O8XZ+2Hy8Kj8wLPZ"
Content-Disposition: inline
In-Reply-To: <AM6PR02MB495010DED643EC262D116DD0EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--O8XZ+2Hy8Kj8wLPZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 11:31:02AM +0000, CHIGOT, CLEMENT wrote:
> From: Junio C Hamano <jch2355@gmail.com> on behalf of Junio C Hamano <git=
ster@pobox.com>
> This patch is needed in order to have hooks working on AIX. When run as r=
oot,
> access on hooks will return true even if a hook can't be executed. Theref=
ore,
> as far as I know, git will try to execute it as is and we'll get this kin=
d of
> error:
> "git commit -m content
>  fatal: cannot exec '.git/hooks/pre-commit': Permission denied"

I think this is the interesting part.

What POSIX says on this is the following:

  If any access permissions are checked, each shall be checked
  individually, as described in XBD File Access Permissions, except that
  where that description refers to execute permission for a process with
  appropriate privileges, an implementation may indicate success for
  X_OK even if execute permission is not granted to any user.

The XBD File Access Permissions text says:

  If a process has appropriate privileges:
    [=E2=80=A6]
    If execute permission is requested, access shall be granted if
    execute permission is granted to at least one user by the file
    permission bits or by an alternate access control mechanism;
    otherwise, access shall be denied.

I believe that's what's occurring here. Your commit message, however,
should contain some text that explains that AIX takes this liberty
provided by POSIX, and why that causes problems for Git (i.e., what
problems the user will see). Ideally, the reader of the commit message
will know the relevant details about this issue from your commit message
without needing to consult the standard itself.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--O8XZ+2Hy8Kj8wLPZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAly/pe4ACgkQv1NdgR9S
9ou+NA/+LNmBmPTcXn9q4znpzUwbCGENvFDwkZeA1lMw27zkLg+/+5EpPafp/gAI
mHOtTo6YxaCr69hnb8XhO1yENR3CCEPLkByEI1Mc0tUiI8SAx08ai0Va44QJJBft
W8WcNglljo1rGJf0vOtqLeR8XuKMbm9FkMadYkyTVZaSXurt4EiCu6vAuvRQb7MO
yyZXTwk4X2JNwyK+w9LacPdLaGt3qN3vgNeaMWZTaZaKi4WUyZSUq0O/zQzA/T4S
2lqdhLm9v7UPuDyXalHA3pvaiAL5dPllJxoUFS5DyhdsxqLU4ioDReFktWMDCAjT
PhO4lFwiCMRLuohw2/jy8CDA85G632TbwJhzVu9xDCEbtrypZOsIc6eFio5lC8MX
+oX1ol8P7Ki+jdgHUQihVrPvJ8oz5DPlfVjmveXfwo89mOUO5gUxgPdkTk58Jc5D
I97erG5GL+GXf0eLsa0B9uM0lxY7AhW9JOt54PdmbD/GIQadtW/XoIBRiVh1tRQb
3vO9XHhHapK5N/kAuLe6HKf4GNhfEd3i7Kia4UI2QSoFQKLjXFb4Z/WPMlYnwgSx
GmmqdiEq5TZw6FkFP03ZVmYPV1dvwg3Mz3gIfbRAFeFeqtqkgPBjca2lbkV3t6Hu
/eR0CoLnyptiEr/U76feNA4AdE2mdxn9r7dK5ANHZXuMZXPebHE=
=qgcA
-----END PGP SIGNATURE-----

--O8XZ+2Hy8Kj8wLPZ--
