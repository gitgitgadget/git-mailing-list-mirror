Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5C4EE4993
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 09:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjHVJER (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 05:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjHVJEO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 05:04:14 -0400
X-Greylist: delayed 45556 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 02:04:11 PDT
Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [IPv6:2a01:4f8:10b:ddb::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71F9113
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 02:04:11 -0700 (PDT)
Received: from leda.eworm.net (unknown [194.36.25.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 35E7B22DD18;
        Tue, 22 Aug 2023 11:04:10 +0200 (CEST)
Date:   Tue, 22 Aug 2023 11:04:04 +0200
From:   Christian Hesse <list@eworm.de>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] t6300: fix match with insecure memory
Message-ID: <20230822110404.1c002dcf@leda.eworm.net>
In-Reply-To: <ZORpucPcjzm-dhjP@five231003>
References: <20230821202606.49067-1-list@eworm.de>
        <ZORpucPcjzm-dhjP@five231003>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k7V.RFpgJG9gllYwbFik=bF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/k7V.RFpgJG9gllYwbFik=bF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Kousik Sanagavarapu <five231003@gmail.com> on Tue, 2023/08/22 13:24:
> Christian Hesse <list@eworm.de> wrote:
>=20
> > From: Christian Hesse <mail@eworm.de>
> >=20
> > Running the tests in a build environment makes gnupg print a warning:
> >=20
> > gpg: Warning: using insecure memory!
> >
> > This warning breaks the match, as `head` misses one line. Let's strip
> > the line, make `head` return what is expected and fix the match.
> >
> > Signed-off-by: Christian Hesse <mail@eworm.de> =20
>=20
> I think a bit of an explanation about why this warning is showing up in t=
he
> commit message would be good.
>=20
> "man gpg" gives me <stripped>
>=20
> So it seems that this warning will pop up if gpg is writing memory pages =
to
> disk which is bad because as stated above we don't want these pages writt=
en
> to disk which is a security risk.

The Arch Linux packages are built inside a clean container, started via
systemd-nspawn. Within the container the system call @memlock is not allowed
by default, for security reasons. There's an upstream systemd issue on this
topic:

https://github.com/systemd/systemd/issues/9414

Note this is only true at build time. If the packages are installed on the
actual system the @memlock system call is available and things work as
expected without issues.

> > ---
> >  t/t6300-for-each-ref.sh | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> > index 5b434ab451..0f9981798e 100755
> > --- a/t/t6300-for-each-ref.sh
> > +++ b/t/t6300-for-each-ref.sh
> > @@ -1764,12 +1764,13 @@ test_expect_success GPGSSH 'setup for signature
> > atom using ssh' '=20
> >  test_expect_success GPG2 'bare signature atom' '
> >  	git verify-commit first-signed 2>out.raw &&
> > -	grep -Ev "checking the trustdb|PGP trust model" out.raw >out &&
> > +	grep -Ev "checking the trustdb|PGP trust model|using insecure
> > memory" out.raw >out && head -3 out >expect &&
> >  	tail -1 out >>expect &&
> >  	echo  >>expect &&
> >  	git for-each-ref refs/tags/first-signed \
> > -		--format=3D"%(signature)" >actual &&
> > +		--format=3D"%(signature)" >out.raw &&
> > +	grep -Ev "using insecure memory" out.raw >actual &&
> >  	test_cmp expect actual
> >  '
> > =20
> > --=20
> > 2.41.0 =20
>=20
> We skip "checking the trustdb" and "PGP trust model" lines (which are not
> warnings) here because we don't really need those from the output that GPG
> produces here but skipping a warning too seems kind of a question mark.
>
> It also seems that one could use "--no-secmem-warning" to suppress such a
> warning. So a better place to make a change would not be in t/t6300 but in
> t/lib-gpg from where the prereq GPG2 comes from. Although I'm against thi=
s,
> because we don't really want to suppress any warnings.
>
> I think it is a good thing this test is breaking because it informs us ab=
out
> the security risk. I have Cc'ed people who might have a thought on this. =
So
> it's better to wait for their response.

Well, after all I just want to change the tests to succeed with our build
environment, let's take a detailed look at the issue. All command below are
inside the build environment, so including the warning about insecure memor=
y.

The output of `git verify-commit first-signed` is:

---- >8 ----
gpg: Warning: using insecure memory!
gpg: Signature made Tue Aug 22 08:46:43 2023 UTC
gpg:                using DSA key 73D758744BE721698EC54E8713B6F51ECDDE430D
gpg:                issuer "committer@example.com"
gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
gpg: Good signature from "C O Mitter <committer@example.com>" [ultimate]
---- >8 ----

Whereas `git for-each-ref refs/tags/first-signed --format=3D"%(signature)"`
gives:

---- >8 ----
gpg: Warning: using insecure memory!
gpg: Signature made Tue Aug 22 08:46:43 2023 UTC
gpg:                using DSA key 73D758744BE721698EC54E8713B6F51ECDDE430D
gpg:                issuer "committer@example.com"
gpg: Good signature from "C O Mitter <committer@example.com>" [ultimate]

---- >8 ----

Running `head -3` on first output causes the warning to be included, but
the issuer line to be removed. That is what finally differs between `expect`
and `actual`.

Just changing the number of lines brings other issues I guess... As far as I
known the output on issuer was added recently with a gnupg release.

So we need a set of commands to bring the output of both command in line,
with or without warning on insecure memory.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/k7V.RFpgJG9gllYwbFik=bF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAmTkegQACgkQiUUh18yA
9HZZOAf+JzOUIUjuGDL+fFf4smHL9H5ooLfZ41j1ErBy3H50JcSS/AR0kuPEn4AX
kly3EQQScIvOgEVlpEK6aRiy629SgA34FIj8GdIyy3Lpe1tVL1OcFxrQH9kfTX9k
UkJfp4MAyYMVwKBaUfOAbhi53VMszrM/vAZyyJ7CCK9F1liJlgv4NceSNiikb1R9
Uf22e6O8tPc8yonrMfagiyJdZbY6dSOxiQOD7g5KimGOWnNVT+PoC66TJyRkbn0g
7BHrxqjs3g+NmFi3FZ9la83C+scj7ffZqe2acWBNnOSX1sZGKc1A4y6BIa+xGgrl
y2BrVzuRuUSF0IHPRQQT8mmkYDy/Qw==
=xyEO
-----END PGP SIGNATURE-----

--Sig_/k7V.RFpgJG9gllYwbFik=bF--
