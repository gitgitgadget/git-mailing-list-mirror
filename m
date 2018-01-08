Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FD5E1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932211AbeAHUwU (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:52:20 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:43762 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932106AbeAHUwT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:52:19 -0500
Received: by mail-qk0-f172.google.com with SMTP id j137so15911052qke.10
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 12:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AFHW6tpRqz+1EPTxphahomZsO1l9Lp+PKuWUeR+s0+Q=;
        b=mCP5AftN8WDYIi8fCdcqOJdZOCCS4fLRZFSTMIPfo126Gt5NfHDEv5qVsJUecJSuee
         V1/CAAsiF/kOW8koTsXbMHiw0V+4xng4rv4SqgsGSZ5Ft/s6Jp0ykBKCUWFXLS+hFdxs
         Dc4jN8RJ+vU55WDspzNV4xb5P6Gvpu4duV1s6pHSexcCVL/zit17CYqJYxYs7dqlEJk2
         dPp2PIKbjsV08ux5osYnxD4rN4f20Zcv4Anxfat2fh5myBiXAzpKQ6vBKU00+I2w4OIX
         vUTqpw4536cGC1phA6KgT/IiIhq+G9V3c2enH/nYzSDrfAx8GoRfvndA7ohPGV7W8bkJ
         2dCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AFHW6tpRqz+1EPTxphahomZsO1l9Lp+PKuWUeR+s0+Q=;
        b=Zmc+cfhtvI00oTpELwz0AK1H8MXek9Um+zcP5Q3t5sjOt+Eot3SSRSlA2pK0GaJAWS
         Qb1GR5m7Kggsi1fS8h9qZFJpOHt/LPUaVhHWB5nsA1M9+9dw8KoeSQmavj+X0kbIQb3v
         AHU+Y+Llitgf3yOAy4eA5gC5WQDdaa5jd+6u5DCB2cd1vqeut6fLp+p3micmUoYZxoB2
         bzsgDHAi9WqDc3tkdrA5HUlOjAOyDgRXKE0dXxTBViaakVNAPJDCJO9pvx6K2h6znxM5
         fAH3yBqI3DyE8EcL8eecWTH1BRYeMqDKMh2BHKRR3xN7C1yHb19pQk+T88UsdF5AkNqg
         uytQ==
X-Gm-Message-State: AKGB3mLSfTxMpY0fn748SyJLPz3x/WlclutrUmoRGLs4r8IInv5hY0mi
        x8QfUIiWUIl8QAlkP0guM7Wd9g==
X-Google-Smtp-Source: ACJfBou8XrI0yn9UhQdyrf8R1Ecu7XeyhYok1JQ6M/j7GBOAt1bOA5al80HrBmw2CfBLXPRYdT9opw==
X-Received: by 10.55.42.143 with SMTP id q15mr18290601qkq.206.1515444738657;
        Mon, 08 Jan 2018 12:52:18 -0800 (PST)
Received: from LykOS.localdomain (216-165-95-146.NATPOOL.NYU.EDU. [216.165.95.146])
        by smtp.gmail.com with ESMTPSA id i35sm8223186qte.96.2018.01.08.12.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jan 2018 12:52:18 -0800 (PST)
Date:   Mon, 8 Jan 2018 15:54:54 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Stefan Beller <sbeller@google.com>
Cc:     Colin Walters <walters@verbum.org>, git <git@vger.kernel.org>
Subject: Re: upstreaming https://github.com/cgwalters/git-evtag ?
Message-ID: <20180108205454.6ky352nkdn5u4w22@LykOS.localdomain>
References: <1515442320.3241451.1228399576.66D7DA96@webmail.messagingengine.com>
 <20180108204029.m42qyezojak4kohh@LykOS.localdomain>
 <CAGZ79kZ8AXezcX1_5WJsUJMHiHCzj2B=Uj8+4K3VF+cC6mTCqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="owomboyl3byeqwuu"
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ8AXezcX1_5WJsUJMHiHCzj2B=Uj8+4K3VF+cC6mTCqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--owomboyl3byeqwuu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Personally I'd dislike to include ev-tags as it might send a signal
> of "papering over sha1 issues instead of fixing it".

+1. I probably didn't convey it well, but this is what I was hoping for.
I think git has enough building blocks to provide something akin to git
evtags already.

Thanks,
-Santiago.

--owomboyl3byeqwuu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlpT2p0ACgkQRo8SLOgW
IpUUwxAAnSGs1VKHqIewbOnfnLrgpSu3gAd57zUjAz3PqBZEnpvSHkAzh9mi7l1A
8i5z8iqcNJz8DgtwGAvq32UcoJp/OaGy9FO6tgVbhwBzq4K1pReY6+8wEAeEEST7
s5ko5zs9kWPTHSUkxaScU6RHFM15TjVMRL3Rj/WP8/CAN2unefP86d7Urp9sO9lk
7SbnrPHHzvRJScWfPYSFob0PoRkbx/H8TmR3IX2mhgaq9Yy4m+38P8sXQFm0sqrV
cDP6ePhSKu25smCJzOaPl3A73XJ219QRi/6vMg7nAZeAhcwfFXb6QjHfzcgdHZel
iVKgl1HFR9/O3WcSX6YTgOET2IMwI7sGFI024Xutl9M0RCt4rZ47mDj/k4mn+QaO
pShEx4bGZmdTrqManvWvkxv30kZu+5lpGmU6RNK5BwEv2kINTJnytjHbqNpKoNOd
NOzhdetNIRIQHu9DeiXXuT97s8eNmO6h2lTngnVqr9n/n5fow8FFKXxAd07w4eSW
ZUWSgux0ZOUGtJ3f4dE8Uta3n4xKArukeS5h4b/3HbkVBd3q9OxyUMCmwA0zGbPQ
5MCGRejIa1ovEXpph7qtvfS7HcOqCbL5GKlx8LPtPCoV+9iEML25kn77pspCu7Pp
d27gsTmb2EzKFmSovrPhFu8XW8pp9+n3EHIs7ze/MImoXpGtwr8=
=MayS
-----END PGP SIGNATURE-----

--owomboyl3byeqwuu--
