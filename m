Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBCAC3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 22:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC872468A
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 22:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="EyKbs9G6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgB1WkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 17:40:17 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43514 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbgB1WkR (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Feb 2020 17:40:17 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 48C5860797;
        Fri, 28 Feb 2020 22:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582929615;
        bh=56AL9j39UVYnujIxgQp8DpHFM47kAw51bhUuuIrGUY8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EyKbs9G6K5Mh9vBTlaq5srJugrlJLpxtN0nwn3ifc/bT7iGqW3yJvmE55arjMq1EA
         r6keixf0fjPyMdC70j+2qXXVu1Hxmbc6Kxs9wrOtNEod4+5b1SNt+CogkPyGuk1eLW
         iPZz90v8BLPnBcJhfY7YXi4C7YmvsZA9J+l0T/oMYzVNXkvlmlcRWMtihoEMWMBzGK
         n08e0pVwboFyHaALeCyzgSMvB3fx8q0YvyvD/dkGeU3sTFYpGAMfxGxqn7OASIcXV7
         00Sw82MDyrDB5mvTBc/jktuDiuhfyAUc+WSYJDzKSA39co4dWo59yQWfu7ewXRayif
         qVP7gyNUdHXXKAQsaLM5DabU5jKy4MtugNDJC8g+LPOBm3D27AeJyFW6YHsTleZhcT
         cqGYUDdJ6MxVTDNFS8De7l8OqYvc++HdqaNWehTdHuBjYATfidREmWoTVunPgV7lT8
         qkPm+ai4UxKyOi1yTYxpo8zs1+QzC6GhbpmTTOfxX8C3KWPDV0+
Date:   Fri, 28 Feb 2020 22:40:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     On Luk <on.luk@webssup.com>
Cc:     git@vger.kernel.org
Subject: Re: Dropbox do not sync particular files after using git push
Message-ID: <20200228224011.GB9290@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        On Luk <on.luk@webssup.com>, git@vger.kernel.org
References: <EC87F304-78E6-40C4-840C-45F118902079@webssup.com>
 <16B44F67-E85E-4D87-A8EC-18ED1B35DB41@webssup.com>
 <9A165840-280C-43C4-B92B-3349E07AC0B1@webssup.com>
 <C8290530-F064-47CD-8FA0-F42CFBF777D9@webssup.com>
 <A07B2628-8AEB-4520-8C60-16BE607B3022@webssup.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <A07B2628-8AEB-4520-8C60-16BE607B3022@webssup.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-24 at 03:59:25, On Luk wrote:
> Hi Sir/Madam,
>=20
> I tried to report this issue to dropbox technical team, but they replied =
that the issue was not caused by Dropbox, so I try to report to your team a=
s a bug report below:
>=20
> Everytime I used git to push commit to my remote repo located in my dropb=
ox, some files stuck in syncing status and can=E2=80=99t be able to sync to=
 dropbox. To get those files be synced, I need to do one of the follow step=
s everytime by manually:
>=20
> 1.	Drag and drop back the file to dropbox using the finder.
> OR
> 2.	Click Pause and resume syncing in dropbox desktop manager.
> OR
> 3.	Restart Dropbox.
>=20
> To make it clear, I prepared a screen recording to show the issue that I =
am facing.
>=20
> www.dropbox.com/s/ivn7qytk0u67v6n/Screen%20Recording%202020-01-03%20at%20=
12.21.21%20PM.mov?dl=3D0
>=20
> This issue only appear after I switch to use my new computer running as m=
acOS 10.15, everything works fine in my old computer running as macOS 10.13=
=2E6.

In general, using Dropbox or other file syncing programs that sync file
by file is a bad idea.  The state of a Git repository cannot be
represented on a file-by-file basis, and these file syncing programs
cannot replicate the POSIX semantics required for data integrity.  This
is just a limitation of those tools and how they work.

If you must sync your Git repository using Dropbox, it would be better
to have a post-receive hook in your destination repository that packages
the repository using git bundle and stores that in the Dropbox folder to
sync from.

Whether Dropbox does or does not sync files is definitely a Dropbox
issue, and not a Git issue.  Git knows nothing about Dropbox and does
not interact with it in any meaningful way.

> The information in this electronic mail ("e-mail") message is for
> the use of the named recipient(s) only and may be confidential.=C2=A0The
> information may be protected by privilege, work product immunity or other
> applicable law. If you are not the intended=C2=A0recipient(s), the retent=
ion,
> dissemination, distribution or copying of this e-mail message is strictly
> prohibited. If you receive this=C2=A0e-mail message in error, please noti=
fy me
> immediately by replying to the message and thereafter, delete all copies =
on
> your=C2=A0system and destroy any hard copies.=C2=A0

In general, you should not send notices like this to mailing lists,
since they make no sense there, and use a different email address to
send to mailing lists if your job requires these kinds of notices.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXlmWygAKCRB8DEliiIei
gd4gAQC7iZsNUSG3YAc7WGCmBAzh0YJ/AZ5skF0QQYlqBAUryQEAuq8y3jPd3e2j
NxBW7y7aJY0RrDOtk2lPjyM2rwpJfQU=
=CP7l
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
