Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 385352047F
	for <e@80x24.org>; Wed, 27 Sep 2017 17:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbdI0R2y (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 13:28:54 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:51125 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbdI0R2x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 13:28:53 -0400
Received: by mail-wm0-f45.google.com with SMTP id b195so20963530wmb.5
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 10:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=pp+IGvKHhPQX1PSDwA+GGpSWGvynZ3ha0vUnaTjZuj4=;
        b=qxlwrRqtyrS4Bx36ew2Mj7tKMWHjVrnFPKM7H7SDCoNmDrRRkaidrSm/ZfVRczF3gx
         tAT04vTSTF4G9WZ/aA1uqKTOnnbSEu7vrI3BpgmbWOwDJFaf52fveew4gIGEHPgnjeMu
         FRp5iedOF8CIhWooSiLP4EpXDakLnP0pmC3p32bOhaVMt69MpKGYptOY75dl3txGdieo
         lJgO/+KSs1Lo+GaiF6mcyTAkD17IetxRrHrY8yx/SVDtT5Ky9wCJETCzAu2xyk48XOqQ
         tYTs0zEijA/Nj1C0fjWmxGFIpBi4C4Ytw+tVhiFFYlm4YeZC9ANqrPFcGYw1ZclSM1UO
         o8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=pp+IGvKHhPQX1PSDwA+GGpSWGvynZ3ha0vUnaTjZuj4=;
        b=JD0IkNAcquyGwbX+SYQa9KvtMj3mTCZcRao/TOHcDyoJ0sOe6XFolcotLx5Mj4cLFp
         nJl5xVjXj8OfwqO1bj7xnTVzOUPO1xuwxJcpZcJRbFUgXyjs7/B6EatBHvA1QYgbdhqj
         9vNLFXjNdENs1tYILUbt6UBFL2gmZJiBGwSMyD9TLe3DLs7z3lEk4oEp3SFiIrT7ml3H
         IydnjgOU8MB2W600Fc2oxC73EEbaFNV5ZWkkzRYiLyVni3vneLaeVtQIyj+Dh/IJcu8l
         2zNfEY/69e9NnBxYOdWkjmI94aYMkJD5PkPzzj3TekH9Zy5mgNkmfrHr40S++agr+Ncn
         lCQQ==
X-Gm-Message-State: AHPjjUjf0vncu1DmDBzf0P4G3B59zwEiCqcm0pJbeREH0qLN4MFvSd1d
        1rqvfLV8r0pQcxy64Va1yo5zGV+l
X-Google-Smtp-Source: AOwi7QBm5SipQxQy5kc1u7zv3jGZ2tSFcjwRFWZ0vJ0VpddmX8zXPhiC7ApgaHhf03CaUB0heIXu+A==
X-Received: by 10.28.54.206 with SMTP id y75mr937196wmh.53.1506533332156;
        Wed, 27 Sep 2017 10:28:52 -0700 (PDT)
Received: from [172.27.233.198] (vpn-muc.tarifhaus.ag. [104.207.130.146])
        by smtp.gmail.com with ESMTPSA id f89sm4984387wmh.18.2017.09.27.10.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Sep 2017 10:28:51 -0700 (PDT)
From:   Toni Uebernickel <tuebernickel@gmail.com>
Message-Id: <38D148EC-B77D-426E-A7E0-128509590407@gmail.com>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F202CE60-EB5C-4828-A98E-CAFBE36D9569";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
Date:   Wed, 27 Sep 2017 19:28:49 +0200
In-Reply-To: <20170927170716.slqxje2tkh5ws5ak@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
To:     Jeff King <peff@peff.net>
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
 <20170927170716.slqxje2tkh5ws5ak@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_F202CE60-EB5C-4828-A98E-CAFBE36D9569
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

The previous version was v2.13.2.
I switched back to this version, and it works perfectly fine; without =
any changes to my system.

--
Toni Uebernickel

tuebernickel@gmail.com - https://keybase.io/havvg
https://github.com/havvg - https://www.xing.com/profile/Toni_Uebernickel

> On 27. Sep 2017, at 19:07, Jeff King <peff@peff.net> wrote:
>=20
> On Wed, Sep 27, 2017 at 03:23:21PM +0200, Toni Uebernickel wrote:
>=20
>> Hi there,
>>=20
>> I updated to git version v2.14.2 on macOS using homebrew.
>>=20
>> Since then `git add --patch` and `git stash save --patch` are not
>> working anymore. It's just printing the complete diff without ever
>> stopping to ask for actions. This results in an unusable state, as =
the
>> whole command option is rendered useless.
>=20
> What was the previous version that was working? It is possible to =
bisect
> to find the culprit commit?
>=20
> There weren't any updates to git-add--interactive.perl (the program =
that
> underlies the `--patch` implementation in both cases) in v2.14.2, and
> very few even in v2.14.0. Of course the problem may be in one of the
> sub-programs it calls.
>=20
> -Peff


--Apple-Mail=_F202CE60-EB5C-4828-A98E-CAFBE36D9569
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqtw0WfnqbGj2qtYvvngIZvYDXHoFAlnL39EACgkQvngIZvYD
XHrnig/7BzSB2rLd4dazF7yMC3cpU4k0k+Ioc2FWTXoTPcb2la1bhq3SzzFgJFJb
FVhwwq8jYkSMXg7uqynvrCQXPu6da57QHgQi3rR8XJ4FMwjJ7YSUMtXz7riBK4fh
DXyB+0yMmRRLfW/ejDsH7LoXtacxcYHfNAA42+FD6+bF0fwMx7SS0W0mN2M0QUP0
l4uuMT9VoUp/D9vUHr/Q6HyvbAOXJ43F3JL+ro0QCr9koKIzIBO4wAgIdewcxmek
+8oSMr8qgyUpWm2ynE6yRFd51yQZ1oBUnqfSQeA15zrsTni5cp9dO2LBzRG1sgh2
Saev0U/6O1IS02waQXhzV9h+Uxt1tL/ssZl+pJPMu2wdxlj/1nTvi3ldoMoGtyFl
VO3m8+oFJ6AyYC7G3AAWPTxkLKIvFGjfSYPiBvKmgY/pF7za64rBnf1bU7UG31rq
Z5CIv8rK6IO4NtRbsgYXj/Z8GHvrvG5pPqRwG+zM44zeS0Mq0rNNIifJAiYLSo/4
To2BICnJBTcEkrSuc7b9FePHNax5jdxx8V/kOuZFH9rXwWMh9P63OuEKOja6vIxK
hjMpY8xLmlgZ86qUIbiXGYMMhI3FqGau1raMmD9ZcFh5HZ42hRkVOV6huQtFP3u5
0EV7Cbyd7VHGXY0KyVaVu8FWfJWcVPFvc62Cbo6txXI63Wj0+Us=
=QSdH
-----END PGP SIGNATURE-----

--Apple-Mail=_F202CE60-EB5C-4828-A98E-CAFBE36D9569--
