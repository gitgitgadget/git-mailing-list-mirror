Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C96B81F453
	for <e@80x24.org>; Sat,  3 Nov 2018 16:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeKDBeW (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 21:34:22 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:35630 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbeKDBeW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 21:34:22 -0400
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 9B0D2335C31;
        Sat,  3 Nov 2018 16:22:36 +0000 (UTC)
Message-ID: <1541262152.1028.20.camel@gentoo.org>
Subject: Re: Git Test Coverage Report (Friday, Nov 2)
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Sat, 03 Nov 2018 17:22:32 +0100
In-Reply-To: <xmqqr2g2mqaq.fsf@gitster-ct.c.googlers.com>
References: <784741be-6045-12bb-75b9-0df6f4c612b7@gmail.com>
         <xmqqva5en832.fsf@gitster-ct.c.googlers.com>
         <1541231868.1028.2.camel@gentoo.org>
         <xmqqr2g2mqaq.fsf@gitster-ct.c.googlers.com>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-SuHm4itbD2xZtPOr1Pfa"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-SuHm4itbD2xZtPOr1Pfa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-11-03 at 19:03 +0900, Junio C Hamano wrote:
> Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org> writes:
>=20
> > As for how involved... we'd just have to use a key that has split
> > signing subkey.  Would it be fine to add the subkey to the existing key=
?
> >  It would imply updating keyids/fingerprints everywhere.
>=20
> Yes, that "everywhere" is exactly what I meant by "how involved",
> and your suggestion answers "very much involved".
>=20
> If we can easily add _another_ key with a subkey that is not the
> primary one we use for other tests, without touching the existing
> key and the existing tests that use it (including the one I touched
> below--- we'd want to see a sig with a key that is not split is
> shown with the same %GF and %GP), while adding a handful of new
> tests that create signed objects under the new & split key and=20
> view them with %GF and %GP, then the end result would be that we
> managed to add a new test case where %GF/%GP are different without
> making very much involved changes.  I guess that was what I was
> getting at.
>=20

I've just did a little research and came to the following results:

1. modifying the 'C. O. Mitter' key would require changes to 4 tests,

2. modifying the 'Eris Discordia' key would require changes to 2 tests
   (both in 7510).

Do you think 2. would be an acceptable option?  I think changing 2 tests
would be preferable to proliferating a third key for one test case.=20
Also, given that both failing tests are specifically format string
tests, one of them would serve additional purpose of testing %GP!=3D%GF.

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-SuHm4itbD2xZtPOr1Pfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEXr8g+Zb7PCLMb8pAur8dX/jIEQoFAlvdy0hfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDVF
QkYyMEY5OTZGQjNDMjJDQzZGQ0E0MEJBQkYxRDVGRjhDODExMEEACgkQur8dX/jI
EQqGvxAA4/EKokIPvX/hJwxf3YVMmX5SgjVhCYIh21TbyE4NS7UI/pIDyW+SJPlf
LEloFRhjDrU/IM0dbh8h/a9kWBPL6NV+hITPo5sV/gOGdTm9l/3b4ZEOC57rZnbn
lIg6hWor5vNIV4j6vNAmJ35rCB5KOOx6dres5wPv7KYbH+uLqPbaeZN+Ek0aVQuC
f4XFqH9ACp3RH/y/qEUFZeXQmRLsoGmauODiOsSwjG+EWlRA/2n6JLTfsPl2hP/j
2s+bmW9oM+92hVOnr8AeL0ecS2/KHa70wyn/BANgJYN27nB1XY8hxvzPv3656CJ0
CCxzAbGV4ubh0i52aOPRgh4BSdE6FPALbsKlvKoRmM7L+tcUYuoYikYH0dEQrRgj
6rtdv/XNkeeX5lj/wr1Ho1D+sIiRw6590PyLWejrtn5nGBaGgxsAmTgVeLoGnsYk
Q2z9WpQOdgSkKwDkWVbwWWQZUN67ajAIlm4kO0JNMPS77iDJXvf7/anSdKedvVvz
UiK9tlvE6wN27PhMACJRmRddTdzrsRQoSEM605gnUyYbeeGtHnrFyJ3Yt7MI13T7
FqjgycJSAtmE0DAXEUdO3NBGgkUIZlaU7t5Q+lqQiqa/Nn1kV3h4gwuGhojOp6s7
l119iDQ2y6F67rkFIvrfjzHsyO34rv+ABz/ajQeC9Lp623RKaPQ=
=m5zT
-----END PGP SIGNATURE-----

--=-SuHm4itbD2xZtPOr1Pfa--

