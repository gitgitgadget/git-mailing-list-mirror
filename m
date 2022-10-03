Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA8FC433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 22:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiJCW22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 18:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiJCW2G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 18:28:06 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBE858DC7
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 15:25:21 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 978E75A0EA;
        Mon,  3 Oct 2022 22:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1664835920;
        bh=ZT9+5Z1oMmMMgdgVQQc86yw2q/ehYCrSbk+mCv/7iuo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TzyHl+7qsFDa69wzSuzdQpsQqTBjYB8+bH7KP7troinna3Z/bsJELbTpAGgUwtPyt
         gio1Cyoe0S1ubhCctBMUzJAJy3EzYuVn31U3PATFmYYgupK/4Q5jYeo026k68S4/AI
         5VuNeqyB+tI/Nxmr6pKXRLujpvb8iP+ZuXpiEXKHS4C9tmryOixrAdVOCBNIj5XDjR
         VVTTuOht6j8JsnpjNQw94gp5hfIbipTVFUUqc6IwFXhgdQcmBWqKFQJLdPWdpHbZwy
         SDoK7MkhGQ9JHqCp49U3zpaT1/pGaRo7psJZMJh7NgaaRr4sR9KhAEwKL977g1TxQL
         jUkIHQA1czld2tQ8M0wdgkSAL9fig2ZduWj93DuH1MXPH7TeFhhnZp8149snDsbHHP
         A8+nbbndj/1aiwIoXnoIdmEF9AtDZcmdbFklgQViQvvx5wqvqi/ZGVbOxmIwRCXIBP
         l/wpNpBbscF7Q4y4nFqueZF7DkLQU3MFGCOrfGRHCXqqZeQBI+P
Date:   Mon, 3 Oct 2022 22:25:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Aleajndro R =?utf-8?Q?Sede=C3=B1o?= <asedeno@google.com>
Cc:     git@vger.kernel.org,
        Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Subject: Re: [PATCH] git-compat-util.h: GCC deprecated only takes a message
 in GCC 4.5+
Message-ID: <YzthTugwy+eaIUxr@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Aleajndro R =?utf-8?Q?Sede=C3=B1o?= <asedeno@google.com>,
        git@vger.kernel.org,
        Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
References: <20221003212318.3092010-1-asedeno@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vIGg64snPnvRyx8g"
Content-Disposition: inline
In-Reply-To: <20221003212318.3092010-1-asedeno@google.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vIGg64snPnvRyx8g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-03 at 21:23:18, Aleajndro R Sede=C3=B1o wrote:
> From: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
>=20
> Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
> Signed-off-by: Alejandro R Sede=C3=B1o <asedeno@google.com>

It might be helpful to explain what system you're targeting when you see
this.  CentOS 7 has GCC 4.8, and I'm not aware of any systems with an
older compiler receiving publicly available updates still.  We've fairly
recently only been testing and targeting GCC 4.8 for that reason.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--vIGg64snPnvRyx8g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYzthTgAKCRB8DEliiIei
geh2AP9y8Z3U2NJPgoL32jMZhx+f4QXM7e2DPEVfxhHGcYX42AD/YZ1bTUAmqQ+5
fLKbN3OD5dryLeLqX/EpO73AmtRKwA8=
=tMD9
-----END PGP SIGNATURE-----

--vIGg64snPnvRyx8g--
