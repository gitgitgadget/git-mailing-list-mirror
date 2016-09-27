Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61CA920986
	for <e@80x24.org>; Tue, 27 Sep 2016 14:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933380AbcI0Oib (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 10:38:31 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35654 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933202AbcI0Oi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 10:38:29 -0400
Received: by mail-qt0-f194.google.com with SMTP id 38so453169qte.2
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wXBLBwYxBwuayRaRqYh2t5M0pAyoXMINUrbp+CggbBg=;
        b=ulg/fy2HBQQSsuEwK0yn5hbnqd1SUzRS+eBRdu7eDC5aL4ELrRjwAdvhKhbQbsmLN7
         TSjukq38sCZEwCtvos7SFA/iDvOGpqfEDmf4Gl+B7m+2eYl0kASAxDBkq1GjbuHsckRV
         neHzpPo0z0j0/3n0ktsMGo/Duffyj/pv7WHttPwDKBeddioo91/3/Wmg5VBLQmcHjeMQ
         Z1SqrkAa6GIiTXnItfxJuVgWqeipNxKcbYVjcK7k9xtADvVuLgCFcCDYQM/H4YSB8zQW
         Ru3yCMcmdU5PtAZ+VA8ZDWVc+Db9EBhdf/wyfjOvS7WIJq+PQK1UZXijKJXsmbqFxU9D
         Jwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wXBLBwYxBwuayRaRqYh2t5M0pAyoXMINUrbp+CggbBg=;
        b=UPPwvx6YA95HZrqMbIRccdFKWODpBgZqe8GvCdIJo1X2OofTy0kBP1ZBtXfl+gB+tn
         +q6PN1/lX52OlwTmaU8rl+PcvKD+JKoF2ACjvIaLOOD4vbTtFj8nOiVXMtRExDSVbkdR
         L/MA66LlI8p6bYfJNnn1izwBpkqMmz/SQcIoMYZ2hs9wL0+84sUagDnpPTqPL0db6GNW
         gyEOMkju/j0YeIbCI6Zx+g379KjzqcehJQPFBhcUcWIS9DV6CCiuKa6CCt7oGSV1BE+1
         ++wqrdP11tGym/b21wCgPqCUb4NfPp1UDHtKUOpKy7IK2tyx/5Y8Z/7J0Hyn/VRQQ2E0
         XogA==
X-Gm-Message-State: AA6/9RlyUX8eR8aE8NkmyI/CNXED5IdwEPJqE+8+hjKsZWa51xXorcSvkmAW70wBKm0y/rLt
X-Received: by 10.200.43.169 with SMTP id m38mr27080204qtm.31.1474987096125;
        Tue, 27 Sep 2016 07:38:16 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-14.NATPOOL.NYU.EDU. [216.165.95.3])
        by smtp.gmail.com with ESMTPSA id 44sm1369504qtt.5.2016.09.27.07.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 07:38:15 -0700 (PDT)
Date:   Tue, 27 Sep 2016 10:38:15 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        sunshine@sunshineco.com, walters@verbum.org
Subject: Re: [PATCH v2 4/5] builtin/verify-tag: add --format to verify-tag
Message-ID: <20160927143814.z54h3wi55t5xnqlu@LykOS.localdomain>
References: <20160926224233.32702-1-santiago@nyu.edu>
 <20160926224233.32702-5-santiago@nyu.edu>
 <D5DC2D99E1F84C308DDB99096B0E3BCD@PhilipOakley>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4sf5wzgmvjhfcjlq"
Content-Disposition: inline
In-Reply-To: <D5DC2D99E1F84C308DDB99096B0E3BCD@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4sf5wzgmvjhfcjlq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > static const char * const verify_tag_usage[] =3D {
> > - N_("git verify-tag [-v | --verbose] <tag>..."),
> > + N_("git verify-tag [-v | --verbose] [--format=3D<format>] <tag>..."),
>=20
> Does this require a corresponding documentation change? (also 5/5)
>=20

Yes, I'll work on this while I wait for more reviews.

Thanks!
-Santiago.

--4sf5wzgmvjhfcjlq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX6oRTAAoJEEaPEizoFiKV+HwQAIF53onJycRiX8EOAYHDy8qY
6IlUV0tRKSKuU3fmYHGG6XcQGPutdQkwMbqMliDMCmLyX2sSCx28C3CQ+0EDxZ3X
SnZRSsC/oK5lziymEbRPUY1aoMxScaMDuR/gbsW6uLau1JQ/v3yD937G+W4YcszH
+fc+tyjIElOLL87e91hLwWxZs2Bc2qouapeqP3yPkg4iCsPkMSFZswd8c+MYD3rW
/BNq29hv6ZwAQtnQA/mBOnkVDJtGRXNmbtesxrvnz/L2Cftn+rifr7yMz7AjQD2Y
Fh3dnTYXkJPbCrTbYps4mJc4eDS2fvGo3faV9ts6T7eJCv4oh6dbG7xtFeoF1Vij
cZgVhGMy+G3tYpVNIw4KeXdHigZ6DNHTmmYsLGwN02lmvHmlMcU9afVB4cLVAcUe
QcuY7O+E2+KJL0VtzqcxUd48uu9tHM8H5NYrhDQKVF05NYS8Yterser6p5/REIIO
bT8EuJ/cA1X+So0SDK9tZUCMuOL4LlHjcuDd0XlXi3BOIg9lhGTtHjefJwdxb5iO
+eusid6brkMmABoUsDf/NWe0fLc0RUObgFVJcwQHbisCii1Tn0JKpEJDL8srbgOK
zrHhvTBdDl+0IxO52MnSd8d2L+tFw9VH6DMFpFgSeH18q1lC6Sh+acy1LmHEmI6Y
2y5yUN/3tb6XPHgvidVj
=+c8X
-----END PGP SIGNATURE-----

--4sf5wzgmvjhfcjlq--
