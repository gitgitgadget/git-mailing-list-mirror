Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B55D1F453
	for <e@80x24.org>; Sun, 28 Oct 2018 15:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeJ2AZ4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 20:25:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52740 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726492AbeJ2AZ4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Oct 2018 20:25:56 -0400
Received: from genre.crustytoothpaste.net (ip-64-134-145-243.public.wayport.net [64.134.145.243])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8EBAD61B73;
        Sun, 28 Oct 2018 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540741258;
        bh=oT1rvtp9jcsl0VUzw4VOnZG19rIFgVxr9iF0piOn5jw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JuPZvi2xwpL2iO+5ijx3DHACfZxtMmd8Kp79TU/T35q91Ep0071QxG7wvb0mjEJx6
         Jw0XYyiPBwpsNAgNncrssjKF9MPJsITnlTeiT6zR4rPD+bhjhUMECwZtvZukmlePvN
         KfWluEJ2Pwk9YKcn5jCkZuTz9PUzgFO5LQdhWlk3MIEvISZJ+yD8nMSMSoygxF5oLh
         koRt6VqlFKhn7vXs8xjJDpkor8ieUuLWizqJ0bQNtcgfDhNgbDDgHsnGh67HPefzsP
         knT7QWZOFw1ZZ8EJq08353y3NtpCEMubUSfb+cxYa6crFej4SqM72RqdRFeEnbmD18
         QQki0DSf5K9G+xLlM1bzGnrCfRA6xTuICd9EBbPonrZYg4SzklVPp1jVRM0ehMjLa6
         xEJZB5L2BelIFJqC0Hds00J944SBk7oZdpFWnjl8yXUTpPJOPLKPaDEkWItC+nF87c
         aHb46t9RUVVMpc4JNLZTVMMfSsFoHQqPhdXzlZD2TmxndtodSoS
Date:   Sun, 28 Oct 2018 15:40:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] some more hdr-check clean headers
Message-ID: <20181028154052.GH6119@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <ecb3d551-314a-aeef-048f-c1bbe0b3c999@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Gk0KcsbyUMelFU1"
Content-Disposition: inline
In-Reply-To: <ecb3d551-314a-aeef-048f-c1bbe0b3c999@ramsayjones.plus.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 27, 2018 at 02:47:47AM +0100, Ramsay Jones wrote:
>=20
> I have some changes to the hdr-check Makefile target in the works, but
> these clean-ups don't have to be held up by those changes.
>=20
> The 'fetch-object.h' patch is the same one I sent separately last time,
> since it only applied on 'next' at the time. The 'ewok_rlw.h' patch is
> just something I noticed while messing around the the Makefile changes.
> The 'commit-reach.h' patch is the patch #9 from the original series, but
> now with a commit message that explains the '#include "commit.h"' issue.
>=20
> These changes are on top of current master (@c670b1f876) and merge
> without conflict to 'next' and with a 'minor' conflict on 'pu'.

All three of these patches look sane to me.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--/Gk0KcsbyUMelFU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvV2IQACgkQv1NdgR9S
9ouI1g//RaUWGU8hlCpBCvZ5L5byaIcHIcb6AJ0kQi0/J3qiwn2X3KBWPKi46Ek9
OFhYjDKJEmVrEja2TtiML9LN34HIT9iGUVtymrP2B/hdxdcEg5ZxT0JeNqqrpXJu
v7njqqL6ciEKc4cGJitKKoXM+vNYwMD28oca11KhFDVNsBZUxnN2xFlQI7duVTTG
D7LImIZbEcwnLZziy1fdik8B+U9ZW+i/3F3sqY55KagAMK5Wy59tZsWn2AElCh6W
e2NPX/SrUhb2XsHp0NjYHyDYdWvJbbz7Z+oNXQfaH/memif//NhiuWyzcQytMIMF
Qni7XOHwSVWevcFSUxDiAZ2PMt6vCQW4pafpm4cjq/IHCS9bf03U4Hzq/vFWwnMw
PCCUvx/+oDEvICQUniwSLp4sbJOk1rmyMHmIjGV/a/RS/DHHsppTDxs53ZOW3EvQ
Ilo31+9+MM2uVx+kM1W3D2fR9e1WSAQjrOTJC9MPAtjFsFPCp2CJVPSxycs5ynjQ
S/K+aaasuCZmFTek9udKnZ/FDh6DPyRfN+Ww6JanmAFCQd4802GfeoU74VOoZxLo
9/ud5nFGS9la/WEC9aZvtenr9/VQKStvSlmlN5IvWJ9llNtvAKWBiXFqQwsLMzYL
B7J0XMjcbKWnzzDb7a4awnpUJlgM6AgvNse550eKwev2yfx0gag=
=p/sJ
-----END PGP SIGNATURE-----

--/Gk0KcsbyUMelFU1--
