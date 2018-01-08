Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41BC01FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756563AbeAHUtG (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:49:06 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:43666 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755717AbeAHUtD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:49:03 -0500
Received: by mail-qt0-f169.google.com with SMTP id w10so15275059qtb.10
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 12:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KUajm8J/eCOLirvNHw49Q60HtWjHd7BFk6as63f/tWQ=;
        b=EI7B8kLXxADblUgmvMaw3ULjDe4mJ+yatW6GzY6+6V+6tJFYB0iJfHpDVJExLP0kfe
         WVGL/LP1XLTsunbJEyFw9vhbZe9qM2AMblk/eBb4CdsPHh6X/psQ07MeXOzajPvZSAeu
         iulG0sBMjd0tghwyr8pd7Wg4nPkWcZgs0NM06olTanzb/d1LLZPmWnNvf7+CacJyutEZ
         tcBKrHOMSPsk7r6Q0SZpjEep0PCWj788q7/WIxe7P0enVyWt6OzyWJFlpMWS+jhjcCW/
         +rStJAZ+uGVp8Z1Z4+5uzkOO2C4xvfApEXrF3pN/00MwKTFaPj2wZheAAEsjEwQ8/+48
         dT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KUajm8J/eCOLirvNHw49Q60HtWjHd7BFk6as63f/tWQ=;
        b=gqXhmyM+fovilWOTmrjeZxav/OPuOdj1guUT2R63E0vKjq/gwuKIJYNA5O9dSxjryu
         QLcwXajwv3Lv/VqVB4Fj4zaMXCtAmMq1Y5zbiedkAfep0hravb6fzRwlVV+soPEdUgp+
         ak02vTJVZH0bWB/qvdyGsqpaL+u02FNuFvoX3h0A2zgc5E9em5W4wqjTvt8RzGIYY8Xb
         560VPB9CTFNY4N82x1G+uee425pDg3GOL6Xsg+9jqPonlAPhapB/wy5krT8OQ7Hl2jqH
         GYzU98i12+npguPWAL/2FFNRBx6+4pUVr+fWLXfnbORkt05FV8iLtzd2w3GkQllHDCov
         wBag==
X-Gm-Message-State: AKwxyteLhWA4zziOJi90Oi8Fd5l/yyJfBUDOimM+l2mPRrNgY6W32MmY
        4WJitELHY7No4aG7gRqJasukow==
X-Google-Smtp-Source: ACJfBouwx8qGFmQcSJqMrwPg9ypRXsSx7Ks3KRdk5/SnfKDPhpU+wfpJhUSqS5UJcZYa5stTpQzyqw==
X-Received: by 10.237.46.66 with SMTP id j60mr17947334qtd.168.1515444543049;
        Mon, 08 Jan 2018 12:49:03 -0800 (PST)
Received: from LykOS.localdomain (216-165-95-146.NATPOOL.NYU.EDU. [216.165.95.146])
        by smtp.gmail.com with ESMTPSA id a19sm7859396qtj.74.2018.01.08.12.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jan 2018 12:49:02 -0800 (PST)
Date:   Mon, 8 Jan 2018 15:51:39 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Colin Walters <walters@verbum.org>
Cc:     git@vger.kernel.org
Subject: Re: upstreaming https://github.com/cgwalters/git-evtag ?
Message-ID: <20180108205138.jak7ahdppotgcckz@LykOS.localdomain>
References: <1515442320.3241451.1228399576.66D7DA96@webmail.messagingengine.com>
 <20180108204029.m42qyezojak4kohh@LykOS.localdomain>
 <1515444153.3249266.1228432904.51A92479@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4kklgdnkwqwlsvdw"
Content-Disposition: inline
In-Reply-To: <1515444153.3249266.1228432904.51A92479@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4kklgdnkwqwlsvdw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yeah, I see where you're coming from. I don't think push certificates
have caught on yet...

You can read on them on [1], and also under the
Documentation/git-push:147.

There's also another PR trying to make a sample hook for signed
pushes on [2].

The basic idea is to push a signed data structure with relevant git
reference information as a git object to avoid a server/mitm from moving
references around.

Cheers!
-Santiago.

[1] https://public-inbox.org/git/1408485987-3590-1-git-send-email-gitster@p=
obox.com/
[2] https://public-inbox.org/git/20171202091248.6037-1-root@shikherverma.co=
m/

On Mon, Jan 08, 2018 at 03:42:33PM -0500, Colin Walters wrote:
>=20
>=20
> On Mon, Jan 8, 2018, at 3:40 PM, Santiago Torres wrote:
> > Hi,
> >=20
> > I personally like the idea of git-evtags, but I feel that they could be
> > made so that push certificates (and being hash-algorithm agnostic)
> > should provide the same functionality with less code.
>=20
> What's a "push certificate"?  (I really tried to find it in Google,
> even going to page 4 where one can start to see tumbleweeds
> going by... I'm fairly certain you're not talking about something related
> to iOS notifications)=20

--4kklgdnkwqwlsvdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlpT2doACgkQRo8SLOgW
IpX6+A/+LYL9N9LYRybcWt67abVbMxkEhPxRUeEvpGcEjj/cb7KZeHFShT59urVx
KeNb+9+9Bttknm6GGUi9c4OtHMHZ83+wXWkW4R1hvtHWW5iMyDnMkP4Ez7SYQCel
p7hlSWEuJjO0bZ417jJ4wtmGoGKx2h6VhvBZV74GnbQznKO9p5uWC2/PSB0976QC
AheYsJCO6Elh3RKR6gZr5K3BUd7LE/whNq2LbeHieyWTw5ZOINXPwC+lwp/WR1A4
iYNoiJRXjg7xuNtn1tGJuJsxuy9pDWm3DvCfRSpqtk4xvHoLO6rJfANO/blAkm4b
pcGwt9985ALWrA3qaY8urMF8zuhNpB6DXA7qwJ2VMHczuAvujnSwL+Yt3CeDuCSd
Uufv2IwEj1KYFTkSNqGqi69mpx2ZIPhdcYRiNTqGNdkOH8w9V2JXkT2V1R/YA9VR
RDBnLZkxFqnNUra7mlXavF4DtCG9SGgAe7LG7UL3/PRSjes/eJEG/CFBILpXpqvu
q0oQ7JnKt8DYD3EuiuUZIvPcdESjIcZL5SmkzP4UrCVlLebgUZtoeyTpJzizn5vX
tDybt9YVqd/KzKTdCOqlzg/TtBPsFRtz+rUtvL2Q//PG+pWWqY2Ami5Oi60G07e1
9CMhZrNDEDt8NN2XcdNT5Bv+ayftDvMKjVYeSUDZ7waRz9IzEHs=
=CxHX
-----END PGP SIGNATURE-----

--4kklgdnkwqwlsvdw--
