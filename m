Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E54C433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 18:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACBE322515
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 18:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbhAJSdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 13:33:47 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50292 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726748AbhAJSdr (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jan 2021 13:33:47 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7E18660781;
        Sun, 10 Jan 2021 18:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610303585;
        bh=EjIpP7GwKc3TQfEUVPyuFaKzlIYYORlIGR1WsEJhGo4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=flHd5YuJtkoieSsUlDZv4syAoiKqwnUE9mIUZa5fXp0vs6tdGjNy36OnCyppXcoog
         biMb1OlOQhRuTDM0hV9om9bY/k5ikN0cPBiXh86uNNIQz4qbqde9ydLTAM+tFpnsHC
         BDCulPKJpg4wCUj8gsNyEC9Z6Ed6k/1xLD8gLQ8rxEup5HP4/s+6J2kUnHU6eBxZu+
         NOHUcl1mpP1NkRiDxXE7VDX7jMGZa4DgRC0VaiZiT9UOLQBaqkMOoHFgNH2+uK9lmj
         0HQjWTkYEHj8qstOGtepqPPamdtffu/ZAPxG1vl7BA6V8xXkDGB4gpTREQQL1CFk/t
         OhQj3YXUBZ2YmcHb5xGstka2yJMxkRYSyVeub4BMcz8xBhI4HRdHbLraQvep+4dT7H
         I4x3vUGApYNGlzAIIrVT2YR9xG4sWeA+SBJkwCicDdjZS8GalK+rGhDLFmfwrcwUVC
         qeLM2G5JvDMc5Y0n9MqFskDgQeQQbuHs+n6yBC+uoqy1Rfb4vjc
Date:   Sun, 10 Jan 2021 18:32:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Alan Mackenzie <acm@muc.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] docs: add description of status output table
Message-ID: <X/tIWgzANq7e71X7@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alan Mackenzie <acm@muc.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <X/oAhdZlLwcFRCrR@ACM>
 <20210109220614.759779-1-sandals@crustytoothpaste.net>
 <xmqqim85d0vw.fsf@gitster.c.googlers.com>
 <X/ry+ApdWMFs5l/+@ACM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="id7ILXiXeR9+fnnp"
Content-Disposition: inline
In-Reply-To: <X/ry+ApdWMFs5l/+@ACM>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--id7ILXiXeR9+fnnp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-10 at 12:28:40, Alan Mackenzie wrote:
> On Sat, Jan 09, 2021 at 17:41:23 -0800, Junio C Hamano wrote:
> > I am actually tempted to suggest rewriting the whole section,
> > starting from the paragraph above and ending at the table, with
> > something like this:
>=20
> >     Three different classes of paths are shown in the same format,
> >     but the meaning of `XY` are different:
>=20
> >     * For merged paths, `X` shows the status of the index, and `Y`
> >       shows the status of the working tree.
>=20
> >     * For unmerged paths, `X` and `Y` show the modification states
> >       of each side of the merge, relative to the common ancestor.
>=20
> Also missing from the current doc, I think, is a description of which
> "side" of the difference is represented by X, and which by Y.  In my use
> case (having conflicts after doing a git stash pop) those "sides" would
> be the work tree and the repository.  In other scenarios (say a merge
> conflict after git pull) I think they would be something else (though my
> head is hurting a bit, here).

The two sides are the two heads that are being merged and don't include
the working tree at all.  I think the answer about which side is which
in a merge depends on whether you're merging or rebasing.  Rebases do
things the opposite way of how merges do them.

In your case, you're interested in the fact that there _is_ an
unresolved conflict, which means you'll either get DD, AA, or something
with a U in it.  That will happen regardless of how you do it, with git
pull, git merge, git rebase -m, or git cherry-pick, and it indicates
that the working tree is "broken" (i.e., has conflict markers) and the
index is in a conflicted state.  Since the state of the working tree and
the index are known, we use this field for listing the two heads
instead.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--id7ILXiXeR9+fnnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX/tIWQAKCRB8DEliiIei
gQPQAQDoCN/+Str1aj0dFGFHFa5JktlkhI4pIGvrDBV7U9R76gEAiluiGdlTmeul
0zgjmuMJK7s0jl1iKa9z/n9F31a3hws=
=H6WW
-----END PGP SIGNATURE-----

--id7ILXiXeR9+fnnp--
