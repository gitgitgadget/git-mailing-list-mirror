Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EEC0200B9
	for <e@80x24.org>; Mon,  7 May 2018 02:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbeEGCae (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 22:30:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41400 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751831AbeEGCad (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 22:30:33 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BA42760444;
        Mon,  7 May 2018 02:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525660232;
        bh=OXe0/9e9uMKpuH0w9CJahhpfkl+WPydwYkqU4FBr3sg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bpVOrB4JCHjZVt/Q9e1GDYK/VUJmfjjUCDcuzMvIayferZ/jRGRwnnbkaGrsjYG6n
         TrAbU2teOXrPcaHlhQefPE2B+oph0PYJUXOsKNuxxWNLqcpdXtgnRjCaHlCpuy9/tp
         OVA4AkbyMcvSR84pls3YTZjUA97KV4hTLV0+izdaCJ6krIJnddhujjqaJXzflorQPV
         n8yD5HrM/vLbiqcv6C90RJEeQ5yeOQ0thOYYNs4ywKDmY7AMHp8qvktpnruZ57izHQ
         ISyJZroYeEtAPtlZu+dliimZSFf5+K8A1bbB0+7qcC2exnzYoSKpvmXuVE7IE0aIJI
         bEN6dFGAI6yZdtmYtuH7B8ycckpEeFTZMmPMisapxq/Hf0v5tOOSF6Uy1vihDQsQlW
         6s6xba7+vRQuySfzZ/atINq+ASmvP8M4WjUWVQ9NnZsE4Ea/Mer/Gpifi8GASkwZrj
         mgVPj2l8ASVG8+ZuXBSyhvVapUIejBvy5k5445s5SmY3uUbqTW3
Date:   Mon, 7 May 2018 02:30:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 14/28] t3905: abstract away SHA-1-specific constants
Message-ID: <20180507023026.GD953644@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
 <20180506231752.975110-15-sandals@crustytoothpaste.net>
 <CAPig+cQ7hn_P_xZW70X4vCztCr_r84+ofh_ApEbZwfQKRRq6Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline
In-Reply-To: <CAPig+cQ7hn_P_xZW70X4vCztCr_r84+ofh_ApEbZwfQKRRq6Nw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2018 at 08:03:27PM -0400, Eric Sunshine wrote:
> On Sun, May 6, 2018 at 7:17 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Adjust the test so that it computes variables for blobs instead of using
> > hard-coded hashes.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include=
-untracked.sh
> > @@ -34,25 +34,26 @@ test_expect_success 'stash save --include-untracked=
 cleaned the untracked files'
> >         git status --porcelain >actual &&
> >         test_cmp expect actual
> >  '
> > -
> > +tracked=3D$(git rev-parse --short $(echo 1 | git hash-object --stdin))
> > +untracked=3D$(git rev-parse --short $(echo untracked | git hash-object=
 --stdin))
>=20
> You lost the blank line following the previous test.

So I did.  Will fix.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrvukIACgkQv1NdgR9S
9osotQ//eCAu/AOpOWlPdZasTYgjrYbm+d8SP56/3U6nC20/+goDbFSXhMMOP1um
szt7mVBWeZaxpjVIrFy/uMlXxrDIfjB5gHKgNmCnQgySW6Ermf0XUQCW5JUJfyls
6ONDcuj1YySRvRQ1KloLQZm4bdcooWNyiGN8Expq/GKGGRuDVPDbuEc5c4BtNnzu
kyqB5JjVf3xJSHCqF2Q0i9an3/B3nqFkNBGe+LLFLoMdHL2h3xWSekufXNDPyAY/
IKgrrlhRpveYMUHw4B3Wtj3xQ4y8oA3sC58om9iwZnJX2Hbfu8cnQKTu48LWwt5S
OqUbvKGPf9Emw6aRSictbe4nTEHBUymu80ywCEXOgXp8tFi5UDRBY0JVCUzAiTkx
p44t/SK9QVtGe0fGHldzuan4AK70dWJvq/UQNg1kehjMeph23xAkpcdvUUYM3TTv
tuAuO4K591gABn2/07+zNXNCmlaCwqYw26CB2o/LlMLDS5E6nBYptdhg0n+1wOLT
4KD+ua2CUu6ZmXUv6KCIvJLhiudQJBbF28DF7SIaEg36VfFb/rkWen7UYHka2J6m
72iGuoinpvr6DclZwjeZ9HirCvrmZLCGP3AwxLTqVz5rlfh1LP6Wwg4lUCVdK/LT
iLWNaPH026gFG0KXSzIk1l1dcqaqWJWjZnranL0/KHQVc5m9yzc=
=MDV5
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--
