Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DE222095D
	for <e@80x24.org>; Wed, 22 Mar 2017 21:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbdCVVoG (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:44:06 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34265 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdCVVoB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:44:01 -0400
Received: by mail-qk0-f195.google.com with SMTP id v127so27822217qkb.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 14:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pHB4fE4pRKan0lVYMbU5uRHTlr9mbOM6d+GQWmcKD18=;
        b=vC9r6fH72TAqO/VKwXTZEpSK4ziLUDdGoPFLQ1g4DlrA6wiwWJyUuJx4T4dpUZwJ0j
         Uukn0y7dcQTrEkG139gL7cQ8tkQdw/8icKnGFUi6vdjB/DGIlPVS72DicOkG5tngB2rM
         ig87o+w2r6t+xx0hYbh7BEHlJ8sZaDRtysfd9vZyMAse4uawgQ0LN+EvZJSDMfw8PQw5
         HTz0ghYg07vi3xG7aeQFdl8VOds0wL3uRlVD3KmwfJage8jPVFaJVctj6UVZoU8M1Qx0
         c24ARIA78RvqiJtatJEVhQRl4RDFVd7VBOTCcMnlihh8KIzmXUpXSMq8X6UDp1NXDOw5
         vAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pHB4fE4pRKan0lVYMbU5uRHTlr9mbOM6d+GQWmcKD18=;
        b=A38wNdhId9eTcKf7jDOKe9ZETGsjfzRlKstJls+RSrHVyQq7CzOo+od+w3DZBtc2J/
         CDDCw1BAIrUlMa3zW6rHB8JSaoJ9Wo4+DDZTy0zw6rHfCqr8MMfGYWsTb39oSog9lxAp
         Bm9uXmevvnChJLNx2Zwj2rZ9dFqdzUR9lBlsTsDlBrqWLlo3b/wXqqEgskKyYRoiSlZl
         nkdFl5PEdlwu/P12o0vbbuDf+RNnswIuuXr9qv9L2daGggQDOQYvuULTDZlDvDA3atYf
         k+tm+PmUrkYeBlOm35zTMIyhuNzwO0hoQseGdf3mBW9IxxIWX5rWs+XHWtDWvK2xzfTs
         PtCg==
X-Gm-Message-State: AFeK/H39y8px7FUk2pHZZytHJDAciRH1hdP9csDqcIM4ia+qVjCm9B4hMGr42xiYTaXt9NTm
X-Received: by 10.55.72.87 with SMTP id v84mr35748109qka.21.1490219038821;
        Wed, 22 Mar 2017 14:43:58 -0700 (PDT)
Received: from LykOS.localdomain ([2604:2000:8183:da00::3])
        by smtp.gmail.com with ESMTPSA id f56sm1868993qta.14.2017.03.22.14.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2017 14:43:58 -0700 (PDT)
Date:   Wed, 22 Mar 2017 17:43:57 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
Message-ID: <20170322214356.5jj7dggtvgilreci@LykOS.localdomain>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
 <20170322200805.23837-4-gitster@pobox.com>
 <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rf4cdtcyqlzqm354"
Content-Disposition: inline
In-Reply-To: <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rf4cdtcyqlzqm354
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 05:10:03PM -0400, Jeff King wrote:
> On Wed, Mar 22, 2017 at 01:08:05PM -0700, Junio C Hamano wrote:
>=20
> > From: Jan Palus <jan.palus@gmail.com>
> >=20
> > These all came as part of an earlier st/verify-tag topic that was
> > merged to 2.12.
> >=20
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >=20
> >  * This should be applied on top of 4fea72f4 ("t/t7004-tag: Add
> >    --format specifier tests", 2017-01-17)
> >=20
> >  t/t7004-tag.sh        | 8 ++++----
> >  t/t7030-verify-tag.sh | 8 ++++----
> >  2 files changed, 8 insertions(+), 8 deletions(-)
>=20

On my side, these patches make tests fail. I'm wondering if this is an
issue with the underlying shell (probably the version)? Let me try to
figure out what is exactly going on here.

> Like 2/3, this one also produces test failures for me. It looks like
> "verify-tag" does not show a tag which has been forged. I'm not sure if
> that's intentional (and the test is wrong) or a bug.=20

I see that offending code would be [1]. Changing this behavior should be
trivial (dropping the continue), although I'm not sure if this is what
we want?

>=20
> -Peff

Thanks,
-Santiago.

[1] https://github.com/git/git/blob/master/builtin/verify-tag.c#L6://github=
=2Ecom/git/git/blob/master/builtin/verify-tag.c#L67

--rf4cdtcyqlzqm354
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAljS8BoACgkQRo8SLOgW
IpUJKg//azHsct2XgTdiDXTqjyASVl42M6HE1TgUzvgyFDA8pIs+YAU8BtR4+4Ua
MaSry9Rq1emF0ZSe3r2XDzztz5DXACXcG66g+pflK/rpdwkNve22pvkDZtZi46W4
D2weD8cADK+sVHhiEaZv/uOl78idf7mTzC3Gr6m3Cy6km0dCrMQXCgdWC9rJQ7c+
IeQcd6P8taaAtfIC9QEMgqexFk89f4SMd1klxgPmKWgAvaVc9zOWADMU/1SCOApr
DaqBYOEhYOuO2EKJ69hQjIBbBQoKLsXu3kkL355hXlmLTNLJy6gr9OVyFNKeTkXD
W7cRWT9jxe06cg6+hPEXUkr9OViyRCdgxVrgCiHr48kKUr1YMFS1XYKJ74zLcKTQ
utqwcntQmXK5sPyeougogtBFoSAHJQjlE9belWUuwzYaotrFYiD5eFns4PfXj57V
qmVaYIn0fCP0vkCePRi0mwcn4eGO1Kw9nqHSubKR0FkVpRSDXQLuHaRFSsDhKugH
G/szeMBxlBhXOt3FmpDDMPUyAIIQ7RdVYS6QTFnQL1InM3GXHdOWPdnoVmSun/sK
9JcwNJu072R0+2gwtNU0OFknVYNk4mmtT5Imu7Xa8yZBPrX9QA898HQ22GN0f3tP
Uqeb4hC5AEaA5Z/10AJrk9/q0S2g0JJjbs3cGN7TR90XFx33BQo=
=m5NQ
-----END PGP SIGNATURE-----

--rf4cdtcyqlzqm354--
