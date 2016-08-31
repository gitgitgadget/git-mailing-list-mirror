Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F0E1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 22:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760455AbcHaWLW (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 18:11:22 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33325 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbcHaWLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 18:11:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id i6so3357910pfe.0;
        Wed, 31 Aug 2016 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:reply-to:to:date:in-reply-to:references
         :organization:mime-version;
        bh=N7GgOTF6T9s5KSpgkfhQSNBjQWgNnYlKLAIEmQDnAfk=;
        b=Kop5Jae4bW1IJUsaJnJp72wYvh7iwf3Kp0CxJH115wmF8LQzJw5bvfueT5w+Yq9tAO
         lQFWbkAtuxBFoG4lOTlV3+vRQEXqSMN5+rvzjclS6H6VSEkA+pmIRGFTTRMpp7Oi20yz
         2j/upzURmN+ILQZPTQ1rPrfhWuTOQLJ1LbF3GdElsT9dK+hdChnInCrq31FU35lLukiT
         7At2NQrQjKMUTvVEKL/P0l5km/6moBwKufFsYPBx9/00+BpWkMaB2YG7MGd4bHX1Vtt3
         m1xY2uE3ltEGVhs5PQLY6XuPuPuBQaDQUsyMM0P4aPW7nwSpGzx+KNg50zxe6LYvVe1B
         2PPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:date
         :in-reply-to:references:organization:mime-version;
        bh=N7GgOTF6T9s5KSpgkfhQSNBjQWgNnYlKLAIEmQDnAfk=;
        b=FdrtbkKEK1I46YVyp2kl5uIPz1HA7aEIApKBbXSCYewg+MjhKVJuOYai/wzLwpDtVL
         MhfHO0xX88JUO2OLpZ4OziqiSpBf+iORR3oCqft+oH5IHbqkASXteJZ23LA/8rMAN3XA
         63CH7EbADeHA0wbe6G0KKVyTjGXqYUZkExlvDpDfI6wbVvyybqV1/azjD0z0ZzK5XdNz
         ukNLit0Hgv4TOUMtXHBjJR4f3dUp1IyOPoZgJJaTG2ZB00ukQ/IVB4x2gop+h5kVoxFl
         HSd+cuynvjQmV//S5kT5nznuF7j0jmQjU6FGfBxjbHCRGzUUFjePgu381/vMRmfVNF5e
         Q58A==
X-Gm-Message-State: AE9vXwP3/ZVm38eVKt1o/3tlQoBLbjrxojHiesMF2nGHQf5vmoi9lvpLXuXHXQkVURIjwA==
X-Received: by 10.98.71.91 with SMTP id u88mr21114695pfa.145.1472681448409;
        Wed, 31 Aug 2016 15:10:48 -0700 (PDT)
Received: from jtkirshe-mobl3.jf.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id ps2sm2012218pab.10.2016.08.31.15.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Aug 2016 15:10:47 -0700 (PDT)
Message-ID: <1472681445.2268.45.camel@gmail.com>
Subject: Re: [PATCH V2] git-send-email: Add ability to cc: any "bylines" in
 the commit message
From:   Jeff Kirsher <tarbal@gmail.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     Joe Perches <joe@perches.com>, git@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 31 Aug 2016 15:10:45 -0700
In-Reply-To: <aa4c9e0b37e70423baa69bc27cc9adda0f152efe.1472669418.git.joe@perches.com>
References: <aa4c9e0b37e70423baa69bc27cc9adda0f152efe.1472669418.git.joe@perches.com>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-n+heF7HBYjicekUf8mvp"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-n+heF7HBYjicekUf8mvp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2016-08-31 at 11:51 -0700, Joe Perches wrote:
> Many commits have various forms of bylines similar to
> =C2=A0=C2=A0=C2=A0=C2=A0 "Acked-by: Name <address>" and "Reported-by: Nam=
e <address>"
>=20
> Add the ability to cc: bylines (e.g. Acked-by:) when using git send-
> email.
>=20
> This can be suppressed with --suppress-cc=3Dbylines.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> =C2=A0Documentation/git-send-email.txt | 11 +++++++----
> =C2=A0git-send-email.perl=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +++++++++++-----
> =C2=A02 files changed, 18 insertions(+), 9 deletions(-)

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
--=-n+heF7HBYjicekUf8mvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXx1XlAAoJEOVv75VaS+3OqcwQAIr/oUGPlntp24dQ6tNXIZ7R
uTyRiZjrlW1mBcWE6aToIVas+c1RecNCw7YG4KVi2DmWFe5cHk0RYIIcDKF+LoqW
7lg8ZvjUHJwUSmtqC5raVkkNXdziF7WfsfugspQAjjs5b1ZTQL7ppaWDfbmksvTA
MNi76dPY5GJ6IqNOj6dsjyMSpqMceIcZm+GNqQKoT0R0MEXp8hoKRwIN8QCdviIb
J/kdBDpbemiDjk4mjDYkd+8NVGXvMFq11Y2rGwDGyBcqfgCLQtVnqepJabWAQk28
W867db3KWLHssbDbfYbji6bX6G3stXhPuNrhERcznacO95lkGfrEKbVWIhAsjSfr
5W817nkRYqX2Q+ruSnwy8QBABpXWQcMVMEOqXYBCKjqatWAoqHwkMc/nXXsCEWB8
GhrPemTeRbk+IFI+JS/OvjCzwk55xbEhuna0puyW7NCfkpDtc7Qn52OgRoP9Rjuu
sBB8O6w3mSkPzu2aM2hGwjQ0HbjZi4CMGD9zDOfnxv+VNWxpyzyNVzZ7k8i9m1Lm
pCWu/OyL0ppOT7NKanmwK8Sk2H+DqMm6Le49UthZyOAH3xJSSlkHzKh97ZerQ0Ar
z/aUlcg5BfJrsyvFG6+degREuFzZHRHrSE75f5Qi4heA3A28DxkxWGVVMBud9DTk
Py1g0th+RdDZV03oIesy
=Oqb+
-----END PGP SIGNATURE-----

--=-n+heF7HBYjicekUf8mvp--

