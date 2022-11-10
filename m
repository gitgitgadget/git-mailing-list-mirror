Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87553C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 22:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiKJWsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 17:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiKJWsx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 17:48:53 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FEB4AF27
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 14:48:52 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 1FD2C5B0ED;
        Thu, 10 Nov 2022 22:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1668120532;
        bh=I74kU19ft84TEsbGaa6X1cKeXnK5NPJKwkt7WeTLt1g=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=x2+5KEcMIJ/rhJrdkrgtb6WETENZ4KDi1xZc+fhhCS+4aE1HHrNkwp8ExdaauGiSa
         FMY52xfbrOZdKj8V0ziMzUz3OKNEdJOcgvlASF2hbaYoaTuNRQgE/de8ezfFfPH3S/
         rJChKwxyGJIJprJxKJkZoJdmFD1AIWUs1hK0whP6yK+EtFlSO07rcO2+I7AZmQTqlJ
         U6ZTHPK7i8LRsQW4gNiTGRvzw8edxA0k+PLbbeVvJdO7Y+gMl1cBGHh4MrGRrYnPto
         W4Jw/dQ3ssFLJJZ55NmggetMzkJyZXZSSIFdjtfAruo3gzXCd9X7i3tIamoYuDlIMJ
         OmuyUU3t2xGKjtBpMhW2GTS39HGLTeKWcEw3a9p5A57Ob7KFoVhNp/IeifvqfFb13D
         kcp4tnEHxoKXlShAsAn1a9bAqLCbknWuUx25NmzBB8klRwxPQusMWuSliO89JvrsqH
         0IEA/8KbdwDiylPB2G67ZGdQUSBN4rWyCNJEsxvLx5ukGoZHKyv
Date:   Thu, 10 Nov 2022 22:48:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/3] chainlint: sidestep impoverished macOS "terminfo"
Message-ID: <Y21/0Kxd2gY2eMBE@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
 <b85b28e5a6beea97c149f0b9de6ba8d0a4a7c1f9.1668013114.git.gitgitgadget@gmail.com>
 <Y2xkpJj4jLqfsggL@tapette.crustytoothpaste.net>
 <CAPig+cTL4x45E2a0RbpO2ntPo08K8hQ2wxcXm=QesqtYqxpvaw@mail.gmail.com>
 <Y215ZKz2iZWJCYo3@tapette.crustytoothpaste.net>
 <CAPig+cRcw8qxAMTZz-CpM23zPn+VpPJ7qQTtFrbMRmgbiyhymQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e3F/awFSd7akYV2m"
Content-Disposition: inline
In-Reply-To: <CAPig+cRcw8qxAMTZz-CpM23zPn+VpPJ7qQTtFrbMRmgbiyhymQ@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--e3F/awFSd7akYV2m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-11-10 at 22:36:14, Eric Sunshine wrote:
> On Thu, Nov 10, 2022 at 5:21 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On 2022-11-10 at 03:37:16, Eric Sunshine wrote:
> > > I notice that the iTerm2 FAQ also recommends "xterm-new" on macOS, and
> > > that one lacks "dim", as well on my machine. So, it seems that it
> > > should be special-cased too.
> > >
> > > Taking all the above into account, perhaps this regex?
> > >
> > >     /xterm|xterm-.*color|xterm-new|nsterm/
> >
> > Maybe this, then?
> >
> > /(xterm|nsterm)(-(256color|direct))?|xterm-new/
> >
> > That matches the three special variants of each one here plus xterm-new.
>=20
> I was thinking of targeting xterm-16color too, not just
> xterm-256color, just to cover bases a bit better.

Sure, that seems like a good idea.  I know that was popular for a time,
although I feel like it's maybe less popular today with more colour
options.

> I also don't mind manually spelling out the regex:
>=20
>     /xterm|xterm-\d+color|xterm-new|xterm-direct|nsterm|nsterm-\d+color|n=
sterm-direct/
>=20
> for simplicity's sake; sure it's verbose, but it's also dead-easy for
> people to understand and extend in the future if necessary.

Simplicity is nice.  I think that seems like a good pattern.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--e3F/awFSd7akYV2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY21/0AAKCRB8DEliiIei
gQikAQDbOFFXXIoPPSKsHFJjYOR9yG14eNjoNHQy2dwQcuVLVQEAr0uPLylolcxo
MDC3ngJTfz5OKn7G0NTZ7wnZettStQc=
=Xg2m
-----END PGP SIGNATURE-----

--e3F/awFSd7akYV2m--
