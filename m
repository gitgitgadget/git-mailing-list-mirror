Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72CE01FC44
	for <e@80x24.org>; Tue,  9 May 2017 00:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbdEIAhW (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 20:37:22 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38536 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751243AbdEIAhV (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 May 2017 20:37:21 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id ACE8C280AD;
        Tue,  9 May 2017 00:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494290240;
        bh=KitOD5b90ethfQHchZni1c39jw5I+m38WT9wdP+cNFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FnYeKnavuFMpYmukUhX472vM4T0kRxMV83QdNwaoxhUGQMLvHgxiKfah9kOiMhTQ4
         6LkaYVn+1WTvAvkEFtSbKE6zUjVe8UbrvJz2xlUuT7Yd0cAqv7dv0FfoETeMZ0K3EU
         4vrGNxm6xbE4iXn/XZJNjfc+nk4/vGaz8D4XDNXFw2XRcbu04+XfHtvn0D+t68B8Ap
         yUIYWWPe04avbY1+wBsdks335T91qs7FzmK+g2bXDCT6BiWxvEkBigstivtConVXgn
         w2TORsjEfM7lzsoYy+REsZUyn2bo0R8ysSWMdGAK2kI6BBldN0VNOMfSb/XTelM6Fx
         KsRgQVpXHsqz3c4J5i0tb1ZpHi2van7559knJiAsIglcBrmFWZAqr8d97ob98uhvmb
         6f5OZvJ32x8kq+R/eMWuz6UoaUmyxqi7KOi61FXFn1aQrcfjxw5AocxMotcioJbXun
         re3xDVRsp9Tp5SwnvUvDc4ToNuDkuOfhUgfj5Ug5KeE1226WO1i
Date:   Tue, 9 May 2017 00:37:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
Message-ID: <20170509003714.ylwn5ezvu5h36kj7@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
 <alpine.DEB.2.20.1705031139090.3480@virtualbox>
 <CACBZZX6_5krLp93PmsW639-N4f1efUT5rPnN+5im=d9-66=QbQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041104070.4905@virtualbox>
 <CACBZZX5bPN3vZhE=0TSQNdRvKYuV3635=VCQAppAfcZ_tuGpvg@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041328190.4905@virtualbox>
 <CACBZZX75nvfQft-gjUG+YP0Y-e-=Knm3bMeDWHSUF=Juz9Ua5Q@mail.gmail.com>
 <xmqqpofj7rim.fsf@gitster.mtv.corp.google.com>
 <20170508233224.udpuuzlygjpsjogt@genre.crustytoothpaste.net>
 <CACBZZX4G_ThE55Gi53QJt1=9K4jQXqJ3QL8JSGpiSSSDRrKeNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mucbvnyvql3d42cl"
Content-Disposition: inline
In-Reply-To: <CACBZZX4G_ThE55Gi53QJt1=9K4jQXqJ3QL8JSGpiSSSDRrKeNA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mucbvnyvql3d42cl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 02:00:18AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> On Tue, May 9, 2017 at 1:32 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > PCRE and PCRE2 also tend to have a lot of security updates, so I would
> > prefer if we didn't import them into the tree.  It is far better for
> > users to use their distro's packages for PCRE, as it means they get
> > automatic security updates even if they're using an old Git.
> >
> > We shouldn't consider shipping anything with a remotely frequent history
> > of security updates in our tree, since people very frequently run old or
> > ancient versions of Git.
>=20
> I'm aware of its security record[1], but I wonder what threat model
> you have in mind here. I'm not aware of any parts of git (except maybe
> gitweb?) where we take regexes from untrusted sources.
>=20
> I.e. yes there have been DoS's & even some overflow bugs leading code
> execution in PCRE, but in the context of powering git-grep & git-log
> with PCRE this falls into the "stop hitting yourself" category.

Just because you don't drive Git with untrusted regexes doesn't mean
other people don't.  It's not a good idea to require a stronger security
model than we absolutely have to, since people can and will violate it.
Think how devastating Shellshock was even though technically nobody
should provide insecure environment variables to the shell.

And, yes, gitweb does in fact call git grep.  That means that git grep
must in fact be secure against untrusted regexes, or you have a remote
code execution vulnerability.

Furthermore, at work we distribute Git with all releases of our product.
We normally only do non-security updates to the last couple of releases,
but we provide security updates to all supported versions.  I'm not
comfortable shipping the entirety of PCRE or PCRE2 to customers without
providing security updates, so you're going to make my job (and my
coworkers') a lot harder by shipping it.  Please don't.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--mucbvnyvql3d42cl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.20 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkRDzoACgkQv1NdgR9S
9otiQBAAoEBDUkvfKkqIqXakc8wQS1x1u+LHoZUnkb9jFKtJdC/FA6crqw6y1hP1
vraHfZj1YdX17zxTdo/jyy4EH+lgqlFOhKnCKOPDhwY0eSDeYvUiiUZ5Zo+muKIW
G+zRlfB3ILZbvZQtgc/ZOHD2FQ4gT9wtjh99RHlfBdlxOoaZqc0yRtw0mdPf++S6
jE5DzaIFmCiS38pOPVJu1HZoFMgJ6LK9deEi72HbkvSv4q7IBHONJcgER3GEiiCB
d9FIH8tPjrAjik7XVpA1xh0Pnfoag9ytCW2fcLaqZ69r/Obzn+nqi8wobtffpKV9
yD8DiGlldYCqIk3vNTE2Tu9gnqd9u+rsJPRv7+psRP3L46k3SNHhyIQqhpMlVC4F
VXVgwOAvizExM0qPfK3UVzLL8SX+Sj6EVpR9QiJGVsmg+h/EtvHDD5EJT+Ao0UR0
63DrPRlazjAxf2yC+n0AMF5QJ8MdZS6vzH4kZTYMgk+h/yENEI0x+mAKZRpLSWAs
xT0MeeQOYxTDU7hHkOYK4Qi8koFDPBhPU4q677kpev4jBtYFYLZwC8TyGotkGFBc
UZEQZd8ScezvpPtl07KL7SoRgjBb6wZMD2cTI6J4ZexIZOTszuFuJrAppq+5kIfg
AZYm7vRlebTvIfRjkv1zQON+p7fTRtdwqieBNBjFjUE9qi/5W8s=
=iEAl
-----END PGP SIGNATURE-----

--mucbvnyvql3d42cl--
