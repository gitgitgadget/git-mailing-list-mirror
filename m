Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDFA620954
	for <e@80x24.org>; Wed, 29 Nov 2017 02:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752540AbdK2CGZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 21:06:25 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56238 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752143AbdK2CGX (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2017 21:06:23 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E030C6046D;
        Wed, 29 Nov 2017 02:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1511921182;
        bh=m4pSoxviaPywhOLurPn73Zyp/SK/U0rRQ1wZM1Q8NIY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Zuvo6q0SpqboAopjs9ANMjj8RXIccAU9xHj2cx/n534UiRUSWSOC8Owh8I4AtM3ff
         YOM/7875Nof6d0fgC9TdNb10V0Lh5cnqduv9OQx2kb0OeAe3nDUJyMC4Z+vig2bw7/
         Is/PPjSLLsQtXYZhIXyhCkaRb+2TmONWEu8LeZB8d36q7zMxsz+pyLl30KHuLZ5ptl
         fxySY4ewkwjzchjBVFWxUMgcA3lATdGCeO2In+cGb+uMpzVdWJK0Li9OfTcSfvPw8g
         KlOvQrSvtuK181qV4QTPYrkU2Odkw124W5ZhmF7+NL1dqiEtF8jv0YJaJA3V82fkrm
         x2unPyZQoJJrxQlNftmrl9+CBpVW2k1mZr4Wcx9Mbf/hIEPWeZDOvRZbNEO8Zi/c+M
         U6M/LqCHgIfUevAk5E/nYyF54FzwnvEHDdXSsGZpD5UvolpTL3Uml8RQF5U+ybex2J
         r+5rFxh5TYiroCJIKXBzIroU6ZpprdyQ1NsUKsT7A5VQD0iJ9NV
Date:   Wed, 29 Nov 2017 02:06:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3] launch_editor(): indicate that Git waits for user
 input
Message-ID: <20171129020616.GC598034@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        sunshine@sunshineco.com, kaartic.sivaraam@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
References: <20171127134716.69471-1-lars.schneider@autodesk.com>
 <20171127200932.GA558049@genre.crustytoothpaste.net>
 <20171127230520.GA29636@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline
In-Reply-To: <20171127230520.GA29636@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2017 at 06:05:20PM -0500, Jeff King wrote:
> On Mon, Nov 27, 2017 at 08:09:32PM +0000, brian m. carlson wrote:
>=20
> > > Show a message in the original terminal and get rid of it when the
> > > editor returns.
> > [...]
> >=20
> > Sorry for coming to the topic so late, but it occurred to me that we
> > might want to conditionalize this on an advice.* flag.  I expect there
> > are some people who will never want to see this, and letting them turn
> > it off would be good.
>=20
> I am torn between saying "yes please, I would absolutely set such an
> option myself" and "if we need advice.*, that is a good sign that the
> feature is mis-designed".

I myself would also set such an option.  More importantly, I think there
are other developers who would complain about such a message, and I'd
like to give them an easy way to turn it off.

Note that I am not altogether opposed to advice.*, since I personally
find it helpful in certain cases as an aide-m=C3=A9moire of what state my
branch is in.

> Let me elaborate a bit on the latter.
>=20
> My gut feeling is that this is absolutely the wrong place to put a
> message like this. We don't know enough about what the editor is doing,
> so we have to take pains to avoid a crufty message in the terminal,
> including:
>=20
>   - playing ANSI-term trickery to erase the message
>=20
>   - hard-coding (!) emacsclient as a special case

I agree that the editor is the right place to put this, but I also
understand that the people most likely to be helped by this are the
least likely to write such scripting.  I think this is especially so
because in my experience newer, less advanced users are more likely than
not to use graphical editors.

Git is an extraordinarily powerful piece of software, but it's also hard
for people to use (judging by my Twitter feed), so if we can make it
less painful for new users, I'm okay with an advice.* setting.

I'm slightly negative on hard-coding emacsclient, since I'm sure someone
will come up with another editor that does the same thing, and then we'd
have to update it.

> If the anti-cruft techniques I mentioned above work well in practice,
> then we get to have our cake and eat it, too. If they don't, then I'm
> not sure if the tradeoff is worth it.

I have a feeling that this may not work properly in editors that don't
support the concept of xterm alternate screens (such as the Linux
console) where the editor window is left on the screen, but it may be
that it works fine and I've just misunderstood how it's supposed to
work.  It may also be that we don't care about such cases, as any cruft
would have already scrolled off the screen.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.2 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAloeFhgACgkQv1NdgR9S
9ovZ3xAAmK8VRQr6gRwHT6TguLjtQU6nvetICa5qYipy0T/fFE66Q2ldudDO+1Wx
DJsAp3ylu71DtsRVJh1RAittWUU26BYU6Y/IxA9g0nKrb9jvXy2U2h5EwCr0Eg7U
xzCZZ/fuR9IDc113HUQ778Pi/eMsvHcf3B0AH2Z8h5Bzet2RxlQ4iWh6mcOFSiMH
8MpSwgcNVpaXcHP6mmy461nhoOEMK18GYl5PT8dQe2uIKMJm5dK3zxTbPjjA9cYO
3Y2bJO0CJ2dvbr6q3asqw4yT58utDu7K2u/WnsW9HNSJ3MjqcBa1sYqBLogGkc5P
CAuxQl6Gh1ugaoZVcyeqI2+CFWeWqMThU1YkitgDJmlcGbJnzOP9tjD3iwjPLDTC
0iqUXlNEUC5pUchGvEUNlo3cuxGrPaHcsg0tTGvb+dHkc4OJHMX4EYllILNaY3uw
YGGa3Xq2T6pN+lfjXf7rBkCu/xon1O1daP+GQ6ZpRHnJOSiNVOXMpEs41l3nii67
3Fj0UzW8Q4J0hRaFsu05DAg8f4TTHKKD74STmTSA2h4AssoVndDGYgUweK4Z9F1s
/9t62e6spMblY2WzfcC8LC42CJqIu7zmsrq8O1u8hI/7LgvORqdthbHWkrjDkqoP
ISJfaWi6VzRpq4FbKYmQRsF28qoJ7x3TDOeTrZyS3jfs8JuC6ok=
=fy6/
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
