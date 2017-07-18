Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E077020387
	for <e@80x24.org>; Tue, 18 Jul 2017 21:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbdGRVQy (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 17:16:54 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33654 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbdGRVQx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 17:16:53 -0400
Received: by mail-qk0-f175.google.com with SMTP id p126so21906480qkf.0
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fQAMqR2IVBS/RN3mcZpBJzL70xZ8yC+pBIM8a3H8j6g=;
        b=ZHJNTWJZ/XrnxlzrXzfR6ifz9Bb0LhLJop1BwPBzSHTbMdsC9lLeY8GbK4xRK1FtlA
         6bJGsoQmjw8/sRWf2Lsot/cf+ZKmz5x7Gq3P3LcNf0LRUsg9Jt7uH8f5Nrwr4hVKj3Cc
         mNiDd1GsbFoaTj+HAdQE+PLGkn6Ymqx9AXmc8+Q/1keLAdIyqGA8PTCJ6tDxKe9vJvV5
         wJ6MlU+ircRodx9sYWSp/ygaI5WCf1kWzvQhozlGbwS76w/4pQpANEnTsl4t5Jvd9Nke
         PgcP0fwGq8ekE84eMKENg13cIxwMoAkKE0T4fiFXwwYynVYAU+kzlQU+9xKfHphFa3lz
         QNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fQAMqR2IVBS/RN3mcZpBJzL70xZ8yC+pBIM8a3H8j6g=;
        b=aro3fwJwGv3pcFPG5LorcUJB8aTTYDWd/4Fm+k3PL0uunf9Til0lz8zdtSVOt6NvIq
         WTGE8GJC7y/zp0+lgdrlHfAnZxFmgdkWbfh/MQSd7aNYYmTgsZpk0AuhBm/5DRHME4wW
         0YM52S5YezfuUtCyqXHxxgxSuXHjoNmLATr7mnUjvdIxSp934qdX62y+1Kcua3/S0Tgv
         2A1QOWED6+OSHoGaZ93KYfKen3dj/Au9Nykmr720S42KgwcuOffrlWz9vU/yrtLGylNW
         kB9Kxr90pDsnTRa/vZ3V6ZDHPcTbincs6WuSH8dH4WNjWrsMlhEh0UZ2YZS+iihlzDvj
         6FCg==
X-Gm-Message-State: AIVw113loTcs6YhsbhJ4eKnas2Agp7jVQBFcP3QwrUpJJ3EVOQ/wEm6v
        SPGodoSqg2W9mTbt
X-Received: by 10.55.50.208 with SMTP id y199mr4682492qky.174.1500412613040;
        Tue, 18 Jul 2017 14:16:53 -0700 (PDT)
Received: from LykOS.localdomain (ENG-KCG295-01.ENGINEERING.NYU.EDU. [216.165.113.136])
        by smtp.gmail.com with ESMTPSA id d44sm2541980qta.55.2017.07.18.14.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jul 2017 14:16:52 -0700 (PDT)
Date:   Tue, 18 Jul 2017 17:16:52 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #04; Thu, 13)
Message-ID: <20170718211651.rcnbkhcwem4sbcb5@LykOS.localdomain>
References: <xmqqo9snsy0k.fsf@gitster.mtv.corp.google.com>
 <20170714002754.jyck5qmykbmuado7@LykOS.localdomain>
 <xmqqfudzsq7u.fsf@gitster.mtv.corp.google.com>
 <20170714140241.mqg5256ml3grmrn6@LykOS.localdomain>
 <xmqqwp7bqbvg.fsf@gitster.mtv.corp.google.com>
 <20170717214241.yui75hywg2ddkfsb@LykOS.localdomain>
 <xmqqmv82g1g7.fsf@gitster.mtv.corp.google.com>
 <20170718175458.hadk64c3yccyv57t@LykOS.localdomain>
 <xmqqeftdpor5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qn746mhx42sl72kv"
Content-Disposition: inline
In-Reply-To: <xmqqeftdpor5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qn746mhx42sl72kv
Content-Type: multipart/mixed; boundary="bzdxwi5mceum5yvh"
Content-Disposition: inline


--bzdxwi5mceum5yvh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Oh, wait, I can run "gpg" just fine, but I do not seem to have
> gpgconf.
>=20
> 	$ type gpgconf
> 	bash: type: gpgconf: not found
>=20
> The patch may need a bit more cross-version work, it seems.

Right, sorry about that.=20

I was testing against Debian Stretch/Arch, who do ship gpg2 with
gpgconf. It seems Debian oldstable and other variants still ship gpg1,
which doesn't have it. Would it make sense to have a fallthrough branch
on the switch statement for gpg2.1 instead? something like the attached pat=
ch.

Thanks,
-Santiago.

--bzdxwi5mceum5yvh
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-t-lib-gpg-flush-gpg-agent-on-startup.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 07ab87c1ddb31197a3a5c124ad5a2462a460d4e3 Mon Sep 17 00:00:00 2001
=46rom: Santiago Torres <santiago@nyu.edu>
Date: Tue, 18 Jul 2017 13:16:11 -0400
Subject: [RFC/PATCH] t: lib-gpg: flush gpg agent on startup

When running gpg-relevant tests, a gpg-daemon is spawned for each
GNUPGHOME used. This daemon may stay running after the test and cache
file descriptors for the trash directories, even after the trash
directory is removed. This leads to ENOENT errors when attempting to
create files if tests are run multiple times.

Add a cleanup script to force flushing the gpg-agent for that GNUPGHOME
(if any) before setting up the GPG relevant-environment.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 t/lib-gpg.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index ec2aa8f68..ffb20a438 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -10,6 +10,8 @@ then
 	'gpg (GnuPG) 1.0.6'*)
 		say "Your version of gpg (1.0.6) is too buggy for testing"
 		;;
+	'gpg (GnuPG) 2.1'*)
+		GNUPGHOME=3D"$(pwd)/gpghome" gpgconf --kill all ;&
 	*)
 		# Available key info:
 		# * Type DSA and Elgamal, size 2048 bits, no expiration date,
--=20
2.13.3


--bzdxwi5mceum5yvh--

--qn746mhx42sl72kv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlluesMACgkQRo8SLOgW
IpXhNBAA2nt+R1Vj06xWhJS4qMW92nL4nYlj7sC8AUCovPy/qmTXGI+p08VdF7Q1
sVyCMtHmvWMc8OKaU7W+rrzZfOSIcbs2aUC+6qdMRGFxzY1WgGZP2bbp9WqIQ1wY
cfBoIb7shaFmR4gJNhsP8pqU0zp3paGfpOlRsKwIcWkvxIlmGi/HgmDgr9E6lviY
8VZOheofpJ3nXj5CBKToGVmii8kkWJMH2GFX2CgRPMl7Dc4e0owMfWZsfLEdR6iU
IigyQWl7EaIbd1I+lmO3Y3NDHhjEGuBCJTbMc1TXpHzXLJcEAkMNp6oJK14yu0u0
juw8cijwzli75V//+7JDT8BGnquR6lzMLa/oRBDViR3puYy6DZAX5xOAj+fngjaW
rMYwluaNkbFaHXx0naav5iApxCu9OwQHv2dIWiz73xGlhC30LTAuJcomnMwgtHZm
M0bOPiRy0me0hihXp8jxmab7mMMmj0reIvJHMXXsV7PRfmqmTwI3ByW1VRgRgVJa
DYo2NeKV4xY+fQzeTH0rsy7tLXiFsty3cOo3IIoCF91hJMoBDEBr3Gv/pE+2Q7as
i4y6wmKfBHDvigDRNqlAJiDCjU7mXxi6jwostauuwwALVyVzfCF9DcbtbbjGkJzB
1/BNw+QcrVSYL3LJJ3zvjbofQrwoGbGPCgVEHtIooJQ/QT9t1o0=
=AqOi
-----END PGP SIGNATURE-----

--qn746mhx42sl72kv--
