Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997BB1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 16:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbfA1Qwv (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 11:52:51 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33514 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729282AbfA1Qwt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jan 2019 11:52:49 -0500
Received: from genre.crustytoothpaste.net (unknown [12.14.75.250])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8D36460737;
        Mon, 28 Jan 2019 16:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1548694368;
        bh=rNjDCw+1PYBwClhCSjLo49lng3M4uInS1Ng/KdlAOxQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wAiQOm76KSRxRnqQeCjuCKpXsrbwHQn8nioORIqHCwBHV1LeElLK2LmPu4IyIsTvB
         6G2MvQW6eG7SYuW7DCGRZNO41sP6v0qdz8i6JW4Ys7ngi0hUYoMRP+kfM/X3ZC9hjg
         DCVHPnMGy+Hbbtj+J0jiFiNcdj6x+n2HF/zqIOutuSFq1I3VVForRwPX85tnC37dXH
         BaVt9PDcdrHm2933+rhKU09vYRebOOQ00A40aThsQP3mvDT20yrEGqqptdiDJx/Aoq
         UcQxTOvFRpPHV8cfG1JdKS3BeaMs6GR5Jop2RqCaxvkOfD8TWs+jlgMGwQwtLrjlhH
         yoBxmMXYBWu248Wa0JazT8xjFH2ya0mCP4tu0bQjDJV4p1QdAIBs3rhowWfk48ZOzT
         uQx704G1WwYrSvg4QeLIiBW2M5w2EzuE2Znb1i8eLlQtUczbUkaRfn3iGW+Ppjry1U
         vodDBSwQboTuRVBu6Ttv4zS2P6K2fURO7NAnkvg3FhsZ7ptAwT9
Date:   Mon, 28 Jan 2019 16:52:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Arti Zirk <arti.zirk@gmail.com>
Cc:     git@vger.kernel.org, e@80x24.org, peff@peff.net, jnareb@gmail.com,
        flavio@polettix.it, gitster@pobox.com
Subject: Re: [PATCH v2] git-instaweb: Add Python builtin http.server support
Message-ID: <20190128165236.GC423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Arti Zirk <arti.zirk@gmail.com>, git@vger.kernel.org, e@80x24.org,
        peff@peff.net, jnareb@gmail.com, flavio@polettix.it,
        gitster@pobox.com
References: <20190124161331.25945-1-arti.zirk@gmail.com>
 <20190128132458.31401-1-arti.zirk@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cpgGT4jyFUyD7BZ9"
Content-Disposition: inline
In-Reply-To: <20190128132458.31401-1-arti.zirk@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cpgGT4jyFUyD7BZ9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 03:24:59PM +0200, Arti Zirk wrote:
> +	# generate a standalone 'python http.server' script in $fqgitdir/gitweb
> +	# This asumes that python is in user's $PATH
> +	# This script is Python 2 and 3 compatible
> +	cat > "$fqgitdir/gitweb/gitweb.py" <<EOF
> +#!/usr/bin/env python

I will point out, that despite what the PEPs say, on Debian and
derivatives, "python" will always invoke Python 2, and never Python 3.

This is probably fine for now, but we'll need to reconsider it before
2020.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cpgGT4jyFUyD7BZ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxPM1QACgkQv1NdgR9S
9otKVw//VUUSWCHviHNvmo/qvqUg+UwJU1TT5Fjz2v8az2Z6cGxj3pT74wLCNavL
S0sJy8kKJFycfCHGS7P/qxpy669bvTSTKcpVByZS0sWs3reFg1RsAt9X+83WMoyT
03exEINTjih98ABTyMUv+Wg/j4LTc0t0hag0iRdwQOneIj5H5O3O2yPUCeIFi9uF
CiDgRv0YoEsSenAmVslP/jB3E4wb6c8ZmoeOUL3fYw1AwDUo5BWP7X+y7E4n6ffo
TaDSUQjUJ+vP6jkx18k7xFVzFLtv1gzoAVpiUSwF5XcJqNX6P72bVUHKFgfs0Qum
4vEsCmupLYhUYyYygIeD0m9jn9xdZSkKZjXypENLrDVqYc4VXsvrtk5WbMX+YiVR
d3K8WELvMTjm/4FEfJ20EupfOd6O3Icg98q1FznKFbn4N9qIQOmxN7K4/KgzGMSD
+xYR+f6V24xQvW0Lk4ZJdyxUJJZEMKQ3gZs5fqUKvZV+USdB+V5anCaltcyxkVaA
q4QRT/FXXV1KXuvfcy4XXFmfRTiLBb2qfnA0MDgR+cq8R5cZyARKBq03eGKPXuoH
ramCi5wXvHVzsN06/pH+mXyP7IVzyA1k8JIR5Of71VKrEEyJxDfawRsDVRX7Gg4W
ca9KeUndiYZMu3Llz5tf0mu8JBAdiSU6iUlAh6QkI/pYukUSPCk=
=2rZm
-----END PGP SIGNATURE-----

--cpgGT4jyFUyD7BZ9--
