From: Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH v2 1/1] create gpg homedir on the fly and skip RFC1991
 tests for gnupg 2.1
Date: Fri, 12 Dec 2014 09:47:53 +0100
Message-ID: <20141212094753.160a0fb5@leda.localdomain>
References: <1418303772-7909-1-git-send-email-mail@eworm.de>
	<xmqqr3w5dd2c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/V9ku20IhiqV3MvwG_s0evj5"; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:48:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzLtP-000780-7h
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759096AbaLLIsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:48:01 -0500
Received: from mx.mylinuxtime.de ([148.251.109.235]:34711 "EHLO
	mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941AbaLLIsA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 03:48:00 -0500
Received: from leda.localdomain (unknown [10.10.1.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id DFF3C241AD;
	Fri, 12 Dec 2014 09:47:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.9.2 mx.mylinuxtime.de DFF3C241AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
	t=1418374078; bh=QMoflpB837kVnJ3vK8dbV1+D+x3pBR9XZNCBkj3rN7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G6Q2HHUTSHOft8jooZVY3ap6HGzbGBSM3zKgmK8B4PcX2/25lbMlJE142rUg75i+x
	 zjoc3cE3DV7uSXAAtuuMZ024qv+dsTGddBbMnQsbU0yqaNC8nlWb3VUtYq5Cln7cl/
	 I6Ejv4FH1rBOFYC7gBda5ImAjN9r4yUKOTJI8vDg=
In-Reply-To: <xmqqr3w5dd2c.fsf@gitster.dls.corp.google.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; x86_64-unknown-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex
 /RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261313>

--Sig_/V9ku20IhiqV3MvwG_s0evj5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> on Thu, 2014/12/11 14:41:
> Christian Hesse <mail@eworm.de> writes:
>=20
> > GnuPG 2.1 homedir looks different, so just creat it on the fly by
> > importing needed private and public keys and ownertrust.
> > This solves an issue with gnupg 2.1 running interactive pinentry when
> > old secret key is present.
> >
> > Additionally GnuPG 2.1 does not longer support RFC1991, so skip these
> > tests.
> > ---
>=20
> Needs a sign-off.

Damn... But yes, you are right. ;)

> Are older GPG implementations still happy with this new way to
> initialize their gpghome? =20

Yes, tested with gnupg 1.4.10 from Debian squeeze (6.x).
Everybody is welcome to test on her/his distribution, though. ;)

> >  t/lib-gpg.sh          |  13 ++++++++++---
> >  t/lib-gpg/ownertrust  |   4 ++++
> >  t/lib-gpg/random_seed | Bin 600 -> 0 bytes
> >  t/lib-gpg/trustdb.gpg | Bin 1360 -> 0 bytes
> >  t/t7004-tag.sh        |  14 +++++++-------
> >  5 files changed, 21 insertions(+), 10 deletions(-)
> >  create mode 100644 t/lib-gpg/ownertrust
> >  delete mode 100644 t/lib-gpg/random_seed
> >  delete mode 100644 t/lib-gpg/trustdb.gpg
>=20
> Do these trust files need to be shipped?  In other words, would it
> be insufficient to just import private-public keyrings?  I know we
> have been shipping trustdb.gpg, and I do not think it is a problem
> to ship export-ownertrust output, but as long as we are cleaning
> things up to make us compatible with both older and newer GPG,
> I thought I'd ask ;-)

Yes, we need this.
Some tests check for the trust level, e.g t7510-signed-commit.sh being one =
of
these.

> > diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> > index cd2baef..17c45ad 100755
> > --- a/t/lib-gpg.sh
> > +++ b/t/lib-gpg.sh
> > @@ -16,12 +16,19 @@ else
> >  		# Type DSA and Elgamal, size 2048 bits, no expiration
> > date. # Name and email: C O Mitter <committer@example.com>
> >  		# No password given, to enable non-interactive operation.
> > -		cp -R "$TEST_DIRECTORY"/lib-gpg ./gpghome
> > -		chmod 0700 gpghome
> > -		chmod 0600 gpghome/*
> > +		mkdir ./gpghome
> > +		chmod 0700 ./gpghome
> >  		GNUPGHOME=3D"$(pwd)/gpghome"
> >  		export GNUPGHOME
> > +		gpg --homedir "${GNUPGHOME}" --import \
> > +			"$TEST_DIRECTORY"/lib-gpg/pubring.gpg \
> > +			"$TEST_DIRECTORY"/lib-gpg/secring.gpg
> > +		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
> > +			"$TEST_DIRECTORY"/lib-gpg/ownertrust
> >  		test_set_prereq GPG
> > +		if [ -e "${GNUPGHOME}"/pubring.kbx ]; then
> > +			test_set_prereq GNUPG21
> > +		fi
>=20
> Instead of !GNUPG21 prerequisite, how about using a RFC1991
> prerequisite, which is satisfied by older GPG but not by the ones
> that lack support?  That is,
>=20
> 	...
>         test_set_prereq GPG
> 	if ! test "${GNUPGHOME}"/pubring.kbx
>         then
> 		test_set_prereq GPG_RFC1991
> 	fi
>=20
> or something.  That way, we do not have to be in a funny situation
> where we say a version of GPG satisfies GNUPG21 prereq but it in
> fact is GPG version 4.3 in the future.

Makes sense.
In addition I do check if gpg does work if --rfc1991 is given, no more
checking for keyring file.

I will reply with a new series of patches.
--=20
Best regards,
Chris

--Sig_/V9ku20IhiqV3MvwG_s0evj5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUiqu5AAoJEFTtyRYJvJGD0rIP/itwJ9bmrRWsnsAHbIkavl1E
83OTPNk736/MNieDRS4koWmDG7nK03LCHwuQnM+egWXQWFY4UA67+WSoY20bOlH+
FUcEg1QH7+vr9LP+H+JJlY0S4QqCZCbF/e5g56pxdOVs4ddsgoSvnRnIeMcBZctG
W+LC1vZ6/9O7TLOO3F7bd0A/uAlY1n/GC13PPyjR4mnH9V8a8zqOBXvhQwuBXx4a
QimoXONIjqT4ysG7/L1aUzBAYayWhIMLj8J0Gb555w+FWvLJBxwiRL39XQnBt7K1
188X2OQkWA1YE/3lQc7Ia5VFHGPnQ9iwpVuFBi7t7Res454xqgmYbqsUB9eIbMez
XGnFt1zJvLpBaJYMtJ0pNUsXAF+0ws6fjNhO4jqhRRgq4n3Mo0aMx/pDxkvz2T70
8+eMTTzraRfbdjDM7ISDNwqzYRkkoL8IIGSwy+2t5/zPrWri1rsbyOR9y93AnTxt
+PgbXDLRur+0K9IuQjgHNv9iqpTa7Z6wOX8HMXX752p6Z87Kvge0ujSQUMBnKRxK
Z/TsDVC1cym2Gli58W5kVD2oe1pFvaFZLyTnwZrTdR+5FzP7U7X5KvvZOedtGvxA
w/98QGCBs6jYY+O7PLn4b5m4eYr1vN9buAToh2VSfGJAieI7jpxGqNvDILLqiDhn
Y6EyTw9XFPWroRGOzXUa
=VYls
-----END PGP SIGNATURE-----

--Sig_/V9ku20IhiqV3MvwG_s0evj5--
