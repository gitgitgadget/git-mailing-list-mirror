Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B987EC433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 22:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiKJWVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 17:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiKJWV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 17:21:29 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E3F18B26
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 14:21:28 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C59385A1AC;
        Thu, 10 Nov 2022 22:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1668118887;
        bh=YeHwkUO5STHYhh1d1YOruO+nunk1lEuboMC6rdJSwLk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oicTqpOf9bBu1Dh+SZHweJSP72bUuV6W166R70i5g1ktUD5VOmvZFNQN4yu9S/0FG
         9Gm54E8JY9czSqvXnw5Ak6ldO5w05rc8PuQE12dfjHu71QrTgGlBYauEOVIibv8TJS
         FjuBAA8JokKSLSSB5pfsgFF63X4cOLm+/Ge5lDAToocgfE9ndC87LC585XxX3AK9jL
         zM8cheQ7+JmBdgyCPO4gnrCKxHK3VKNi6Vpf5H42DB5AXz2HO4jm052CbJgg/IBbKY
         /X6lu0P7BLBNmJd88v1BH8xM2eVdDvTJFbdzVAdY20AuQl48Lg7S/3FW5f/ONSgjCi
         X+pOIqF3F+nuU40mOErEGUxg1YJonkRdK9S92z/6iGpukSsOhAfR3m/CDtXuo2Ttzo
         xIbHzHJJOqjsPkgvBvd72rCWd9uXoNN7hkKkBr4N8IuAc1Eb+i8Ze2XubxcgtqrRFm
         aFkjEux7SxTb47WhnOsM+sXkvRmOJ0VbNCkj4HNehSG+2Cy/Owd
Date:   Thu, 10 Nov 2022 22:21:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/3] chainlint: sidestep impoverished macOS "terminfo"
Message-ID: <Y215ZKz2iZWJCYo3@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
 <b85b28e5a6beea97c149f0b9de6ba8d0a4a7c1f9.1668013114.git.gitgitgadget@gmail.com>
 <Y2xkpJj4jLqfsggL@tapette.crustytoothpaste.net>
 <CAPig+cTL4x45E2a0RbpO2ntPo08K8hQ2wxcXm=QesqtYqxpvaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RwwU80vfU2mryJU+"
Content-Disposition: inline
In-Reply-To: <CAPig+cTL4x45E2a0RbpO2ntPo08K8hQ2wxcXm=QesqtYqxpvaw@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RwwU80vfU2mryJU+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-11-10 at 03:37:16, Eric Sunshine wrote:
> Hmm, on my machine "nsterm" also lacks the "dim" capability. I see
> that Neovim docs recommend "nsterm" with Terminal.app, so perhaps that
> ought to be handled specially here, as well. Do you think any
> variations other than base "nsterm" are worth special-casing?

I'd say we should do nsterm, nsterm-256color, and nsterm-direct.

> I don't mind tightening which terminal types are handled specially.
> "xterm-direct" doesn't exist on my old macOS. Is it present on newer
> macOS? If so, does it require special-casing (i.e. does it lack
> "dim")? If we don't special-case "xterm-direct", it will fall back to
> using `tput` interrogation, which should be fine as long as the
> "xterm-direct" terminfo entry is accurate.

It's present in newer ncurses, so I expect it will make its way to macOS
eventually.  I don't know whether Apple's version of it will contain
the `dim` capability, but on Debian all three xterm variants do.

It sounds like Apple is specifically limiting their capabilities for
some reason when upstream ncurses doesn't.  I can't say why that is, but
perhaps it's for compatibility.  Debian had to do that for one release
with screen* when Screen added support for some new feature but tmux had
not.

> I notice that the iTerm2 FAQ also recommends "xterm-new" on macOS, and
> that one lacks "dim", as well on my machine. So, it seems that it
> should be special-cased too.
>=20
> Taking all the above into account, perhaps this regex?
>=20
>     /xterm|xterm-.*color|xterm-new|nsterm/

Maybe this, then?

/(xterm|nsterm)(-(256color|direct))?|xterm-new/

That matches the three special variants of each one here plus xterm-new.

> Of course, the other option is to follow Git's own lead by not
> worrying about TERM and `tput` and just assume everyone understands
> ANSI color codes. I'm too old-school to feel entirely comfortable with
> that approach, but I would entertain it if others feel it is safe
> enough.

Sure.  I would also prefer to avoid that.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--RwwU80vfU2mryJU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY215YwAKCRB8DEliiIei
ga9fAP4trtgStuhljTUD8EU7Y1djZDR1zz24HVahZsapv35xGwD/UV3DdiJXlJ/D
mCFfTy7812st8AUIxpBPk+PxwcvovAw=
=mQVe
-----END PGP SIGNATURE-----

--RwwU80vfU2mryJU+--
