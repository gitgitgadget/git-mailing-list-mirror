Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6761C433EF
	for <git@archiver.kernel.org>; Sun,  3 Jul 2022 07:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiGCHI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jul 2022 03:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiGCHI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jul 2022 03:08:26 -0400
Received: from cressida.uberspace.de (cressida.uberspace.de [185.26.156.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F495593
        for <git@vger.kernel.org>; Sun,  3 Jul 2022 00:08:22 -0700 (PDT)
Received: (qmail 19737 invoked by uid 989); 3 Jul 2022 07:08:20 -0000
Authentication-Results: cressida.uberspace.de;
        auth=pass (plain)
Date:   Sun, 03 Jul 2022 09:08:01 +0200
From:   Matthias Beyer <mail@beyermatthias.de>
Subject: Re: cherry-pick with --no-rerere-autoupdate does still rerere?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <1656746869.11nc2qu6dn.astroid@takeshi.none>
        <xmqqwncv49qm.fsf@gitster.g>
In-Reply-To: <xmqqwncv49qm.fsf@gitster.g>
MIME-Version: 1.0
User-Agent: astroid/0.16.0 (https://github.com/astroidmail/astroid)
Message-Id: <1656831907.rjf3s99jhj.astroid@takeshi.none>
Content-Type: multipart/signed; protocol="application/pgp-signature";
        micalg=pgp-sha256; boundary="=-z/PxO2DXjl0b7sw1KUyC"
X-Rspamd-Bar: -
X-Rspamd-Report: MIME_GOOD(-0.2) SIGNED_PGP(-2) SUBJECT_ENDS_QUESTION(1) BAYES_HAM(-0.445336)
X-Rspamd-Score: -1.645336
Received: from unknown (HELO unkown) (::1)
        by cressida.uberspace.de (Haraka/2.8.28) with ESMTPSA; Sun, 03 Jul 2022 09:08:19 +0200
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-z/PxO2DXjl0b7sw1KUyC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Excerpts from Junio C Hamano's message of Juli 2, 2022 9:04 pm:
> Matthias Beyer <mail@beyermatthias.de> writes:
>=20
>> I just experienced a `git cherry-pick <commit> --no-rerere-autoupdate` w=
here the
>> conflict still got automatically resolved from rerere.
>=20
> If I am not mistaken, this is totally expected.  You told the
> command "use rerere but do not blindly accept the replayed
> resolution into the index".

Ah! After over 10 years of using git, I still missed that ("update the inde=
x" in
the manpage). I was thinking about "cherry pick this, but don't use rerere =
at
all".

Thanks for clearing up my confusion!
Matthias


--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Kind regards,
Matthias Beyer

--=-z/PxO2DXjl0b7sw1KUyC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEUJGUus1GMTrRclzcEKWX9Kitz80FAmLBQFIACgkQEKWX9Kit
z825MA//ejKOv+rFzG0mun9QoIX96TnwY5YezsPBkFt3Cc8OoUKHRbXbVn8UOuws
mA9oPnI7N9HPVos5iH4JfLNhy9MJ2XaEE9ZJcXQV+WxJl2/xJ9YihgoVknQjo8yT
VuZHdwVmMeT2+QfOT3rchaWndDCz4NmQxfzHVJcHe6SXLDfDXhI53KpeDN3Q3eQW
j9/lDoZBu5/vSlWaMvWSU5o2NxH8eK6Lm8hR7KbQKwaSWZ6tpOS/+46D3AZUDip8
G1xbdsQhxoE94Nd6iEDKf7Nxjo/EpzO+zMFBwRZESHK/lxeq4zgvKnojraynk1aC
DVuXzV3qqrbl3hhQ2QeDjuUUnCCH8UdOoV2djD42l84XCqtFMzJ+yhcZKA8GN/wV
GxLQcRUhtiv1bm+0bXQA75MYXcVpCBhPUggcDMBkmpBNPB3v4UXT3K7CySm9bCMv
NpEWwRzJa6qqld+D0K93TjGXoBjKRNDWo6wBu6TR/LHaxQK2RmePPo+2ELLtA149
7ybgJVasm1EoXq0dl3JVTWHOGJIQhJgbbpuuNOTTSoA5b2OZFyQaJZUJiGvWoY+G
FPoGfNlmzcGjkF9pxBwbIcKhOfUUlZyTlEnzEJ/YrdBacnwRKthtqqL9JbAQEnyu
lxcccUFD1CT3b9x+ydrFRfQUGF7qggcXbMLxnEP8pE+7SmnUfHk=
=UiVY
-----END PGP SIGNATURE-----

--=-z/PxO2DXjl0b7sw1KUyC--
