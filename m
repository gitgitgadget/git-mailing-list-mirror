Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95829EB64D7
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 01:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjF2B7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 21:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjF2B73 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 21:59:29 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E040F2D7D
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 18:59:26 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E77B55A215;
        Thu, 29 Jun 2023 01:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1688003965;
        bh=YU/Gzf2VbHfgCKCwpES23EgdOmFhXTWpiH2KAWM3KuM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fWNyV0kk/7Dn7KYZr3F157DRDYbyeTvunTdYCejQBfkyCfqIELVADCEgbFsSLKVpk
         +R0mBrcasacAHv2UMOQmb3mVKdSZ2viN4itphaZnJEORnzGBK8N3MQcxKi/FIrG48M
         H/ASIZrJbvnsnu8t0YoO8FmsIbDi8B7ISV111/HK50S09Is4Z3RH2Nn+L0AAI3/b8U
         uURwB5RayeCgKICuH39KdoDVAIO2nGQ40AbBHFATQU9lInruf+Gx5kTzfu1aV+1LXi
         4xc0D3wPYyYjjVJl3FP0kgqW9x1oE4lBRtgK7bK6G4XkfGUHHyj+iWVMKXtX+SQ98w
         jCIZnl10HBDEQAgoo1Y+NcTftXfIiUAXXghQWCBbb19PqyTonEgaYR3+w2xBmmjiCA
         sP+ZxMUQy952geu34oD9ebhZxAhYSPhldmD4I3/NTYHMxH/DmJ6QTDcMDMUgEysET7
         EqmZ4rijfgQ3m1Go/bcN4hBg0FJNmXKTDT450C0zF2YeBpgvxgD
Date:   Thu, 29 Jun 2023 01:59:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Adam Majer <adamm@zombino.com>
Cc:     git@vger.kernel.org
Subject: Re: SHA256 support not experimental, or?
Message-ID: <ZJzlezhHk4HpPmRk@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Adam Majer <adamm@zombino.com>, git@vger.kernel.org
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D9/FUMzfvimdS63r"
Content-Disposition: inline
In-Reply-To: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--D9/FUMzfvimdS63r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-06-28 at 16:28:28, Adam Majer wrote:
> Hi all,
>=20
> Is sha256 still considered experimental or can it be assumed to be stable?
>=20
> The usecase here is we are planning on moving to sha256 repositories most=
ly
> due to integrity guarantees, hypothetical or otherwise. What is important=
 is
> not the initial interop challenges with sha1 repos, but whether the on-di=
sk
> format will remain compatible with future versions of git. At minimum, the
> on-disk format would be converted by some future version(s) of git into
> another one and not be an end-of-the-road because it was "experimental"
> where dataloss is an implied risk.

I have no intention of changing things at this point.  I think it should
be viewed as stable by now, and I'd support this patch, although to get
it picked up it will need a commit message and a sign-off.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--D9/FUMzfvimdS63r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZJzlewAKCRB8DEliiIei
gT3AAQDQ0feFIa2xw00EwJylH1glODIs4gVe+hm2fzLQdK28QwEAlmnqumnmnY2i
Lob5I3fw1ln2g1NB5VyL+uLMCZxaQQo=
=EkVB
-----END PGP SIGNATURE-----

--D9/FUMzfvimdS63r--
