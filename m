Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7562C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 10:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346711AbiAGKXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 05:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346709AbiAGKXH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 05:23:07 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C92FC061212
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 02:23:07 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9C57C5B236;
        Fri,  7 Jan 2022 10:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1641550986;
        bh=G0IrBYDlppRJRcsMS7ga639I6HH5kBdFJFHCfdlgD1o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=opWMlGNoa+OOd9AcDV4hFR8FhPI6R9mEWdkgU3VSB+Wwtb9IhJN+r8an1nYmmeeIq
         iJ8K33FIi2sJQEnQh7o6PLEWuPxusDestn/orAza4iFxXZJ62AijebJfBgW2CDkfuZ
         HLjRizqWDT63kaOfltVAt+AN7GM8ybKJna1plIFiCBqT63+ssTLpXS8Vd9NbsVc6pe
         5BBqjyuwQxBPf7K5cwsjdTg0dZluuUhki3QlocObCuIPDHHQmMxqHDVEPv0+nE1PzV
         w/YtIjr7WYwGkZybiy/Jq9tMAKgtzSydiI5aKpsnEgGH18lQgooIEb70xMzW3KZAsp
         0K71YMTRGC2HtTuxKkbXZf5goZZ0RF1ey9GCkag0sPbeq0SH4rAkBWr5kcLYVhhReP
         6RzizfBpDOnrrGt1Ya1vUeFqGV8zgCccPe/HcGqH1SJSjQC6972PB2obfMcjW4hstB
         0/eY19GUnytR2LXiMhWd8gjVapvuIJ3bqCcDE9KzNrarmvI9faY
Date:   Fri, 7 Jan 2022 10:23:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     theking2@king.ma
Cc:     git@vger.kernel.org
Subject: Re: Offer Windows Terminal as option for terminal emulation
Message-ID: <YdgUiNL653Ib8iul@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        theking2@king.ma, git@vger.kernel.org
References: <d45a1072c8fec95896cf82b5620f7219@king.ma>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ntc0bNtILWIkJp/G"
Content-Disposition: inline
In-Reply-To: <d45a1072c8fec95896cf82b5620f7219@king.ma>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ntc0bNtILWIkJp/G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-07 at 08:12:08, theking2@king.ma wrote:
> Since Windows 11 an acceptable terminal program comes with the OS as
> replacement for cmd.exe. There is no need to install yet another terminal
> emulator MinTTY

Hey,

It looks like you probably wanted to write to the Git for Windows
project, and I'd recommend their issue tracker at
https://github.com/git-for-windows/git/issues.  As a non-Windows user, I
don't know why this decision has been made and whether there were any
reasons for doing it, but it's a part of Git for Windows and not Git
proper.

I do know that in the past, Windows Terminal has had some serious
compliance bugs: it claimed to be xterm-256color (instead of the correct
ms-terminal) and failed to implement enough features that it broke Vim
in many cases, which obviously wouldn't be suitable.

However, I think that's been fixed, and it may function correctly now
that it's supportable as an option, but you'd have to ask the Git for
Windows project why they don't have that option.  They may be delighted
to off an option to have less code.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Ntc0bNtILWIkJp/G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYdgUhwAKCRB8DEliiIei
gZjVAQDV8ikYRJH/hXB9htK6iYsvFcZxX7Ua/Ggw64vQIiA0pQEAzM9pO7ABraHk
zWIj0nH69TIP0jKKtY558jqU8cmaAws=
=U7Q3
-----END PGP SIGNATURE-----

--Ntc0bNtILWIkJp/G--
