Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C02BF208CD
	for <e@80x24.org>; Tue, 22 Aug 2017 05:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbdHVF0M (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 01:26:12 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:38487 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdHVF0L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 01:26:11 -0400
Received: by mail-qk0-f176.google.com with SMTP id k126so9120712qkb.5
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 22:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DUAwzya8dJYMFnhDUk9cdVDUIbFFOSxjmgmvySIkJKQ=;
        b=a0QU9oJ3wOAXPF3bWXi/Kv1QW5jSK57tH9UrjZsJL577x0oiFKr+522U9kCDk4hfZX
         KjgE3MAgsS8I7ErVcwo5Y44PIntWrlzdOVGIrzSXE9UXdLvOe4a1Ftn1PeFpjx4BHZH/
         z0/ZgEo1xUvd127ssPbZhuKn+cFl60CIWBBtKJUOzPHTt8+VdmAEhP57yfKPNEbEJHyL
         9nEuSRonjOZMFuUWshmSNhc3bHUC/2FeC8n54Nvt81yaS+h3tjbY2XeCiRBnEO05bQZ9
         4gMYCz0Xhy8G5PqIyXTnKeSfR4VZDtj073dClLJIyfZvs17MWcy8g+bRPDElcIE//f+j
         aOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DUAwzya8dJYMFnhDUk9cdVDUIbFFOSxjmgmvySIkJKQ=;
        b=W+yoFhShmNoYx9JBatAJEFuGMls3NwmbPoOD97YpVx1iAUyQJznHbsWyP5Kd0Xd9bz
         XbGZndPiAXW9Oy39f7tytUCBO5baEQpdShCNjcjUGpTGsHyX6kNsVdPZNH7FnVjGa0dI
         07xjujIKdrEgj3pVPazEaz56Z29jZIdZr5v7zgCBTJNDXCo8Q0YGzqrvzInoFw0EplJt
         XoVD3iEk0T59PMrAytqRCTMRRrRi2QWIeMrdQ0Y6+QrnWNCAmTlQpnkAaXqv5xrvAiQD
         Ki3iVepSbYGv4F381B2/rtEzx1th/uS89JQVWHaUcwomfkN0B9PuEl05k0ons2tKZXLv
         F4iQ==
X-Gm-Message-State: AHYfb5hVRutx62M4TDihDKGlY1PGxZl2CDyUAoZrAUcryYrPj9+5urLh
        h3odaZfx7XXpGwoD
X-Received: by 10.55.204.2 with SMTP id r2mr27262694qki.75.1503379571114;
        Mon, 21 Aug 2017 22:26:11 -0700 (PDT)
Received: from LykOS.localdomain (cpe-66-108-233-115.nyc.res.rr.com. [66.108.233.115])
        by smtp.gmail.com with ESMTPSA id r23sm9420093qtc.50.2017.08.21.22.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Aug 2017 22:26:10 -0700 (PDT)
Date:   Tue, 22 Aug 2017 01:26:25 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: t5551 hangs ?
Message-ID: <20170822052625.wzlhckjm6gwr2q6f@LykOS.localdomain>
References: <20170822051059.GA26331@tor.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xbpbgedn63edpoph"
Content-Disposition: inline
In-Reply-To: <20170822051059.GA26331@tor.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xbpbgedn63edpoph
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello, Torsten.=20

On Tue, Aug 22, 2017 at 07:10:59AM +0200, Torsten B=F6gershausen wrote:
> Hej,
> I found 2 threads about hanging t5551, one in 2016, and one question
> from Junio somewhen in 2017.
> I have it reproducable here:
> - Debian 8, 64 bit
> - SSD
> - Half-modern processor ;-)

I don't think the SSD/regular disk have anything to do with it.=20

- Are you running tests concurrently? (e.g., with -j x)
- What happens if you run the test individually (i.e., cd t and
  ./t5551...)
- You probably want to see the version of apache this is running/etc.
- What happens if you kill the apache processes?=20

I can't reproduce on my side, but let me see if I can dig a little into
it.

Cheers!
-Santiago.

--xbpbgedn63edpoph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlmbwH4ACgkQRo8SLOgW
IpWaEA//SgrQQ+amsm3SA9SntY2o8SwHAX6EJVWMb9M+jzv7EFuRv8Z2i0UN/MTD
OzE4u0jBnvBS2t1R8pQWxh15UkEhlii2+voTUshf1xPnEIMiAoOM0YJnyXbAwtrn
dOwaJqqYa+4Lgwu5Q1ggwBb+WxV0mepmnqxoklVt2CZKBikvUX/1mOsFLMXiReOL
CilAIJZV/wI8RjdQdDubYHOoFk9dHKLOG3P7VmuUAMRIblyJzHAakvAQOlrbLn/B
T3+veXCekDI4NnmpVXkccwQBtH9divtocVVoIMXAP6R4cnCLVWkjP1gUKp6RAD1U
X4YR4FIHNw64Y0/EiABBTkuqEWpEJPybziRXk5+Hfb0r25csCx1N8ikNi0NhQ74u
rhHR6nYMnLGLMnS8AHvq2g6TRDsYRvWGVYqVmLoFDnPqCAosNqod0rVDs/MaoOjX
xEHEZS0Di0190FUuTQcQ5kvgTXpejC5BCN9vx2jVcWerseU12t1OsRTswWeBkYkw
ibHiV3iEiSY2oYtuOWEGVCcRHpWM1vzQd97m40C4H3GjvhQ2NhE14I5+d7rIEZHg
mTKRWDByU5aBpD7+tD9kNUxfo91GYLBwGBk/dliniYRcyysvTh/hi+S2PYR0O2ha
tOFl1+QuHwltgsF7WlqN48UeSo7h/seKva8+/XSmjO0kZ02w9rM=
=SbpS
-----END PGP SIGNATURE-----

--xbpbgedn63edpoph--
