Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54DAF1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756075AbeAHUh4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:37:56 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:37649 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755320AbeAHUhz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:37:55 -0500
Received: by mail-qt0-f171.google.com with SMTP id f2so15251860qtj.4
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 12:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IG8uusyZZGcjqHyZbgOAAgHO4kh+UpV2vUH0VI1DBg4=;
        b=vGGROqufYbFK96BaEdP/oLFh9DP79UdZj9TRLzkHfQyTB5mf+ywigljb6EZu9WQZWX
         NJhfaiNd2tpMFlACcOSC9+xjGuvBPKNSw26NjEcUdGr4076ES8vQgmcZagH3xu5fqlve
         UjH+x2N6nQXlYSU4HO9bMy7LBzfFLWLOcpz0jLXsBRLkQ9X6EuoZxdEdCjO4xU5heWSn
         rzdygik7vIYwDPeVqt2dgMZBTFNRAxUwaYaGWstz+35kmo59TyY8d7zva8MqkFdSnsFu
         UJBVMR3mMe/Hhhb79qbXheiQuGdmfAXT3TdQPgBCr9AbCy7vqz+rSItybY7/PPw0XCr+
         QPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IG8uusyZZGcjqHyZbgOAAgHO4kh+UpV2vUH0VI1DBg4=;
        b=bUXLLq4AvZGSw/z9ebwPrXWhNAFBLY6F3ryxr5xu1mzkhhlM43MZrqj5BiP7Y/jLos
         KIuBdaF2Wc7n0CkTeVRgZ0iUk9fCf7tgehGZ0Bb3cOIQbHha0yR+LOJ+lLu9QyiN98i1
         tkkpo5rWFMU46yqr7TvWguuIHltiI5FpKh1P9ISo7rO1GK5GPUhIVfw1wNH31tNqUxUH
         YsZbCuXZX0yWX7KDJvD4ccYM6Tre0UHBN/8txMSa+bRwUpolh7iV6uz7KdTTU4s1kFpt
         Yg8XmGQQXla3ic69xUUHR/OhTnCs3Q0wFXGKUj0nICh69Cbjhw703R7ToLUMuqufRHd+
         dhxQ==
X-Gm-Message-State: AKwxyte9iS5Pjc6R9nZBx5g0/49PLcpAamaxcLZoLWy74+ZMnMjYkYTv
        E1JCsM/czbJZ03CFnifRVHZCSTMk
X-Google-Smtp-Source: ACJfBovoz7eg6x/7gXxt44SaXxMkWOeE7Qhcq8P1ukFdsaboSHIrgdz3bBB95yLx5JdC3Qu1P2hcug==
X-Received: by 10.237.60.162 with SMTP id d31mr16865066qtf.3.1515443874739;
        Mon, 08 Jan 2018 12:37:54 -0800 (PST)
Received: from LykOS.localdomain (216-165-95-146.NATPOOL.NYU.EDU. [216.165.95.146])
        by smtp.gmail.com with ESMTPSA id q2sm4504144qki.26.2018.01.08.12.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jan 2018 12:37:54 -0800 (PST)
Date:   Mon, 8 Jan 2018 15:40:30 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Colin Walters <walters@verbum.org>
Cc:     git@vger.kernel.org
Subject: Re: upstreaming https://github.com/cgwalters/git-evtag ?
Message-ID: <20180108204029.m42qyezojak4kohh@LykOS.localdomain>
References: <1515442320.3241451.1228399576.66D7DA96@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5xirefqll5uqumkc"
Content-Disposition: inline
In-Reply-To: <1515442320.3241451.1228399576.66D7DA96@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5xirefqll5uqumkc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I personally like the idea of git-evtags, but I feel that they could be
made so that push certificates (and being hash-algorithm agnostic)
should provide the same functionality with less code.

To me, a git evtag is basically a signed tag + a data structure similar
to a push certificate embedded in it. I wonder if, with the current
tooling in git, this could be done as a custom command...

Cheers!
-Santiago.

On Mon, Jan 08, 2018 at 03:12:00PM -0500, Colin Walters wrote:
> Hi, so quite a while ago I wrote this:
> https://github.com/cgwalters/git-evtag
>=20
> Since I last posted about this on the list here, of course
> shattered.io happened.  It also looks
> like there was a node.js implementation written.
>=20
> Any interest in having this in core git? =20

--5xirefqll5uqumkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlpT1zsACgkQRo8SLOgW
IpUI5hAAvA56vqRI4U1tI2djwPVwS6Lur9e09DvLM2RWy4uIhKG0NpzeVdtouum4
FYoarE8LhWYbstyBfxqEpUOMl+vj9Z3W5KdyemwGHWzmN/8BYSNevd1MnUmypF9V
OK9jw9BhMJWYhxCwwfMU0QqjuzIsgNdaqEidpNoXYQ9+jArLULzgJotJuAXOYhnW
9kQUuf0Oh6f0YwLYB5rJWvvsQ3P8+BpBK3kPwm2OiJK9+rhlpiGYxJfUDNcquRgd
pHeZ01qi65KuPvvMxFzmot0z6P+taHJAcEVpDPg+FKoSgI9/VwFhp7A5HtpFz1WP
dh8tjiJIk8iPUg8rGFsoh5muZSqG0HZrm7UGkLXHSRTn1DP7z1DOC7y9qPOyaNxb
EugHIJKFBRnXln8trKc2PiP0HoAHKdWYiKg95uI/2tXXaHDLoaHj0VjMQSv5sZvI
ayKovHYy9fYoq//UFek/IR6MbB6PUkYTRsySsY3CIpfc+hk1M98iBbvb/5T6IKdy
aNbtATX5KHv+9x6giED7SJrN12W6FxA7s72DDxpX3Ezrsmh76PJo4M/e1upjNpwp
dcmeGy+c60TdXkz8qen6pLIdpuhCCnko+u5zxrLH0LfF+Fo+vh/TRuXHQkHqC6w2
9e2KrFhf4/mcpAYuQMyxOO92hnDWqTKi51FTXcIy4T6pSvZYux4=
=LNUj
-----END PGP SIGNATURE-----

--5xirefqll5uqumkc--
