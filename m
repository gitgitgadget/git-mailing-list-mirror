From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v5 1/4] submodule: Make 'checkout' update_module explicit
Date: Sun, 26 Jan 2014 17:59:59 -0800
Message-ID: <20140127015959.GT29063@odin.tremily.us>
References: <20140117023746.GJ7078@odin.tremily.us>
 <cover.1390768736.git.wking@tremily.us>
 <43e8f3bfdaffefca9edd7a23574816630690e1e5.1390768736.git.wking@tremily.us>
 <CAPig+cQweMT6g+GLFfAWg=9hcU7EjQ7eMOjYiMDQ4rennJSsXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EcNOobXTltE2FMDQ"
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jan 27 03:00:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7bUj-0004BW-7a
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 03:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbaA0CAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 21:00:06 -0500
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:34001
	"EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753121AbaA0CAF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jan 2014 21:00:05 -0500
Received: from omta11.westchester.pa.mail.comcast.net ([76.96.62.36])
	by qmta09.westchester.pa.mail.comcast.net with comcast
	id JpR91n0010mv7h059q03Qe; Mon, 27 Jan 2014 02:00:03 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta11.westchester.pa.mail.comcast.net with comcast
	id Jq011n00E152l3L3Xq02fT; Mon, 27 Jan 2014 02:00:03 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 3F0B5F1C7CD; Sun, 26 Jan 2014 18:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1390788000; bh=+w5ZK3D2RGgsURa8jURkBDAEdkdX9NDByuHUIkNAU0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JDhbcuQeV+ctK2uHhq7XBIH7RHfh41cy362b4ZS54RLkjhPSzmXV2gppAblc+nM5G
	 tH2Lrvbd7b2eyN8r5vxXYX8oe1z5voU8FkmpX08GNS383BAIEKrZXOnP0JDJTXSpCC
	 hvH6vh/vAAjyqTGdc22FbJnqm+c5SDz6n+33DllU=
Content-Disposition: inline
In-Reply-To: <CAPig+cQweMT6g+GLFfAWg=9hcU7EjQ7eMOjYiMDQ4rennJSsXw@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1390788003;
	bh=FGdgptpkL1Gs++AGAEHV9udnZg40jYtks+Q+3dmsUiY=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=o0T4pX2FBQDquVA1IiHMAC6fNf1BHRWN/oDMkmKUKq/uVqeSbxz0oUzLEp5mnraNi
	 HSctRh//tuUmvz263AMH4gnilXo8AapUd6ietgz7OcbBZ2fLpJzWhFkAct1d2ei8FI
	 4EogjZ9LmI9R+ijvcSaMc1BlZjrkyAEZHAjNmk1bolbdgsgDlaXEIhB00XsCH4wLqu
	 qP16h+wJyP0l5D4T/m2DoQ2s8YRzVrgszyLy3/QR6c8hrdvSliDCRHq1pHG6wcxX16
	 lLX84KPumHWNBu+2nus0FEaseIQv1nrDatsKkRWYLXirQMyPprbi52CNMPYooQ0nSv
	 WsuEZQOP6MnSA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241128>


--EcNOobXTltE2FMDQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2014 at 08:32:04PM -0500, Eric Sunshine wrote:
> On Sun, Jan 26, 2014 at 3:45 PM, W. Trevor King <wking@tremily.us> wrote:
> > +                               update_module=3D"checkout"
>=20
> Here, you (unnecessarily) quote 'checkout'...
>=20
> > -                               update_module=3D ;;
> > +                               update_module=3Dcheckout ;;
>=20
> But here you use bare (unquoted) 'checkout'. Bare is probably more
> idiomatic.

Whatever you want ;).  Queued for v6.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--EcNOobXTltE2FMDQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5b2dAAoJEKKfehoaNkbtc8EP+wWEEwCyYlv3PO3tu1/QWxK7
18GmO1QFYVQj4k//5UBohnfh7Tv22RZ4Y/5NE3G/AIs31IgarUahZivlYskgA3k/
PDdspEktI1nw57dOAm0dloYFyv3pQ7uqgSoeM2E4yATfjhtKm6hNw+rche1duG+Q
+49VoAeNYc2rHwvrif+EBBKUJvmgcOeZa7Ko6NI6yJAm4sgBYhzGUtU7QlwQwtJp
6zGXf3/3umVafu8qzdSEHTcVatlbIC84D/JMzBTRB/xiUXGiUbAH+84hyL8Td+nX
BumNjnQOInf8jn9Ok4kXS/5WByEuVlnf2hfvJdsuK7PKIpomVvdtgHKTd+wLzSFP
qvVcXhNC/62jzTTPGvnER6DfyShcefTpIrVc3A1u00xjHMRf7eJm84WBrYsycLWb
7cHAYeNlayLKmJ6uGEL5ga9lzm6fTZl1bIignLSBQr6/qXgpRyZbHLpmIMFtpUKT
VHRpjq8pMNk0Rq70lBdM5FvpT/cQzZmbjuJquQEMvF9dbwG9KXbJWIW/tGQIECTI
K28udiFsMrhZ479IoxiZHeZBD395MY8/Q4MLg9cf913KLLMDYA18d95WXIohL4Ws
lEub6cfkMFYwhZPp4AI8FkhS0CQi0ceTpj19n/MaCZ3B32TikZjTb0tqR8C6KO6G
ly6mPCCtvC+7lOUmJFGU
=nCD6
-----END PGP SIGNATURE-----

--EcNOobXTltE2FMDQ--
