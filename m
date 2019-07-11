Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB8761F461
	for <e@80x24.org>; Thu, 11 Jul 2019 14:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfGKOsf (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 10:48:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56560 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728178AbfGKOsf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Jul 2019 10:48:35 -0400
Received: from genre.crustytoothpaste.net (rrcs-50-84-77-156.sw.biz.rr.com [50.84.77.156])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5A18B605AA;
        Thu, 11 Jul 2019 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1562856513;
        bh=pUyK+kDqBlgE2t/uGQk4rkQLcwOskuHQ3YrwBuBRQ5M=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=SlN7ZX+nAoO/NOguMhmASFGxhJec2AJ38W045Acbh+cmOhKbdeiHBPkpLLsjQPzrB
         lM/ugukL0/Q6OHxsScS9Cequye+TLZAAsPojPlSbN6pj6MPd5Pp9+gTqKvJL5PKYUJ
         Vub+wlwXObZ9VUajpm4O7aL+C5i6SXLCjqOtSeW0re+7PjECZAbnGDetHe2P5s8qJJ
         vdFxZAwj37npC0aPG5b8FhQCUhkhlk4uCEjUlyjveaJy+CpBqyHjiVrImWAzQO4wPa
         HivvvIwqgQpULVp5FfUsC0zYrg4Pq6m1mhLvqoOG8BC9lUtcdPudWYOS+9u6aGqY1a
         VhBeGW1DthpSMvVMaqOTtbW+5qZcA5flinoY3aKbgr3l5QkFy6f02XIlkEOekhSR7B
         gVoc/wNAwXQAk9WB4Lp4lUjnUaxuooy4K6DW87nuO04j0RWVuUPXiLgVVHbohkNq4/
         WzNXGVisYNZ1nN3jgQXh1QX5OAuTDN+QBIuPMVh+ztz1YycemQF
Date:   Thu, 11 Jul 2019 14:48:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Mark Florian <mflorian@gitlab.com>, git@vger.kernel.org
Subject: Re: `@` alias for `HEAD` not working in `git push -u origin @`
Message-ID: <20190711144828.GH9224@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Mark Florian <mflorian@gitlab.com>, git@vger.kernel.org
References: <CANC=f2c8eynWJ1r=zwZq1qwrDE85LVFMU2mjLU26HYMDGaD4iA@mail.gmail.com>
 <20190710233937.GG9224@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1907111141380.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oox5VnwalALFvA7"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1907111141380.46@tvgsbejvaqbjf.bet>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2oox5VnwalALFvA7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-11 at 09:46:26, Johannes Schindelin wrote:
> After reading that thread, I come to the conclusion that it was not so
> much a decision not to pick it up, but more like a falling between the
> cracks.
>=20
> I would be in favor of this patch.

I think there was some later follow-up in a different thread (one of the
"What's cooking" threads) that expressed reservations about it, but I
can't find that thread right now.

Regardless, if there's interest, I can certainly resend and see how
folks on the list feel about it.

> Since I have your attention and since I am interested in a related issue
> (when I wanted to propose a GSoC mini project to let `git fetch <remote>
> @` expand the `@` to the current (local) branch name, Matthieu Moy
> pointed out that `git fetch --current <remote>` might be a better UI):
> what does your patch do with `git fetch`'s refspec arguments?

I haven't checked. I believe it would resolve "git fetch origin @" to
"git fetch origin HEAD" and "git fetch origin @:refs/heads/master" to
"git fetch origin HEAD:refs/heads/master".

I can add some additional tests for this case, although I'm not
especially sure that it provides useful behavior people will want.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--2oox5VnwalALFvA7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.16 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0nTDwACgkQv1NdgR9S
9otfsg/+L8N4MFLjjFLGBdIfhh92xw3o6g2RQcrTyqUIKK9CTOYSCSpENtd0Uovw
VnnG17ckY519hDBpfeMPiHpGe2enPc3aXC0F4q/A4SkvF9E5kO5bgR/EC7SGDA5g
INzXNtfj/ocOr3iJ0ROplUSCohbU1YsvZVMTytaVX4yutL6f6lGFvbIGYnQAfP+A
Tj+P0W+5Ui0Ai7RaOpMA7NL92jjmxRuhuxkHyUV0kPQIWQR5MqRoO1gDmbr1z5bN
4tFrkT4xzH6DbWp+1DFc+jH9MR6Xp/slt3icjSvYuQaQkp6N41xDY03tAKbHVtVm
EjYojwkOzHVPDM3vE3GVJXv0NQuSDGEMWRijog/sFJEkqRfOs131WaZ4hx7JItR/
P3jZjeRD2YaO2hGO/C5RaXhkLA/cx1WUWJqwaMJXpsF6Qx2MWpNp3C2hUl2ZkLqD
nln/QHIhtrKjKDQZ60YUrC85J+eG0fw4fbOMA5dKnMUC7dgRxWFICDDP0h5B98Yl
gBK3KQb72xS2RWPKjWY+lfhAYgOfTtZXKxUXz3MGIZ1Jckthb4uJGe4SjCE+fjTu
rKol3mp66Ey4J4SAM78gOIOebKzomNax4Aq4nhYcXEYQRmhPzJ+zw+Cud5V/8RQ8
kN8fMb+BZW3wwpYfFkYrDSQ0XZlx5NzwPEWlm46/vY8kc9dBlUE=
=MAPs
-----END PGP SIGNATURE-----

--2oox5VnwalALFvA7--
