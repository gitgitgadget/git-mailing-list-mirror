Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9145FC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 20:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F67860551
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 20:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhH0Ulr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 16:41:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52098 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231664AbhH0Ulr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Aug 2021 16:41:47 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4D92C6044D;
        Fri, 27 Aug 2021 20:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1630096857;
        bh=gg+pGAOCupJwhehBYiK+xBMzgXGrGW6mBHFY97XQ0ag=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=RGGjXVN95dlqRMlOKaFY4kMc5A/zMC81sS/PlTblK0K/PMuAGMLoIEufzMHi+ar/B
         xcH4WObvajXENIuf1syLtNjaqiu3W7Nd9/sJp381Lab9aOnDtZojfY1ULa2mcrXJVH
         jPEcr79PFKrrUAmb7DsoBJFDKQ3JrPekjLdr+GC6J/luIUfQTu+ki3kalSMq+teKka
         Ip5mxZUjNDTWjC8/awixDUO+03Gl5AUfejtD04na9kqu7biV3wmZ8epEICfgJcwSjC
         v9hZNLu6Rtaf/jsX7i8g728Pui0oJ/NBiId0i+HiTPh3Fy2IHYxXBNCheJQCMrsPqx
         k4FVURl8HTI0j8swR+Y5NR04SF0Ai+PV4otFL2IZp1eQB0vagJ+MLxy32vvfYZxkTt
         JMS+ef6iYpaNsj54gDBW2zt/vmFiW9Pb1DVZHOtBwWrhsnVnARV+gHdQbGQvjTSv30
         NR9u41RymoUwSGRHROPOBc+cRoVTtxFBqQgo7HbNpGZAsoTVC7X
Date:   Fri, 27 Aug 2021 20:40:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive: convert queue_directory to struct object_id
Message-ID: <YSlN0+ZCpDqoem9J@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <bfdb36fc-3b92-fe62-e928-dc235cede31d@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iyLLRQe5DX3Na2Gi"
Content-Disposition: inline
In-Reply-To: <bfdb36fc-3b92-fe62-e928-dc235cede31d@web.de>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iyLLRQe5DX3Na2Gi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-08-27 at 19:59:16, Ren=C3=A9 Scharfe wrote:
> Pass the struct object_id on instead of just its hash member.
> This is simpler and avoids the need to guess the algorithm.

Seems reasonable.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--iyLLRQe5DX3Na2Gi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYSlN0gAKCRB8DEliiIei
gQqJAP9SR7KhZ6Cg7Gd+caXdfIayCECwgZK2kX5MaF6kwPvscAD/SRfGGAfRngGE
kELK6E07Wv6DODqG0o8Jc/wtYtk83gI=
=f7vJ
-----END PGP SIGNATURE-----

--iyLLRQe5DX3Na2Gi--
