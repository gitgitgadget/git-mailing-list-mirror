Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5960C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 21:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJTVPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 17:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJTVPX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 17:15:23 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33503102DD7
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 14:15:20 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 037A65A1FB;
        Thu, 20 Oct 2022 21:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1666300519;
        bh=+19Xhxrri3bm56EEcDxHbGeiIofeBvzUs/wHsCb34Qc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=O/t1mfFHRHI2K5hoGM5ddjZnw0KbXe5GXOfisAQN5NhQBD3qXsBPojdiDQjU8Dt3X
         DUIs+I/CoVS3m1fWIB2Dtp4tlBJGmpq9u8963MwAPn6L/HzYrzATJPfXJtR6xVQ8jR
         uYv5NOrlTX+crpSI8OywFVzjmNMgaMtryHhLgZ+Bn29bRmpoFu1ht47EQ2rCwdVGIA
         s2BT5myjc/LCBiFHJmDqxHVKKmjdLgjHbicvUAUhPTKKncthyykck9YT+Cfda6F5f7
         +4jratC9xX4SyezGtFxTmVExfFWD0Pf4OEHhopGp8iky2pxx3fKMC4apUTa8JYreo3
         hvFob+58AIoL87dtBDP7uGHHR0p//S4m+pKyzqXcJ+0QSPspsuiaoBOs+9OdjnWsMZ
         4kMu1O2dyUscXGLdYgCMBGfpl4xC9wIVBwjEERdn4+t23ame63DUJIJlhKGUShbFjx
         CtE9/iVx1hQl/ugc9rajg8nkAuAfxvO39kVQoeCC08HB6ZYG9ek
Date:   Thu, 20 Oct 2022 21:15:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 3/4] Makefile: really use and document
 sha1collisiondetection by default
Message-ID: <Y1G6ZEQbTBS1zqdL@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
 <patch-v2-3.4-78ef8636c57-20221019T010222Z-avarab@gmail.com>
 <CAPig+cS8jvUn9bR=1ywWgCC3gPosgycdcdbm+aASo59mXz6rfw@mail.gmail.com>
 <xmqqo7u7srp4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xfsPz9CJPwDI1Svk"
Content-Disposition: inline
In-Reply-To: <xmqqo7u7srp4.fsf@gitster.g>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xfsPz9CJPwDI1Svk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-19 at 16:28:55, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>=20
> >> diff --git a/Makefile b/Makefile
> >> +ifdef DC_SHA1
> >> +$(error the DC_SHA1 flag is no longer used, and has become the defaul=
t. Adjust your build scripts accordingly)
> >> +endif
> >
> > bikeshedding: Do we really need to penalize (abuse) people merely for
> > asking us to do what we're already doing anyhow?
>=20
> A valid question.
>=20
> I can understand and very much appreciate [1/4] as a very focused
> fix to the problem.  Very small part of this step, namely, make the
> DC_SHA1 the default everywhere, is also very much welcome.
>=20
> Everything else I see in these patches are extra "while we are at
> it" that should not exist.  These "while at it" changes tend to
> somehow implement more subjective choices that will cause more
> discussion and take more review resources.  Not all "white at it"
> may be more subjective, but at least in this series, they appear
> to be.

I will definitely say that we should be using SHA-1-DC by default
everywhere and I'm fine with that change.  I don't think we should fail
if someone sets the former knob, since I don't recall us doing that
elsewhere.  It also seems bad to bother folks if we're already doing
what they asked for (and what we want them to do anyway).

I don't have a strong attachment to the remainder of the series and
agree that maybe a different series would be a better location for those
patches.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--xfsPz9CJPwDI1Svk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY1G6ZAAKCRB8DEliiIei
gZc0AP9aHXNDN4zjsgw0dPQ1BZc9ksVe+MSn/cMXxnaDolqGKQD+NObF6J9GGJKW
D3Irn8ekgGg4Jk5GD2hl+xYsiL1JWwA=
=fclX
-----END PGP SIGNATURE-----

--xfsPz9CJPwDI1Svk--
