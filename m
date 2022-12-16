Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD74C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 00:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiLPAnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 19:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLPAnD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 19:43:03 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C9432BAE
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 16:43:02 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id CC6E75A0EA;
        Fri, 16 Dec 2022 00:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1671151380;
        bh=FSRlAu85D3Sj984RQ7k3zsS4E+uHySzyCL003ugMd/I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rpe26W7+FucYvjcMKR64Fan2faFgC+3+yhlsoPiLDn8fEKGnIdjxdDXT8gy6RBShA
         wUxJOtF9wbK/tMLqmuJdFH7666df/vXSy6PiZbZu5JqW0sOiTeQLEHykMgFBsmo5LR
         0hkxOINlE3jdvQgLQeM+T6U7QfGOiNzC+vYcvSE0HbPTV51IXc9d8RHhvOfxNd+Vom
         HS9hSPanVPdF/7hOTvxFWF6/z+7npASU75zEetXBDom7OMGQwX99w53YqYobnxvEpb
         F5WMFvcYNomgbSoqkj7HvMYD/8UM8Prvq0LuwsBZDYKCKteTtpqxbfUWQkCjFgb6A0
         yxi+YZIK+nlSaBFTl3VaHJLpfA0bviTG3fJhhy1mQ6mIUwTK2BTk54PMUAjhTiW8GF
         /0go4ADsf+K5AXJHiYLGo9rqedcdT3ij58WIwlKmTxoE1BagOU8+HL5b/HADLtpeRF
         1VzYPHQwvSro4rfAme6wYSPzpMdgSs5rsUW7QGZxdG6kKBK7r9/
Date:   Fri, 16 Dec 2022 00:42:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jean-Michel MERCIER <jeanmichel.mercier@newsbridge.io>
Cc:     git@vger.kernel.org
Subject: Re: feature-request: silently stops ssh-agent.exe when upgrading
 (windows)
Message-ID: <Y5u/E04V0QWQTDhu@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jean-Michel MERCIER <jeanmichel.mercier@newsbridge.io>,
        git@vger.kernel.org
References: <CAOLx1BgQinzZBkHvvmDrGUedEyQa_7ZVsyVGmWjF4gYhxc3P+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Sxas10j3uBXJ2hfg"
Content-Disposition: inline
In-Reply-To: <CAOLx1BgQinzZBkHvvmDrGUedEyQa_7ZVsyVGmWjF4gYhxc3P+w@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Sxas10j3uBXJ2hfg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-12-15 at 08:38:01, Jean-Michel MERCIER wrote:
> Hello

Hey,

> I've looked in the public-inbox archive without finding any similar reque=
st.
>=20
> I believe it is a bit annoying that upgrading git-scm always generates
> an error when ssh-agent.exe is still running. User than have to open
> the Task Manager, find the task and kill it.
>=20
> Could you consider silently stopping ssh-agent during an upgrade, and
> may be restarting it afterward ?
> Most installer do that or at least offer the user to do it to allow
> seamless upgrading.

The Git project doesn't distribute any binaries at all, and it doesn't
distribute OpenSSH.   It distributes source code for Git, and that's
all.

It sounds like you're using Git for Windows, which does distribute
binaries, both of Git and OpenSSH.  If you have feedback for them,
you'll probably want to use their issue tracker
(https://github.com/git-for-windows/git/issues) and, if it hasn't
already been reported, you can request a change there.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Sxas10j3uBXJ2hfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY5u/EgAKCRB8DEliiIei
gRG7AP9sjzmWGCJBw8c5NxUJnS1Y0GtNTd/7Jeq5ioKcjZ45iAEAvdA6W+ejYcXZ
xfY5IHf7nAzscklNiBTDqW0Kj1I3hQ4=
=b24x
-----END PGP SIGNATURE-----

--Sxas10j3uBXJ2hfg--
