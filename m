Return-Path: <SRS0=73cz=AB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69BAC433DF
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 01:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E2622CBE
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 01:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UJLBvzLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbgFTBe2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 21:34:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39910 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731401AbgFTBe2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 21:34:28 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2C91A60436;
        Sat, 20 Jun 2020 01:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592616836;
        bh=wv7biLU+pg/eJWO7BH/nfR+wHsA9Esx+98KnCoCJIN4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=UJLBvzLLeT6XXlieH5m9ghAsgRHzmQCGXMjffhtwc+frzfN1WX5kbN2mBPfFhnToL
         QYs/eu5qW6WAjiTLdj6UbxzsdFD00bcsMxFHnRkg9kB482Bl4rcErr7wKRJ7XrcEDY
         8wwBGjTiVVev1mgUV+MYx4t3jpAymWv1EmMAbsFgJx3NKhywvVndRiOAqHAMjp6Q/8
         OdXCX7aKPwJgXq3wgSdcWmwNc07yHiBWzoqCfqPiQXdJwaYhqeTeB/1Aw/ZEXN2uVJ
         PF0Z9BFancURA0A3wuNrVSRqRpU5V/xL4zmLaXIPBICNGO9/Icf/u+pMVm6F1gKHxd
         D8gbIqVTxGsvbq82zaPjdEastY/8ddqDb9zs+qhHR55SDyIYvTV05YoyMjf4bsJ8M3
         YfsyBJQ8W5yeQIf/AwLA+57EGgSbX0pjT/fcCdG24V7MxZLVQvy3nXIFnPsBUmPwZk
         ElPT3nS3SAHXhN2EF73NU54xF7WlTk9jjlfuDDuPnOMKB5pQ/T+
Date:   Sat, 20 Jun 2020 01:33:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 00/44] SHA-256 part 2/3: protocol functionality
Message-ID: <20200620013350.GK6531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
 <xmqqk102g3ua.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9RxwyT9MtfFuvYYZ"
Content-Disposition: inline
In-Reply-To: <xmqqk102g3ua.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9RxwyT9MtfFuvYYZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-19 at 21:09:33, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Otherwise, this series is the same as v2 except for a rebase (for my
> > convenience and Junio's).
>=20
> Not mine, though.  Keeping the same base is easier to see the
> incremental difference.

Okay, sorry about that.  It does make it more convenient for me
eventually (since I get to resolve conflicts more incrementally), but I
don't usually have to worry about that until the series hits master, so
I can hold off.  I'm not rebasing as many patches anymore, so it's less
of a problem for me.

> It wasn't too cumbersome to rebase back on the same base as what was
> queued (and the making sure the result, when merged to 'master',
> matches the result of applying all these patches directly on top of
> 'master'), though ;-)
>=20
> In any case, the updated step 34 made sense to me.  Thanks.

Yeah, I discovered it the other day when updating another project to
deal with a SHA-256 Git, and I happen to be on vacation today, so I
thought I'd send out a quick fix.  I was surprised to learn that we had
no tests for cloning empty repositories, but here we are.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--9RxwyT9MtfFuvYYZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXu1nfgAKCRB8DEliiIei
gdoeAP0e1NyjdJCTrhSWlXQeWCGnQX4n6OR/zwfu//dHDig8sQEAiQMfDUHx+Kmc
S9QhYhXrbcX9b7X0p4hKIHgVRDVXyAk=
=YWsR
-----END PGP SIGNATURE-----

--9RxwyT9MtfFuvYYZ--
