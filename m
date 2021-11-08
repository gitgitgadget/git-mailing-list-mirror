Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D134C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 02:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5491761351
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 02:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbhKHCMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 21:12:39 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51018 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232513AbhKHCMi (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 7 Nov 2021 21:12:38 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 828496048F;
        Mon,  8 Nov 2021 02:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1636337394;
        bh=ZJQIeaWNJ0Zf5D45a00SkzC8q6mvmjqw4fHYMCCziMQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Qq2Wb8xEXOWHEB3VQMfH9IyD6a48Fpkyr7u3l6vDRnzlwEX4nVrwzgAFMteKqIdhG
         SmdMJUXTc1AYiWMEH6Rm4J4MMUq1IIFVW5Z/kIUQarDTu2JZYJOuYb4wKskxfBVnYz
         1J1GjLDrsTQ7dZS7kzOerT7PKoMtNBMMPorUkc43JAgafPx4tjfzYPUqOClVPlBdkV
         FQOSju1NKcn7f5lnRHATDLnrb6T+XIAi+nWNi76+bJKp2PinzLhqPDYb/JesWP+/Yd
         P4/uj6O9Q6HarN0hJMzZloB9Z3iXaGTh8pl9vPas+8AozPyfixtkjmiCUQ5rXn3byd
         SprSC8aMUHM2Vuw3UhG6egUEH8JnC0qXNXWYSyG0iNwwONP54Asj+jG4s9wI2qaKlS
         PFyqMLbnzBZEx0nm8MTVm1EIT30HyYWo5aGbpKqC0EPZFpPPMXl6LoGLZmCnBJavbz
         MxNkUFQCYl3OG6xcr7+t/92IPNdSNIAB/SbG3DlAxNERhIECWiI
Date:   Mon, 8 Nov 2021 02:09:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/3] gitfaq: give advice on using eol attribute in
 gitattributes
Message-ID: <YYiG7rTkElKbucl0@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211107225525.431138-1-sandals@crustytoothpaste.net>
 <20211107225525.431138-3-sandals@crustytoothpaste.net>
 <CAPig+cRkbjt=bJngcbzVPRGqY=14Zs57V0i=RR_5=m+k8fu+hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hxmTCxR40i3X41Om"
Content-Disposition: inline
In-Reply-To: <CAPig+cRkbjt=bJngcbzVPRGqY=14Zs57V0i=RR_5=m+k8fu+hg@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hxmTCxR40i3X41Om
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-07 at 23:48:00, Eric Sunshine wrote:
> I like the concrete explanation in the commit message of why `.sh` and
> `.bat` files need to be configured specially, and was expecting that
> quite useful information to be repeated here in the body. That does
> seem exactly like what someone would come to the FAQ searching for,
> and even though the above content hints at it, the hint may be just
> vague enough to be overlooked. Consequently, I'm wondering if it ought
> to be spelled out more explicitly here. In particular, if we give
> examples of actual error messages people might encounter when
> attempting to run a CRLF shell script or an LF batch file, that would
> really give a FAQ searcher/reader something to latch onto when trying
> to solve a problem. This could be done as a lead-in paragraph
> immediately before the "For example, the following...".

I think that we could definitely add some text here to explain why one
would want to use this, providing an example.

> Also, following v1 review, I think you had intended[1]: s/end up with/hav=
e/

I will fix that in v3.  Thanks for the reminder.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--hxmTCxR40i3X41Om
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYYiG7gAKCRB8DEliiIei
gbyUAP9dy7dM82UI3UI35jhEHOenajGcqMk5fye+qKIUWPCxLwD9HPzgp+KsmID6
S1kZcIlYi2V/4yoMERakVJzAEZwTow8=
=7fL2
-----END PGP SIGNATURE-----

--hxmTCxR40i3X41Om--
