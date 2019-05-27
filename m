Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 826AD1F462
	for <e@80x24.org>; Mon, 27 May 2019 23:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfE0Xn6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 19:43:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36770 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbfE0Xn5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 May 2019 19:43:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5881:abd5:52a:5d54])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2284560737;
        Mon, 27 May 2019 23:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1559000634;
        bh=jJ31Bj4iBzWcTRYm/2Kt7VrXvIDbR2fdGN9UJOy7DX4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=RmawC6+IuIKGgmJxYfqVyv4zZfMbTEqiCDU8mX3Zvz+yY0r57V7ZCsyl4qAjr4hwG
         /inDjwreOh4KpoKjbWDpvLshPo3h8Pho7xMNNld7LBIf3SVuqEHrm6zvIova2GQgOv
         wAsmV376rxOawO2UbkTIKpP/5jgxG2Vy2sHSiOvpyfqcVT2QhD+X/+PT2t2Nb2eolD
         R1bgDBBaiQckdRA51dZIlsKrWq4jiw7Ib74DT9q6sIGmyRW2gvBw0UOzDCtkVK5bsw
         qAURgejMRWpe4WX1chqNLhBV30lynG8mWvWiiePM/GnLTVAQGB1ZUbbg5BqZFcE5VL
         Bz+cmGk1u4genMz6cEUFclrsOus4RlWu+czxNT8BM0DYGbYe2WTlWrjiGMLj/dkMye
         a2HU4ddwgx/jdLhQ5IE4vkvXxpXA1g/pUMYuAa5+vVfu30yLsJLagsv2Elb/9fhhl3
         pZb51u0esr0n+z0qu9azBr4356Juxv53GWWeujKlPaxgXtmLlLr
Date:   Mon, 27 May 2019 23:43:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Chris Mayo <aklhfex@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] send-email: remove documented requirement for
 Net::SMTP::SSL
Message-ID: <20190527234347.GH8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, Chris Mayo <aklhfex@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
References: <20190526172242.13000-1-aklhfex@gmail.com>
 <20190527193517.GA22013@dcvr>
 <87imtvmy7f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Content-Disposition: inline
In-Reply-To: <87imtvmy7f.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-27 at 20:36:36, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> I've done enough git-send-email patching in anger for a year at least
> with what's sitting in "next" so I'm not working on this, but just my
> 0.02:
>=20
> I wonder if we shouldn't just be much more aggressive about version
> requirements for something like git-send-email.
>=20
> Do we really have git users who want a new git *and* have an old perl
> *and* aren't just getting it from an OS package where the module is
> dual-life, so the distributor can just package up the newer version if
> we were to require it?

In my experience, shipping newer versions of packages shipped with the
OS is a no-no. That's a great way to break unrelated software on the
system, and if you're the distributor, to get users angry at you about
breaking stuff on their systems.

We do indeed have users who want a newer Git on those systems and are
using the system Perl. The Git shipped with CentOS 7 (not to mention
CentOS 6) is positively ancient and doesn't support useful features like
worktrees, so it makes sense to upgrade it. But if you're not a Perl
shop, nobody cares about the version of Perl on the system and fussing
with it doesn't make sense.

> I.e. couldn't we just remove the fallback code added in 0ead000c3a
> ("send-email: Net::SMTP::SSL is obsolete, use only when necessary",
> 2017-03-24) and do away with this version detection (which b.t.w. should
> just do a $obj->can("starttls") check instead).
>=20
> For shipping a newer Net::SMTP we aren't talking about upgrading
> /usr/bin/perl, just that module, and anyone who's packaging git
> (e.g. Debian) who cares about minimal dependencies is likely splitting
> out git-send-email.perl anyway.
>=20
> We could then just add some flag similar to NO_PERL_CPAN_FALLBACKS so
> we'd error out by default unless these modules were there when git was
> built, packagers could then still set some "no I can't be bothered with
> send-email at all" or "no I can't be bothered with its SSL support", in
> the latter case git-send-email would work except for the SSL parts.

We had a problem with Homebrew sometime back where they stopped shipping
git-send-email because it required Perl modules and there was a big
uproar and a request for us to allow dynamic Perl support. I would like
to discourage distributors from simply refusing to ship core pieces of
Git because it tends to cause problems for users and for us down the
line.

I understand and am fine with splitting components out into multiple
packages or omitting parts interfacing with other systems (e.g.
git-svn).
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzsdjMACgkQv1NdgR9S
9ouqyw/+MDyZYaLwszRJNxO97ed9FQhwLO7JXjtkBvcnPUn6cuSwgKs2M8xuZuWT
oTDj5l3jwh6JMCy+nJdOawIXISjgrp3Ml/3ZH85JDw0ED08M9OXfQ0AJNuPMi5H+
D5spo4TD3Fo9IawGQ9QUbmCc4UGxbrMSKnPeLakT1veTKAzn8rQFfSeuYbbXEoQU
5R6gYQ99+OQUab4JIu1CFYyy8r9+Z991fjcoIM9omJ6eWyeOmXTbKRCHYacFhxR7
1guieffJGROxAnA5vD1y+tXFCJEcZx4k38dVt0ERz+0pZ7VK1muf60KNBDGxOyca
eR9aWFJRPzh/yxdEN6lFlQUeRCjmaJQfdWpdZzDjKNBBNZ0ODB/EvVekU0tYQeTE
cdE4RJFLU7Ax5CRQPi7NIKzT2tAHrX17clIT3UXz3sl2La4uikLQxdRcYZw7+D9F
WvTba4jWDsIx9qeCpcpINnlhYd4n8fQ6J6xiGWsmJOCapOOeq2Xc1udl4T7xXHDR
2upX3kjjsvK/PkpY+GW7khpmPCVgyaAhUGp8vv9BoEPNYE8tnw9O9fmg2EQbRjpd
svhgesEtYLmJeyYhEEXaC0VYPAMw5yDNGxISGuyxoG0g05Jnmt1XebwMhYbCPivu
kgVfqna2UAvJ9v0sz0hSh8wKses2QreXcpKZif1YFNTVpnORKzU=
=eAFQ
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--
