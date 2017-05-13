Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FCA1201A7
	for <e@80x24.org>; Sat, 13 May 2017 02:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751123AbdEMCt4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 22:49:56 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39528 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750952AbdEMCtz (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 May 2017 22:49:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 82640280AD;
        Sat, 13 May 2017 02:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494643794;
        bh=wAM+9xesnccU9aXS+SSVZar9PktdsKqZ4s6/CQOF7AI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xejnIZJKqwYQK02baxI18jHmLVdxp43h6pyzA2Sx3H1rGGdLXiOREBDMY2JuvnapC
         9yT1xc7HILGBLmJx59SujOgW6fobgmycQTGI2ensaEzgoaepcDnYqeruSAuMxO2FRr
         6A2IkNv9FJ8C0X/viACusRu395czvcGCtfyeGnV1CeWZf0xQX1bAmGi9WtXCUP6O9m
         V6R68t59fYBs8FTekKD8z/ihqT6OeXihjiPS9BKgnY5kBLCVE/u7K6jp/GLVl8rgYe
         0bWRR2i/trzIgRkY8zd5Sa2MgNLloQjsa7+HxLUmlCp3I2sD+C0PzfwPMJrdUrjofy
         lii6NXdF+tiYDAQNCXuweW7FvAwYs/qmPVUK5s7U/3n8kok/PNBijE9673N+lMOfxn
         A0ZZpRvXxj4+fQR97mHWoaXgtt8NyW0TLV0uB//tSZ9mPbPQjIA2bAx8Mgo4m0wOpk
         gHxd8IApr+EM8XgKEIKGiV3D4A2xYrgaBHfFp1b2DWlLSeNn+De
Date:   Sat, 13 May 2017 02:49:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin/log: honor log.decorate
Message-ID: <20170513024950.qlk5vrdwwsquceyn@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20170512220704.txmdk45s66aqhexi@genre.crustytoothpaste.net>
 <20170512221221.406645-1-sandals@crustytoothpaste.net>
 <20170512233214.GE27400@aiede.svl.corp.google.com>
 <20170512233753.rz2g7quews4ny5iq@genre.crustytoothpaste.net>
 <20170512234814.GG27400@aiede.svl.corp.google.com>
 <CAMMLpeRkVsvp_fzt+bHSQ_F9gsMhYqej_oyqrjhAXsY1xs7=Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdt234axta2mijvd"
Content-Disposition: inline
In-Reply-To: <CAMMLpeRkVsvp_fzt+bHSQ_F9gsMhYqej_oyqrjhAXsY1xs7=Qw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fdt234axta2mijvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 07:23:04PM -0600, Alex Henrie wrote:
> When I saw Brian's email today, my first thought was "What was I
> thinking?" My mistake was pretty obvious. Then I remembered that when
> I wrote the original patch, I wasn't sure where to set the default
> value, because there were no clear examples in this file. Now that
> we've established a clear precedent for setting the log.decorate
> default (and other defaults like it) in init_log_defaults, I don't
> expect any more problems with log.decorate. And since it's not
> practical to add tests for similar bugs for every command and
> configuration option in Git, we'll just have to be a little more
> vigilant about code review.
>=20
> Again, I apologize for the trouble.

Everyone sends a patch that breaks sometimes (I've broken kernel.org's
infrastructure).  We try hard to avoid it, but we don't always succeed.
I appreciate your review on my patch and suggestion on how to improve
it, and I hope this won't put you off from further contributions.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--fdt234axta2mijvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.20 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkWdE4ACgkQv1NdgR9S
9ouThBAAxMLPW+AY50YNgzsW+dBUxo6B8lC4bH1e4jI5LlLdAyFNCSEA0RHi/SW7
wilIZKMD72ivLxuKL5lQBBfCLUvbJbCzsujg18KpTqoJISoCdAMKS3qbBmEPUEiT
664aj0gEcDtOsnTdfXqIoZP2TW6VxtQBo4Xrcb6NSE99l2FaRdWXzFMtFPJCOFP4
9cy4S4gDe34kjl4LRchPca2R2nGbCq9FurHnNyFW0Lt71Z67nxkscX8MZ0KnxoPP
3in2JDvCIAZ9LNlIVPkSqAm2R/Sns4rsk04sXUWu4W8XvhtIKiD2c1Hs7fXDxgKb
gtovO0sNRNSzS3zxrxnM25v7VEhIaoTQ8LGhweD2IhrlstDcswmW1LvVd4enknTF
KxyofUmBsYoXMw2/ciq42KZHtXRiOmbTANMSxB7pSXE0B+t8ZisgVTrnyK9ISRrN
cbBgsJ4HL3/i+6euILS9pelWPVhMOgSxE0x5+X7YYl0xIYUS7aVEYmWbMgGx8M0m
aJzRJGKcR/qCVwMba+DMCgIbl7fAbVcYffROc4WvmFJsUgTRHnJTTCa+eu52qbW5
JOlEgST1vQNF232qQnAUiutbFVpLofLOWpk5phCvM0BVEIPiDhseLtt2RLGTyNtt
ec7Et1XpD4HbOtH17DV8chvLzk0efw/uXMdyGIQfGZH0oNjkv+M=
=S1T2
-----END PGP SIGNATURE-----

--fdt234axta2mijvd--
