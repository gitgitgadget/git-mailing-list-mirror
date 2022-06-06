Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D7FC433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 22:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiFFWvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 18:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiFFWvr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 18:51:47 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9DB55AC
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 15:51:46 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 8CCE15A26C;
        Mon,  6 Jun 2022 22:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1654555905;
        bh=a7bdyZdl2/i3vbK9CfR39ZZfo+5oX+6wYrCQIeITrlI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NHrtpcSkz5KMyMehIBpw/lRDnUh/hrYVqe48FWtfs/95M3aIXywZWySVjqxQ2iiHL
         FGuAm4fc7VEoxcSlWlxJNTBHAhWjColBqhlZOLFe9PPCUNcevLEMKiR1jz9mu7InMq
         V+ohaiVLKn8IGtqRQvXZyEuvBYetLs1N184icAJtM5+X5xluLlvOeIc8LR9VmFRSTH
         JGhqX13p0VIfeDngVsdXv6iBHeZIpAnkFIILuq9TSUgRoJwh9eJZS6zoY1qT7dot7M
         Yb1iWnX4BQr8UeRW3kmNsIJD1AI3EQ8VTt+Xa4qMh5ApvnS/b0JeKyuiR7pxfd3th6
         8UHSRX2ESSyTm0WNKUR0UvriLNF4eImTFXTftLQbqLFSq+N/h6HKKa0KQbwGspYFGk
         DcHb3CNEqAYlA8FI67IEUPQWUfTBteDvKuHJ9txg+eDoxUJNYNe2u5pIoSUrNCCro5
         hTsgT/AuSsV2Wu/oxOOV/Audsk3YV2RuXTarFu3mICcmPg47k1g
Date:   Mon, 6 Jun 2022 22:51:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Laura Smith <n5d9xq3ti233xiyif2vp@protonmail.ch>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-config  gpg.program - more flexibility needed ?
Message-ID: <Yp6E/1ye2Wi1mn0f@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Laura Smith <n5d9xq3ti233xiyif2vp@protonmail.ch>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <cVbMAjbLsxZPKlRxZe1zSKBcPx60ss_U_7r5ew78Dv3TVnCTMoisvnDgQXAh-2i4Li41Id6TAsO-rpc4DBIN41lMMIzhGIYxcQcfJ2eBM8Q=@protonmail.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eN/D4PpuEJATT02m"
Content-Disposition: inline
In-Reply-To: <cVbMAjbLsxZPKlRxZe1zSKBcPx60ss_U_7r5ew78Dv3TVnCTMoisvnDgQXAh-2i4Li41Id6TAsO-rpc4DBIN41lMMIzhGIYxcQcfJ2eBM8Q=@protonmail.ch>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--eN/D4PpuEJATT02m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-06 at 11:37:18, Laura Smith wrote:
> If my understanding is correct, gpg.program (https://git-scm.com/docs/git=
-config#Documentation/git-config.txt-gpgprogram) is a bit too hard-coded ?
>=20
> There are excellent non-gpg CLI programs out there such as gosop, sequoia=
 and sequoia-sop.
>=20
> It would be great if instead of hard-coding the required flags that git r=
equires, users were given the option to override the flags.

Unfortunately, it's a little hard to override the flags because
different flags are passed in in different situations.  For example, in
some cases, we need the --status-fd output to properly determine whether
the signature is trusted or not, and people can either pass in a key ID
or not when signing.  There isn't really a way to make things abstract
in a useful way since there are so many possible permutations.

It should, however, be possible to write a wrapper around Sequoia or
other programs that would provide the necessary behaviour if you'd like
to use a different implementation.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--eN/D4PpuEJATT02m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYp6E/wAKCRB8DEliiIei
gb8KAP9CQe8ZMzSp/v77kp0V9j5l5E33PDoXdiAYd9Hhp0qGMwEAmxjbFyORNC/m
MDxYnI53ZPl/Tl522h9Vb78iwRQLYAk=
=J58M
-----END PGP SIGNATURE-----

--eN/D4PpuEJATT02m--
