Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B62420189
	for <e@80x24.org>; Wed, 22 Jun 2016 18:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbcFVSok (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 14:44:40 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39980 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750957AbcFVSoj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2016 14:44:39 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [64.134.182.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 294232809F;
	Wed, 22 Jun 2016 18:44:36 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466621076;
	bh=2T/xJGzbHTS9+UDBp+XeuxhPRE/naBEtZZRsz7BQY8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3SNHk2UbGemHic0UbzuTAq+JBNPSVaYhgJP86yPOtLEgoOxbuonwGiwLE7PFXbrT
	 aTBoI9F7Usl/UHH0GfaLTUMOVSCjeYYGskAGE1zhpiQPZJIQqgEvv4B2tcxuZfuDek
	 e1peMh/JBAI4mgu/orSp5l9Y0cguyleCkLupjI2MqBuvyLWwGlHKldhwK9gzT0/uqk
	 cMYb3k7US0G6cHCvXbgCFNmqo38cDbaYaN3MIgA7Dkkmyh1IlOLNXVz/Xb9llc2OQZ
	 +nxDvQqx1FeklW7834jvc2bSjSrHbQOc5/nJ2aC4elPH1Qvr2ubOj31ma+SVguUOQt
	 aiE+0MdSQiMQleIXePks6BydOjI6nxCiITbAQIqaRFnQ5Gc2aJFaGEtN8kDn4ahLgi
	 vsokhxnvmTbc1TBl/nydRlhS3EN8V0IHPDdMHW+GtCpF+1IF4fgs2jlGxojHwh1Mf6
	 tIvOaFIh0iAlTxjKzCQ4UBqgKXmyu7zeXkJPL6UfOxKI6wzx12j
Date:	Wed, 22 Jun 2016 18:44:31 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/8] object_id part 4
Message-ID: <20160622184431.GA8937@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
References: <20160618221407.1046188-1-sandals@crustytoothpaste.net>
 <xmqqy45ynsnp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <xmqqy45ynsnp.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.6.0-1-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 21, 2016 at 02:22:50PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > This series is part 4 in a series of conversions to replace instances of
> > unsigned char [20] with struct object_id.  Most of this series touches
> > the merge-recursive code.
>=20
> I've queued them in 'pu', but please read contrib/examples/README
> ;-) Tentatively, I used contrib/coccinelle instead, but something
> even shorter (e.g. contrib/cocci) might be sufficient.

That seems fine with me.  I did read contrib/examples/README, but
figured it might be okay nevertheless.  I think contrib/coccinelle is
better, though.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXatyOAAoJEL9TXYEfUvaLip8QAMS4wpTcClMTKj5bXV7ssxFU
tZKt+DeBGuKaJ0eMOUqHohLxVrssFdyN4bIsX8zcX9cLlyRxWNsqmhNdH91xDzJJ
DIrWJveOsqcgtq0mPCQegPEMSvWox/fXjdpTI5ZyG77xw2GGE5YhMC5MZpnpGlhr
5MqKUUBnc+gN3/bp9FGDWcaK0PwbuwlPSK0NGYjWAXTeIhhD0F7vG+Z6MC7Jxw6k
SvItQ4Zbc0jZqFhQdvMPzqgGkDNRSANUtSVqIvJeIAihkwOtrZ0R+R8yTLQjXjYF
YzGp0GVRAjyqe62UqUDk7Zhmt/Ky42RnWN/OWvMT+sUkgBUXr3CmMDauOBbJk7TR
wJd3lijvw5PmMK2yePFIkhYO1Wy8N2cadnAg87GKREMfSwBv1UCILUmEb7adFY64
M9dOKM+IzGpWUbEpNyuGlJ6jekJsI2Rekf+/d1WxlWR81lkc0WiOU+UI3+SC6FOV
uklvXtNlFC3nj15X7AcidYBpfTZNojlWOClH2Ofa4+6T47nYjyIP6bU0G9MG1Umq
DMhCOJZocJdcELAE2KCwu7EGKVAE9m0AYE6FTFwvrJtTQs/iGfxXjdpYScpXeeC+
2mNmBGid1SXwYl/DFHKPsCuYgM/GN2Gvt6tTqqZnrYTTsgDoS8Awu/XoV3H0KtdG
yvXIjwFPwE2n2qVfMNW7
=vUmX
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
