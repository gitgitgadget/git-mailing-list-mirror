Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689061F462
	for <e@80x24.org>; Mon, 29 Jul 2019 14:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfG2ObP (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 10:31:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34514 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfG2ObP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 10:31:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id s49so24694189edb.1
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puck-ch.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=5DO2cz7uykhRRtZhQ47xHcOe1xV6g1hRCK35sUs6GWU=;
        b=ONKYPA47MwC/AyI84c9Qtfe8Sd8Uw9HPLQH8hevapHHoKa7m+7rStQm4epn40w32rM
         HkbAQUNelsP2eOXrwMhZDEpW3LSPB3H7QsabLEz5ioJVh8PfE7XoQPC+foNOQ80Qrx8T
         UTx9Pyp7k4zA1anemQgz8806BeD1FSbJztbzmK9FyrDgIXAzWQVVNykcUH07dHM11+Na
         m9/igubeBssCHFo/oygUck5C2DuKK4W5EY8nv3B2Sl2mOSOTHxbvhUXYTFwMiuwjTkDB
         cj3FSym/9QB3q5nPdfQfHNcjqrpOJoMShUdem9AcmMFtIfFivo4ZzHGLtE6lWG3p6+YK
         KX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=5DO2cz7uykhRRtZhQ47xHcOe1xV6g1hRCK35sUs6GWU=;
        b=hjdvxHY+pkQJn/I6BvjZ76gTworxJA+JraPQXEzkbvVipZWo1tmGdsGxXQ4F3b7lg+
         6944V1bL/CV/JzqiqWGkmfHCIEjK4wz/cNsHbMzNLSM6F4APKN2e92qyeGc+R8C3kDZj
         YwzVH8oJKUbswUhiETCHpZb/OcZBtkfMTd0TPT21Yoy7ygY3igI5C1Aj5Kpgcc+jjN2f
         LAqNbIVhADzl7cSrn/BSlm9DM1o2eWJ+3iuhWwht4pE5uWAwoYrtusMsPACkdznJzuqc
         y4mPEsIS436itl1/5M9C1emLXbHE+sp+TgbVQDBfjqUV8s+CUHBDd3NKiYRk/LxQqpyF
         3wkw==
X-Gm-Message-State: APjAAAUQ6D2RsQTeh9KFltAe3VITyoK5xwWtWzJ4d5JchtSkwUImOG8w
        IzMTSM6dBy6fRDnP6weUF/KjaL4=
X-Google-Smtp-Source: APXvYqwHvgawc+5gnfOUsoxs+qXP7+avOt50vTZ8bJM8Sej9cPzTChmV3SSK9La5sKCb3L3iHJ/75A==
X-Received: by 2002:a17:907:20db:: with SMTP id qq27mr84575455ejb.30.1564410673359;
        Mon, 29 Jul 2019 07:31:13 -0700 (PDT)
Received: from developix01.idiap.ch (171-180-109-153-snat.guest.idiap.ch. [153.109.180.171])
        by smtp.gmail.com with ESMTPSA id u9sm16201280edm.71.2019.07.29.07.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 07:31:12 -0700 (PDT)
From:   Olivier Bornet <olivier.bornet@puck.ch>
X-Google-Original-From: Olivier Bornet <Olivier.Bornet@puck.ch>
Message-Id: <10AB3C94-B14E-4F5F-AFC6-24F42A2FA5C1@puck.ch>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_998C66F9-A560-4750-827E-3ADA976DFF30";
        protocol="application/pgp-signature";
        micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Problem with fsck and invalid submodule path in history
Date:   Mon, 29 Jul 2019 16:31:07 +0200
In-Reply-To: <20190729093928.GP20404@szeder.dev>
Cc:     Olivier Bornet <Olivier.Bornet@puck.ch>, git@vger.kernel.org
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
References: <9C668779-15AC-4099-AAFA-7FFF519D426F@puck.ch>
 <20190729093928.GP20404@szeder.dev>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_998C66F9-A560-4750-827E-3ADA976DFF30
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello,
> On 29 Jul 2019, at 11:39, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> However, you can tell 'git fsck' to ignore it using the
> 'fsck.skipList' configuration variable (see 'git help config'; for
> some reason it's not included in 'git fsck's documentation):

Thanks for pointing it out. Thanks to it, we have managed to handle
the error with our gitlab automatic fsck procedure.

Have a nice day.

--
Olivier Bornet
Olivier.Bornet@puck.ch



--Apple-Mail=_998C66F9-A560-4750-827E-3ADA976DFF30
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF0EARECAB0WIQTQBq6Ke3j78UKE67h2PdH8xT2SGAUCXT8DLwAKCRB2PdH8xT2S
GNehAKCDO+/11sbWJ5ccOfOfosZzEWaEAwCfUZ+dblBtojhcqmtes/0nxhvWXng=
=pA0x
-----END PGP SIGNATURE-----

--Apple-Mail=_998C66F9-A560-4750-827E-3ADA976DFF30--
