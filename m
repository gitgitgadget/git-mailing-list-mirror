Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB60C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 00:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 939902078E
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 00:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgIPAfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 20:35:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60440 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726905AbgIPAey (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 Sep 2020 20:34:54 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ACA7D60489;
        Wed, 16 Sep 2020 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600216493;
        bh=AF5mM1l3n/7zHeFJuQn73beAdGy6jU3w2mvE2M8979s=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=SAu1YM6jeCOVMmun+L5J0KrscjYHtcn9rAflY1KbETmTLRNlJNt4VWACgiTtTVaMF
         g/TG8F1LYUKw6Yq85kxYQLgo7JO2pJxaiJMylNEjzBd/YvvdSHo2YrIl1Pvl1p/v14
         lncLiF0GvqHIyhwOzCzCSKVyJ7dvjloDDL0vzcq8w0aj4P6YPFIzcQlm7Xc1LJvBdI
         w0JcF7OyXutTA6l1Rhqdn5G/yX0r81uu/0Wk6NCQtBrCqUuTozhJR3RGtsIVLjygR1
         mhIyRZ9PDJBtJYrcCHjVWXg0xmxS1oJxROinS38luAbQkLh0PtlpTMJ5uNQ7cGS/aR
         uCMJBYAl8fxq+oARsOi15FWQ1h84DLQM68HtTLjbNBuMph0Oo4rrXnVgI5drundB+8
         4/AveW8xgqBq8VHXSimRItg1DwFEDMHr91FLIcerXS8XyNOmDhKpMbQu8Ko2edORTS
         Q6hk2XL8zOrQijAPzV9RmLVBwgoDFIO5b2hTH4AdDKpBx5P/wgX
Date:   Wed, 16 Sep 2020 00:34:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/2] t5534: new test case for atomic signed push
Message-ID: <20200916003448.GH2866143@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Han Xin <chiyutianyi@gmail.com>,
        Git List <git@vger.kernel.org>, Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
References: <20200915095827.52047-1-hanxin.hx@alibaba-inc.com>
 <xmqqv9gezsr9.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ewQ5hdP4CtoTt3oD"
Content-Disposition: inline
In-Reply-To: <xmqqv9gezsr9.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ewQ5hdP4CtoTt3oD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-15 at 20:31:38, Junio C Hamano wrote:
> Han Xin <chiyutianyi@gmail.com> writes:
>=20
> > In order to test signed atomic push, add a new test case.
> >
> > Reviewed-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> > ---
>=20
> Thanks, but nowhere in the above it does not say what is being
> tested.  By looking at 2/2 (by the way, these should be a single
> atomic patch, not a "failure turns into success", as it is not even
> a bug fix), readers may be able to guess that you want to enforce
> that with even broken implementation of GPG, an immediate failure to
> push one of the refs will be noticed by looking at their refs, but
> it is unclear why that is even desirable---if you combine the two
> patches, you may have a better place to argue why it is a good idea,
> but a test-only patch makes it even less clear why the new behavior
> expected by this test is desirable.

Yeah, I find myself a little confused by this, and I think maybe a more
verbose commit message could be valuable in clearing that up.  I think
what this series is trying to do is check that if we can tell on the
client side that the push will be rejected, then not to invoke GnuPG to
generate the push certificate.

If so, that would be a nice change; after all, the user's key may
involve a smartcard or a passphrase and avoiding needless hassle for the
user would be desirable.  But even after reading the series, it's not
clear to me that that _is_ what the goal is here or that this is
necessarily the best way of going about it.  Telling us more about the
reason for the patch would help us understand the change and why it's
valuable better.
--=20
brian m. carlson: Houston, Texas, US

--ewQ5hdP4CtoTt3oD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX2FdqAAKCRB8DEliiIei
gTumAP968QaneoIWUQxm3TNr4jJzL0DBXfyewoIzzkRQPgl2fwD/YrMJHwvkCk6j
Z2Eu9BZEhYSHtDP/+PdVz1rNUT7qQQo=
=XIPT
-----END PGP SIGNATURE-----

--ewQ5hdP4CtoTt3oD--
