Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D4CC433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 17:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D808207DD
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 17:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AL0zQtKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgFRR4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:56:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39386 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728109AbgFRR4T (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Jun 2020 13:56:19 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 21CB76048A;
        Thu, 18 Jun 2020 17:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592502948;
        bh=Aj5pW5jYTZt4gpRaXT9QDjSBiTlmakWiOCIZ5GamNJk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=AL0zQtKbkFvYxcHTFU3Siicfu5fkAi+3lzEY9hfbzmlNBCK0svlsxhZfLLAPuVEs1
         q8Ky8ysay+Qo6JvvgWMvCLtovBSDZDpW/noCM7Pz339g/M0lTTJwS5/S+IV5wvfOwf
         i7rPUTWlA8nh7Ap+fEdCz5NjyuYZW20xUR66ZaNbY0o0aglFiAZ6LGKf33yF22AuDK
         C1zgUprrjVob0DyK7vq9/NmHxwHonY5kzppQn9on5Cpv9UV0uDwbT4cRK90EzxuT6J
         VdJzgTOGZwcgGJrb8lbBDgsdzw0lrLCaBGaFbhbfKgOmM92C1zowqzOr2LVjHdm+Fw
         F57CJeo51U/wBujyx443QZBfGFhHr3FtTbtDxIAddMzUkeqywp5hsAkLM4ukieGSK3
         IWzRQ+h3b8U3YOQsEUU+HwnMlqxHTrTuR0fz69JvYswGD/nBTaADVTsqZkeZirHOUX
         FLVvew72dGJ1lH7vfT2Oe96JT/wftVyD7a+AaRNNFhOr+QQsDI8
Date:   Thu, 18 Jun 2020 17:55:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2020, #03; Wed, 17)
Message-ID: <20200618175544.GJ6531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqpn9wq3tl.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3bvv0EcKsvvYeex"
Content-Disposition: inline
In-Reply-To: <xmqqpn9wq3tl.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--u3bvv0EcKsvvYeex
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-18 at 06:35:18, Junio C Hamano wrote:
> * bc/sha-256-part-2 (2020-05-27) 44 commits
>  - remote-testgit: adapt for object-format
>  - bundle: detect hash algorithm when reading refs
>  - t5300: pass --object-format to git index-pack
>  - t5704: send object-format capability with SHA-256
>  - t5703: use object-format serve option
>  - t5702: offer an object-format capability in the test
>  - t/helper: initialize the repository for test-sha1-array
>  - remote-curl: avoid truncating refs with ls-remote
>  - t1050: pass algorithm to index-pack when outside repo
>  - builtin/index-pack: add option to specify hash algorithm
>  - remote-curl: detect algorithm for dumb HTTP by size
>  - builtin/ls-remote: initialize repository based on fetch
>  - t5500: make hash independent
>  - serve: advertise object-format capability for protocol v2
>  - connect: parse v2 refs with correct hash algorithm
>  - connect: pass full packet reader when parsing v2 refs
>  - Documentation/technical: document object-format for protocol v2
>  - t1302: expect repo format version 1 for SHA-256
>  - builtin/show-index: provide options to determine hash algo
>  - t5302: modernize test formatting
>  - packfile: compute and use the index CRC offset
>  - t3200: mark assertion with SHA1 prerequisite
>  - setup: set the_repository's hash algo when checking format
>  - fetch-pack: parse and advertise the object-format capability
>  - t5562: pass object-format in synthesized test data
>  - builtin/clone: initialize hash algorithm properly
>  - remote-curl: implement object-format extensions
>  - transport-helper: implement object-format extensions
>  - docs: update remote helper docs for object-format extensions
>  - builtin/receive-pack: detect when the server doesn't support our hash
>  - connect: detect algorithm when fetching refs
>  - fetch-pack: detect when the server doesn't support our hash
>  - connect: make parse_feature_value extern
>  - send-pack: detect when the server doesn't support our hash
>  - connect: add function to detect supported v1 hash functions
>  - transport: add a hash algorithm member
>  - pkt-line: add a member for hash algorithm
>  - connect: add function to fetch value of a v2 server capability
>  - connect: add function to parse multiple v1 capability values
>  - remote: advertise the object-format capability on the server side
>  - wrapper: add function to compare strings with different NUL termination
>  - connect: have ref processing code take struct packet_reader
>  - Documentation: document v1 protocol object-format capability
>  - t1050: match object ID paths in a hash-insensitive way
>=20
>  SHA-256 migration work continues.
>=20
>  Ready???

I found one slight bug in this with regard to cloning empty repositories
with the dumb HTTP protocol and will send out a v3 before Monday.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--u3bvv0EcKsvvYeex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXuuqoAAKCRB8DEliiIei
gfTFAP0QWLXdNXFCwPt/bWx9oFUFLZHq1bpSHKXMJcDJ6LemvQD+M+hgCjwfudei
VPM1zmVrCntLGX3xfOkPXqZq7MkPaQk=
=hRR7
-----END PGP SIGNATURE-----

--u3bvv0EcKsvvYeex--
