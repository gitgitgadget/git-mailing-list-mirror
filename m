From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Jul 2015, #07; Mon, 27)
Date: Thu, 30 Jul 2015 00:29:25 +0000
Message-ID: <20150730002925.GF809807@vauxhall.crustytoothpaste.net>
References: <xmqqpp3dgurr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MGu/vTNewDGZ7tmp"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 02:29:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKbj6-0005hR-GE
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 02:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbbG3A3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 20:29:31 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60941 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754679AbbG3A33 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2015 20:29:29 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:48ea:e153:11e5:6f04])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8DE1E28295;
	Thu, 30 Jul 2015 00:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1438216168;
	bh=jRltFF8dVamZ37J5JQdPnOxJqsgbj6Hz/xknXL/n5cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVJ8SmX05OfXffmyG6L4u+izDaU0DHfDyijuXnOxfuFGYDOe12QiBiiy6C3kloXzj
	 ktycsOZ1jaILhkxsAMmkwVowLQtXu0dFsJtXTrur3A5KbpT6QyItvhCx+1b2+yTnex
	 wEkspBNSm0klLUjW5MNVgcr2mjeT7l9Qh82FWxYig/Uao0Gm9HL4/nf076wtd28n8g
	 +iriY05fgmMjIImwu1iFRX72XIcSQFQli+wfQCA3SCzZmpt+q3lREn5Uuob8C9Rp13
	 S1m4TSfgKf4gBAmNZ52UCaX4MVOnoSOPO01toutYUGBNGYsKge1FXqZZHIwkwWndwm
	 NSfvkNNyAZyxJ0hvc+DUmvpwXFQsbJRKzcCxoa58KNmuwupvuKyYJf+8VSjEcEGM4w
	 Pgcl8HcaqkX91MkrvNS6T5Li+S6uTts+yLcHHXv3h1tipV6MGQtx3bF+O3ACyXAjZ5
	 wiRmEnWMSO805KPxqJCbTpmCtC8uh4ZeIVkvw/RV1g7b3NRzwJy
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqpp3dgurr.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-2-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274964>


--MGu/vTNewDGZ7tmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 02:23:04PM -0700, Junio C Hamano wrote:
> * bc/object-id (2015-06-17) 10 commits
>  . remote.c: use struct object_id in many functions
>  . object-id: use struct object_id in struct object
>  . remote.c: use struct object_id in ref_newer()
>  . transport-helper.c: use struct object_id in push_refs_with_export()
>  . connect.c: use struct object_id in get_remote_heads()
>  . remote-curl: use struct object_id in parse_fetch()
>  . fetch-pack: use struct object_id in add_sought_entry_mem()
>  . object_id: convert struct ref to use object_id.
>  . sha1_file: introduce has_object_file() helper
>  . refs: convert some internal functions to use object_id
>=20
>  More transition from "unsigned char[40]" to "struct object_id".
>=20
>  While GSoC and other topics are actively moving existing code
>  around, this cannot go in; ejected from 'pu'.

Is there anything I can do to make this series less painful (e.g. a
reroll or such)?  If waiting is the best technique, that's fine; I just
want to minimize the impact of this change in terms of other code and
maintainer burden.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--MGu/vTNewDGZ7tmp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.6 (GNU/Linux)

iQIcBAEBCgAGBQJVuW/kAAoJEL9TXYEfUvaLfZ4P/0vzycgTGuOkka1z+piDFrfR
BG5b6WSAQ4f6Yx+BTq/h/rypeXaQoy5tDCHstL9787LFNEl1vGJ5CitzsHUB6yZI
LvjPeKqMAVhsmhvjdXGTcJcZDt72fuG/Uiy69YyaNSNQhKf90fZoozy7llaw6wTP
FfkguthYtflCXp6+KGa6Gvru5d5d3ZvhCT4XpC0Q+BwwrIRUJypzvPAhen3RGs44
ZGvqgMEFnh72ym0L5cEA0DMe7Kn8bW7GsgIHAAVhssS3m5zg/ex1L7GZDCrqeCy7
3c+dynQnQQqKJ3dJrg10A43hopBQHqYIt3IA6EcPTxY6wwZfT2DHflL3679rSKbX
tTXeAIPHKWUGT8shY892f3OZ1DKqvcJt/oHNHMq0j1mbSkPIZ6+nRhHwfDeYGvIz
i8RRtB93CECxO2yMlx1Ycsuxv92tT+/JC5BeT3OcBiNTHzN/8N4mvFfVHRGpsJfh
+Z6b1da8Y9GLmrFVNoZBAnqYhcDKtAEgONYJg8MO/pTi1X2a0GmXyv783bm3huGZ
Y0ibcpsPZbHOyMSosiCVZFWPZ0XN/oFw4DWYlv7FlmBuV35BT9bHs8gsAVP38IEt
yVXJaZVCCej9cgx5rOI+eneKRfnffgJE9mSY2vf46EIASK2NrEzvgo57Bc9Hf5z3
LpKwHsigrzKnJkiXYn1u
=fxze
-----END PGP SIGNATURE-----

--MGu/vTNewDGZ7tmp--
