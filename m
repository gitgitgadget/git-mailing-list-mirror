Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F87F1F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 00:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfHPAXD (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 20:23:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57616 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbfHPAXC (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Aug 2019 20:23:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3DE6A605B2;
        Fri, 16 Aug 2019 00:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565914978;
        bh=8AYQ0ZUiTQntyklKcUQAF+kPMiGA6EKJJlii4kCTRaM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BIYgTRkedlu5Coh/dso2b0P/l78Jw6Cyn/2wCv7QKek9bUCryWxJiUqhoK3BzfuRf
         9FnKKmoK42yrihkSMMunbD+NT9yLBb7VYhBFYDXIONVkWmrhjse+fSL3CQiTZG3nsX
         FYdZrkGAkrr1ueDxPuoOGy/RhLnlQ0mthYBHYyCLS0I9ok7ctYZmsitQiyLobIGizb
         8I0gH6bMT62dhis45Jo27wlg3TiAtZieu+56Y0+eWWIdVh8cXIZYEPCfx1tctDYYfW
         tAnSHUA8Qv15/EMZnj6+crmSLHYzPDvgu08ybUywqxpfACnBY7mhy/swdfM5oZAUBI
         asy/XYVzjoqF3ISqUtdKgZ456U+6CJ32damk0JFKzV5iJ5vwT1tLBm2sFSoiC5DCiy
         jEU5JQ+wbr7eygSHP8MyzQ+X48R2974oiXDnzV8sp+kqBd5q6PDYtodmfzFmc1v/Jt
         21Esz+OIk5sY+Iy/9cTXluld12RYFVI2gkJ/YaEyZ11o7F9FPyJ
Date:   Fri, 16 Aug 2019 00:22:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] apply: reload .gitattributes after patching it
Message-ID: <20190816002253.GA365197@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190813024307.705016-1-sandals@crustytoothpaste.net>
 <20190813024307.705016-3-sandals@crustytoothpaste.net>
 <xmqq7e7h7xap.fsf@gitster-ct.c.googlers.com>
 <xmqqftm22i7e.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <xmqqftm22i7e.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.2.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-15 at 22:10:29, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> >> When applying multiple patches with git am, or when rebasing using the
> >> am backend, it's possible that one of our patches has updated a
> >> gitattributes file. Currently, we cache this information, so if a
> >> file in a subsequent patch has attributes applied, the file will be
> >> written out with the attributes in place as of the time we started the
> >> rebase or am operation, not with the attributes applied by the previous
> >> patch. This problem does not occur when using the -m or -i flags to
> >> rebase.
> > ...
> > "rebase -m" and "rebase -i" are not repeated run_command() calls
> > that invoke "git cherry-pick" or "git merge" these days, either, so
> > I am somewhat curious how they avoid fallilng into the same trap.
> >
> > Thanks for the fix.  Will queue.
>=20
> Actually there still is one more thing I wasn't clear about the
> change.
>=20
> > To ensure we write the correct data into the working tree, expire the
> > cache after each patch that touches a path ending in ".gitattributes".
> > ...
> > +			if (!flush_attributes && patch->new_name &&
> > +			    ends_with_path_components(patch->new_name, GITATTRIBUTES_FILE))
> > +				flush_attributes =3D 1;
>=20
> When an attribute file is removed by a patch, we should forget what
> we read earlier from the file before it got removed.  Would such a
> case, where patch->new_name would be NULL, be handled correctly?

That's a good question. I don't think we handle that case, so I'll
include that (and an appropriate test) with my reroll.

I suspect we probably want something like:

  if ((patch->new_name && ends_with_path_components(patch->new_name, GITATT=
RIBUTES_FILE)) ||
      (patch->old_name && ends_with_path_components(patch->old_name, GITATT=
RIBUTES_FILE)))

This should cause at most one flush per patch, and I think this should
cover both cases, as well as any we haven't thought of. It's also
possible that we could get a copy or rename that causes a false
positive, but considering the contents of a .gitattributes file, that
seems unlikely enough in practice that it's probably not worth worrying
about for now.

> The call to ends_with_path_components() is almost no cost, and I
> would suspect that this call is easier to reason about without the
> "!flush_attributes &&" in the conditional part, by the way.

Yeah, it probably is. It was added to avoid the allocation, but now that
we don't have one, it shouldn't be a problem.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1V910ACgkQv1NdgR9S
9oufpg//U/OzQ2HwWv300YY3E67A17UwZoKib49zIGesYCa4c8SS7m+ncQWQcPyF
gC9G6F4FK0/d2uq18Hj27ALrfHINl2V+ZX0UnxV7j8A72U+4DGe3FGZWRhY99thm
n87wEfpxkGSVTwkV7VcljGDkCgkGijUbZ9iEIbXbBRL+STsbXMBTbc5AwfBJDaEW
GeEzzOWuDe2M6nVFmU5gowUmg1xPIzKKlUfS+XhUiq9bhlXuA8YzXfulbrLPX+TN
4B5pkmjU3FCNDOYPqdxR+3hodVH+/X3599ZGrbHEUdyE/Sw+CKPq8Q2TXLwuwaNb
M66Bg9HPdEuEuCVz2gGIMm7XEts7mWgaOx4zkTUCztnUtk8hCvl3fkGkpM32Z22P
iQz1AiNqQABbK4vljxGmlBXCbBmu80JskR+KUf8GfVouGyxDx2CXdn/wKaPjl8Km
xMzFZWutFy4o8ldPFLkgndW+XhU3UpQ1PFbXChoeZLSoymCVY2FZ5Y4f8gzQ4wKV
d8T6/xhN7V9ZAzUKpw2i6PgeHbX5mc4QcOjTk8ZhoCY8WdiJGAPHr9bjum7mdg83
3AlTyNlzq5UaZVsecBCdhaikoPpTfYNnrgDgrvDIHtCz2VHHrEIixBJ4QMqW1vY5
bEKM23qy+jRMROZ9AtrlynstTNYdcOVByTlI3P6ijoL/Hucp6gY=
=008G
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
