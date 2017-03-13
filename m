Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67EB620373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754308AbdCMVoY (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:44:24 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38658 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754085AbdCMVoF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:44:05 -0400
Received: by mail-wm0-f54.google.com with SMTP id t189so50467141wmt.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Geu7fYms8++19uK+HJYZEOrjgZz5RuI1MqYb9Orqozo=;
        b=uCxlZNCHtuS2pVv8tvicvCi34JuT1c2jRNQqlyJs4b5jRcqn4Kw8tlJp5ng6aWbxDs
         lCdsrGDmVlii9ufEj1WcSXC2kXJ6/OJAgpN7JLPMI0PTBGQW+DCglaLJhASOrbDH336J
         CJi/RTpQldfPNDQwaN+a+tpf4IGk/0mVfkuQ8jkuqLQa1vlBAcuKDOqB8kdbIZA6K+iE
         7n4Rgw6YwQMB4j5Q77OukMe1brLwKqCbqHVz19FQYJ4QL5q4iAGKng88ucZz9btnkj7G
         wG7f04T0xjZzXd/khgTfwerdqbQ8BvQdZD4Y+KfsUHZvbKVyUaNYh5/O8cv7rghPI//T
         TegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Geu7fYms8++19uK+HJYZEOrjgZz5RuI1MqYb9Orqozo=;
        b=Dr9TiygSKDhkJCW5rYozB74pyzfh+lh352A2YvvoJt60A/jh2QY0XsJBRb+8CdbEtn
         ac7k87tls0Riv8x54e8vb/dh9AswX9igNvlvWDoiFlbX1Y/YxClc21j4xWK6dHgM+oWN
         ZutKIVL/EwrH3Y4a2uUmHUKDFeAWnuYejYug15S8YnPCQfQSTaerMLx5Kjnek/q5LOU1
         c0fp8tYJoPGL0DmtxwHl5gVwNQNiuwByIUIWmQ2Tl1ku0tHq8UkZk0cVhd8hpUj629Ik
         YkSYEY9b9VeWP8tDH3CvK5lLELS7qWK/rp1O8dTGi7uDFv+h30HULzygQsawLytBXiGV
         7pdA==
X-Gm-Message-State: AFeK/H0ZTVhqOiV4jbySJEk0wjOL9fr1T7Ai3xrkwTYIEoHnyot2iHhcQq/mzKykwWfpeg==
X-Received: by 10.28.105.92 with SMTP id e89mr10868326wmc.93.1489441443019;
        Mon, 13 Mar 2017 14:44:03 -0700 (PDT)
Received: from workstation ([213.149.51.172])
        by smtp.gmail.com with ESMTPSA id w30sm26573657wrb.5.2017.03.13.14.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 14:44:02 -0700 (PDT)
Date:   Mon, 13 Mar 2017 22:44:00 +0100
From:   Domagoj Stolfa <domagoj.stolfa@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Possible git blame bug?
Message-ID: <20170313214400.GA98717@workstation>
References: <20170313201104.GA32821@workstation>
 <xmqqmvcorjyo.fsf@gitster.mtv.corp.google.com>
 <CAPc5daVRX_-bJ_2reDLKJin9PNfy6EjbD14T=Mpx=9P8xzdmuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <CAPc5daVRX_-bJ_2reDLKJin9PNfy6EjbD14T=Mpx=9P8xzdmuw@mail.gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

> >> The question is whether this is a bug or not, as --since=3D<year> migh=
t not be a
> >> valid filter.
> >
> > I do not think blame ever was designed to work with --since, so that
> > is indeed the case.
>=20
> Actually, I do see that we had a cut-off based on rev->max_age since we
> introduced it at cee7f245 ("git-pickaxe: blame rewritten.", 2006-10-19).
>=20
> I do not know offhand if --since=3D2000 _means_ --since=3D2000-01-01 or s=
omething
> completely different, though.

It seems to indicate something entirely different. The problem with it is t=
hat
it mentions commits that haven't even touched the file though. Output with
commit hashes that have touched that file would be sensible, albeit wrong i=
n the
sense that the user did not want to see that behaviour.

For example, saying:

$ git blame time.h --since=3D2017
^e19f2a27ed8 (Domagoj Stolfa 2017-03-12 20:43:01 +0100  33) #ifndef _SYS_TI=
ME_H_

$ git blame time.h --since=3D2016
^21613a57af9 (bz  2016-03-13 21:26:18 +0000  33) #ifndef _SYS_TIME_H_

$ git blame time.h --since=3D2015
^48507f436f0 (mav 2015-03-13 21:01:25 +0000  33) #ifndef _SYS_TIME_H_

and so on, with different hashes.

Looking at these commits:

(1) https://github.com/dstolfa/freebsd/commit/e19f2a27ed82f616d47dd4e0dc757=
22139e72957
(2) https://github.com/dstolfa/freebsd/commit/21613a57af9500acca9b352895831=
2dd3ae12bb4
(3) https://github.com/dstolfa/freebsd/commit/48507f436f07a9515c6d7108509a5=
0dd4fd403b2

neither of them seems to touch time.h, yet git blame reports them to do so.
Interestingly enough, it seems to be taking the commit that is the closest =
to
the current date in that year, and blaming it on that one, regardless of wh=
at it
actually did and the file specified.

--=20
Best regards,
Domagoj Stolfa

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHQB+y96lmmv+IXofwxT+ikb0YU4FAljHEp8ACgkQwxT+ikb0
YU4QfQf9HBE43Qc2DDBYcKDGRuOi8/IkJSzPl1UmpJ0hEG5/iRw8ZyxiDWW4/h40
Q4j52NzqWkyACKEsebj52+jnHV6qB9ZdxGqczMyZOYA4rSDaSAuCmyVnQ/S3/tKc
h+eQRIW9edcd41o1+kdTVuRmAQK1FVLx1/1YTPXIoEbAqPH9g6JswQIo9/gCHIC2
m6nK7UyU6TdySdEaAmc3VEtjxVucdPEkf8/HPnlVF3T05yQ1pmhvz3UiGjMa8kGe
VvKzwrs/O36dvk4GtnaiCDx0TgI2Md77MpU5u3cE0xALlrVb6ScrNQ302ZNnxxYk
0u+Yg1Mo/DkeMExYz/i2/Rj3B+iwtw==
=98vS
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
