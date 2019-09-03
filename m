Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88DCC1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 00:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfICAu1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 20:50:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58524 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725870AbfICAu0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Sep 2019 20:50:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6959:e43b:5cf6:a465])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B47AE60448;
        Tue,  3 Sep 2019 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1567471825;
        bh=+9izSUBwPCSdIDoDfj6ZwPYrQo6rK+5KOs7yo/ag8dw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=inNUhQ5ojsSgRAoKxafj3MWpH0I1ZA+nBAPlf6Z7Su+PHTB99CzxyxTtdLHOzz9wo
         pMIhVsnrhfTTsZnqvJ1hOdWTa4J76+nk0jhU5CVWarI2p9RXPnphiTpBhx0TGv+RC1
         1pGGNMYMNoJoiL451JnDtiGdajs5yTp42ZGKFl/9ozzwZZHxuctF7MLzquLZ8FJ6MO
         PyA8Nrf/eIV/Ek6BJvLaqJh7Lyc1M+mpLfaQ3mZ5cXMfwZ2tWyNgGEtZya+dLfP2aJ
         ZIQFfsMSuUuAmIdzmKFYOuDkcUOYgZo5sFctFUERyUAgnKNz28+0g1ONKdspV1vCe7
         xVh0HgBoPkNGOLrbiVPeqQ2DXdmo9fZzw2Ht50N1ygcYCInVsU6EutLUK5yO4VtAeT
         uW2iGZfibKnZ4TIoeZ+DUXqVST8ladSfCyIi2dHix83s7rlDpLjMTf5hJlmDPYNDi+
         pm4HE2H9ryK3bCxtHoPAKha4CqQeEF1av0jInfHXjX4jMnVssOo
Date:   Tue, 3 Sep 2019 00:50:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Warren He <pickydaemon@gmail.com>
Cc:     git@vger.kernel.org, Warren He <wh109@yahoo.com>
Subject: Re: [PATCH] rebase: introduce --update-branches option
Message-ID: <20190903005018.GH11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Warren He <pickydaemon@gmail.com>, git@vger.kernel.org,
        Warren He <wh109@yahoo.com>
References: <20190902234109.2922-1-wh109@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+G3HLlWI7eRTl+h"
Content-Disposition: inline
In-Reply-To: <20190902234109.2922-1-wh109@yahoo.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--k+G3HLlWI7eRTl+h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-02 at 23:41:08, Warren He wrote:
> Sometimes people have to rebase multiple related branches. One way to do =
that
> quickly, when there are branches pointing to ancestors of a later branch =
(which
> happens a lot if you try hard to pad your PR count on GitHub--I mean if y=
ou try
> to make small, logically separate changes), is to rebase that later branc=
h and
> then reset ancestor branches to the rewritten commits. You just have to w=
ork
> out which branches correspond to which of the new commits.
>=20
> Here's an automated way to update those ancestor branches.
>=20
> It's implemented as a function that processes a todo list, modeled after
> `todo_list_add_exec_commands`. Currently steps are added as `exec git bra=
nch -f
> <branchname>`, which comes with the caveat that they're not applied atomi=
cally
> when it finishes rebasing.

This is an interesting idea, and I definitely would find myself using
it.  I maintain multiple nested branches for the SHA-256 transition and
rebasing tends to be a bit of a hassle.  The idea of reordering commits
further down into earlier branches using this technique is also
appealing.

I like the idea of using existing tooling for this and not needing an
additional verb.

My gut tells me folks may want a bit more control over *which* branches
are rebased, but I don't have a personal need for that, so I'm not going
to request it or propose an interface for it.  If nobody else does, then
I think we should adopt the simplest approach, which is what you've
proposed.  Users can always edit the todo list if they find an
unexpected branch, after all.

The other thought I had about this is a question about how it performs
with many refs.  I've worked with a repository with easily 80,000 refs,
and I wonder if the current technique will perform adequately there.

I'm interested to hear others' opinions on this series and am looking
forward to seeing it progress.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--k+G3HLlWI7eRTl+h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1tuMoACgkQv1NdgR9S
9ot9QxAAhJHF50Ovx3deCEKMQV8EV8q852dyfFKiTN808l5MwyX1ZXotiONgNxIz
JjZWgqrsHyWdRfIyXS9ywGARf72j88lPlirUthLSRw/9EZChTMNe1VSKjWRJcJ10
2e4z7BQDI/Z9MbJaa3dABj15WPuAljZOBgKJJlcWTGytjrKUGZEMxS1CaOQ/5v7D
D+asMLizdTUKx0bcx/jqCyT6gPUb6/hCJUWz7ASyPkelcoOqxP7ys6PUdBW7LZLq
jexV/dJSaJiONCyvVE5C+7jgAeyDIW/aAupZARxkXZjnKaEjlQxi4N01oejoRGWk
MuCk6YnqoVTXoKEDDd3P2493NseEBkp39Il3wcAXURSMdYKEnfAo6mdjgSt0He/L
03d1Myd6RLCJPDDy7JV64OsmMp+VBlQyoxbvljuTj+EMlKO+4QgxVMEq/bpeF09n
12Y40vmx0CHzOj9wvxS/vvXdPjZGILMVEFrtzAc+7jnmtDqHTquswE4b3Dm1y0OS
QEuB+Kkyco2RclpCRnSWR4Fa+G5zW9AV37iwdMiVgDvAeOfX3sFW7uWU+1+VVPq/
dChTbvVOUkf2MEJ4dSTCJVlynPFEKssIpi1TvhbCs4QKpjw2QWyCO6YtwQCCNEcd
RVsy/lnEF86S6M5UD1M1wPfOotuYSeNIqvV6iO4PhuBjR5s5NMc=
=2jvJ
-----END PGP SIGNATURE-----

--k+G3HLlWI7eRTl+h--
