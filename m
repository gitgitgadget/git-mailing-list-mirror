Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA0DC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244637AbiBOWqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:46:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbiBOWqY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:46:24 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ECFF7454
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:46:13 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B5B2D5A062;
        Tue, 15 Feb 2022 22:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1644965171;
        bh=36fk+edsOYOAFcblrPIh2xWBvr4vjJFZb8E42+VFa5A=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yh9dSXEJRt9YBIvAUfLoJklYVBDa4J8qr9Wj3OoPZPE9wdp4Ftp+z2dx+i7NQTGvb
         q+62ztpqkJh82RwAJJkFGWfKlkHOobiaMEQKuU95S8ECi0cCphx9TxNkmq7+o8mmky
         ew9XrDdGfllTZy/pfWbxlHIbzjqObrihgfIpOJGooTQj35eVrh/JihC7zIL/YhJ2fF
         FKMlmo+/9CXEepwdQxbvFTnUv4Pcv1NSqaow0NY55JngIy0cdKbLTElsmgT76DBS6h
         pgntcVVhefUcnanK7+cWd/aEG7upq7XRV5rwveWqUEHVDw7Q4oCN5MxF1jHkGZn0lq
         FYGxu6b9d3wesNBwAeQOmY31TpY+0b2Y7SMWcqa4zwqP8yeI4sA2/QpWoVQr8kl81M
         SDeA6ARJzP5e2gN/oQBheMWppkA7BkqzWanYl/C4MWGUxHCvmmOIr2i+tbByrybJ3E
         zFurUVqutEoErFd40M7HIS86nDzR6X2VKD82Lki+aNsKIc+4XWR
Date:   Tue, 15 Feb 2022 22:46:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Improvements to tests and docs for .gitattributes
 eol
Message-ID: <YgwtMhuODDcVWEd6@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
 <20220214020827.1508706-1-sandals@crustytoothpaste.net>
 <xmqqilth2u28.fsf@gitster.g>
 <20220214204631.mquj645jt5qajwku@tb-raspi4>
 <xmqq8rud0ytj.fsf@gitster.g>
 <9ab7761a-ff63-f809-47af-033825e5779e@kdbg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q37AJVP7lvtcCXKt"
Content-Disposition: inline
In-Reply-To: <9ab7761a-ff63-f809-47af-033825e5779e@kdbg.org>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Q37AJVP7lvtcCXKt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-02-15 at 07:05:44, Johannes Sixt wrote:
> Sorry, I don't find this description clear at all due to the many 'or's
> and 'and's and no indication which parts belong together. The original
> text was clear (but, of course, not helpful if it was wrong).
>=20
> I suggest to rewrite the paragraph into format with bullet points:
>=20
>    ... only if one of the following is true:
>=20
>   - is set and foo or bar
>   - is unspecified and either
>       - this
>       - or that
>   - is set to auto but not...
>=20
> or something along the lines. I can't propose actual text because I have
> no clue what the truth is.

Unfortunately, the fact is that this behaviour is complicated.  I can
try a reroll with a bulleted list, though.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Q37AJVP7lvtcCXKt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYgwtMQAKCRB8DEliiIei
gZiLAP9+LeUynUv7oBtNYsCM/lNNrLaeOPulPYZW/mQC+9XdtQD/a+TXxV6X+BBK
cOL1TP8+Bro1Uir3M1DK+7hIRRjgjQk=
=AyXZ
-----END PGP SIGNATURE-----

--Q37AJVP7lvtcCXKt--
