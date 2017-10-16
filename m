Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CE1B202A2
	for <e@80x24.org>; Mon, 16 Oct 2017 23:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933032AbdJPXtX (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 19:49:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55314 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932715AbdJPXtV (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Oct 2017 19:49:21 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 16DE960448;
        Mon, 16 Oct 2017 23:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508197760;
        bh=10vT9tpZqG1yg4RQnzOAVCYVxqLAYMVVzt/xEw/TxPI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=y+jK8ARRVpzHQDeBs9h/XRpd4Rk2sJN8LsZvPWxA5K/bPCXif4b8UoSoGom5CIJQn
         jlqdQuK4nlR6jfUq/CFemWo4bDhHQ2W0wtayMhek2d+AhdCncz4ExZzciIR5n+6sWz
         hesTe2iggKF/+EpCHxmnIQ5kgNeHRVHCOGPuIjk/Qyy2gPaKBVHuwpeGIDaUVZ3MnY
         xlSB34am9Fd+TxiVL55r3HK/SAzb2QlIez4HpsbOoAUVx/S5h5cJloRjjNBgwBuSBi
         O+kXyVE8DpiZNt2Y8uY9GgvTEo4voSuwa78O05+Z3+I/RG69Ncp0nF2zcovczRG/cT
         8cb9so7YTId3TA/vnvG6ZsoNxqTPHfA1HWTC1D701RYJmdgNnCHOFLxIAlEntSQrHP
         HWjD8Y5iwmSKsN32lmSOLsr/DA2RnJle4dGYNaI4zn+m1DHacR/Mp+r18rkwTPFZli
         F+NMmex70C5iQsptriMGzDrN5mow8EmLTk8zC6E7xaaEnWbdfAw
Date:   Mon, 16 Oct 2017 23:49:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 00/25] object_id part 10
Message-ID: <20171016234912.6r7fqkxugn43wji5@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
 <xmqq8tgbu9bt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ksd5at24rcniw2j4"
Content-Disposition: inline
In-Reply-To: <xmqq8tgbu9bt.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ksd5at24rcniw2j4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 11:15:34AM +0900, Junio C Hamano wrote:
> With a hope that this might help other reviewers, here is the
> interdiff between "the previous one merged with v2.15-rc1" and "this
> round applied on v2.15-rc1 directly". =20
>=20
> The changes all looked sensible to me.  Thanks.

Is there a reasonably straightforward tool or workflow to generate
interdiffs?  If so, I can include them in the future.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ksd5at24rcniw2j4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlnlRXgACgkQv1NdgR9S
9ou38g//b4wthjWVTKmMurwtUxRKYGTmjfhlElaPmU4qoX3oK+frFSUm9s3nisRI
FvHKJ3fv5hlJ4RjUofGJ6u6CIrz78y3nIiOhaDWkCMGZm8ex5ReGFS2+VmNQ6Xpb
G59Fvu7LS+SjUJ6ekeUJxasmkn+0QGzO1lNvPtDfLDPJuohbKGfJf5vYal5U5zhl
huv7kE8QjsKbHaa+571xGOkJcbS/KVYeNbzYUrpSRCpgR0GhBTSBEkn13v2dPsnC
mav3ZX0+Q4IH+icmkb9Dslk2aXxgpX0YY3b6uqUds5zRLH5LmsbCRqgRc6xkbTvk
9sW63ykIrmjZzHj3XKbW/+omIjs4gUgq9LGJwz4kXT6TsSUDgKTTzPsms0l5nDaU
2Q7qBdHFfhToPtbmQ9qLAzIC6Bm1qDFMl/8yJAdHPEkXpby9SOzyx0YDsTGb3yoo
cXaINUa61ViCEH2VT/rCyaM3iF+0uOcB/D8GBobEBK3wiXsGLc2VQRRwj0KW6Qy3
buHYXEUi3K9N5F7t4/Rt7pZmiOXs68ciqh4vbUw2Xw6MqfXcsICY0recJlUWNtSl
uPWPJtF5KFnlpZ2IWbsFh0HYDJiyzLe4eYYqUPxLOruEs4kVYoU+BZ6aVYuWIcKE
QMM2/HqrA6SOICxsFjG9DWmvb0m8A4vK7HW7nkxe9O6QKPBFf5Y=
=fO2K
-----END PGP SIGNATURE-----

--ksd5at24rcniw2j4--
