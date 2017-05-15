Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2CB9201A7
	for <e@80x24.org>; Mon, 15 May 2017 17:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755231AbdEORJf (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 13:09:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36569 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdEORJe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 13:09:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id u65so29699199wmu.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 10:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version;
        bh=v67/ugNK6VU2pGYbw9hjkjQsUPrWqi58E91Vl0+/krM=;
        b=RG3uC/XzI5Al+k6XPu9lZNGgb0/eJkQM74KR0ToNnhUXsC9Wc8PLnnaMrcwFYhj/yi
         9lJ/8HRChtxwMvmUScd+5Qa3ccPNnpAlPJ+ya2T+fLa+NzfL2Otk5vM8Qz87lSEiUkYo
         u+d0oN8zOZIC56hM22740piui0Ia/Tbniz4YbkiOdQizwz5F2BCqQz/09rVLR0wTbv2I
         vdrpCrPoCry+74M+Qtid7I3xhq8saGb+5YoM1Xox73GQdrQszJfSoqEB7m8jr92aHIIp
         rEtyNUSazLnL+LIRESHJUZtVQ+uG6RUoL/hCnDFLhpkK5RSU5Pb6IIZWZHJr0oh1Dg/x
         TZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version;
        bh=v67/ugNK6VU2pGYbw9hjkjQsUPrWqi58E91Vl0+/krM=;
        b=TSPd7ALh3jx3hQbs3u0bG5KpYWBx+fW0mzXood5JISBN4ubg7xv+rHUbWsUiqrp6Lh
         1j57CuXgn9ggKD3LNS8ArohvO2ClY1/fXt+ljzXOVe+Cc7IuRZwlmm0LmUpGrSAfCR5d
         X0cJF2uyZuQ+EsFWOt52JwIMzwH599i+876hAQhQdIPeFI4KvNaILJw1gisYGP9lnYmw
         oqYZGZxdAzCZike6Ks+1hlw+EDYyvNkJiboBlatZK1Pv8AnWlsAZi2pYiZwPZajAJaSA
         7q1cTgADdFJk8MlaJpOqqtTe24rspSxyy4SFEqPMeEKNRhGB6WzJWnB2vTiK9V6MHbhS
         6x9A==
X-Gm-Message-State: AODbwcAtshrdSuSEvpqR/0mwBlhcW2/Mg0LMHjsX9dry3DD8QpxDalTx
        N1snJpu/BDLT1Ya7lys=
X-Received: by 10.28.144.15 with SMTP id s15mr4280802wmd.137.1494868172496;
        Mon, 15 May 2017 10:09:32 -0700 (PDT)
Received: from [192.168.0.164] ([37.120.55.59])
        by smtp.gmail.com with ESMTPSA id c37sm12210372wra.16.2017.05.15.10.09.31
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2017 10:09:31 -0700 (PDT)
To:     git@vger.kernel.org
From:   Mihails Strasuns <mihails.strasuns@gmail.com>
Subject: Is it possible to use new conditional includes outside of git dir?
Message-ID: <b18ddd8e-5772-6351-6e49-78c1372077f1@gmail.com>
Date:   Mon, 15 May 2017 20:09:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="U6N56lFbKBGRe5391dECeWru8Vfr9KU3b"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U6N56lFbKBGRe5391dECeWru8Vfr9KU3b
Content-Type: multipart/mixed; boundary="8wGumsBB2LUt84rWm5xTRlJkj7s6EU2jK";
 protected-headers="v1"
From: Mihails Strasuns <mihails.strasuns@gmail.com>
To: git@vger.kernel.org
Message-ID: <b18ddd8e-5772-6351-6e49-78c1372077f1@gmail.com>
Subject: Is it possible to use new conditional includes outside of git dir?

--8wGumsBB2LUt84rWm5xTRlJkj7s6EU2jK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hello,

I was very excited to try out new conditional include feature but have
quickly found out that it doesn't work with some of my custom scripts
because of the following behaviour:

# .gitconfig
[includeIf "gitdir:~/work/"]
path =3D ~/.gitconfig.work
[user]
name1 =3D Someone

# .gitconfig.work
[user]
name2 =3D SomeoneElse
$ cd ~/work; git config user.name1 # "Someone"
$ cd ~/work ; git config user.name2 # <nothing>

I see that it matches current `git config` documentation - indeed, it
mentions only matching on git directory and not arbitrary file path. I
wonder though, if this limitation is intentional and what is the
rationale behind it?

Thank you,
Michael


--8wGumsBB2LUt84rWm5xTRlJkj7s6EU2jK--

--U6N56lFbKBGRe5391dECeWru8Vfr9KU3b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFPBAEBCAA5FiEEcdkabkQjfDM/yGOXratW3TZssTUFAlkZ7tkbHG1paGFpbHMu
c3RyYXN1bnNAZ21haWwuY29tAAoJEK2rVt02bLE1BnkIAKdW7yj17nvNDH5lAlAQ
/eyU8bKqXXdKxm/9lwlhRd4IZEzLcMvRcnV+SNKNo+93oBgISUJmeHPb8GOEX++J
iQv8DcrAKnSngVQU14Rn0QX8t+aTadbzYvalTYegQnRvut0t1kFqcTEWCwCH4oBO
+NZbecjXw6N1JUBgeFn2d78ei3gaakSCQG0C7kF8zWP9L4rALbWbF1arDk0A4aqi
nPew+ZD1O+hgrrecJ/2DCK7i65Xucy56XxOoJdTapzXfbabRT1dXbEJrRBeKV3F3
C8dW3oQ+0gy7Qm+0w86e7XoJCLgyWvypEHYKb/eOGV+lOoqdFXqI2E+79TOBZJkt
oUo=
=Ug/a
-----END PGP SIGNATURE-----

--U6N56lFbKBGRe5391dECeWru8Vfr9KU3b--
