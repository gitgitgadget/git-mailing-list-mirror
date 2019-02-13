Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8CD51F453
	for <e@80x24.org>; Wed, 13 Feb 2019 03:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbfBMDgH (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 22:36:07 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34498 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728014AbfBMDgH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Feb 2019 22:36:07 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EAE3B60443;
        Wed, 13 Feb 2019 03:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550028964;
        bh=LYiMkU4VFgvUuLlMjiAwDM1GP4l8q0ftr8a5ic7GiNE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uVdet1gpllLvk2XUd4jopQbHeiV+QlWJ1CDrjlbCgBMlwiP2QwjhcjH35zRhO8wJs
         mq+VhikuZX5MVRQMylRFfZOtmc8imBlCKEhnZfwkZCy6LhLkNxFJ76pzqjK6z5ZwY2
         +uwKUgVHWX5NMvWECyOqcpfmsExRAB81vRJescV5bYGKyaKOhze9wph3Z3y3XwzwPF
         ppik8pYCCeG1sxlpyvXiZUEIIic1K3iwstJz9PCU3qEySTHwX11h0CWdqivEslmsPd
         zxJvK8SIcDvysGiQNrKAbtEGfMNPeVFinxWnTi2bGnTObXOdESYa0dIDwwhTZ5rpf1
         RcwuU8FGbC5o74R9IVTLDUzqmJ6uZXzJyRkvfco+K18WYlA5fdBaCbCQsHsPUYO+mH
         6pZWfW5jgH8XEPKpTy2uukAfDolqCRJtBYX57p0o2hdkN83ZGkNBJEbSf9ADZj7qPI
         rJKhjgh2wTcs/9LgsdtgNaO2pVlBP2wV5gwKUTzXGsyHYbEfJsu
Date:   Wed, 13 Feb 2019 03:35:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     ismael@iodev.co.uk
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-gui: Handle Ctrl+BS & Ctrl+Del in the commit msg
Message-ID: <20190213033558.GJ684736@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        ismael@iodev.co.uk, git@vger.kernel.org
References: <20190211214203.32444-1-ismael@iodev.co.uk>
 <20190212002932.GC684736@genre.crustytoothpaste.net>
 <9EBA7C5F-4D59-45EE-B2E6-E7E76D7221EC@iodev.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Content-Disposition: inline
In-Reply-To: <9EBA7C5F-4D59-45EE-B2E6-E7E76D7221EC@iodev.co.uk>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 12:24:40PM +0100, ismael@iodev.co.uk wrote:
> These bindings delete the word before and after the cursor
> respectively. It didn't seem necessary to describe the thing in detail
> because it has been commonplace for more than 30 years AFAICT.

I'm sure that these key bindings are familiar to you and probably to a
lot of people, but I wasn't aware of them. I imagine there might be
other people who aren't aware of them as well. The commit message is an
opportunity for you to explain both what your patch does and argue why
it's valuable.

It's also rather uncommon for commit messages in this project to lack a
body; we typically prefer to say at least a few sentences about why
we've chosen to make a change, even preferring to perhaps state some of
the more obvious things just for clarity's sake to assist other people
(and future us) in understanding what's going on.

This isn't me trying to be difficult, but rather to help you get your
patch in a state that's most likely to be accepted. It's common here to
do a couple of revisions of a patch, incorporating reviewers' comments
and polishing along the way.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxjkJ4ACgkQv1NdgR9S
9otQzg/+KfYyobUUDaJNNyOPCdWgpeaS5BCPS0ShTqO0VZcG2PlJ2Eg3Chkj0WB4
6MdgOcG7r2Lp1KRni2Ig+VKsph9CXITs/k2FD5Dt1SCS7p3LBA5mgxr0+6WDZz+O
BOAywSc4F6ZJScEHZGU4EmmMlG1gLnehxERbCnsMPoeFw2+UD713aGLx+8YnOL4D
aN/tf3EQpijWUOzb4ilA3/OLOyQUFoFB6xuO3O/2E/Ic0J1KR8yLPJPEun5ZT3dX
Poaac2BVniJvJFTkSxSi1PhpcFin4CR181gT85NCUH09GilNtTMkH4VP5VBdv9Ww
EJ01vkj41mr+7/0T5OFOL+WRdhc/vIlSSEXDCmmiQR6lfSqqtsPr/ORE0OH8bY7E
ax0NqlBRBslqKI3s5qw/uCv+qnpDHfTD7Ca8gP9CI2SPlKX3gtUqJ7ju/aLtomZz
lzxc6MbN9upD8mrSiurGMKYEUB9T6aGo744QT/epvZxADAMHwsGUJd8mezoqhTUr
qL2IyxMqEnbhNlncQPiyFH6wAK7nUAISkceQlKhRZqbN8K55OR3G4zEWEccajxCM
lliGbbbJ82AIa/fvwnhvNQFs079qttLT5sm0UjrejQS9ICwVvwx32aZVNe+61xOc
QA8lVWNm2dagDJxlp2KqTjL1YV9AJn7rdvAIOwtDHugY+KX8kMc=
=q9J/
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--
