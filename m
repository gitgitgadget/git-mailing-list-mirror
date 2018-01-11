Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2B411F404
	for <e@80x24.org>; Thu, 11 Jan 2018 02:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932075AbeAKCIr (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 21:08:47 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57994 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932072AbeAKCIp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Jan 2018 21:08:45 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 29C656096E;
        Thu, 11 Jan 2018 02:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1515636521;
        bh=y4CT+hj07ni3+LBwQCx2wzdZ0N1PGRRe/ctvC+yAF3I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zFqe7e1QrnkZZhuJdnXUl/KUaP8SKIVEcxod8oeDm+jlfwRtkwa+8TuIU5n7jqMRx
         l8osFqZmM28Kq3FfjwDWMPy4z2Se3z/lkmX9r1QDWRF4ciyPtpTRaglW9tTu7vlRbR
         o/o1v/zJ9bKH+BXg8ReFYht+v6nsA/W8PwrxUqFRigeDQbOkvCxjGCJIs8kRD8N7d1
         d+BHr0O3q/q9VMPrOVuJbB83+ocuFp5xQ+MJ+rUGPCwzQWQJkyB7DcCDRKP8y1/1KG
         KrI25QLa8V+swhLUBrxLmD4ZluJdfCQmRgikouAANWc2xhhGU38RQ+FPU/T/NF3Zvx
         q4rfraglKplyebYmYVhpP8Dc2Yq6DIxLD1e1K8W7/kXk6R26Xc+fdUVYgJ6BVFGiSY
         CyJPlRG6Dydu34c9fL9GDbQ+JtFts0kbdCeo8/Tp3msJr7MBDzOucQrP7Pu5zJKk4p
         6kUJNgPbqHneQZ7cWOn0SrIZKid/cTygB9DD0eLmO3ecZxitFsJ
Date:   Thu, 11 Jan 2018 02:08:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Yasushi SHOJI <yasushi.shoji@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] bisect: debug: convert struct object to object_id
Message-ID: <20180111020834.GB5946@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Yasushi SHOJI <yasushi.shoji@gmail.com>, git@vger.kernel.org
References: <20180109110356.25824-1-yasushi.shoji@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20180109110356.25824-1-yasushi.shoji@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-5-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2018 at 08:03:56PM +0900, Yasushi SHOJI wrote:
> The commit f2fd0760f62e79609fef7bfd7ecebb002e8e4ced converted struct
> object to object_id but a debug function show_list(), which is
> ifdef'ed to noop, in bisect.c wasn't.
>=20
> So fix it.

Thanks.  This is obviously the right change to make.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpWxyIACgkQv1NdgR9S
9otiwQ//XEILbaYQkJE995N8BzvdHDuhCCAJkGzbInJzPLMJiAXhHP0rMH+JxuWR
xksNxmbRfv/O219nUDFm2JmcUiF5fJx/fayGiEwACPCQdGeUlwukD9dqAld9texV
lG8Pu7ESalMdeBFcgRoBQHujjGMvAUM9pjXC8P1r5YFiAV93qa6sEZy2H6UAymxJ
YPcc0UlK7qIJeruQxxexlAHpTiXOJ2eYrg6WsHU8kpdFwHCCN9eNevxdaxQTLtFj
Ud5nrmB72wuW9AAPOqmKDg74tVv2EnyeXYzkONe9WBT3NvY7nUD3DWifcfA72JZ8
tGdY2se+/1pjgJam9szWHm+3VugbiAJv6wEJwOSmtRtW94/yYsEfbhiPrf7+ChVK
MebKGNU9xUH1v/qwAJZiMUlJURkKH7KqpwqMk3J7pKyyi7Yow85cEj0J569YRBHm
2B8rV/xe6iaf7Ws7PvEEjIhMdTTKecWdJXCtJ3reu+T7VqsrcqtRXkb0StwW8BR1
uSjVAt+BbIiLpSmtBglcSUkLzpzz0KploNXKA5uny+6Ic7GM+U9jySR9T2qRNs8X
XG/bsHWDo0ZT23he5aTN+MIfPwvi+KCGfsbDfD6pB/AvfG8fVYpy3ayRzi6MfLzD
nJeQm0U2klS9vQoMzz1ZKtxsXj3laetL4zUsaP5SanjKMVV3xcQ=
=ggsG
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
