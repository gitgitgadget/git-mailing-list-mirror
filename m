Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E0CC6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 00:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiITAcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 20:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiITAcF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 20:32:05 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BD7520A9
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 17:32:03 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 15DB55A1DF;
        Tue, 20 Sep 2022 00:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1663633923;
        bh=S4tgjF1Y4tdov47cN3ioOVqSqVCQBicMcyzmSKXoj2E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=PfTwC2UMnqEE/aSmY64BylsA3sWbGtzCw1ID5/vXQHgkXii97l+RrcpRU+GtIZ1+7
         cWGwu9YestkJRIGywcdgNGrGCSyr9x9uM8p7w0HMh+JsOdC5K8dYWFDY/rx2h81kyT
         XtaZLd87v4Hu3FywY0+cRn31U5hxYJwKwMJezZA81dN8nRGQF9887Tyt95na3R0H/t
         wLQfsX3+oGDZD7FHQGpMATb98izotNOXZs5zzikxdfkkwPmion/cYc8gbmavfju4Bq
         GZFzJ7xq32wmTj/mCLXPUFO8S951W3YDDiZVlsPh7Mz2rtPHw3AySC1ZbVnQIh3yGW
         DBsdFawPBIe2/2HVIBCMO1NdhtP9P5z2boWunh9eE1aRkHR+SH9VyeNAtm9RM35/Vm
         k0i5Hj0CXJyEhFul7J2DG3VaijLbT7Ne04hCPJ3bQG4JoCXiygbkR25eS3u7bd2SL9
         LKoqD5PWP+Qj7+yFyb85+6FNU+upzhyg7YC9T1q7hic72Rx4XS+
Date:   Tue, 20 Sep 2022 00:32:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Florine W. Dekker" <florine@fwdekker.com>
Cc:     demerphq <demerphq@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git <git@vger.kernel.org>
Subject: Re: Wildcards in mailmap to hide transgender people's deadnames
Message-ID: <YykKARz//2mENrRH@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Florine W. Dekker" <florine@fwdekker.com>,
        demerphq <demerphq@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git <git@vger.kernel.org>
References: <2e846a72-a4c6-2a5a-255a-15eee037f574@fwdekker.com>
 <854127f2-55aa-5636-813d-d91b8a4cdcbc@web.de>
 <CANgJU+Wt_yjv1phwiSUtLLZ=JKA9LvS=0UcBYNu+nxdJ_7d_Ew@mail.gmail.com>
 <045e7914-ab16-4d5e-ea9d-8e3c7c758fff@fwdekker.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A8+mvSYOsUPZxRZ8"
Content-Disposition: inline
In-Reply-To: <045e7914-ab16-4d5e-ea9d-8e3c7c758fff@fwdekker.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--A8+mvSYOsUPZxRZ8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-09-16 at 16:59:23, Florine W. Dekker wrote:
> I understand what you mean, and agree that mailmap is just a workaround f=
or
> this issue, having been designed to unify a user's multiple identifiers,
> rather than helping move on from a now-invalid identifier. Being complete=
ly
> new to this mailing list, however, I feel that solving the issues you rai=
se
> might be a might much for me to take on.

I agree this is a bigger, separate issue that we should address, but it
shouldn't prevent us from doing what improvements we can to the mailmap.

> Instead, for now, I'm interested to see what we can do with mailmap as a
> workaround. I like the idea of using URL encoding, and would like to hear
> others' opinions on doing so. I think it provides a social signal on its
> obfuscated state, it prevents people from accidentally finding out, and is
> easy and efficient to execute.

I think this would be a fine solution.  If folks think the hashed
mailmap would be better, I can resend that, or if we like the
URL-encoded option, that shouldn't be too difficult to implement.

I do appreciate you taking the time to bring this up since I think this
is an important issue to address and it's come up a couple of times.  I
hope that this time we can come up with some sort of improvement with
the mailmap we're willing to take.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--A8+mvSYOsUPZxRZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYykKAQAKCRB8DEliiIei
gaWAAP9HjVKKC/ZDAV/zL9XEMIspRydCIRkOzAIzawNHUx8fhwEAvUoixm2BCLSt
GSoCPmMfxQ5Jm7MoaoSYbFGYH5rJRQw=
=0Vqd
-----END PGP SIGNATURE-----

--A8+mvSYOsUPZxRZ8--
