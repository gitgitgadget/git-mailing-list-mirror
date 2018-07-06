Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF0611F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 20:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933061AbeGFUUD (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 16:20:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52912 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932328AbeGFUUC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jul 2018 16:20:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:294b:af98:ff6d:ed6])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3FBA960431;
        Fri,  6 Jul 2018 20:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1530908400;
        bh=r1DzzpgureVtdAXVjc9Q0i8jdCgDvxRzoZWbiIZqoqk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HK2Z2Cj5Yzrlux8VevG0elw/nfVr9Yzbiu+7zzhy2c74N+CzNs8kKFp4XN1OUgl1d
         voSMdBkRx4AqxUlpfW3+a1P3P5CWOnR59wXmWxmQGQL1zPGGNooBAMrct38+KXbA1j
         Tq0qZ80yE4p4+nU9/qWJgu3hTNh5ZwA+ch6CujuC/QQeqqfxkf5u/H44l/eloaz+VO
         Zk8r4YVf5e8698YNJ/ugp+CvVAmYYQ54Znz58nOoamshNmnSX9wkDT8KRGlGCKoJOw
         dxpmY+C/89TCkHogKsfg5DL6xbSlL+BoGkGL7oKTz/KaOlG6wBZWwM5fLOaQ5yeZv6
         KudtfbO9hjDj5hXaqPpxw1CBNrWQ9xcJTMY4+K7VjFd5GWbREHKjfhbNUbFg5yZ33M
         EcGtyfdCGCdV/rQBzo6SvcaAcBZrZZYw0VFnOftUAoyUozbdUiGwCE+856TGgltgHi
         AiE7E1tsJcFJMJKnSQO3aM4Ui2kUy2IW7f0QP71U0EO04ZLp8ut
Date:   Fri, 6 Jul 2018 20:19:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, sir@cmpwn.com
Subject: Re: [PATCH 1/3] send-email: add an auto option for transfer encoding
Message-ID: <20180706201955.GG7697@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, sir@cmpwn.com
References: <20180706022357.739657-1-sandals@crustytoothpaste.net>
 <20180706022357.739657-2-sandals@crustytoothpaste.net>
 <CAPig+cR7tWw7D8JMg1a9G2Jgi=HQj3YZjCn+tHDNjDEsrfSLqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
Content-Disposition: inline
In-Reply-To: <CAPig+cR7tWw7D8JMg1a9G2Jgi=HQj3YZjCn+tHDNjDEsrfSLqg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 06, 2018 at 02:01:25AM -0400, Eric Sunshine wrote:
> On Thu, Jul 5, 2018 at 10:24 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > For most patches, using a transfer encoding of 8bit provides good
> > compatibility with most servers and makes it as easy as possible to view
> > patches.  However, there are some patches for which 8bit is not a valid
> > encoding: RFC 5321 specifies that a message must not have lines
> > exceeding 998 octets.
> >
> > Add a transfer encoding value, auto, which indicates that a patch should
> > use 8bit where allowed and quoted-printable otherwise.  Choose
> > quoted-printable instead of base64, since base64-encoded plain text is
> > treated as suspicious by some spam filters.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > @@ -1852,13 +1851,16 @@ sub apply_transfer_encoding {
> > +       $to =3D ($message =3D~ /.{999,}/) ? 'quoted-printable' :'8bit'
> > +               if $to eq 'auto';
>=20
> Style: space after colon: 'quoted-printable' : '8bit'

Will fix.

> > diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> > +test_expect_success $PREREQ 'long lines with auto encoding are quoted-=
printable' '
> > +       clean_fake_sendmail &&
> > +       git send-email \
> > +               --from=3D"Example <nobody@example.com>" \
> > +               --to=3Dnobody@example.com \
> > +               --smtp-server=3D"$(pwd)/fake.sendmail" \
> > +               --transfer-encoding=3Dauto \
> > +               --no-validate \
> > +               longline.patch \
> > +               2>errors &&
>=20
> Why capture stderr to a file then ignore the file?

Copy-paste error from an earlier test.  Will fix.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAls/zusACgkQv1NdgR9S
9otlCQ//bgYang/poal6XYX9zxjfzuNyk5NFShRTERUSVrzweTs2BXrLC5+UaET4
2gOiGH/X5FS3ceuuSRgKyL6XZ3TaGcONBCF9bmtR12K9kleHWcqLNGo9ngEodyeP
gIPfsK0GV38iL4vCYYEsvJq3Q+54G7dBWObhh8fQAxmCmpYDKh7awytDLR6M6Ok8
7LIdU9VpsTr9yu2Dhz0uSC+xtrdsrVz81Xj4ucgvPNBkYtQA39S8He96HsxvLIlE
FIkg7GgUgP0Lqf3PP47GOnombBgYioCzenjV7u2KOJYXeV8noRU4AAU1SifYwjy8
oS88PhRqXY8S4RCbn9K/KFVu8SYB3uNc9UhL5Rkdq80i+ZUtNE2K5AzGAOonSRb1
gCnDZl6ax+VgmVoMWBUObcHShjJQ+I8bxnjOdLFQ5t666OQnBvfhZfJgaQmNwXRX
GLeT/nqO9sylK/64ZBAAodQ5rH8JJWQx1Qlfc9uW2+6S72TJb66BV3hMuz7Igm76
0Axp2VEU1YpvoQQry+sJ+g08JcIcbZmdjIWpvSYE34rdMzAAIV9IpYq6q0uzfwAR
2TewZU9Lg7OXIYIMtGyD/CsDxj7UDOb7LhAhyB1HCA8dfGDGXL0bnzXUfuTSX/gI
KobVDCch9W0fYT9UrEIKcCpCitd6A81X8lV0BYAo7BMvgK7bXrc=
=woTz
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--
