Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA7031F453
	for <e@80x24.org>; Wed, 24 Oct 2018 22:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbeJYHKv (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 03:10:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52270 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbeJYHKv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Oct 2018 03:10:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e0bc:761d:9be1:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5C5DF61B72;
        Wed, 24 Oct 2018 22:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540420853;
        bh=DXl4BI6Z/s8ArRMyukOAZ1XJCFqPemxAFqN2GtnYe8A=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=1lgl4AJ08NGKz49R85et+CxYaLzzZDTEu8787hcKsVYhQMKoEmESi9CmwR8r4KGWq
         qjqJtBc0g+FjaWuC4C5TSqML6TLN+hryKLcQGLDhdW099Pd48wGTVIVTGIPyliFUbX
         ndVbiQwuwg4Dx1fjMVcxL3H/69xzPbOQ1CiUNWM+R5cut8W0CiqU5kTrvXyGO9zbvp
         5BvF4a9NuXcBDj5WGpLGr9dYrVIJz/Rpol7FHWxf0e0YKpgEyN3m+zmkuI2Y3m2l3O
         8NckPOxYToSX5NMHQwuFpgKBiYPEbHDzLQL8cETkBnnRIdBOPAiURSPH9JENMfm6Aw
         dnBJasztBdw2/LuOomq6pRNVOsxrtgfgUetPEoL8t9OgR3sz5PinftktdBizJelMwd
         2qg7XtrPvXkjl2DM1YVfeTxBfA9ZvRsCcmD7j2hev1MTPbbB5uHuV/fU/xBiwu/siZ
         thuKRZA5mcCZQhmAwlH/FcZT17kJUzq6Lg4oNjb03LmEoFaM43+
Date:   Wed, 24 Oct 2018 22:40:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH 2/3] mingw: replace MSVCRT's fstat() with a Win32-based
 implementation
Message-ID: <20181024224047.GF6119@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Karsten Blees <blees@dcon.de>
References: <pull.53.git.gitgitgadget@gmail.com>
 <f2ce9bdc01892b514f75c6c25c3393765593b1ca.1540290197.git.gitgitgadget@gmail.com>
 <20181024022024.GE6119@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1810240927520.4546@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1810240927520.4546@tvgsbejvaqbjf.bet>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2018 at 09:37:43AM +0200, Johannes Schindelin wrote:
> Hi brian,
>=20
> On Wed, 24 Oct 2018, brian m. carlson wrote:
> > These lines strike me as a bit odd.  As far as I'm aware, Unix systems
> > don't return anything useful in this field when calling fstat on a pipe.
> > Is there a reason we fill this in on Windows?  If so, could the commit
> > message explain what that is?
>=20
> AFAICT the idea was to imitate MSVCRT's fstat() in these cases.
>=20
> But a quick web search suggests that you are right:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D58768#c4 (I could not find =
any
> official documentation talking about fstat() and pipes, but I trust Alan
> to know their stuff).

Yeah, that behavior is quite old.  I'm surprised that Linux ever did
that.

> Do note, please, that according to the issue described in that link, at
> least *some* glibc/Linux combinations behave in exactly the way this patch
> implements it.
>=20
> At this point, I am wary of changing this, too, as the code in question
> has been in production (read: tested thoroughly) in the current form for
> *years*, and I am really loathe to introduce a bug where even
> Windows-specific code in compat/ might rely on this behavior. (And no, I
> do not trust our test suite to find all of those use cases.)

I don't feel strongly either way.  I feel confident the rest of Git
doesn't use that field, so I don't see any downsides to keeping it other
than the slight overhead of populating it.  I just thought I'd ask in
case there was something important I was missing.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvQ9O8ACgkQv1NdgR9S
9otAsQ/+MIVciIVeSmqI/WtsVo1kjuw4LQz02Tnh2NZuCkHYYytc8HPg9UIW/CDI
fiOKxIrK/C/Ie3Ux2bphjTHERYGYDCONzafH1VkQFNgqd1hfwwBq7tGrzN664hph
auerw0qOidsQcnGvH+3TGINDTKuf1ym8fCBzhbMF1xaA1Nj8Wkw+E/73YVujhebY
PYcCfNhibgzNCig8zcu99lvhjMgchlkFfjwM/DFP1pPFgu90kGU1FeKeONeDy1q2
4Rjin/wQ5ASR8J475AD9KnpNbOfUbBPdo7cfXT2EhI0LEq8r2LTtmHLnBpdg0QhZ
HGYqqg1FjJ5IwadKoqSIAm+pQ9Abck/XJx0sGNGZzDatwpYrT39GimLGBCimLAbF
3ziF2SQc0W6A5YTbx/s/O4uUQ100eXXu1InStqJIBvoMsV6FI9jyPaBpjLM9MWWP
rLKUgLVT/Hkb95EfAGtJbasQN/8PDk2/aVDdRU/fL4XDNcMrl1eLbJBFHel+WyDc
efAptlCFAY6jdb69u7hm82rrDV5WisrTV8yZ02aWbihAnblAddil+Qwy8xBiSnXG
HGTB3PoYSQKqR8y1ceVGTfHuoPklbO8lw5t2ekxuMS8QQmV944EjZckaOCkVQp69
anDV9oFpZ6PiZVipYtFZ7V9ch3mfpdaBavx/Nf9oz5scs0sJXb0=
=HiLA
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--
