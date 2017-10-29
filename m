Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3F7202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 17:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbdJ2RAd (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 13:00:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55648 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751036AbdJ2RAc (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2017 13:00:32 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 96C956044A;
        Sun, 29 Oct 2017 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509296431;
        bh=vjNnAQGASMCDMAZUga0q1CTgiZmohtCmwE7vKdhEqwA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bofWCfLllBhUDEqFpyiMy0Az+SlymTG6QnS6lKwCnHdNQ6usLnKFiV5zTuidwtxtp
         632eI4mXcqL3uKt7qhRLwiCr36SUtcYPuuRy8fpSEjJex7WzYdAJ5bBOxVlT2ckeme
         hFLWILUKsKoXfKBLIeoZUPQgQSaD5y5rtzkpzGDD/GywgZgaqid+iPeBz/wR2sDd0y
         k1HckTZKDsE9TdPm+OSEZB+iu0wSM7avhtMLNf395QxmNRM4DjVEy8YIhB0m4Ej86c
         2Wq9g7rOoknfh7f/tYkI29eYY5MMzEAtXNfPgzXTBhwGfvQAgMtvdaE5Qy9LR8AUo2
         avus7ismSJB81b+nJnbj2UT8w1X9IO38TWXlNzvZ9E2Eo+AK0p+5lu9awi+9ljrxXm
         rg03Wc46gpinoXI7Xqz9acfwD0Eq/C25rxTsgBnMkxix8mW9Owyta3T8XM/CruEHoM
         3wvnvIeW9pzb/JMmXRJzY/ecDlvFQtFBrEfb4ehgXnmIiTMKiUC
Date:   Sun, 29 Oct 2017 17:00:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 2/4] Add structure representing hash algorithm
Message-ID: <20171029170025.3z2mohqgcwhycq43@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
References: <20171028181239.59458-1-sandals@crustytoothpaste.net>
 <20171028181239.59458-3-sandals@crustytoothpaste.net>
 <CAPig+cSX_+mN8Pz=0k3xnHRa-Teoq2JrSHe0zQhzJ1NZafXPoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6q7v327tbriute6n"
Content-Disposition: inline
In-Reply-To: <CAPig+cSX_+mN8Pz=0k3xnHRa-Teoq2JrSHe0zQhzJ1NZafXPoQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.13.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6q7v327tbriute6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2017 at 09:36:05PM -0400, Eric Sunshine wrote:
> On Sat, Oct 28, 2017 at 2:12 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > diff --git a/sha1_file.c b/sha1_file.c
> > @@ -39,6 +39,49 @@ const struct object_id empty_blob_oid =3D {
> > +static inline void git_hash_sha1_init(void *ctx)
> > +{
> > +       git_SHA1_Init((git_SHA_CTX *)ctx);
> > +}
> > +
> > +static inline void git_hash_sha1_update(void *ctx, const void *data, s=
ize_t len)
> > +{
> > +       git_SHA1_Update((git_SHA_CTX *)ctx, data, len);
> > +}
> > +
> > +static inline void git_hash_sha1_final(unsigned char *hash, void *ctx)
> > +{
> > +       git_SHA1_Final(hash, (git_SHA_CTX *)ctx);
> > +}
>=20
> Why 'inline' if you only ever take the addresses of these functions?

Good point.  I wanted to avoid the overhead of a needless intermediate
function call when using this code path and have the compiler
essentially emit a call to the underlying functions directly, but inline
probably won't affect whether that happens.

I'll remove them.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--6q7v327tbriute6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAln2CSkACgkQv1NdgR9S
9os9jw/+Ps9i6tz3aUB9oU0DvH5CjOf6KfzgUtgRIOvlnIBqOBSiim9dKbqieuLT
VrfijC+1HBafQqEAur8cl8cvCdnk1L4Mk5SDRsQRFuBnd0myTxEtHwnT80jI+ZYC
J2MaLR0D3P+Lx4qFRsdl7D8Zt/TpSha6+Zp5e4ZX2Ev0DU7q//uFSWN/9AFVJI7J
as9zj8nMPAwu/L+LQ+cyg5f904RmpkbFdWiklIAfgBnU4xmoPMNUybkXw+0OjOLg
TRhN3XJaKCkRvg/PRHHfJJa0Vb665yA8YT6mfJB6IBGFDvorcYvezuBiZL+Bh+yB
HcecZAZDHTy7FEsQB5RQGpdPNrmJaAz4UGm6+86SlJLkA+c8Cent81F70zA765ju
Mli7glne5zeOxAbbd7dHRjPsgllHGqKSiUfBuiy1Ou3BjLUyHpNzgV27dqWkKHIV
Phgf+bcthz2cPL+NVYzdgqD4rlrdRrDITPn3CaAAuoJOimpvwcKFTAY3aDOFUc0X
Faz6Mi7sFgp79nU2UQ8XmF3H2kBkDOwJLzt+jLIf67bY0bekGMrAKFJFJw8y8kX8
9A8KBHc746yHNhV3fovC1/nnQiwqDTy+UxdmHB8N1CRW1vDcajIZh2HUOMVlJzcA
eS3z5vnQmS9FQ5L71ZTw5nTyWFwjlmSEKioJiJ4Ri6eq+20gO0M=
=XLJc
-----END PGP SIGNATURE-----

--6q7v327tbriute6n--
