Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E4051F600
	for <e@80x24.org>; Thu, 20 Jul 2017 20:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935466AbdGTUZr (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 16:25:47 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:37315 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935211AbdGTUZq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 16:25:46 -0400
Received: by mail-qk0-f171.google.com with SMTP id y126so16218744qke.4
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 13:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RREpEU5gypN9msshSb5M1eLx0K+0NqOWN1LSyLdj9ak=;
        b=zcyfycOXRFjTF0vBb+pU4NojyqnXIEw43kvZedfSoRSwl3RrUwMo3Su5QteeWwZ7Ij
         mLRL3f5yw7R4hphlo+oyJAnw4J/oO6LDLCjjyH2SbcvMw96KNk7czo/qodkrDlZYz/uU
         7NmymAfdSuB9MJcXd2b9DRlUIQxFVm2AIFwubBfSpS0fYeLtl99t2wnmyL4TbpP0WjyT
         JWr/c0yAa/nZ5ljYSY1K+F2YKbtI8x0xcBPkm0Z60Yv1opYWVnufq98+hFOcH7bWQDPp
         lHAE16gahLSLM7H5/MtrgUz/6B+0N2wL89ggPsZ2EucT5S9db47lWjfvyExZSJlpbcXx
         UJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RREpEU5gypN9msshSb5M1eLx0K+0NqOWN1LSyLdj9ak=;
        b=cvzSemLAyOViErVR4PaHcxI/GvqfQaDIY73m0e81KeT1lC6BkSkgSY8lWGfWwuz+hA
         ccEq4kgB8jZesSo0bCQhdKkiuEJd0r8yteDkee1ZhA2ZIEoHYZQr2Ece4Lh3PWapXP1U
         yxHfpi44EAVp2QL1f/RGGxUJbKmLDdYPmSd1ACrYYntbusLdZI3tQgOn/Qg79czXv+Lo
         iq2ZMff+fqLKfKgUXiT6foEgd2oGNunkJj+MFw6Lz0xnDxh0ORRFmWJ9xyb1Thqmjt/P
         YoCDBlRzIw22MmUy1+BJCVHYmv5Tpo5HPDVqrINGMuL+4NC/duR1MBo8l+/PR2RxcJsg
         ubxg==
X-Gm-Message-State: AIVw112Oh+DF4uB5GsHytbkpiGFdoKAN6jyHk8xkLmQMEq40LvgAXGpS
        uxuiUMsQypoIZcxh
X-Received: by 10.55.105.130 with SMTP id e124mr6127586qkc.117.1500582345416;
        Thu, 20 Jul 2017 13:25:45 -0700 (PDT)
Received: from LykOS.localdomain (ENG-KCG295-01.ENGINEERING.NYU.EDU. [216.165.113.136])
        by smtp.gmail.com with ESMTPSA id g27sm2287865qtg.84.2017.07.20.13.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jul 2017 13:25:44 -0700 (PDT)
Date:   Thu, 20 Jul 2017 16:25:44 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t: lib-gpg: flush gpg agent on startup
Message-ID: <20170720202543.qw7wbrz5nhvvqt47@LykOS.localdomain>
References: <20170720165814.30037-1-santiago@nyu.edu>
 <20170720170113.fvquowatpv4ms6if@LykOS.localdomain>
 <xmqq379qlvzi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="235tq4xouom7wnl3"
Content-Disposition: inline
In-Reply-To: <xmqq379qlvzi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--235tq4xouom7wnl3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> With that "run it but ignore the outcome even if we failed to.", we
> do not have to worry about any of that ;-)

Oh right! thanks for the suggestion! Let me re-roll...

Thanks,
-Santiago.


--235tq4xouom7wnl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAllxEcUACgkQRo8SLOgW
IpVsXxAAlKr5dZseN6eUm/eHvAWmbLgencHT4dbnF+/KsESqj7S23f2PxPbnZ4TR
riklVb+hBrPvLTYjBBcEOu8WNlW7l60Iw7YLCe/5Opaksy4XHe8sADPNTidw8PBw
YziKAwz+ZkzoBqMYAzLjkNz6G6ApJ0SXrgwyybYXCzzrIzFk33gwNiOOIaAp3AiQ
iwb325X6RZttys2FzdWTYLBvcqGG1K/J8T/7rjxZFucdAb03aP2J73IQ+iutRD51
Q45+h0LtumcC+PdnNx4+llJMcemY4Q4FcCD8+DkOgIlTazl48Kl2YmjQBCbT0f/1
LuLFC4vR8FBPwr7hQ59w/Tz/5wtJzQTfkAZ5NAiSgUMWX4eWTw4jKUAsdkkfqrgY
plO8du5mQFRAsO3KcTtFbtbvWwsajFo255w84xCPeI1HkRqW2cFdZy890T1ovQ4p
Z+EXdR8iPYFJL/l620fHJ1r9uepVvRpFk/HNSjGUyRZhAYta0WfeG2rKkeb685PO
uJII6BXJVmT8OaWV5uesE0iV9Jsr6T6xfafSkpMkc9iRA/AxvHVQ9pXofSppfV1V
1F1RDCw2LA/DKGuiYMg84LSA67T3zkhmB1Fr8MzFjUmGljdZ9BWXTdmV6MP6yDCp
7cai7gj2PXM/lx4ofxMBnXewjzZlsfzfCFx6dH4/db1FxwV5QH8=
=diS7
-----END PGP SIGNATURE-----

--235tq4xouom7wnl3--
