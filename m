Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B431F453
	for <e@80x24.org>; Tue, 12 Feb 2019 23:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfBLXg4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 18:36:56 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34472 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727871AbfBLXg4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Feb 2019 18:36:56 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C370560443;
        Tue, 12 Feb 2019 23:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550014614;
        bh=QySKpX70EjhCgN977nk6Kk8B1/BKY2Zft8js9Sj6sv4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cOOFFvJiydYkfW9IEMsuMzHk9cXFNZkRxtTXAKuT8j0nsd/b+TC3B8i/mnCNdtqc2
         KH7VmFT2SJdm19wd64aIKMkj2zQdV8Dy6UgeAKKZXpvM0szsYF7U5PHqiYmInrdGdg
         D2smuGpukIq8o+xOpnA81ZVnuCI589FiiBGEqk4BhPpObPOuJn+VLP6CvC6W9DY7dK
         hELluLH1Uh9NDRCFM7LQXqcOU84mUUF1RlvvU1dGaE1EAOXguGg46r9BoegIKOraIV
         T98r0iwHxOfRK6EVKHqO/Bj8JP+kf0PRaecMW8N8gueMvVZWdUogRi/BSADo4q3D8l
         Msa/gGG9hnX7+ixBqgOJ3QATSFzBFttAdXYnVpEjq4HT7WQHf2I5uKwRWxKO56xWnK
         YQ0/dulDVOAPuz9nqdfTxza6/rraUzrjCP8RzCMFn+PpJ3e0sKZHjzXW7FxRs/wsMW
         wX4d7xxc4e8xmIiOfiVgIwvZDp7vIaFaY2PY//ySwGB4haBtMM7
Date:   Tue, 12 Feb 2019 23:36:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 12/31] fast-import: make hash-size independent
Message-ID: <20190212233648.GF684736@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
 <20190212012256.1005924-13-sandals@crustytoothpaste.net>
 <CAPig+cQivuPjDztK30QO0xKx1Tx+nYDPzTvgXvi9WVyRX5-aRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Content-Disposition: inline
In-Reply-To: <CAPig+cQivuPjDztK30QO0xKx1Tx+nYDPzTvgXvi9WVyRX5-aRQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 10:44:12PM -0500, Eric Sunshine wrote:
> On Mon, Feb 11, 2019 at 8:23 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Replace several uses of GIT_SHA1_HEXSZ and 40-based constants with
> > references to the_hash_algo.  Update the note handling code here to
> > compute path sizes based on GIT_MAX_RAWSZ as well.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > diff --git a/fast-import.c b/fast-import.c
> > @@ -2047,7 +2047,8 @@ static uintmax_t do_change_note_fanout(
> > -       char realpath[60];
> > +       char realpath[GIT_MAX_RAWSZ * 3];
>=20
> I wonder if the fixed multiplier deserves a comment explaining that
> this is reserving enough space for a hex representation with '/'
> between each digit pair plus NUL. Which leads to the next question: Is
> there is GIT_MAX_HEXSZ constant? If so, this might be more clearly
> represented (or not) by taking advantage of that value.

There is such a constant. I'll add a comment and see if I can write it
in a way that makes it more intuitive what we're computing.

> Also, there are a number of hardcoded 60's in the code earlier in this
> file, such as:
>=20
>     if ((max_packsize && (pack_size + 60 + len) > max_packsize)
>         || (pack_size + 60 + len) < pack_size)
>         cycle_packfile();
>=20
> Is that just a coincidence or is it related to the 60 characters
> allocated for 'realpath'?

That's an interesting question. It looks like these are indeed related
to the hash size, but they're not related to the realpath call above.
I'll convert them as well.

> > @@ -2405,7 +2406,7 @@ static void note_change_n(const char *p, struct b=
ranch *b, unsigned char *old_fa
> >                 char *buf =3D read_object_with_reference(&commit_oid,
> >                                                        commit_type, &si=
ze,
> >                                                        &commit_oid);
> > -               if (!buf || size < 46)
> > +               if (!buf || size < the_hash_algo->hexsz)
>=20
> What exactly did the 46 represent and how does it relate to 'hexsz'?
> Stated differently, why didn't this become:
>=20
>     the_hash_algo->hexsz + 6'
>=20
> ?

Good catch. I believe that 46 is the number of bytes in "tree %s\n",
which is the smallest possible commit (a root commit without an author
or committer).

I'll fix this misconversion.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxjWJAACgkQv1NdgR9S
9otWaA//VhwyJhAIMCpYD+IRYZ/FR07eEf/TsGGfgnRRCt/1eGuL38ARJj480NdD
oCuwwJUjg962Jh4HoIpI/1CBcf53qkZu1fTbQ4EHPizQB4ju+Psk+mK2Z4/rDA9Q
Ef+qxqzpFmbRdJhxNAJZu6mVso6UIyI8sU0GvGe20+1LO+x87RjhCEvKcq0kx++R
dw83kmvUShHNWSWJzUEXFuXFkEu4fGPwdsM+CQ1fueJLHDW4gL+uAsdg6MlS0FYb
WiMgMT62agOGkMrs1+S8tj4pxE51dOixZb1qzuw2TAOymdhoh0Vn5K5pbFEZZNGp
JXdv4rq59Z3+8Wo1k8L7Xio0aA8rQ6KOntcXO4lR51WpIszmwueWSduR0Q3aBYaw
sHJmBDh+Ydvyu5dvquBChNi+pYUTP8tDKRCar0Erl6VueUikkm/IQeT+UNaJjb3j
MYmjwh+7iWApq1+bCQLiCrL8mrkvV46qwFE/E8+WxIfNvob9jm1W2UsICZ0KJNlc
GR/YDbofaYtdWFrLVZWbY/fAIiOQczFLGiFvsaxP4ODD+h82xT99iFWTGy8DL1sI
5/GHWlDuxxnn+SRv1+CT/7XFW7krQi1IktXy18O23eFHZ/FFkhGXRJ9e+n5821hX
S7CyNsGCWDTOS4rZfFWfOMHUFntlhtU8NvAzLDf2ah3qEM9vjyA=
=++ks
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
